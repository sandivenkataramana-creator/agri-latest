# Quick Reference: User Account Creation

## For HOD Account Creation

### Step-by-Step

1. **Navigate to HODs page** → Click "Add HOD" button
2. **Fill form:**
   - Name
   - Department
   - Category
   - Email (required for account)
   - Phone
   - Status
3. **Submit form** → HOD created
4. **Click mail icon** on the HOD row
5. **Password Modal opens** → Enter password
6. **Submit** → Account created
7. **Copy credentials:**
   - Username: [shown in alert]
   - Email: [shown in alert]
   - Password: [you entered]

### Login
- Go to Login page
- Enter: Username or Email
- Enter: Password (from alert)
- Submit

---

## For Staff Account Creation

### Step-by-Step

1. **Navigate to Staff page** → Click "Add Staff" button
2. **Fill form:**
   - Employee ID
   - Name
   - Designation
   - Department Category
   - Department
   - HOD (select from dropdown)
   - Email
   - Phone
   - Status
   - **NEW:** Password (optional, only for new staff)
3. **Enter password** if you want account created
4. **Submit form**
5. **If password provided:**
   - Staff created
   - Account created automatically
   - Success alert shows credentials:
     - Username: [auto-generated]
     - Email: [confirmed]
     - Password: [you entered]

### Login
- Go to Login page
- Enter: Username or Email
- Enter: Password (from alert)
- Submit

---

## Username Format

Automatically generated from name:
- **Input:** "John Doe"
- **Username:** "john.doe"
- **Input:** "Jane Smith"
- **Username:** "jane.smith"

If duplicate exists:
- First duplicate: "john.doe2"
- Second duplicate: "john.doe3"
- And so on...

---

## Important Notes

✓ Email is REQUIRED on HOD/Staff record
✓ Username is auto-generated (cannot be customized)
✓ Password is plain text on creation (change after first login)
✓ For Staff, password is optional
  - If empty: Staff created without account
  - If filled: Staff created AND account created
✓ Can create account later using mail icon if skipped

---

## Troubleshooting

**"Email not available" error**
- Add email to HOD/Staff record before creating account

**"Username already exists" error**
- This shouldn't happen - system auto-generates unique usernames
- Contact admin if issue persists

**Can't login with credentials**
- Verify username/email spelling matches
- Verify you're using correct password
- Check that account status is 'active'

**Forgot password**
- Ask admin to send new password (via mail icon on HODs page)
- Or create new account

**Staff created but no account**
- Password field was left blank (by design)
- Click mail icon on staff row to add password later
- Or edit staff and provide password to create account

---

## Access Control

After login, you get access based on your role:

**HOD Role:**
- HOD Dashboard
- Manage Schemes
- Manage Budget
- View Department Analytics
- Manage Staff under your department

**Staff Role:**
- Staff Dashboard
- View Attendance
- View Payroll
- Access HOD's data and reports
- Participate in departmental activities

---

## Security Tips

1. Change password immediately after first login
2. Don't share username/password
3. Logout when not using the system
4. Report suspicious login activity
5. Use strong passwords (uppercase, numbers, special chars)

---

## Getting Help

Contact Administrator for:
- Account creation issues
- Password reset
- Role/permission questions
- Access issues
- Account deactivation
