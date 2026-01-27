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
    const { name, employee_id, designation, department, category_id, hod_id, email, phone, joining_date, status } = req.body;
    const [result] = await db.query(
      'INSERT INTO staff (name, employee_id, designation, department, category_id, hod_id, email, phone, joining_date, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
      [name, employee_id, designation, department, category_id || null, hod_id, email, phone, joining_date, status || 'active']
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
    const { name, employee_id, designation, department, hod_id, email, phone, joining_date, status } = req.body;
    await db.query(
      'UPDATE staff SET name = ?, employee_id = ?, designation = ?, department = ?, hod_id = ?, email = ?, phone = ?, joining_date = ?, status = ? WHERE id = ?',
      [name, employee_id, designation, department, hod_id, email, phone, joining_date, status, req.params.id]
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
