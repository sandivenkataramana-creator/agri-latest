# Diagnostic Guide: Email Not Sending with Send Password Button

## Your Situation
- ✅ Email works when registering employees (RegisterUser page)
- ❌ Email NOT working when using "Send Password" button for HODs
- ✅ Account is created successfully in database
- ❌ But email is not received

## Why This Happens

When you register an employee, the `sendRegistrationEmail` function is called, which IS working.

When you use "Send Password" on HOD modal, the `sendAccountCredentials` function is called, which may not be working.

**Both functions use the same underlying `sendEmail` function**, so the issue is likely:
1. The endpoint is not being called
2. The email is being sent but not received
3. SMTP credentials are not set when the backend started

## Step 1: Restart Backend Server

This is critical! After any `.env` changes, the backend must restart:

```bash
# In backend terminal:
# Press Ctrl+C to stop the server
# Then restart:
npm start
```

Watch for this log message when server starts:
```
✓ SMTP Server is ready to send emails
```

## Step 2: Check Backend Logs

When you click "Send Password" and enter a password, you should see detailed logs like:

```
🔐 SENDING ACCOUNT CREDENTIALS EMAIL
User Type: HOD
Email: svramana1998@gmail.com
Username: dr.b.gopi.ias
Calling sendEmail function...

📧 EMAIL SEND REQUEST
To: svramana1998@gmail.com
Subject: Your HOD Account Credentials - HOD Management System
SMTP Credentials Check:
  SMTP_USER: ✓ Set
  SMTP_PASSWORD: ✓ Set
📧 Attempting to send email...
✅ Email sent successfully to svramana1998@gmail.com
Message ID: <message-id>
sendAccountCredentials result: { success: true, messageId: '...' }
```

**If you DON'T see these logs:**
- The "Send Password" endpoint is not being called
- Check the browser network tab to see if API call was made
- Check the frontend for JavaScript errors

**If you see error logs:**
```
❌ SMTP credentials not configured
❌ Error sending email
```
- SMTP is not properly configured
- Check `.env` file

## Step 3: Test Email Configuration

```bash
cd backend
node test-email.js
```

This will:
- ✓ Check if SMTP is configured
- ✓ Test connection to Gmail SMTP
- ✓ Send a real test email
- ✓ Show detailed error if anything fails

## Step 4: Verify .env File

Open `backend/.env` and verify:

```
SMTP_HOST=smtp.gmail.com
SMTP_PORT=587
SMTP_USER=tpcchandicapped@gmail.com
SMTP_PASSWORD=iowh xcma tlth hdfx
FRONTEND_URL=http://localhost:3000
```

All four SMTP settings must be present!

## Step 5: Test the Feature

1. **Restart backend** (important!)
2. Go to HODs page
3. Click mail icon on any HOD
4. Enter a test password (e.g., `Test123`)
5. Click "Send Password"
6. **IMMEDIATELY check backend console for logs**
7. Check email inbox for message

## Troubleshooting by Logs

### Log Type 1: Email Sent Successfully ✅
```
✅ Email sent successfully to svramana1998@gmail.com
```
**What to do:** Check your email inbox AND spam folder

### Log Type 2: SMTP Credentials Missing ❌
```
❌ SMTP credentials not configured
SMTP_USER: ✗ Missing
SMTP_PASSWORD: ✗ Missing
```
**What to do:** 
1. Add SMTP settings to `.env`
2. Restart backend
3. Try again

### Log Type 3: Authentication Failed ❌
```
❌ Error sending email
Error message: Invalid login: 535-5.7.8 Username and password not accepted
```
**What to do:**
1. Go to: https://myaccount.google.com/apppasswords
2. Generate NEW app password
3. Update SMTP_PASSWORD in `.env` (remove spaces)
4. Restart backend
5. Try again

### Log Type 4: Connection Timeout ❌
```
❌ Error sending email
Error message: connect ETIMEDOUT
```
**What to do:**
1. Check internet connection
2. Check if port 587 is blocked by firewall
3. Try: `ping smtp.gmail.com` in terminal
4. Contact IT if port is blocked

### Log Type 5: Endpoint Not Called ❌
(No 🔐 or 📧 logs appear at all)
**What to do:**
1. Check browser's Network tab (F12 → Network)
2. Click "Send Password" and look for API call
3. If no call appears: there's a frontend issue
4. Check browser console (F12 → Console) for errors

## Complete Checklist

When "Send Password" doesn't send email:

```
Verification Steps:
☐ Backend server restarted (CRITICAL!)
☐ .env has all 4 SMTP settings
☐ .env SMTP_PASSWORD doesn't have spaces
☐ Backend logs show "SMTP Server is ready"
☐ Clicked "Send Password" and saw no errors
☐ Check backend logs for 📧 EMAIL SEND REQUEST
☐ Check logs for ✅ Email sent successfully
☐ Checked email inbox and spam folder
☐ Waited 30 seconds for email
☐ Ran test-email.js successfully
```

## Quick Diagnosis

**Test this right now:**

1. Restart backend: `npm start`
2. Run test: `node test-email.js`
3. If test passes: Email service is working
4. Then test the UI: Click "Send Password" on any HOD
5. Check backend logs
6. Check email

This will quickly show if the issue is:
- SMTP configuration (test-email.js will reveal)
- Frontend not calling endpoint (logs won't show 📧)
- Email being blocked/delayed (check spam folder)

## Files Modified (with logging)

- `backend/services/emailService.js` - Enhanced with detailed logging
- `backend/test-email.js` - Diagnostic tool

**No code logic changed** - just added logging to help diagnose!

## Success Indicators

When working correctly, you will see:

```
🔐 SENDING ACCOUNT CREDENTIALS EMAIL
User Type: HOD
Email: <email>@gmail.com
Username: <auto-generated>
Calling sendEmail function...

📧 EMAIL SEND REQUEST
To: <email>@gmail.com
Subject: Your HOD Account Credentials - HOD Management System
SMTP Credentials Check:
  SMTP_USER: ✓ Set
  SMTP_PASSWORD: ✓ Set
📧 Attempting to send email...
✅ Email sent successfully to <email>@gmail.com
Message ID: <xxx-xxx-xxx>
```

And you'll receive the email within 30 seconds!
