# Frontend Integration Guide - HOD Multi-Department Mapping

## Quick Summary for Frontend

**The backend now supports:**
1. ✅ One HOD account managing multiple departments
2. ✅ Credentials auto-sent to HOD email
3. ✅ Login returns ALL departments in `departments` array
4. ✅ No breaking changes to existing API

---

## API Changes

### HOD Creation (POST /api/hods)

**Request:** Same as before
```javascript
{
  name: "Dr. B. Gopi, IAS",
  email: "b.gopi@example.com",
  department: "Higher Education",
  category_id: 3,
  phone: "9876543210",
  status: "active"
}
```

**Response:** Enhanced with multi-department support
```javascript
{
  id: 24,
  message: "HOD created successfully. Credentials sent to email.",
  isNewHod: true,                        // ← NEW: Indicates first creation
  email: "b.gopi@example.com",           // ← NEW: Returned for reference
  departments: [                         // ← NEW: All mapped departments
    { 
      department_name: "Higher Education",
      category_id: 3,
      is_primary: true 
    }
  ]
}
```

---

### HOD Login (POST /api/auth/login)

**Request:** Same as before
```javascript
{
  username: "b.gopi@example.com",
  password: "[temp_password]"
}
```

**Response:** Enhanced with `departments` array
```javascript
{
  success: true,
  user: {
    id: 14,
    username: "b.gopi@example.com",
    email: "b.gopi@example.com",
    role: "hod",
    name: "Dr. B. Gopi, IAS",
    hod_id: 24,
    department: "Higher Education",       // primary/first
    departments: [                        // ← NEW: All departments
      "Higher Education",
      "Agricultural Extension",
      "Animal Husbandry"
    ],
    password_changed: false,
    token: "eyJhbGc..."
  },
  token: "eyJhbGc...",
  requiresPasswordChange: true
}
```

---

## What Changed in Frontend?

### 1. HOD Creation Form
**No changes needed!** The form works exactly the same. The backend now handles the reuse logic automatically.

### 2. After Login - Use New `departments` Array

**Before:**
```javascript
// Old way - single department
const dept = user.department; // "Higher Education"
```

**After:**
```javascript
// New way - multiple departments
const allDepts = user.departments; // ["Higher Education", "Agricultural Extension", ...]

// Or still access primary:
const primaryDept = user.department;
```

### 3. Department Selector/Dropdown

You can now:
```javascript
// Show all departments HOD manages
<select>
  {user.departments.map(dept => (
    <option key={dept} value={dept}>{dept}</option>
  ))}
</select>
```

### 4. HOD Dashboard

Display all departments:
```javascript
<h2>{user.name}</h2>
<p>Role: {user.role}</p>
<p>Manages {user.departments.length} department(s):</p>
<ul>
  {user.departments.map((dept, i) => (
    <li key={i}>{dept}</li>
  ))}
</ul>
```

---

## Backend Response for HOD Lists

### GET /api/hods

**Response:** Now includes department mappings
```javascript
[
  {
    id: 24,
    name: "Dr. B. Gopi, IAS",
    email: "b.gopi@example.com",
    departments: [
      { 
        department_name: "Higher Education",
        category_id: 3,
        is_primary: true
      },
      { 
        department_name: "Agricultural Extension",
        category_id: 5,
        is_primary: false
      }
    ]
  }
]
```

**Use in Frontend:**
```javascript
{hods.map(hod => (
  <tr key={hod.id}>
    <td>{hod.name}</td>
    <td>{hod.email}</td>
    <td>{hod.departments.map(d => d.department_name).join(', ')}</td>
  </tr>
))}
```

---

## Email Notifications

### What Happens Now

**Scenario 1: New HOD Created**
```
POST /api/hods with new email
↓
Backend creates HOD
↓
Auto-generates password: K7@mN2*xPq9$
↓
Sends email to: b.gopi@example.com
  Subject: Your HOD Account Credentials
  Body: Username & temp password & instructions
↓
User receives email
↓
Logs in with username + temp password
```

**Scenario 2: Same HOD Added to New Department**
```
POST /api/hods with existing email + different department
↓
Backend finds existing HOD
↓
Adds new department mapping
↓
Auto-generates password: K7@mN2*xPq9$
↓
Sends email to: b.gopi@example.com
  Subject: Your HOD Account Credentials (Updated)
  Body: Same credentials (or asks to reset if different)
↓
User uses same login for all departments
```

---

## Error Handling

### Duplicate Department Assignment
```bash
POST /api/hods (same email + same department)

Response:
{
  "status": 400,
  "error": "This HOD is already assigned to the 'Higher Education' department."
}
```

**Frontend should handle:**
```javascript
try {
  const response = await axios.post('/api/hods', hodData);
  // Success - handle isNewHod flag
} catch (error) {
  if (error.response?.status === 400) {
    // Show user-friendly error
    alert(error.response.data.error);
  }
}
```

---

## Code Examples

### React HOD Creation with New Logic
```javascript
const [hods, setHods] = useState([]);

const handleCreateHOD = async (formData) => {
  try {
    const response = await axios.post('/api/hods', formData, {
      headers: { 'Authorization': `Bearer ${token}` }
    });
    
    // Response includes isNewHod flag
    if (response.data.isNewHod) {
      // First time creation
      alert(`HOD created! Credentials sent to ${response.data.email}`);
    } else {
      // Reused existing HOD
      alert(`${response.data.email} now manages additional departments:\n${response.data.departments.map(d => d.department_name).join(', ')}`);
    }
    
    // Refresh HOD list
    fetchHODs();
  } catch (error) {
    alert(`Error: ${error.response.data.error}`);
  }
};
```

### React HOD Login with Multiple Departments
```javascript
const handleLogin = async (username, password) => {
  try {
    const response = await axios.post('/api/auth/login', {
      username,
      password
    });
    
    const { user, token } = response.data;
    
    // Save user data - now includes departments array
    localStorage.setItem('user', JSON.stringify(user));
    localStorage.setItem('token', token);
    
    // Access departments
    console.log('HOD manages departments:', user.departments);
    // Output: ["Higher Education", "Agricultural Extension", "Animal Husbandry"]
    
    // Navigate to dashboard
    navigate('/dashboard');
  } catch (error) {
    alert(`Login failed: ${error.response.data.error}`);
  }
};
```

### Display HOD with All Departments
```javascript
const HODListItem = ({ hod }) => {
  return (
    <div>
      <h3>{hod.name}</h3>
      <p>Email: {hod.email}</p>
      <p>Manages {hod.departments.length} department(s):</p>
      <ul>
        {hod.departments.map((dept, i) => (
          <li key={i}>
            {dept.department_name}
            {dept.is_primary && ' (Primary)'}
          </li>
        ))}
      </ul>
    </div>
  );
};
```

---

## Testing Checklist

- [ ] Create new HOD → Verify `isNewHod: true` in response
- [ ] Add same HOD to new department → Verify `isNewHod: false`
- [ ] Check `departments` array has all mappings
- [ ] Try duplicate department → Verify 400 error
- [ ] Login with HOD → Verify `departments` array in response
- [ ] Display all departments in HOD list
- [ ] Check email received when HOD created
- [ ] Check email received when new department mapped

---

## Backward Compatibility

✅ All existing API endpoints still work exactly the same
✅ Existing code won't break
✅ New `departments` and `isNewHod` fields are optional additions
✅ Old code using `user.department` still works

---

## Implementation Notes

- **Email sending** happens asynchronously (doesn't block API response)
- **Password generation** is 12 chars with uppercase, lowercase, numbers, special chars
- **First login** requires password change for security
- **Department mappings** include `is_primary` flag (first mapped = primary)
- **Case-insensitive** email matching (B.Gopi@example.com = b.gopi@example.com)

---

## Questions?

Review the detailed implementation guide:
`HOD_MULTI_DEPT_IMPLEMENTATION.md`

Or check the backend code:
- `/backend/routes/hods.js` (lines 103-240)
- `/backend/routes/auth.js` (lines 90-96)
