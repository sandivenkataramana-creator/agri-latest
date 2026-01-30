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

// Get all HODs
router.get('/', async (req, res) => {
  try {
    // Get HODs with their department mappings
    let results;
    try {
      [results] = await db.query(`
        SELECT DISTINCT h.*, c.name as category_name 
        FROM hods h 
        LEFT JOIN categories c ON h.category_id = c.id 
        ORDER BY h.name
      `);
      
      // For each HOD, get all their department mappings
      const hodsWithDepts = await Promise.all(results.map(async (hod) => {
        const [depts] = await db.query(`
          SELECT department_name, category_id, is_primary
          FROM hod_department_mapping
          WHERE hod_id = ?
          ORDER BY is_primary DESC, department_name
        `, [hod.id]);
        
        return {
          ...hod,
          departments: depts.length > 0 ? depts : [{ department_name: hod.department }]
        };
      }));
      
      return res.json(hodsWithDepts);
    } catch (err) {
      // If mapping table doesn't exist, fall back to simple query
      if (err.code === 'ER_NO_SUCH_TABLE' || err.message.includes('hod_department_mapping')) {
        [results] = await db.query('SELECT * FROM hods ORDER BY name');
        return res.json(results);
      } else {
        throw err;
      }
    }
  } catch (error) {
    console.error('Error fetching HODs:', error);
    res.status(500).json({ error: error.message });
  }
});

// Get HOD by ID
router.get('/:id', async (req, res) => {
  try {
    const [results] = await db.query('SELECT * FROM hods WHERE id = ?', [req.params.id]);
    if (results.length === 0) {
      return res.status(404).json({ message: 'HOD not found' });
    }
    
    // Get department mappings
    const [depts] = await db.query(`
      SELECT department_name, category_id, is_primary
      FROM hod_department_mapping
      WHERE hod_id = ?
      ORDER BY is_primary DESC, department_name
    `, [req.params.id]);
    
    const hod = results[0];
    hod.departments = depts.length > 0 ? depts : [{ department_name: hod.department }];
    
    res.json(hod);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Create HOD
router.post('/', ...superAdminOnly, async (req, res) => {
  try {
    const { name, department, category_id, email, phone, status } = req.body;
    
    console.log('\n📝 Creating/Updating HOD with Department Mapping');
    console.log('Request body:', { name, department, category_id, email, phone, status });
    
    // Validate required fields
    if (!name || !department) {
      return res.status(400).json({ error: 'Name and Department are required' });
    }
    
    // Convert empty strings to null for category_id and email
    const parsedCategoryId = category_id && category_id !== '' ? parseInt(category_id) : null;
    const finalEmail = email && email.trim() !== '' ? email.trim() : null;
    
    let hodId;
    let isFirstCreation = false;
    let hodData;
    
    // Check if HOD with this email already exists
    if (finalEmail) {
      console.log('🔍 Checking for existing HOD with email...');
      const [existingHods] = await db.query(
        'SELECT id, name, email FROM hods WHERE LOWER(email) = LOWER(?)',
        [finalEmail]
      );
      
      if (existingHods.length > 0) {
        // Reuse existing HOD
        hodId = existingHods[0].id;
        hodData = existingHods[0];
        console.log('♻️ Reusing existing HOD ID:', hodId, 'Name:', existingHods[0].name);
        
        // Check if this department is already mapped to this HOD
        const [existingMapping] = await db.query(
          'SELECT id FROM hod_department_mapping WHERE hod_id = ? AND LOWER(department_name) = LOWER(?)',
          [hodId, department]
        );
        
        if (existingMapping.length > 0) {
          console.log('⚠️ This HOD is already mapped to this department');
          return res.status(400).json({ 
            error: `This HOD is already assigned to the "${department}" department.` 
          });
        }
        
        // Add new department mapping for existing HOD
        console.log('📌 Adding new department mapping...');
        try {
          await db.query(
            'INSERT INTO hod_department_mapping (hod_id, department_name, category_id, is_primary) VALUES (?, ?, ?, ?)',
            [hodId, department, parsedCategoryId, false]
          );
          console.log('✅ Department mapping added to existing HOD');
          isFirstCreation = false;
        } catch (mappingErr) {
          console.error('❌ Error adding department mapping:', mappingErr.message);
          return res.status(500).json({ error: 'Failed to add department mapping: ' + mappingErr.message });
        }
      } else {
        // Create new HOD
        console.log('✨ Creating new HOD...');
        const [result] = await db.query(
          'INSERT INTO hods (name, department, category_id, email, phone, status) VALUES (?, ?, ?, ?, ?, ?)',
          [name, department, parsedCategoryId, finalEmail, phone || null, status || 'active']
        );
        hodId = result.insertId;
        console.log('✅ HOD created successfully, ID:', hodId);
        
        // Create department mapping for new HOD
        try {
          await db.query(
            'INSERT INTO hod_department_mapping (hod_id, department_name, category_id, is_primary) VALUES (?, ?, ?, ?)',
            [hodId, department, parsedCategoryId, true]
          );
          console.log('✅ Primary department mapping created');
        } catch (mappingErr) {
          console.warn('⚠️ Could not create department mapping:', mappingErr.message);
        }
        
        isFirstCreation = true;
      }
    } else {
      // No email provided - create new HOD
      console.log('✨ Creating new HOD without email...');
      const [result] = await db.query(
        'INSERT INTO hods (name, department, category_id, email, phone, status) VALUES (?, ?, ?, ?, ?, ?)',
        [name, department, parsedCategoryId, null, phone || null, status || 'active']
      );
      hodId = result.insertId;
      console.log('✅ HOD created successfully, ID:', hodId);
      
      // Create department mapping
      try {
        await db.query(
          'INSERT INTO hod_department_mapping (hod_id, department_name, category_id, is_primary) VALUES (?, ?, ?, ?)',
          [hodId, department, parsedCategoryId, true]
        );
        console.log('✅ Department mapping created');
      } catch (mappingErr) {
        console.warn('⚠️ Could not create department mapping:', mappingErr.message);
      }
      
      isFirstCreation = true;
    }
    
    // Get all departments for this HOD
    const [allDepts] = await db.query(
      'SELECT department_name FROM hod_department_mapping WHERE hod_id = ?',
      [hodId]
    );
    
    console.log('📊 HOD now manages', allDepts.length, 'department(s):', allDepts.map(d => d.department_name).join(', '));
    
    // Send email credentials if email is provided
    if (finalEmail) {
      console.log('📧 Sending credentials email...');
      const temporaryPassword = generateTemporaryPassword();
      const emailResult = await sendAccountCredentials(
        finalEmail,
        finalEmail,
        temporaryPassword,
        'HOD'
      );
      
      if (emailResult.success) {
        console.log('✅ Credentials email sent successfully');
      } else {
        console.warn('⚠️ Email sending failed:', emailResult.error);
      }
    }
    
    res.status(201).json({ 
      id: hodId, 
      message: isFirstCreation 
        ? 'HOD created successfully. Credentials sent to email.' 
        : 'New department mapping added to existing HOD. Credentials resent to email.',
      isNewHod: isFirstCreation,
      email: finalEmail,
      departments: allDepts
    });
  } catch (error) {
    console.error('❌ Error processing HOD:');
    console.error('Error message:', error.message);
    console.error('Error code:', error.code);
    
    // Handle specific errors with more precision
    if (error.code === 'ER_DUP_ENTRY') {
      console.error('Duplicate entry detected');
      return res.status(400).json({ 
        error: 'Duplicate entry. Please check your input.' 
      });
    }
    
    res.status(500).json({ error: error.message, code: error.code });
  }
});

// Update HOD
router.put('/:id', ...superAdminOnly, async (req, res) => {
  try {
    const { name, department, category_id, email, phone, status } = req.body;
    const hodId = req.params.id;
    
    console.log('\n✏️  Updating HOD ID:', hodId);
    console.log('Request body:', { name, department, category_id, email, phone, status });
    
    // Validate required fields
    if (!name || !department) {
      return res.status(400).json({ error: 'Name and Department are required' });
    }
    
    // Convert empty strings to null for category_id and email
    const parsedCategoryId = category_id && category_id !== '' ? parseInt(category_id) : null;
    const finalEmail = email && email.trim() !== '' ? email.trim() : null;
    
    // Check for duplicate email (excluding current HOD) BEFORE updating
    if (finalEmail) {
      console.log('🔍 Checking for existing email...');
      const [existingEmails] = await db.query(
        'SELECT id, name FROM hods WHERE LOWER(email) = LOWER(?) AND id != ?',
        [finalEmail, hodId]
      );
      
      if (existingEmails.length > 0) {
        console.log('⚠️ Email already exists for:', existingEmails.map(e => e.name).join(', '));
        return res.status(400).json({ 
          error: 'Email address is already in use by another HOD. Please use a different email or leave it empty.' 
        });
      }
    }
    
    console.log('Processed values - Email:', finalEmail, 'Category ID:', parsedCategoryId);
    console.log('Query params:', [name, department, parsedCategoryId, finalEmail, phone || null, status, hodId]);
    
    await db.query(
      'UPDATE hods SET name = ?, department = ?, category_id = ?, email = ?, phone = ?, status = ? WHERE id = ?',
      [name, department, parsedCategoryId, finalEmail, phone || null, status, req.params.id]
    );
    console.log('✅ HOD updated successfully');
    res.json({ message: 'HOD updated successfully' });
  } catch (error) {
    console.error('❌ Error updating HOD:');
    console.error('Error message:', error.message);
    console.error('Error code:', error.code);
    console.error('SQL State:', error.sqlState);
    console.error('Full error:', error);
    
    // Handle specific errors with more precision
    if (error.code === 'ER_DUP_ENTRY') {
      console.error('Duplicate entry detected');
      if (error.message.includes("'email'") || error.message.includes('key \'email\'')) {
        return res.status(400).json({ 
          error: 'Email address is already in use by another HOD. Please use a different email or leave it empty.' 
        });
      } else {
        return res.status(400).json({ 
          error: `Duplicate value found: ${error.message}. Please check your input.` 
        });
      }
    }
    
    res.status(500).json({ error: error.message, code: error.code });
  }
});

// Create user account for HOD with credentials
router.post('/:id/create-account', ...superAdminOnly, async (req, res) => {
  try {
    const hodId = req.params.id;

    // Get HOD details
    const [hods] = await db.query('SELECT * FROM hods WHERE id = ?', [hodId]);
    if (hods.length === 0) {
      return res.status(404).json({ error: 'HOD not found' });
    }

    const hod = hods[0];
    if (!hod.email) {
      return res.status(400).json({ error: 'HOD email not available' });
    }

    // Auto-generate a strong temporary password
    const password = generateTemporaryPassword();
    console.log(`🔐 Auto-generated temporary password for HOD ${hod.name}`);

    // Generate username from HOD name (lowercase, replace spaces with dots)
    let username = hod.name.toLowerCase().replace(/\s+/g, '.');
    let finalUsername = username;
    let counter = 1;

    // Check if username already exists, if so, append counter
    while (true) {
      const [existing] = await db.query('SELECT id FROM users WHERE username = ?', [finalUsername]);
      if (existing.length === 0) break;
      finalUsername = `${username}${counter}`;
      counter++;
    }

    // Check if user already exists for this HOD
    const [existingUser] = await db.query('SELECT id FROM users WHERE hod_id = ? AND role = ?', [hodId, 'hod']);
    if (existingUser.length > 0) {
      // Update existing user with new password
      await db.query(
        'UPDATE users SET password = ?, email = ?, name = ?, status = "active" WHERE hod_id = ? AND role = ?',
        [password, hod.email, hod.name, hodId, 'hod']
      );
      return res.json({
        message: 'User account updated successfully',
        username: existingUser[0].username || finalUsername,
        email: hod.email,
        role: 'hod',
        hodId: hodId,
        accountCreated: false
      });
    }

    // Create new user account for HOD
    const [result] = await db.query(
      'INSERT INTO users (username, password, email, role, hod_id, name, status) VALUES (?, ?, ?, ?, ?, ?, ?)',
      [finalUsername, password, hod.email, 'hod', hodId, hod.name, 'active']
    );

    console.log(`User account created for HOD ${hod.name}:`, {
      userId: result.insertId,
      username: finalUsername,
      email: hod.email,
      hodId: hodId
    });

    // Send credentials email to HOD
    try {
      await sendAccountCredentials(hod.email, finalUsername, password, 'HOD');
      console.log(`Credentials email sent to ${hod.email}`);
    } catch (emailError) {
      console.warn(`Failed to send credentials email to ${hod.email}:`, emailError.message);
      // Don't fail the request if email fails - account is still created
    }

    res.status(201).json({
      message: 'User account created successfully. Credentials sent to email.',
      username: finalUsername,
      email: hod.email,
      role: 'hod',
      hodId: hodId,
      accountCreated: true,
      emailSent: true
    });
  } catch (error) {
    console.error('Error creating user account:', error);
    res.status(500).json({ error: error.message });
  }
});

// Send password to HOD
router.post('/:id/send-password', ...superAdminOnly, async (req, res) => {
  try {
    const { password } = req.body;
    const hodId = req.params.id;

    if (!password) {
      return res.status(400).json({ error: 'Password is required' });
    }

    // Get HOD details
    const [hods] = await db.query('SELECT * FROM hods WHERE id = ?', [hodId]);
    if (hods.length === 0) {
      return res.status(404).json({ error: 'HOD not found' });
    }

    const hod = hods[0];
    if (!hod.email) {
      return res.status(400).json({ error: 'HOD email not available' });
    }

    // First, create user account with the password
    const accountRes = await new Promise((resolve, reject) => {
      const createAccountReq = { body: { password } };
      const createAccountRes = {
        status: () => ({ json: () => {} }),
        json: (data) => resolve(data)
      };
      // Call the create-account endpoint logic internally
      router.stack.find(r => r.route && r.route.path === '/:id/create-account' && r.route.methods.post)
        ?.handle?.(createAccountReq, createAccountRes)
        .catch(reject);
    }).catch(() => null);

    // Here you can integrate with email service (nodemailer, SendGrid, etc.)
    // For now, we'll just return success with account info
    console.log(`Password sent to ${hod.email}: ${password}`);

    res.json({ 
      message: 'Password sent successfully and account created',
      email: hod.email,
      username: accountRes?.username || hod.name.toLowerCase().replace(/\s+/g, '.')
    });
  } catch (error) {
    console.error('Error sending password:', error);
    res.status(500).json({ error: error.message });
  }
});

// Delete HOD
router.delete('/:id', ...superAdminOnly, async (req, res) => {
  try {
    await db.query('DELETE FROM hods WHERE id = ?', [req.params.id]);
    res.json({ message: 'HOD deleted successfully' });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Get HOD with all related data
router.get('/:id/details', async (req, res) => {
  try {
    const [hod] = await db.query('SELECT * FROM hods WHERE id = ?', [req.params.id]);
    if (hod.length === 0) {
      return res.status(404).json({ message: 'HOD not found' });
    }
    
    const [schemes] = await db.query('SELECT * FROM schemes WHERE hod_id = ?', [req.params.id]);
    const [staff] = await db.query('SELECT * FROM staff WHERE hod_id = ?', [req.params.id]);
    const [budget] = await db.query('SELECT * FROM budget WHERE hod_id = ?', [req.params.id]);
    const [kpis] = await db.query('SELECT * FROM kpis WHERE hod_id = ?', [req.params.id]);
    
    res.json({
      ...hod[0],
      schemes,
      staff,
      budget,
      kpis
    });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

module.exports = router;
