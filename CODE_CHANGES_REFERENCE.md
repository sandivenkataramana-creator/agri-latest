# Code Changes Reference

## File 1: backend/routes/hods.js

### Change 1: Added HOD Account Creation Endpoint

**Location:** After the "Update HOD" endpoint, before "Delete HOD" endpoint

**Code Added:**
```javascript
// Create user account for HOD with credentials
router.post('/:id/create-account', ...superAdminOnly, async (req, res) => {
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

    res.status(201).json({
      message: 'User account created successfully',
      username: finalUsername,
      email: hod.email,
      role: 'hod',
      hodId: hodId,
      accountCreated: true
    });
  } catch (error) {
    console.error('Error creating user account:', error);
    res.status(500).json({ error: error.message });
  }
});
```

**Lines Added:** ~85 lines

---

## File 2: backend/routes/staff.js

### Change 1: Added Staff Account Creation Endpoint

**Location:** After "Create staff" endpoint, before "Update staff" endpoint

**Code Added:**
```javascript
// Create user account for staff with credentials
router.post('/:id/create-account', ...superAdminOnly, async (req, res) => {
  try {
    const { password } = req.body;
    const staffId = req.params.id;

    if (!password) {
      return res.status(400).json({ error: 'Password is required' });
    }

    // Get staff details
    const [staffMembers] = await db.query('SELECT * FROM staff WHERE id = ?', [staffId]);
    if (staffMembers.length === 0) {
      return res.status(404).json({ error: 'Staff not found' });
    }

    const staff = staffMembers[0];
    if (!staff.email) {
      return res.status(400).json({ error: 'Staff email not available' });
    }

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

    res.status(201).json({
      message: 'User account created successfully',
      username: finalUsername,
      email: staff.email,
      role: 'staff',
      staffId: staffId,
      hodId: staff.hod_id,
      accountCreated: true
    });
  } catch (error) {
    console.error('Error creating user account:', error);
    res.status(500).json({ error: error.message });
  }
});
```

**Lines Added:** ~85 lines

---

## File 3: frontend/src/services/api.js

### Change 1: Added API Functions for Account Creation

**Location:** After HODs import section

**Code Changed:**
```javascript
// BEFORE:
export const getHODs = () => api.get('/hods');
export const getHODById = (id) => api.get(`/hods/${id}`);
export const getHODDetails = (id) => api.get(`/hods/${id}/details`);
export const createHOD = (data) => api.post('/hods', data);
export const updateHOD = (id, data) => api.put(`/hods/${id}`, data);
export const deleteHOD = (id) => api.delete(`/hods/${id}`);

// AFTER:
export const getHODs = () => api.get('/hods');
export const getHODById = (id) => api.get(`/hods/${id}`);
export const getHODDetails = (id) => api.get(`/hods/${id}/details`);
export const createHOD = (data) => api.post('/hods', data);
export const updateHOD = (id, data) => api.put(`/hods/${id}`, data);
export const deleteHOD = (id) => api.delete(`/hods/${id}`);
export const createHODAccount = (hodId, password) => api.post(`/hods/${hodId}/create-account`, { password });
```

**Lines Added:** 1 line

### Change 2: Added Staff Account Creation Function

**Location:** After Staff section

**Code Changed:**
```javascript
// BEFORE:
export const getStaff = () => api.get('/staff');
export const getStaffById = (id) => api.get(`/staff/${id}`);
export const getStaffByHODId = (hodId) => api.get(`/staff/hod/${hodId}`);
export const createStaff = (data) => api.post('/staff', data);
export const updateStaff = (id, data) => api.put(`/staff/${id}`, data);
export const deleteStaff = (id) => api.delete(`/staff/${id}`);

// AFTER:
export const getStaff = () => api.get('/staff');
export const getStaffById = (id) => api.get(`/staff/${id}`);
export const getStaffByHODId = (hodId) => api.get(`/staff/hod/${hodId}`);
export const createStaff = (data) => api.post('/staff', data);
export const updateStaff = (id, data) => api.put(`/staff/${id}`, data);
export const deleteStaff = (id) => api.delete(`/staff/${id}`);
export const createStaffAccount = (staffId, password) => api.post(`/staff/${staffId}/create-account`, { password });
```

**Lines Added:** 1 line

---

## File 4: frontend/src/pages/HODs.js

### Change 1: Updated Import Statement

**Location:** Line 1-6

**Code Changed:**
```javascript
// BEFORE:
import { getHODs, createHOD, updateHOD, deleteHOD, getCategories, createCategory } from '../services/api';

// AFTER:
import { getHODs, createHOD, updateHOD, deleteHOD, getCategories, createCategory, createHODAccount } from '../services/api';
```

**Lines Modified:** 1 line

### Change 2: Updated handleSendPassword Function

**Location:** Around line 145-170

**Code Changed:**
```javascript
// BEFORE:
const handleSendPassword = async (e) => {
  e.preventDefault();
  if (!passwordData.password) {
    alert('Please enter a password');
    return;
  }

  try {
    const token = user.token;
    const response = await axios.post(
      `http://localhost:5000/api/hods/${passwordData.hodId}/send-password`,
      { password: passwordData.password },
      {
        headers: {
          Authorization: `Bearer ${token}`,
          'Content-Type': 'application/json'
        }
      }
    );

    alert(`Password sent successfully to ${response.data.email}`);
    setPasswordModalOpen(false);
    setPasswordData({ hodId: null, password: '' });
    setEditingHod(null);
  } catch (err) {
    console.error('Error sending password:', err);
    alert('Failed to send password. ' + (err.response?.data?.error || 'Please try again.'));
  }
};

// AFTER:
const handleSendPassword = async (e) => {
  e.preventDefault();
  if (!passwordData.password) {
    alert('Please enter a password');
    return;
  }

  try {
    const token = user.token;
    
    // First, create the user account with credentials
    const accountResponse = await axios.post(
      `http://localhost:5000/api/hods/${passwordData.hodId}/create-account`,
      { password: passwordData.password },
      {
        headers: {
          Authorization: `Bearer ${token}`,
          'Content-Type': 'application/json'
        }
      }
    );

    // Show success message with login credentials
    const credentials = `\n\nLogin Credentials:\nUsername: ${accountResponse.data.username}\nEmail: ${accountResponse.data.email}\nPassword: ${passwordData.password}`;
    
    alert(`Account created and password set successfully!${credentials}`);
    
    setPasswordModalOpen(false);
    setPasswordData({ hodId: null, password: '' });
    setEditingHod(null);
  } catch (err) {
    console.error('Error creating account:', err);
    alert('Failed to create account. ' + (err.response?.data?.error || 'Please try again.'));
  }
};
```

**Lines Modified:** ~30 lines

---

## File 5: frontend/src/pages/Staff.js

### Change 1: Updated Import Statement

**Location:** Line 4

**Code Changed:**
```javascript
// BEFORE:
import { getStaff, createStaff, updateStaff, deleteStaff, getHODs, getCategories, createCategory } from '../services/api';

// AFTER:
import { getStaff, createStaff, updateStaff, deleteStaff, getHODs, getCategories, createCategory, createStaffAccount } from '../services/api';
```

**Lines Modified:** 1 line

### Change 2: Updated formData State

**Location:** Around line 20-30

**Code Changed:**
```javascript
// BEFORE:
const [formData, setFormData] = useState({
  name: '',
  employee_id: '',
  designation: '',
  department: '',
  category_id: '',
  hod_id: '',
  email: '',
  phone: '',
  status: 'active'
});

// AFTER:
const [formData, setFormData] = useState({
  name: '',
  employee_id: '',
  designation: '',
  department: '',
  category_id: '',
  hod_id: '',
  email: '',
  phone: '',
  status: 'active',
  password: ''
});
```

**Lines Modified:** 1 line (added password field)

### Change 3: Updated handleSubmit Function

**Location:** Around line 113-130

**Code Changed:**
```javascript
// BEFORE:
const handleSubmit = async (e) => {
  e.preventDefault();
  if (isReadOnly) return;
  try {
    const submitData = {
      ...formData,
      hod_id: Number(formData.hod_id)
    };
    
    if (editingStaff) {
      await updateStaff(editingStaff.id, submitData);
    } else {
      await createStaff(submitData);
    }
    fetchData(); // Refresh the list
    handleCloseModal();
  } catch (err) {
    console.error('Error saving staff:', err);
    alert('Failed to save staff. Please try again.');
  }
};

// AFTER:
const handleSubmit = async (e) => {
  e.preventDefault();
  if (isReadOnly) return;
  try {
    const submitData = {
      ...formData,
      hod_id: Number(formData.hod_id)
    };
    
    // Remove password from staff creation data
    const staffData = { ...submitData };
    const password = staffData.password;
    delete staffData.password;
    
    let staffId;
    if (editingStaff) {
      await updateStaff(editingStaff.id, staffData);
      staffId = editingStaff.id;
    } else {
      const response = await createStaff(staffData);
      staffId = response.data.id;
    }
    
    // If password was provided and it's a new staff member, create account
    if (password && !editingStaff) {
      try {
        const accountResponse = await createStaffAccount(staffId, password);
        alert(`Staff created successfully!\n\nLogin Credentials:\nUsername: ${accountResponse.data.username}\nEmail: ${accountResponse.data.email}\nPassword: ${password}`);
      } catch (accountErr) {
        console.error('Error creating account:', accountErr);
        alert('Staff created but account creation failed. Please create account manually.');
      }
    } else {
      alert('Staff ' + (editingStaff ? 'updated' : 'created') + ' successfully!');
    }
    
    fetchData(); // Refresh the list
    handleCloseModal();
  } catch (err) {
    console.error('Error saving staff:', err);
    alert('Failed to save staff. Please try again.');
  }
};
```

**Lines Modified:** ~50 lines

### Change 4: Added Password Field to Form

**Location:** Before Status field in form (around line 320)

**Code Added:**
```javascript
// ADD THIS AFTER PHONE FIELD:
{!editingStaff && (
  <div className="form-group">
    <label>Password (for login account)</label>
    <input type="password" name="password" value={formData.password} onChange={handleChange} placeholder="Leave blank to skip account creation" />
  </div>
)}
```

**Lines Added:** 5 lines

---

## Summary of Changes

| File | Changes | Type |
|------|---------|------|
| backend/routes/hods.js | Added create-account endpoint | New |
| backend/routes/staff.js | Added create-account endpoint | New |
| frontend/src/services/api.js | Added 2 API functions | New |
| frontend/src/pages/HODs.js | Updated password handler | Modified |
| frontend/src/pages/Staff.js | Added password field and account creation | Modified |

**Total Lines Added:** ~180 lines
**Total Lines Modified:** ~50 lines
**Total New Functionality:** User account creation on HOD/Staff creation

---

## Testing Changes

### Test 1: HOD Account Creation
```
1. HODs page → Add HOD → Fill form → Submit
2. Click mail icon on new HOD
3. Enter password → Submit
4. Verify: Alert shows username
5. Login page → Use username + password → Should authenticate as 'hod'
```

### Test 2: Staff Account Creation with Password
```
1. Staff page → Add Staff → Fill form
2. Enter password in password field
3. Submit
4. Verify: Alert shows username and credentials
5. Login page → Use username + password → Should authenticate as 'staff'
```

### Test 3: Staff Creation without Password
```
1. Staff page → Add Staff → Fill form
2. Leave password empty
3. Submit
4. Verify: Staff created but no account
5. Use mail icon later to create account
```

### Test 4: Duplicate Username
```
1. Create staff "John Smith" → Account created, username = "john.smith"
2. Create staff "John Smith" → Account created, username = "john.smith2"
3. Both should login successfully with their respective usernames
```
