# Fix Email Not Sending - Action Plan

## The Problem
✗ You created a HOD account
✗ Account created successfully in database
✗ But password email was NOT received

## The Solution (Step by Step)

### 1️⃣ Stop the Backend Server
```
Press Ctrl+C in the backend terminal
```

### 2️⃣ Check Gmail App Password
1. Go to: https://myaccount.google.com/apppasswords
2. Sign in with `tpcchandicapped@gmail.com`
3. Select:
   - **App:** Mail
   - **Device:** Windows Computer
4. Click **Generate**
5. Copy the **16-character password** shown
6. Keep this window open

### 3️⃣ Update .env File
1. Open: `backend/.env`
2. Find or add these lines:
```dotenv
SMTP_HOST=smtp.gmail.com
SMTP_PORT=587
SMTP_USER=tpcchandicapped@gmail.com
SMTP_PASSWORD=iowh xcma tlth hdfx
FRONTEND_URL=http://localhost:3000
```

3. If using NEW password from step 2:
   - Replace the `SMTP_PASSWORD` value
   - Remove any spaces from the password
   - Save the file

### 4️⃣ Test Email Configuration
```bash
# In PowerShell, navigate to backend folder:
cd backend

# Run the test:
node test-email.js
```

**Expected Output:**
```
✓ SMTP Connection Successful!
✓ Test Email Sent Successfully!
Message ID: <xxx>
```

**If error:** Follow the troubleshooting guide below

### 5️⃣ Restart Backend Server
```bash
npm start
```

### 6️⃣ Test by Creating HOD Account
1. Go to Frontend (http://localhost:3000)
2. Navigate to HODs section
3. Click mail icon on any HOD
4. Enter a test password like: `TestPass123`
5. Click "Send Password"
6. **Check email inbox for `tpcchandicapped@gmail.com` account**
7. Look for email titled: "Your HOD Account Credentials"

### 7️⃣ Verify Email Received
- ✓ Email in inbox? **SUCCESS!**
- ✗ Email in spam? Add to contacts
- ✗ No email? Run `node test-email.js` again

---

## If Test Fails

### Error: "SMTP Connection Failed"
```
Solution:
1. Check SMTP_USER is: tpcchandicapped@gmail.com
2. Check SMTP_PASSWORD is correct from Gmail App Passwords
3. Remove spaces from password
4. Make sure port 587 is not blocked
```

### Error: "Username and password not accepted"
```
Solution:
1. Go to: https://myaccount.google.com/apppasswords
2. Generate NEW app password
3. Copy the 16-character code
4. Paste to SMTP_PASSWORD (remove spaces)
5. Save .env file
6. Restart server
7. Run test-email.js again
```

### Error: "Connect ETIMEDOUT"
```
Solution:
1. Check internet connection
2. Try: Test-NetConnection smtp.gmail.com -Port 587 (in PowerShell)
3. If blocked, ask IT to unblock port 587
4. Or use port 465 (requires code change)
```

---

## Quick Checklist

```
Before testing:
☐ SMTP_HOST = smtp.gmail.com
☐ SMTP_PORT = 587
☐ SMTP_USER = tpcchandicapped@gmail.com
☐ SMTP_PASSWORD = valid App Password (16 chars, no spaces)
☐ Backend server restarted
☐ .env file saved

Testing:
☐ Run: node test-email.js
☐ Should show: ✓ SMTP Connection Successful!
☐ Should show: ✓ Test Email Sent Successfully!
☐ Check email inbox for test email

Using the system:
☐ Create HOD account with password
☐ Email should arrive within 30 seconds
☐ If not, check spam folder
☐ If still missing, see troubleshooting guide
```

---

## Server Console Messages to Expect

When you send a password email, you should see:

```
User account created for HOD Dr. B. Gopi, IAS: {
  userId: 14,
  username: 'dr..b..gopi,.ias',
  email: 'svramana1998@gmail.com'
}
📧 Attempting to send email to: svramana1998@gmail.com
✓ Email sent successfully to svramana1998@gmail.com: <message-id>
```

**If you don't see these messages:**
- Email sending code isn't being called
- Check that password field has a value
- Verify the endpoint was called correctly

---

## Still Not Working?

1. **Share these logs:**
   - Output from `node test-email.js`
   - Server console messages when creating account
   - Any error messages

2. **Check:**
   - Gmail account status (not locked/suspended)
   - Two-factor authentication is enabled
   - App Password was generated correctly
   - Internet connection is stable

3. **Alternative:**
   - Manually share credentials from the UI alert
   - Password is still visible in admin interface
   - Users can login with credentials from alert

---

## Files You May Need to Check/Edit

- `backend/.env` - SMTP configuration
- `backend/services/emailService.js` - Email service code
- `backend/routes/hods.js` - Where email is sent from
- `backend/routes/staff.js` - Where email is sent from

## Test Files

- `backend/test-email.js` - Run to diagnose email issues
- `EMAIL_TROUBLESHOOTING.md` - Detailed troubleshooting guide

---

## Success Indicators

✓ User receives email with credentials
✓ Email subject: "Your HOD Account Credentials - HOD Management System"
✓ Email contains: Username, Password, Login Instructions
✓ Email sent from: tpcchandicapped@gmail.com
✓ Server logs show: "Email sent successfully"
