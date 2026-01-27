# User Account Creation Guide
## Automatic User Authentication for HODs and Staff

### Overview

This implementation ensures that users created from the HODs and Staff management pages are automatically stored with login credentials in the authentication system, allowing them to authenticate directly without requiring manual registration through the RegisterUser page.

---

## Implementation Details

### 1. Backend Changes

#### New Endpoints

**HOD Account Creation:**
- **Endpoint:** `POST /api/hods/:id/create-account`
- **Authentication:** Requires SuperAdmin role
- **Request Body:**
  ```json
  {
    "password": "user_password_here"
  }
  ```
- **Response (201):**
  ```json
  {
    "message": "User account created successfully",
    "username": "generated_username",
    "email": "hod@email.com",
    "role": "hod",
    "hodId": 1,
    "accountCreated": true
  }
  ```
- **Features:**
  - Automatically generates unique username from HOD name (lowercase, spaces replaced with dots)
  - Stores password in users table
  - Links user to HOD via hod_id foreign key
  - Assigns 'hod' role to user
  - Idempotent: Can be called multiple times to update password if user already exists

**Staff Account Creation:**
- **Endpoint:** `POST /api/staff/:id/create-account`
- **Authentication:** Requires SuperAdmin role
- **Request Body:**
  ```json
  {
    "password": "user_password_here"
  }
  ```
- **Response (201):**
  ```json
  {
    "message": "User account created successfully",
    "username": "generated_username",
    "email": "staff@email.com",
    "role": "staff",
    "staffId": 1,
    "hodId": 5,
    "accountCreated": true
  }
  ```
- **Features:**
  - Automatically generates unique username from Staff name
  - Stores password in users table
  - Links user to Staff via staff_id foreign key
  - Links user to HOD via hod_id (inherited from staff record)
  - Assigns 'staff' role to user
  - Idempotent: Can update password if user already exists

#### Database Schema

Uses existing `users` table with these relevant fields:
```sql
CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    role ENUM('superadmin', 'admin', 'hod', 'staff', 'district_officer'),
    hod_id INT NULL,
    staff_id INT NULL,
    name VARCHAR(255) NOT NULL,
    status ENUM('active', 'inactive') DEFAULT 'active',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    ...
);
```

#### Modified Files

**File:** `backend/routes/hods.js`
- Added `/api/hods/:id/create-account` POST endpoint
- Updated `/api/hods/:id/send-password` to call create-account internally

**File:** `backend/routes/staff.js`
- Added `/api/staff/:id/create-account` POST endpoint

---

### 2. Frontend Changes

#### API Service Functions

**File:** `frontend/src/services/api.js`
```javascript
// New functions added:
export const createHODAccount = (hodId, password) => 
  api.post(`/hods/${hodId}/create-account`, { password });

export const createStaffAccount = (staffId, password) => 
  api.post(`/staff/${staffId}/create-account`, { password });
```

#### HODs Page Updates

**File:** `frontend/src/pages/HODs.js`

- **Updated:** `handleSendPassword()` function
  - Calls `/api/hods/:id/create-account` endpoint
  - Displays generated username and credentials in success alert
  - Shows format: `Username: [generated], Email: [hod_email], Password: [provided]`
  - Allows SuperAdmin to set initial password and create account simultaneously

**Password Modal Feature:**
- Mail icon with `<FiMail>` icon triggers password modal
- Modal allows entering password
- On submit, creates user account with that password
- Displays credentials for HOD to use for login

#### Staff Page Updates

**File:** `frontend/src/pages/Staff.js`

- **Updated:** Form state to include `password` field
- **Updated:** `handleSubmit()` function
  - When creating new staff member with password field filled:
    1. Creates staff record
    2. Calls `/api/staff/:id/create-account` with provided password
    3. Shows success alert with generated username and credentials
  - Password field only shown for new staff (not during edit)
  - Password is optional - can skip account creation by leaving blank

- **New Form Field:**
  - Label: "Password (for login account)"
  - Type: password
  - Placeholder: "Leave blank to skip account creation"
  - Only visible when creating new staff (not editing)

---

## User Authentication Flow

### For HODs

1. **SuperAdmin creates HOD** via HODs page form
   - Fills: Name, Department, Category, Email, Phone, Status
   - HOD record created in `hods` table

2. **SuperAdmin sends password** to HOD
   - Clicks Mail icon (`<FiMail>`) on HOD record
   - Password Modal opens
   - Enters password
   - System creates user account in `users` table with:
     - Username: auto-generated from HOD name
     - Password: provided by admin
     - Role: 'hod'
     - Links to HOD via hod_id

3. **HOD logs in** on Login page
   - Uses generated username or email
   - Uses provided password
   - Authenticated as 'hod' role
   - Can access HOD dashboard and features

### For Staff

1. **SuperAdmin creates Staff** via Staff page form
   - Fills: Employee ID, Name, Designation, Department, Category, HOD, Email, Phone, Status
   - **New:** Password field (optional)
   - If password provided, staff record created AND account created in one flow

2. **Account creation is automatic** when staff created with password
   - System creates staff record in `staff` table
   - System creates user account in `users` table with:
     - Username: auto-generated from Staff name
     - Password: provided by admin
     - Role: 'staff'
     - Links to Staff via staff_id
     - Links to HOD via hod_id (from staff record)

3. **Staff logs in** on Login page
   - Uses generated username or email
   - Uses provided password
   - Authenticated as 'staff' role
   - Can access Staff dashboard and features
   - Data is automatically linked to their HOD

---

## Key Features

### 1. Automatic Username Generation
- Converts name to lowercase
- Replaces spaces with dots
- Example: "John Doe" → "john.doe"
- Handles duplicates by appending counter: "john.doe2", "john.doe3", etc.

### 2. Unique Usernames
- Before creating account, checks if username already exists
- Appends numeric suffix if needed
- Ensures no duplicate usernames in system

### 3. Email Validation
- Both HOD and Staff must have email address
- Email must be unique in users table
- Error returned if email not available

### 4. Password Management
- Passwords stored in users table (in production should be hashed with bcrypt)
- Current implementation: plain text (for demo)
- Can be updated by calling create-account endpoint again

### 5. Role-Based Authorization
- HOD users get 'hod' role
- Staff users get 'staff' role
- Roles control access to different features and dashboards
- Role checked in login response and stored in localStorage

### 6. Foreign Key Relationships
- HOD users linked to hods table via hod_id
- Staff users linked to staff table via staff_id
- Staff users also linked to hods table via inherited hod_id
- Enables efficient querying of users by department/HOD

---

## Login Process

### Using Username
1. User enters username (e.g., "john.doe") on login page
2. Backend queries: `SELECT * FROM users WHERE LOWER(username) = ?`
3. Matches user record
4. Compares password (plain text comparison in current version)
5. Returns user with role and related data (HOD info, department, etc.)
6. Frontend stores token and user data in localStorage
7. User authenticated and redirected to dashboard

### Using Email
1. User enters email on login page
2. Backend queries: `SELECT * FROM users WHERE LOWER(email) = ?`
3. Matches user record
4. Same authentication flow continues
5. Works as alternative to username

---

## Database Diagram

```
users table (Authentication)
├── id (PK)
├── username (UNIQUE)
├── password
├── email (UNIQUE)
├── role (enum: superadmin, admin, hod, staff, district_officer)
├── hod_id (FK → hods.id)
├── staff_id (FK → staff.id)
├── name
├── status
├── created_at
└── updated_at

hods table (HOD Records)
├── id (PK)
├── name
├── department
├── email (UNIQUE)
├── phone
├── status
└── ...

staff table (Staff Records)
├── id (PK)
├── name
├── employee_id (UNIQUE)
├── email
├── hod_id (FK → hods.id)
└── ...
```

---

## API Usage Examples

### Create HOD Account (via HODs page mail button)

```javascript
// In HODs.js handleSendPassword()
const response = await axios.post(
  'http://localhost:5000/api/hods/1/create-account',
  { password: 'SecurePass123' },
  { headers: { Authorization: `Bearer ${token}` } }
);

// Response:
{
  "message": "User account created successfully",
  "username": "john.doe",
  "email": "john@example.com",
  "role": "hod",
  "hodId": 1,
  "accountCreated": true
}
```

### Create Staff Account (via Staff page form)

```javascript
// In Staff.js handleSubmit()
const response = await createStaffAccount(staffId, password);

// Response:
{
  "message": "User account created successfully",
  "username": "jane.smith",
  "email": "jane@example.com",
  "role": "staff",
  "staffId": 5,
  "hodId": 1,
  "accountCreated": true
}
```

### Login with Created Credentials

```javascript
// Login request
const loginResponse = await axios.post(
  'http://localhost:5000/api/auth/login',
  { username: 'john.doe', password: 'SecurePass123' }
);

// Response includes:
{
  "token": "JWT_TOKEN",
  "user": {
    "id": 1,
    "username": "john.doe",
    "email": "john@example.com",
    "role": "hod",
    "name": "John Doe",
    "hod_id": 1,
    "department": "Agriculture"
  }
}
```

---

## Testing Checklist

- [ ] Create HOD from HODs page with name and email
- [ ] Click mail icon to open password modal
- [ ] Enter password and submit
- [ ] Verify success alert shows generated username
- [ ] Login page: Try logging in with generated username and password
- [ ] Verify user authenticated with 'hod' role
- [ ] Verify HOD dashboard shows correct department
- [ ] Create Staff from Staff page with name, email, and password
- [ ] Submit form
- [ ] Verify success alert shows staff and account creation details
- [ ] Login page: Try logging in with generated staff username and password
- [ ] Verify user authenticated with 'staff' role
- [ ] Verify Staff dashboard shows correct HOD association
- [ ] Test duplicate username handling (create two staff with same name)
- [ ] Verify second staff gets username with counter (e.g., "john.smith2")
- [ ] Test updating password by sending password again for same HOD
- [ ] Verify password is updated in users table

---

## Security Considerations

### Current Implementation
- Passwords stored in plain text (for demo purposes)
- No password hashing used
- Suitable for development/testing only

### Production Recommendations
1. **Enable Password Hashing:**
   ```javascript
   const bcrypt = require('bcrypt');
   const hashedPassword = await bcrypt.hash(password, 10);
   ```

2. **Update Login Comparison:**
   ```javascript
   const passwordMatch = await bcrypt.compare(password, user.password);
   ```

3. **Add Password Validation:**
   - Minimum 8 characters
   - Mix of uppercase, lowercase, numbers, special characters
   - Check against common password lists

4. **Implement Password Reset:**
   - Email-based OTP for password recovery
   - Cannot reset via admin without OTP verification

5. **Add Audit Logging:**
   - Log all account creations
   - Log all password changes
   - Log all login attempts

6. **Session Management:**
   - Implement token expiration
   - Add refresh token mechanism
   - Implement logout with token blacklist

---

## Files Modified

1. **Backend:**
   - `backend/routes/hods.js` - Added account creation endpoint
   - `backend/routes/staff.js` - Added account creation endpoint

2. **Frontend:**
   - `frontend/src/services/api.js` - Added API functions
   - `frontend/src/pages/HODs.js` - Updated password sending logic
   - `frontend/src/pages/Staff.js` - Added password field and account creation

3. **Database:**
   - No schema changes (uses existing users table)

---

## Troubleshooting

### Issue: "HOD email not available"
- **Cause:** HOD record doesn't have email address
- **Solution:** Add email address to HOD record before creating account

### Issue: "Username already exists"
- **Cause:** Username auto-generation found duplicate
- **Solution:** Backend automatically appends counter (e.g., "john.doe2")

### Issue: Login fails with created credentials
- **Cause:** Email field might not match exactly (case sensitivity)
- **Solution:** Backend does case-insensitive comparison, check if correct email/username used

### Issue: Staff created but account not created
- **Cause:** Password field was left blank during creation
- **Solution:** This is by design - password is optional. Edit staff record and use mail icon, or recreate with password

---

## Future Enhancements

1. **Bulk Account Creation**
   - CSV import with automatic account creation
   - Batch email sending with credentials

2. **Email Notifications**
   - Send credentials via email automatically
   - Temporary password on first login
   - Email templates with branding

3. **Account Deactivation**
   - Deactivate user when HOD/Staff marked inactive
   - Archive inactive accounts

4. **Password Policy**
   - Enforce password complexity
   - Require password change on first login
   - Password expiration policies

5. **Multi-Factor Authentication**
   - OTP via email/SMS
   - TOTP (Time-based One-Time Password)
   - 2FA for sensitive operations

6. **Audit Trail**
   - Complete login/logout history
   - Failed login attempts
   - Account modifications log
