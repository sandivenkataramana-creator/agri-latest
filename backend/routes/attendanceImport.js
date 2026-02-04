const express = require('express');
const router = express.Router();

let db;
try {
  db = require('../config/database');
  console.log('[attendanceImport] Database loaded successfully');
} catch (err) {
  console.error('[attendanceImport] Failed to load database:', err.message);
  // Create a dummy that will return an error
  db = {
    query: async () => {
      throw new Error('Database module failed to load: ' + err.message);
    }
  };
}

const { authenticateJWT } = require('../middleware/auth');
const crypto = require('crypto');
const { logAudit } = require('../services/auditService');

// Test endpoint
router.get('/test', (req, res) => {
  console.log('[TEST] Endpoint hit');
  res.json({ message: 'test ok' });
});

// Wrapper for async route handlers
const asyncHandler = (fn) => (req, res, next) => {
  return Promise.resolve(fn(req, res, next)).catch(next);
};

// Get all HODs for dropdown
router.get('/hods-list', authenticateJWT, (req, res) => {
  (async () => {
    try {
      console.log('[hods-list] Fetching HODs');
      
      // Try with is_active filter first
      let query = 'SELECT id, name, department FROM hods WHERE is_active = 1 ORDER BY name ASC';
      try {
        const [hods] = await db.query(query);
        console.log('[hods-list] Found', hods?.length, 'active HODs');
        return res.json({ data: hods || [] });
      } catch (activeErr) {
        // If is_active column doesn't exist, try without it
        if (activeErr.code === 'ER_BAD_FIELD_ERROR') {
          console.log('[hods-list] is_active column not found, trying without filter');
          query = 'SELECT id, name, department FROM hods ORDER BY name ASC';
          const [hods] = await db.query(query);
          console.log('[hods-list] Found', hods?.length, 'HODs');
          return res.json({ data: hods || [] });
        }
        throw activeErr;
      }
    } catch (err) {
      console.error('[hods-list] Error:', err.message);
      res.status(500).json({ message: 'Failed to fetch HODs: ' + err.message, data: [] });
    }
  })();
});

// Generate API Key for third-party system
router.post('/generate-api-key', authenticateJWT, async (req, res) => {
  try {
    console.log('[generate-api-key] START - user role:', req.user?.role);
    
    // Only superadmin can generate API keys
    if (req.user.role !== 'superadmin') {
      console.log('[generate-api-key] Unauthorized - user role is', req.user.role);
      return res.status(403).json({ message: 'Unauthorized' });
    }

    const { system_name, description, hod_id } = req.body;
    console.log('[generate-api-key] Request data:', { system_name, hod_id, description });

    if (!system_name) {
      return res.status(400).json({ message: 'system_name is required' });
    }

    // Verify HOD exists if provided
    if (hod_id) {
      console.log('[generate-api-key] Checking HOD:', hod_id);
      try {
        const [hodCheck] = await db.query('SELECT id FROM hods WHERE id = ?', [hod_id]);
        if (!hodCheck || hodCheck.length === 0) {
          console.log('[generate-api-key] HOD not found');
          return res.status(400).json({ message: 'Invalid HOD ID' });
        }
        console.log('[generate-api-key] HOD found');
      } catch (hodErr) {
        console.log('[generate-api-key] HOD check error:', hodErr.message);
        // Continue anyway if HOD check fails
      }
    }

    // Generate secure API key
    const apiKey = crypto.randomBytes(32).toString('hex');
    const apiKeyHash = crypto.createHash('sha256').update(apiKey).digest('hex');
    console.log('[generate-api-key] API key generated');

    // Try to insert with hod_id first, fall back to without if column doesn't exist
    let insertSuccess = false;
    
    try {
      console.log('[generate-api-key] Trying insert WITH hod_id column');
      const query = `
        INSERT INTO third_party_api_keys (system_name, api_key_hash, hod_id, description, is_active, created_at)
        VALUES (?, ?, ?, ?, 1, NOW())
      `;
      const queryParams = [system_name, apiKeyHash, hod_id || null, description || null];
      await db.query(query, queryParams);
      insertSuccess = true;
      console.log('[generate-api-key] Insert successful WITH hod_id');
    } catch (dbErr) {
      console.log('[generate-api-key] Insert failed with error code:', dbErr.code);
      
      if (dbErr.code === 'ER_BAD_FIELD_ERROR') {
        // If hod_id column doesn't exist, try without it
        console.log('[generate-api-key] Trying insert WITHOUT hod_id column');
        try {
          const query = `
            INSERT INTO third_party_api_keys (system_name, api_key_hash, description, is_active, created_at)
            VALUES (?, ?, ?, 1, NOW())
          `;
          const queryParams = [system_name, apiKeyHash, description || null];
          await db.query(query, queryParams);
          insertSuccess = true;
          console.log('[generate-api-key] Insert successful WITHOUT hod_id');
        } catch (fallbackErr) {
          console.error('[generate-api-key] Fallback insert also failed:', fallbackErr.message);
          throw fallbackErr;
        }
      } else if (dbErr.code === 'ER_DUP_ENTRY') {
        console.log('[generate-api-key] Duplicate entry error:', dbErr.message);
        // Check if it's system_name duplicate or HOD duplicate
        if (dbErr.message.includes('unique_system_per_hod')) {
          return res.status(409).json({ 
            message: `System name '${system_name}' already exists for this HOD. Please use a different system name or select a different HOD.` 
          });
        } else if (dbErr.message.includes('system_name')) {
          return res.status(409).json({ 
            message: `System name '${system_name}' already exists. If you need this system for a different HOD, you can reuse the same name with a different HOD selected.` 
          });
        } else {
          return res.status(409).json({ 
            message: 'This API key already exists. Please use a unique system name.' 
          });
        }
      } else {
        console.error('[generate-api-key] Database error:', dbErr.message);
        throw dbErr;
      }
    }

    if (!insertSuccess) {
      throw new Error('Failed to insert API key');
    }

    // Log the action
    try {
      await logAudit(`API_KEY_GENERATED: ${system_name}`, req.user.id, {
        system_name,
        hod_id,
        description
      });
      console.log('[generate-api-key] Audit logged');
    } catch (auditErr) {
      console.warn('[generate-api-key] Audit logging failed:', auditErr.message);
      // Continue anyway - don't fail the request if audit fails
    }

    console.log('[generate-api-key] Success - sending response');
    res.json({
      message: 'API Key generated successfully',
      apiKey, // Show only once - tell them to save it
      system_name,
      hod_id,
      note: 'Save this API key securely. It will not be shown again.'
    });
  } catch (err) {
    console.error('[generate-api-key] ERROR:', err.message);
    console.error('[generate-api-key] Stack:', err.stack);
    res.status(500).json({ message: 'Failed to generate API key: ' + err.message });
  }
});

// List API keys (superadmin only) - TEMPORARILY DISABLED TO FIX BUG
// List API keys (superadmin only)
// Get all API keys
router.get('/api-keys', authenticateJWT, (req, res) => {
  (async () => {
    try {
      console.log('[api-keys] Fetching API keys for user:', req.user?.id);
      
      // Try query with HOD info first
      let query = `
        SELECT 
          apk.id,
          apk.system_name,
          apk.description,
          apk.is_active,
          apk.created_at,
          COALESCE(h.name, 'N/A') as hod_name,
          h.id as hod_id
        FROM third_party_api_keys apk
        LEFT JOIN hods h ON apk.hod_id = h.id
        ORDER BY apk.created_at DESC
      `;
      
      try {
        const [apiKeys] = await db.query(query);
        console.log('[api-keys] Found', apiKeys?.length, 'API keys');
        return res.json({ data: apiKeys || [] });
      } catch (withHodErr) {
        // If hod_id column doesn't exist, try without it
        if (withHodErr.code === 'ER_BAD_FIELD_ERROR') {
          console.log('[api-keys] hod_id column not found, trying without HOD join');
          query = `
            SELECT 
              id,
              system_name,
              description,
              is_active,
              created_at
            FROM third_party_api_keys
            ORDER BY created_at DESC
          `;
          const [apiKeys] = await db.query(query);
          console.log('[api-keys] Found', apiKeys?.length, 'API keys');
          return res.json({ data: apiKeys || [] });
        }
        throw withHodErr;
      }
    } catch (err) {
      console.error('[api-keys] Error:', err.message);
      res.status(500).json({ message: 'Failed to fetch API keys: ' + err.message, data: [] });
    }
  })();
});

// Webhook endpoint - Third-party system posts attendance data here
// This is the main integration point
router.post('/webhook/attendance', async (req, res) => {

    console.log('DEBUG QUERY:', req.query);
  console.log('DEBUG HEADERS:', req.headers);
  try {
    const apiKey = req.headers['x-api-key'];
    
    if (!apiKey) {
      return res.status(401).json({ message: 'Missing API key' });
    }

    // Verify API key
    const apiKeyHash = crypto.createHash('sha256').update(apiKey).digest('hex');
    const query = `
      SELECT id, system_name, is_active 
      FROM third_party_api_keys 
      WHERE api_key_hash = ? AND is_active = 1
    `;

    const [result] = await db.query(query, [apiKeyHash]);

    if (!result || result.length === 0) {
      return res.status(401).json({ message: 'Invalid or inactive API key' });
    }

    const apiKeyId = result[0].id;
    const systemName = result[0].system_name;

    // Update last_used_at
    await db.query(
      'UPDATE third_party_api_keys SET last_used_at = NOW() WHERE id = ?',
      [apiKeyId]
    );

    // Validate request data
    const { employee_id, check_in, check_out, attendance_date, status, remarks, device_id } = req.body;

    if (!employee_id || !attendance_date) {
      return res.status(400).json({ message: 'employee_id and attendance_date are required' });
    }

    // Find staff by employee_id
    const [staffResult] = await db.query(
      'SELECT id, hod_id FROM staff WHERE employee_id = ?',
      [employee_id]
    );

    if (!staffResult || staffResult.length === 0) {
      return res.status(404).json({ message: `Employee ${employee_id} not found` });
    }

    const staffId = staffResult[0].id;
    const hodId = staffResult[0].hod_id;

    // Calculate working hours if both check_in and check_out exist
    let workingHours = null;
    if (check_in && check_out) {
      const [hours] = await db.query(
        `SELECT SEC_TO_TIME(TIME_TO_SEC(?) - TIME_TO_SEC(?)) as duration`,
        [check_out, check_in]
      );
      workingHours = hours[0]?.duration;
    }

    // Determine status if not provided
    let finalStatus = status || 'present';
    if (!status && check_in) {
      // Auto-detect late: after 10:45 AM
      const checkInTime = new Date(`2000-01-01 ${check_in}`);
      const lateThreshold = new Date('2000-01-01 10:45:00');
      finalStatus = checkInTime > lateThreshold ? 'late' : 'present';
    }

    // Check if record exists for this date
    const [existingRecord] = await db.query(
      'SELECT id FROM attendance WHERE staff_id = ? AND DATE(date) = DATE(?)',
      [staffId, attendance_date]
    );

    let attendanceId;

    if (existingRecord && existingRecord.length > 0) {
      // Update existing record
      attendanceId = existingRecord[0].id;
      await db.query(
        `UPDATE attendance 
         SET check_in = ?, check_out = ?, status = ?, working_hours = ?, remarks = ?, device_id = ?, source = 'third_party', updated_at = NOW()
         WHERE id = ?`,
        [check_in || null, check_out || null, finalStatus, workingHours, remarks || null, device_id || null, attendanceId]
      );
    } else {
      // Create new record
      const [insertResult] = await db.query(
        `INSERT INTO attendance (staff_id, hod_id, date, check_in, check_out, status, working_hours, remarks, device_id, source, created_at)
         VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, 'third_party', NOW())`,
        [staffId, hodId, attendance_date, check_in || null, check_out || null, finalStatus, workingHours, remarks || null, device_id || null]
      );
      attendanceId = insertResult.insertId;
    }

    // Log the import
    await db.query(
      `INSERT INTO attendance_import_logs (api_key_id, employee_id, attendance_date, check_in, check_out, status, device_id, import_status, error_message, created_at)
       VALUES (?, ?, ?, ?, ?, ?, ?, 'success', NULL, NOW())`,
      [apiKeyId, employee_id, attendance_date, check_in || null, check_out || null, finalStatus, device_id || null]
    );

    res.json({
      message: 'Attendance record processed successfully',
      attendance_id: attendanceId,
      employee_id,
      attendance_date,
      status: finalStatus
    });

  } catch (err) {
    console.error('Error processing attendance webhook:', err);
    
    // Log failed import
    try {
      const apiKey = req.headers['x-api-key'];
      const apiKeyHash = crypto.createHash('sha256').update(apiKey).digest('hex');
      const [result] = await db.query(
        'SELECT id FROM third_party_api_keys WHERE api_key_hash = ?',
        [apiKeyHash]
      );
      
      if (result && result.length > 0) {
        await db.query(
          `INSERT INTO attendance_import_logs (api_key_id, employee_id, attendance_date, import_status, error_message, created_at)
           VALUES (?, ?, ?, 'failed', ?, NOW())`,
          [result[0].id, req.body.employee_id || 'unknown', req.body.attendance_date || null, err.message]
        );
      }
    } catch (logErr) {
      console.error('Error logging failed import:', logErr);
    }

    res.status(500).json({ message: 'Failed to process attendance record', error: err.message });
  }
});

// Bulk import endpoint - for importing multiple records at once
router.post('/webhook/attendance-bulk', async (req, res) => {
  try {
    const apiKey = req.headers['x-api-key'];
    
    if (!apiKey) {
      return res.status(401).json({ message: 'Missing API key' });
    }

    // Verify API key
    const apiKeyHash = crypto.createHash('sha256').update(apiKey).digest('hex');
    const query = `
      SELECT id, system_name, is_active 
      FROM third_party_api_keys 
      WHERE api_key_hash = ? AND is_active = 1
    `;

    const [result] = await db.query(query, [apiKeyHash]);

    if (!result || result.length === 0) {
      return res.status(401).json({ message: 'Invalid or inactive API key' });
    }

    const apiKeyId = result[0].id;
    const records = req.body.records || [];

    if (!Array.isArray(records) || records.length === 0) {
      return res.status(400).json({ message: 'records array is required and must not be empty' });
    }

    // Process records
    const results = {
      successful: 0,
      failed: 0,
      errors: []
    };

    for (const record of records) {
      try {
        const { employee_id, check_in, check_out, attendance_date, status, remarks, device_id } = record;

        if (!employee_id || !attendance_date) {
          results.failed++;
          results.errors.push({
            employee_id: employee_id || 'unknown',
            error: 'employee_id and attendance_date are required'
          });
          continue;
        }

        // Find staff
        const [staffResult] = await db.query(
          'SELECT id, hod_id FROM staff WHERE employee_id = ?',
          [employee_id]
        );

        if (!staffResult || staffResult.length === 0) {
          results.failed++;
          results.errors.push({
            employee_id,
            error: `Employee not found`
          });
          continue;
        }

        const staffId = staffResult[0].id;
        const hodId = staffResult[0].hod_id;

        // Calculate working hours
        let workingHours = null;
        if (check_in && check_out) {
          const [hours] = await db.query(
            `SELECT SEC_TO_TIME(TIME_TO_SEC(?) - TIME_TO_SEC(?)) as duration`,
            [check_out, check_in]
          );
          workingHours = hours[0]?.duration;
        }

        // Determine status
        let finalStatus = status || 'present';
        if (!status && check_in) {
          const checkInTime = new Date(`2000-01-01 ${check_in}`);
          const lateThreshold = new Date('2000-01-01 10:45:00');
          finalStatus = checkInTime > lateThreshold ? 'late' : 'present';
        }

        // Check if exists
        const [existingRecord] = await db.query(
          'SELECT id FROM attendance WHERE staff_id = ? AND DATE(date) = DATE(?)',
          [staffId, attendance_date]
        );

        if (existingRecord && existingRecord.length > 0) {
          await db.query(
            `UPDATE attendance 
             SET check_in = ?, check_out = ?, status = ?, working_hours = ?, remarks = ?, device_id = ?, source = 'third_party', updated_at = NOW()
             WHERE id = ?`,
            [check_in || null, check_out || null, finalStatus, workingHours, remarks || null, device_id || null, existingRecord[0].id]
          );
        } else {
          await db.query(
            `INSERT INTO attendance (staff_id, hod_id, date, check_in, check_out, status, working_hours, remarks, device_id, source, created_at)
             VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, 'third_party', NOW())`,
            [staffId, hodId, attendance_date, check_in || null, check_out || null, finalStatus, workingHours, remarks || null, device_id || null]
          );
        }

        // Log success
        await db.query(
          `INSERT INTO attendance_import_logs (api_key_id, employee_id, attendance_date, check_in, check_out, status, device_id, import_status, created_at)
           VALUES (?, ?, ?, ?, ?, ?, ?, 'success', NOW())`,
          [apiKeyId, employee_id, attendance_date, check_in || null, check_out || null, finalStatus, device_id || null]
        );

        results.successful++;
      } catch (recordErr) {
        results.failed++;
        results.errors.push({
          employee_id: record.employee_id || 'unknown',
          error: recordErr.message
        });

        // Log failure
        try {
          await db.query(
            `INSERT INTO attendance_import_logs (api_key_id, employee_id, attendance_date, import_status, error_message, created_at)
             VALUES (?, ?, ?, 'failed', ?, NOW())`,
            [apiKeyId, record.employee_id || 'unknown', record.attendance_date || null, recordErr.message]
          );
        } catch (logErr) {
          console.error('Error logging failed import:', logErr);
        }
      }
    }

    res.json({
      message: `Processed ${records.length} records`,
      results,
      timestamp: new Date().toISOString()
    });

  } catch (err) {
    console.error('Error processing bulk attendance:', err);
    res.status(500).json({ message: 'Failed to process bulk attendance', error: err.message });
  }
});

// Get import logs
router.get('/import-logs', authenticateJWT, async (req, res) => {
  try {
    if (req.user.role !== 'superadmin') {
      return res.status(403).json({ message: 'Unauthorized' });
    }

    const { start_date, end_date, import_status, api_key_id } = req.query;
    let query = 'SELECT * FROM attendance_import_logs';
    const params = [];
    const conditions = [];

    if (start_date) {
      conditions.push('DATE(created_at) >= DATE(?)');
      params.push(start_date);
    }

    if (end_date) {
      conditions.push('DATE(created_at) <= DATE(?)');
      params.push(end_date);
    }

    if (import_status) {
      conditions.push('import_status = ?');
      params.push(import_status);
    }

    if (api_key_id) {
      conditions.push('api_key_id = ?');
      params.push(api_key_id);
    }

    if (conditions.length > 0) {
      query += ' WHERE ' + conditions.join(' AND ');
    }

    query += ' ORDER BY created_at DESC LIMIT 1000';

    const [logs] = await db.query(query, params);

    res.json({ data: logs });
  } catch (err) {
    console.error('Error fetching import logs:', err);
    res.status(500).json({ message: 'Failed to fetch import logs' });
  }
});

// Disable/Enable API key
router.patch('/api-keys/:id/toggle', authenticateJWT, async (req, res) => {
  try {
    if (req.user.role !== 'superadmin') {
      return res.status(403).json({ message: 'Unauthorized' });
    }

    const { id } = req.params;
    const { is_active } = req.body;

    await db.query(
      'UPDATE third_party_api_keys SET is_active = ? WHERE id = ?',
      [is_active ? 1 : 0, id]
    );

    try {
      await logAudit(`API_KEY_STATUS_CHANGED: ${is_active ? 'ACTIVATED' : 'DEACTIVATED'}`, req.user.id, { api_key_id: id });
    } catch (auditErr) {
      console.warn('Audit logging failed:', auditErr.message);
    }

    res.json({ message: 'API key status updated' });
  } catch (err) {
    console.error('Error updating API key:', err);
    res.status(500).json({ message: 'Failed to update API key' });
  }
});

// Get API key details (for displaying in UI - returns masked key)
router.get('/api-keys/:id/view', authenticateJWT, async (req, res) => {
  try {
    if (req.user.role !== 'superadmin') {
      return res.status(403).json({ message: 'Unauthorized' });
    }

    const { id } = req.params;
    const [result] = await db.query(
      'SELECT id, system_name, description, is_active, created_at, last_used_at FROM third_party_api_keys WHERE id = ?',
      [id]
    );

    if (!result || result.length === 0) {
      return res.status(404).json({ message: 'API key not found' });
    }

    res.json({ data: result[0] });
  } catch (err) {
    console.error('Error fetching API key details:', err);
    res.status(500).json({ message: 'Failed to fetch API key details' });
  }
});

// Regenerate API key (delete old, create new with same description)
router.post('/api-keys/:id/regenerate', authenticateJWT, async (req, res) => {
  try {
    if (req.user.role !== 'superadmin') {
      return res.status(403).json({ message: 'Unauthorized' });
    }

    const { id } = req.params;

    // Get existing key details
    const [existingKey] = await db.query(
      'SELECT id, system_name, description FROM third_party_api_keys WHERE id = ?',
      [id]
    );

    if (!existingKey || existingKey.length === 0) {
      return res.status(404).json({ message: 'API key not found' });
    }

    const { system_name, description } = existingKey[0];

    // Generate new API key
    const apiKey = crypto.randomBytes(32).toString('hex');
    const apiKeyHash = crypto.createHash('sha256').update(apiKey).digest('hex');

    // Delete old key and create new one in a transaction
    await db.query('DELETE FROM third_party_api_keys WHERE id = ?', [id]);
    
    const insertQuery = `
      INSERT INTO third_party_api_keys (system_name, api_key_hash, description, is_active, created_at)
      VALUES (?, ?, ?, 1, NOW())
    `;

    await db.query(insertQuery, [system_name, apiKeyHash, description || null]);

    // Log the action
    try {
      await logAudit(`API_KEY_REGENERATED: ${system_name}`, req.user.id, {
        system_name,
        old_key_id: id
      });
    } catch (auditErr) {
      console.warn('Audit logging failed:', auditErr.message);
    }

    res.json({
      message: 'API Key regenerated successfully',
      apiKey,
      system_name,
      description,
      note: 'The old API key has been deleted. This is the only time the new key will be shown. Save it securely.'
    });
  } catch (err) {
    console.error('Error regenerating API key:', err);
    res.status(500).json({ message: 'Failed to regenerate API key: ' + err.message });
  }
});

// Bulk upload attendance from CSV/Excel (for server downtime recovery)
router.post('/bulk-upload-attendance', authenticateJWT, async (req, res) => {
  try {
    if (req.user.role !== 'superadmin') {
      return res.status(403).json({ message: 'Unauthorized' });
    }

    const { records } = req.body;

    if (!Array.isArray(records) || records.length === 0) {
      return res.status(400).json({ message: 'records array is required and must not be empty' });
    }

    const results = {
      successful: 0,
      failed: 0,
      errors: []
    };

    for (const record of records) {
      try {
        const { employee_id, check_in, check_out, attendance_date, status, remarks, hod_id } = record;

        if (!employee_id || !attendance_date) {
          results.failed++;
          results.errors.push({
            employee_id: employee_id || 'unknown',
            error: 'employee_id and attendance_date are required'
          });
          continue;
        }

        // Find staff
        const [staffResult] = await db.query(
          'SELECT id, hod_id FROM staff WHERE employee_id = ?',
          [employee_id]
        );

        if (!staffResult || staffResult.length === 0) {
          results.failed++;
          results.errors.push({
            employee_id,
            error: `Employee not found`
          });
          continue;
        }

        const staffId = staffResult[0].id;
        const finalHodId = hod_id || staffResult[0].hod_id;

        // Calculate working hours
        let workingHours = null;
        if (check_in && check_out) {
          const [hours] = await db.query(
            `SELECT SEC_TO_TIME(TIME_TO_SEC(?) - TIME_TO_SEC(?)) as duration`,
            [check_out, check_in]
          );
          workingHours = hours[0]?.duration;
        }

        // Determine status
        let finalStatus = status || 'present';
        if (!status && check_in) {
          const checkInTime = new Date(`2000-01-01 ${check_in}`);
          const lateThreshold = new Date('2000-01-01 10:45:00');
          finalStatus = checkInTime > lateThreshold ? 'late' : 'present';
        }

        // Check if exists
        const [existingRecord] = await db.query(
          'SELECT id FROM attendance WHERE staff_id = ? AND DATE(date) = DATE(?)',
          [staffId, attendance_date]
        );

        if (existingRecord && existingRecord.length > 0) {
          await db.query(
            `UPDATE attendance 
             SET check_in = ?, check_out = ?, status = ?, working_hours = ?, remarks = ?, source = 'manual_upload', updated_at = NOW()
             WHERE id = ?`,
            [check_in || null, check_out || null, finalStatus, workingHours, remarks || null, existingRecord[0].id]
          );
        } else {
          await db.query(
            `INSERT INTO attendance (staff_id, hod_id, date, check_in, check_out, status, working_hours, remarks, source, created_at)
             VALUES (?, ?, ?, ?, ?, ?, ?, ?, 'manual_upload', NOW())`,
            [staffId, finalHodId, attendance_date, check_in || null, check_out || null, finalStatus, workingHours, remarks || null]
          );
        }

        results.successful++;
      } catch (recordErr) {
        results.failed++;
        results.errors.push({
          employee_id: record.employee_id || 'unknown',
          error: recordErr.message
        });
      }
    }

    // Log the bulk upload action
    try {
      await logAudit(`BULK_ATTENDANCE_UPLOAD: ${results.successful} successful, ${results.failed} failed`, req.user.id, {
        total_records: records.length,
        successful: results.successful,
        failed: results.failed
      });
    } catch (auditErr) {
      console.warn('Audit logging failed:', auditErr.message);
    }

    res.json({
      message: `Processed ${records.length} records`,
      results,
      timestamp: new Date().toISOString()
    });
  } catch (err) {
    console.error('Error processing bulk attendance upload:', err);
    res.status(500).json({ message: 'Failed to process bulk attendance upload', error: err.message });
  }
});

module.exports = router;
