# Email Not Sending - Troubleshooting Guide

## Problem
When you create a HOD or Staff account and enter a password, the account is created but **the password email is not received**.

## Quick Diagnosis

### Step 1: Run Email Test
```bash
cd backend
node test-email.js
```

This will:
- ✓ Verify SMTP configuration
- ✓ Test connection to Gmail SMTP
- ✓ Send a test email to your configured email address
- ✓ Show detailed error messages if anything fails

### Step 2: Check Server Logs
Look for messages like:
```
✓ SMTP Server is ready to send emails
📧 Attempting to send email to: user@example.com
✓ Email sent successfully: <message-id>
```

If you see errors like:
```
✗ SMTP Connection Failed
✗ Error sending email
```
Then follow the solutions below.

---

## Common Issues & Solutions

### Issue 1: SMTP Credentials Not Configured

**Error Message:**
```
⚠️ SMTP credentials not configured
SMTP_USER: ✗ Missing
SMTP_PASSWORD: ✗ Missing
```

**Solution:**
1. Open `backend/.env`
2. Add these lines (if not already present):
```
SMTP_HOST=smtp.gmail.com
SMTP_PORT=587
SMTP_USER=your-email@gmail.com
SMTP_PASSWORD=your-app-password
```

3. **Important for Gmail:** Use an **App Password**, NOT your regular Gmail password
   - Go to: https://myaccount.google.com/apppasswords
   - Select "Mail" and "Windows Computer"
   - Copy the 16-character password
   - Paste it into `SMTP_PASSWORD`

4. Restart the backend server

---

### Issue 2: Invalid Gmail App Password

**Error Message:**
```
Error sending email: Invalid login: 535-5.7.8 Username and password not accepted
```

**Solution:**
1. You're using the wrong password
2. Go to: https://myaccount.google.com/apppasswords
3. **Create a NEW App Password:**
   - Select App: **Mail**
   - Select Device: **Windows Computer**
   - Click **Generate**
   - Copy the **16-character password** (ignore spaces)
   - Paste into `SMTP_PASSWORD` in `.env`
4. Remove spaces from the password
5. Restart the server

**Current .env should look like:**
```
SMTP_USER=tpcchandicapped@gmail.com
SMTP_PASSWORD=iowh xcma tlth hdfx
```
(Remove internal spaces if password doesn't work)

---

### Issue 3: Two-Factor Authentication Enabled

**Error Message:**
```
Error: Login with your email and password
```

**Solution:**
1. Google requires app-specific passwords if 2FA is enabled
2. Go to: https://myaccount.google.com/apppasswords
3. Sign in if prompted
4. Select: Mail + Windows Computer
5. Generate a new app password
6. Use THIS password in `.env`, not your Gmail password

---

### Issue 4: Firewall/Network Blocking Port 587

**Error Message:**
```
Error: connect ETIMEDOUT [IP]:587
Error: connect ECONNREFUSED
```

**Solution:**
1. Check if port 587 is blocked:
   ```powershell
   # In PowerShell as Administrator:
   Test-NetConnection smtp.gmail.com -Port 587
   ```
   
2. If blocked, ask your IT department to unblock:
   - SMTP to smtp.gmail.com on port 587
   
3. Alternative: Use port 465 (SSL)
   - Change in `.env`:
   ```
   SMTP_PORT=465
   SMTP_SECURE=true
   ```
   (Note: This requires code change in emailService.js)

---

### Issue 5: Email Configured But Still No Email Received

**Possible Causes:**

1. **Email going to SPAM:**
   - Check spam/junk folder
   - Add `tpcchandicapped@gmail.com` to your contacts
   - Mark email as "Not Spam"

2. **Email domain reputation:**
   - Gmail might block emails from new domains
   - Solution: Use a reputable email service like SendGrid

3. **Server logs show email sent:**
   - Check console: `✓ Email sent successfully`
   - Wait 2-3 minutes (Gmail may delay)
   - Check spam folder
   - Check different email account

---

## How to Fix Emails Not Sending

### Step 1: Update .env File

```dotenv
SMTP_HOST=smtp.gmail.com
SMTP_PORT=587
SMTP_USER=tpcchandicapped@gmail.com
SMTP_PASSWORD=iowh xcma tlth hdfx
FRONTEND_URL=http://localhost:3000
```

**For the SMTP_PASSWORD:**
- Get App Password from: https://myaccount.google.com/apppasswords
- Use 16-character password, NOT your Gmail password
- Remove any spaces

### Step 2: Test Email Configuration

```bash
cd backend
node test-email.js
```

Expected output:
```
✓ SMTP Connection Successful!
✓ Test Email Sent Successfully!
Message ID: <12345...>
```

### Step 3: Verify Email Receipt

1. Check inbox of `SMTP_USER` email (where test was sent)
2. If not found, check SPAM folder
3. If still missing, check error messages in test output

### Step 4: Restart Backend Server

```bash
# Kill current server (Ctrl+C)
# Then restart:
npm start
```

### Step 5: Test by Creating Account

1. Go to HODs page
2. Click mail icon on any HOD
3. Enter a temporary password
4. Click "Send Password"
5. Check email for credentials within 30 seconds

---

## Verification Checklist

- [ ] SMTP_HOST is `smtp.gmail.com`
- [ ] SMTP_PORT is `587`
- [ ] SMTP_USER is your email address
- [ ] SMTP_PASSWORD is your **App Password** (not Gmail password)
- [ ] App Password is 16 characters with spaces removed
- [ ] Server logs show: "SMTP Server is ready to send emails"
- [ ] Test email succeeds with `node test-email.js`
- [ ] Email received in inbox or spam folder
- [ ] Backend server restarted after changing .env

---

## Using Alternative Email Services

If Gmail SMTP doesn't work, use these alternatives:

### SendGrid (Recommended for Production)
```
SMTP_HOST=smtp.sendgrid.net
SMTP_PORT=587
SMTP_USER=apikey
SMTP_PASSWORD=SG.xxxxxxxxxxxxxxxxxxxxx
```
- Free tier: 100 emails/day
- Sign up: https://sendgrid.com

### Mailgun
```
SMTP_HOST=smtp.mailgun.org
SMTP_PORT=587
SMTP_USER=postmaster@yourdomainname.mg
SMTP_PASSWORD=your-mailgun-password
```

### AWS SES
```
SMTP_HOST=email-smtp.us-east-1.amazonaws.com
SMTP_PORT=587
SMTP_USER=your-ses-user
SMTP_PASSWORD=your-ses-password
```

---

## Check Server Console

After creating an account, look for these messages in the backend terminal:

**✓ Success:**
```
User account created for HOD Dr. B. Gopi, IAS: {...}
📧 Attempting to send email to: svramana1998@gmail.com
✓ Email sent successfully to svramana1998@gmail.com: <message-id>
```

**✗ Failure:**
```
✗ Error sending email to svramana1998@gmail.com: Invalid login
Error details: {error object}
```

---

## Database Backup

User accounts are **still created** even if email fails. Check database:

```sql
SELECT username, email, role, name, status FROM users 
WHERE role IN ('hod', 'staff') 
ORDER BY created_at DESC LIMIT 5;
```

You can:
- Share credentials manually from UI alert
- Send password via different email later
- Retrieve from database if needed

---

## Support

If email still doesn't work:

1. **Check backend logs** - copy the error message
2. **Run test-email.js** - provides detailed diagnostics
3. **Verify .env file** - SMTP settings must be correct
4. **Restart server** - changes to .env require restart
5. **Check spam folder** - emails might be filtered

**Key indicators:**
- "SMTP Server is ready" = ✓ Configuration OK
- "Email sent successfully" = ✓ Email sent
- No "Email sent" message = Email sending code didn't run or failed

---

## Files Modified

- `backend/services/emailService.js` - Enhanced with better logging
- `backend/test-email.js` - New test script
- `.env` - Check SMTP configuration

**No code changes needed to endpoints** - they're already sending emails correctly!
