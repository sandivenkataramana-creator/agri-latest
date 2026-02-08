const express = require('express');
const router = express.Router();
const db = require('../config/database');
const crypto = require('crypto');
const { authenticateJWT, requireRole } = require('../middleware/auth');
const { sendAccountCredentials } = require('../services/emailService');

const superAdminOnly = [authenticateJWT, requireRole('superadmin')];

// Generate a strong temporary password
const generateTemporaryPassword = () => {
  // Generate 12 character password with mix of uppercase, lowercase, numbers, and special chars
  const length = 12;
  const uppercase = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  const lowercase = 'abcdefghijklmnopqrstuvwxyz';
  const numbers = '0123456789';
  const special = '!@#$%^&*';
  const all = uppercase + lowercase + numbers + special;

  let password = '';
  password += uppercase[Math.floor(Math.random() * uppercase.length)];
  password += lowercase[Math.floor(Math.random() * lowercase.length)];
  password += numbers[Math.floor(Math.random() * numbers.length)];
  password += special[Math.floor(Math.random() * special.length)];

  for (let i = 4; i < length; i++) {
    password += all[Math.floor(Math.random() * all.length)];
  }

  return password.split('').sort(() => Math.random() - 0.5).join('');
};

// Get all staff
router.get('/', async (req, res) => {
  try {
    let results;
    try {
      [results] = await db.query(`
        SELECT s.*, h.name as hod_name 
        FROM staff s 
        LEFT JOIN hods h ON s.hod_id = h.id 
        ORDER BY s.name
      `);
    } catch (err) {
      console.error('Error fetching staff:', err);
      throw err;
    }
    res.json(results);
  } catch (error) {
    console.error('Error in staff route:', error);
    res.status(500).json({ error: error.message });
  }
});

// Get staff by ID
router.get('/:id', async (req, res) => {
  try {
    const [results] = await db.query(`
      SELECT s.*, h.name as hod_name 
      FROM staff s 
      LEFT JOIN hods h ON s.hod_id = h.id 
      WHERE s.id = ?
    `, [req.params.id]);
    if (results.length === 0) {
      return res.status(404).json({ message: 'Staff not found' });
    }
    res.json(results[0]);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Get staff by HOD
router.get('/hod/:hodId', async (req, res) => {
  try {
    const [results] = await db.query('SELECT * FROM staff WHERE hod_id = ?', [req.params.hodId]);
    res.json(results);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Create staff
router.post('/', ...superAdminOnly, async (req, res) => {
  try {
    const { name, employee_id, designation, section, department, category_id, hod_id, email, phone, location, joining_date, status } = req.body;
    const [result] = await db.query(
      'INSERT INTO staff (name, employee_id, designation, section, department, category_id, hod_id, email, phone, location, joining_date, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
      [name, employee_id, designation, section || null, department || null, category_id || null, hod_id || null, email || null, phone || null, location || null, joining_date || null, status || 'active']
    );
    res.status(201).json({ id: result.insertId, message: 'Staff created successfully' });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Create user account for staff with credentials
router.post('/:id/create-account', ...superAdminOnly, async (req, res) => {
  try {
    const staffId = req.params.id;

    // Get staff details
    const [staffMembers] = await db.query('SELECT * FROM staff WHERE id = ?', [staffId]);
    if (staffMembers.length === 0) {
      return res.status(404).json({ error: 'Staff not found' });
    }

    const staff = staffMembers[0];
    if (!staff.email) {
      return res.status(400).json({ error: 'Staff email not available' });
    }

    // Auto-generate a strong temporary password
    const password = generateTemporaryPassword();
    console.log(`🔐 Auto-generated temporary password for Staff ${staff.name}`);

    // Generate username from staff name (lowercase, replace spaces with dots)
    let username = staff.name.toLowerCase().replace(/\s+/g, '.');
    let finalUsername = username;
    let counter = 1;

    // Check if username already exists, if so, append counter
    while (true) {
      const [existing] = await db.query('SELECT id FROM users WHERE username = ?', [finalUsername]);
      if (existing.length === 0) break;
      finalUsername = `${username}${counter}`;
      counter++;
    }

    // Check if user already exists for this staff member
    const [existingUser] = await db.query('SELECT id FROM users WHERE staff_id = ? AND role = ?', [staffId, 'staff']);
    if (existingUser.length > 0) {
      // Update existing user with new password
      await db.query(
        'UPDATE users SET password = ?, email = ?, name = ?, status = "active" WHERE staff_id = ? AND role = ?',
        [password, staff.email, staff.name, staffId, 'staff']
      );
      return res.json({
        message: 'User account updated successfully',
        username: existingUser[0].username || finalUsername,
        email: staff.email,
        role: 'staff',
        staffId: staffId,
        accountCreated: false
      });
    }

    // Create new user account for staff
    const [result] = await db.query(
      'INSERT INTO users (username, password, email, role, staff_id, hod_id, name, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?)',
      [finalUsername, password, staff.email, 'staff', staffId, staff.hod_id, staff.name, 'active']
    );

    console.log(`User account created for Staff ${staff.name}:`, {
      userId: result.insertId,
      username: finalUsername,
      email: staff.email,
      staffId: staffId,
      hodId: staff.hod_id
    });

    // Send credentials email to staff member
    try {
      await sendAccountCredentials(staff.email, finalUsername, password, 'Staff');
      console.log(`Credentials email sent to ${staff.email}`);
    } catch (emailError) {
      console.warn(`Failed to send credentials email to ${staff.email}:`, emailError.message);
      // Don't fail the request if email fails - account is still created
    }

    res.status(201).json({
      message: 'User account created successfully. Credentials sent to email.',
      username: finalUsername,
      email: staff.email,
      role: 'staff',
      staffId: staffId,
      hodId: staff.hod_id,
      accountCreated: true,
      emailSent: true
    });
  } catch (error) {
    console.error('Error creating user account:', error);
    res.status(500).json({ error: error.message });
  }
});

// Update staff
router.put('/:id', ...superAdminOnly, async (req, res) => {
  try {
    const { name, employee_id, designation, section, department, hod_id, email, phone, location, joining_date, status } = req.body;
    await db.query(
      'UPDATE staff SET name = ?, employee_id = ?, designation = ?, section = ?, department = ?, hod_id = ?, email = ?, phone = ?, location = ?, joining_date = ?, status = ? WHERE id = ?',
      [name, employee_id, designation, section || null, department || null, hod_id || null, email || null, phone || null, location || null, joining_date || null, status || 'active', req.params.id]
    );
    res.json({ message: 'Staff updated successfully' });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Delete staff
router.delete('/:id', ...superAdminOnly, async (req, res) => {
  try {
    await db.query('DELETE FROM staff WHERE id = ?', [req.params.id]);
    res.json({ message: 'Staff deleted successfully' });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

module.exports = router;

// ============================================================
// PUBLIC ENDPOINT: Staff Registration (Single or Bulk)
// ============================================================
// Purpose: Device/3rd-party servers POST staff data (online or offline sync)
// Supports: Single record OR array of records (bulk sync)
// Headers: x-hod-id (required), x-department-id (required)
// Upsert Logic: Updates by employee_id if exists, inserts if new (prevents duplicates during offline sync)
// ============================================================

// router.post('/register-device', async (req, res) => {
//   try {
//     const hodId = req.headers['x-hod-id'] || req.body.hod_id || req.query.hod_id;
//     const departmentId = req.headers['x-department-id'] || req.body.department_id || req.query.department_id || req.body.dept_id;

//     if (!hodId || !departmentId) {
//       return res.status(400).json({ message: 'hod_id and department_id are required (headers or body)' });
//     }

//     // Validate HOD and Department
//     const [hod] = await db.query('SELECT id FROM hods WHERE id = ?', [hodId]);
//     if (!hod || hod.length === 0) return res.status(400).json({ message: 'Invalid HOD ID' });

//     const [dept] = await db.query('SELECT id FROM departments WHERE id = ?', [departmentId]);
//     if (!dept || dept.length === 0) return res.status(400).json({ message: 'Invalid Department ID' });

//     // Check if request body is an array (bulk) or single object
//     const isArray = Array.isArray(req.body);
//     const records = isArray ? req.body : [req.body];

//     if (records.length === 0) {
//       return res.status(400).json({ message: 'At least one staff record is required' });
//     }

//     const results = {
//       total: records.length,
//       inserted: 0,
//       updated: 0,
//       failed: 0,
//       errors: []
//     };

//     // Process each staff record
//     for (const record of records) {
//       try {
//         const {
//           employee_id,
//           person_id,
//           name,
//           email,
//           phone,
//           designation,
//           role,
//           shift,
//           status,
//           job_type
//         } = record;

//         if (!employee_id || !name) {
//           results.failed++;
//           results.errors.push({
//             employee_id: employee_id || 'unknown',
//             error: 'employee_id and name are required'
//           });
//           continue;
//         }

//         // Map department from headers (required field)
//         const finalDeptId = departmentId || dept_id || null;
//         const finalHodId = hodId || null;

//         // Validate department_id is provided
//         if (!finalDeptId) {
//           results.failed++;
//           results.errors.push({
//             employee_id: employee_id || 'unknown',
//             error: 'department_id is required (must be in x-department-id header)'
//           });
//           continue;
//         }

//         // Check if staff already exists by employee_id (for upsert)
//         const [existing] = await db.query('SELECT id FROM staff WHERE employee_id = ?', [employee_id]);

//         if (existing && existing.length > 0) {
//           // UPDATE existing staff (prevents duplicates on sync)
//           const staffId = existing[0].id;
//           await db.query(
//             `UPDATE staff SET person_id = ?, name = ?, email = ?, designation = ?, role = ?, shift = ?, status = ?, job_type = ?, hod_id = ?, department_id = ?, updated_at = NOW() WHERE id = ?`,
//             [person_id || null, name, email || null, role || null, role || null, shift || null, status || 'active', job_type || null, finalHodId, finalDeptId, staffId]
//           );
//           results.updated++;
//           console.log(`[register-device] Staff updated: ${employee_id} (ID: ${staffId})`);
//         } else {
//           // INSERT new staff
//           await db.query(
//             `INSERT INTO staff (
//     person_id,
//     name,
//     employee_id,
//     email,
//     phone,
//     designation,
//     role,
//     shift,
//     status,
//     job_type,
//     hod_id,
//     department_id,
//     created_at
//   )
//   VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, NOW())`,
//             [
//               person_id || null,
//               normalizedName,
//               employee_id,
//               email || null,
//               phone || null,
//               designation || null,
//               role || null,
//               shift || null,
//               status || 'active',
//               job_type || null,
//               hodId,
//               departmentId
//             ]
//           );


//           results.inserted++;
//           console.log(`[register-device] Staff created: ${employee_id} (ID: ${insertResult.insertId})`);
//         }
//       } catch (recordErr) {
//         results.failed++;
//         results.errors.push({
//           employee_id: record.employee_id || 'unknown',
//           error: recordErr.message
//         });
//         console.error(`[register-device] Error processing record:`, recordErr.message);
//       }
//     }

//     // Return appropriate status based on results
//     if (results.failed === records.length) {
//       // All failed
//       return res.status(400).json({
//         message: 'All records failed to process',
//         results
//       });
//     }

//     // Partial or full success
//     const statusCode = results.failed === 0 ? 200 : 207; // 207 Multi-Status for partial success
//     res.status(statusCode).json({
//       message: `Staff sync completed: ${results.inserted} inserted, ${results.updated} updated, ${results.failed} failed`,
//       results,
//       timestamp: new Date().toISOString()
//     });

//   } catch (err) {
//     console.error('[register-device] Error:', err);
//     res.status(500).json({ message: 'Failed to register staff', error: err.message });
//   }
// });

router.post('/register-device', async (req, res) => {
  try {
    // ===============================
    // 1. Extract HOD & Department IDs
    // ===============================
    const hodId =
      req.headers['x-hod-id'] ||
      req.body.hod_id ||
      req.query.hod_id;

    const departmentId =
      req.headers['x-department-id'] ||
      req.body.department_id ||
      req.query.department_id;

    if (!hodId || !departmentId) {
      return res.status(400).json({
        message: 'hod_id and department_id are required (use headers x-hod-id, x-department-id)'
      });
    }

    // ===============================
    // 2. Validate HOD & Department
    // ===============================
    const [hod] = await db.query(
      'SELECT id FROM hods WHERE id = ?',
      [hodId]
    );
    if (!hod || hod.length === 0) {
      return res.status(400).json({ message: 'Invalid HOD ID' });
    }

    const [dept] = await db.query(
      'SELECT id FROM departments WHERE id = ?',
      [departmentId]
    );
    if (!dept || dept.length === 0) {
      return res.status(400).json({ message: 'Invalid Department ID' });
    }

    // ===============================
    // 3. Normalize request body
    // ===============================
    const records = Array.isArray(req.body) ? req.body : [req.body];

    if (records.length === 0) {
      return res.status(400).json({
        message: 'At least one staff record is required'
      });
    }

    const results = {
      total: records.length,
      inserted: 0,
      updated: 0,
      failed: 0,
      errors: []
    };

    // ===============================
    // 4. Helper: normalize name
    // ===============================
    const normalizeName = (value) => {
      if (!value) return null;
      return value
        .trim()
        .toLowerCase()
        .split(/\s+/)
        .map(w => w.charAt(0).toUpperCase() + w.slice(1))
        .join(' ');
    };

    // ===============================
    // 4b. Helper: map job_type to employee_type
    // ===============================
    const mapEmployeeType = (jobType) => {
      if (!jobType) return 'regular'; // default
      
      const normalized = jobType.toLowerCase().trim();
      
      // Map "Full time", "Full-time", "FULL TIME", "fulltime", etc. → "regular"
      if (normalized.includes('full') || normalized === 'fulltime') {
        return 'regular';
      }
      
      // Map "Part time", "Part-time", "PART TIME", "parttime", etc. → "regular"
      if (normalized.includes('part') || normalized === 'parttime') {
        return 'regular';
      }
      
      // Map "Contract", "Contractor", "CONTRACTOR", etc. → "contract"
      if (normalized.includes('contract')) {
        return 'contract';
      }
      
      // Map "Outsource", "Consultant", "CONSULTANT", etc. → "outsource"
      if (normalized.includes('outsource') || normalized.includes('consultant') || normalized.includes('temp')) {
        return 'outsource';
      }
      
      // Default to "regular"
      return 'regular';
    };

    // ===============================
    // 5. Process each record
    // ===============================
    for (const record of records) {
      try {
        const {
          employee_id,
          person_id,
          name,
          email,
          phone,
          designation,
          role,
          shift,
          status,
          job_type
        } = record;

        if (!employee_id || !name) {
          results.failed++;
          results.errors.push({
            employee_id: employee_id || 'unknown',
            error: 'employee_id and name are required'
          });
          continue;
        }

        const normalizedName = normalizeName(name);

        // ===============================
        // 6. Map job_type to employee_type
        // ===============================
        const mappedEmployeeType = mapEmployeeType(job_type);

        // ===============================
        // 7. Check existing staff
        // ===============================
        const [existing] = await db.query(
          'SELECT id FROM staff WHERE employee_id = ?',
          [employee_id]
        );

        // ===============================
        // 8. UPDATE existing staff
        // ===============================
        if (existing.length > 0) {
          const staffId = existing[0].id;

          await db.query(
            `UPDATE staff SET
              person_id = ?,
              name = ?,
              email = ?,
              phone = ?,
              designation = ?,
              role = ?,
              shift = ?,
              status = ?,
              job_type = ?,
              employee_type = ?,
              joining_date = COALESCE(joining_date, CURDATE()),
              hod_id = ?,
              department_id = ?,
              updated_at = NOW()
             WHERE id = ?`,
            [
              person_id || null,
              normalizedName,
              email || null,
              phone || null,
              designation || null,
              role || null,
              shift || null,
              status || 'active',
              job_type || null,
              mappedEmployeeType,
              hodId,
              departmentId,
              staffId
            ]
          );

          results.updated++;
          continue;
        }

        // ===============================
        // 9. INSERT new staff
        // ===============================
        await db.query(
          `INSERT INTO staff (
            person_id,
            name,
            employee_id,
            email,
            phone,
            designation,
            role,
            shift,
            status,
            job_type,
            employee_type,
            joining_date,
            hod_id,
            department_id,
            created_at
          )
          VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, CURDATE(), ?, ?, NOW())`,
          [
            person_id || null,
            normalizedName,
            employee_id,
            email || null,
            phone || null,
            designation || null,
            role || null,
            shift || null,
            status || 'active',
            job_type || null,
            mappedEmployeeType,
            hodId,
            departmentId
          ]
        );

        results.inserted++;

      } catch (recordErr) {
        results.failed++;
        results.errors.push({
          employee_id: record.employee_id || 'unknown',
          error: recordErr.message
        });
      }
    }

    // ===============================
    // 10. Final response
    // ===============================
    if (results.failed === results.total) {
      return res.status(400).json({
        message: 'All records failed to process',
        results
      });
    }

    res.status(results.failed === 0 ? 200 : 207).json({
      message: `Staff sync completed`,
      results,
      timestamp: new Date().toISOString()
    });

  } catch (err) {
    console.error('[register-device] Fatal Error:', err);
    res.status(500).json({
      message: 'Failed to register staff',
      error: err.message
    });
  }
});

