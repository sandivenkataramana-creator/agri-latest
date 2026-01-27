# Email Notification Setup Guide

## Overview
The system now automatically sends email notifications with login credentials when HOD or Staff accounts are created. Users will receive their username and temporary password at their registered email address.

## What's New

### Changes Made:
1. **Email Service Enhanced** (`backend/services/emailService.js`)
   - Added `sendAccountCredentials()` function
   - Sends beautifully formatted HTML emails with account details
   - Includes security warnings and login instructions

2. **HOD Endpoint Updated** (`backend/routes/hods.js`)
   - POST `/api/hods/:id/create-account` now sends email
   - Response includes `emailSent: true` flag

3. **Staff Endpoint Updated** (`backend/routes/staff.js`)
   - POST `/api/staff/:id/create-account` now sends email
   - Response includes `emailSent: true` flag

## Email Configuration

### Current Settings (in `.env`):
```
SMTP_HOST=smtp.gmail.com
SMTP_PORT=587
SMTP_USER=tpcchandicapped@gmail.com
SMTP_PASSWORD=iowh xcma tlth hdfx
FRONTEND_URL=http://localhost:3000
```

### Using Gmail:
If using Gmail, follow these steps:
1. Go to your Google Account settings
2. Enable "Less secure app access" OR use "App Passwords"
3. Generate a 16-character app password
4. Update `SMTP_PASSWORD` in `.env`

### Using Other Email Services:
- **Outlook/Hotmail**: `smtp-mail.outlook.com` (port 587)
- **Yahoo Mail**: `smtp.mail.yahoo.com` (port 587 or 465)
- **Custom SMTP Server**: Update `SMTP_HOST` and `SMTP_PORT`

## Testing Email Functionality

### Manual Test:
```bash
# Create HOD account via API
curl -X POST http://localhost:5000/api/hods/24/create-account \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer YOUR_JWT_TOKEN" \
  -d '{"password": "TestPassword123"}'
```

### Expected Response:
```json
{
  "message": "User account created successfully. Credentials sent to email.",
  "username": "dr..b..gopi,.ias",
  "email": "svramana1998@gmail.com",
  "role": "hod",
  "hodId": "24",
  "accountCreated": true,
  "emailSent": true
}
```

### Check Logs:
Watch server console for:
```
User account created for HOD Dr. B. Gopi, IAS: {...}
Credentials email sent to svramana1998@gmail.com
```

## Troubleshooting

### Email Not Received

1. **Check Server Logs**
   ```
   Error sending email to user@example.com
   ```

2. **Common Issues**:
   - Gmail: Enable "Less secure app access" or use App Password
   - Firewall: Port 587 may be blocked
   - Invalid credentials: Double-check SMTP_USER and SMTP_PASSWORD
   - DNS issues: Check internet connection

3. **Verify SMTP Configuration**:
   ```bash
   # In Node.js terminal
   const transporter = nodemailer.createTransport({...});
   transporter.verify((error, success) => {
     if (error) console.log(error);
     else console.log('SMTP is ready');
   });
   ```

### Email Sent But Not Visible

- **Check spam/junk folder** - add sender email to contacts
- **Email domain reputation** - some systems may block new domains
- **Email client filters** - check email rules/filters

### Account Created But No Email

The account is still created successfully! The admin can:
1. Share credentials manually from the alert
2. Check server logs for the generated username
3. Query the database directly if needed

## Email Content

Users receive an HTML email with:
- ✅ Username (auto-generated)
- ✅ Temporary Password
- ✅ Email Address
- ✅ Security warnings
- ✅ Login instructions
- ✅ Link to login page

### Email Example:
```
Subject: Your HOD Account Credentials - HOD Management System

From: tpcchandicapped@gmail.com

Body:
- Account Created Successfully
- Login Credentials:
  - Username: dr.b.gopi.ias
  - Password: (your password)
  - Email: svramana1998@gmail.com
- Security Notes
- How to Login
- Support Contact
```

## API Response Changes

### Before:
```json
{
  "message": "User account created successfully",
  "username": "...",
  "email": "...",
  "accountCreated": true
}
```

### After:
```json
{
  "message": "User account created successfully. Credentials sent to email.",
  "username": "...",
  "email": "...",
  "accountCreated": true,
  "emailSent": true
}
```

## Production Recommendations

1. **Use Dedicated Email Service**:
   - SendGrid, Mailgun, AWS SES
   - Better reliability and deliverability

2. **Add Retry Logic**:
   - Retry email if first attempt fails
   - Store failed emails for manual sending

3. **Email Templates**:
   - Brand with company logo
   - Add company contact information
   - Include HR contact for password reset

4. **Security**:
   - Never log passwords in production
   - Use environment variables for SMTP credentials
   - Implement rate limiting on account creation

5. **Monitoring**:
   - Log all sent/failed emails
   - Track email delivery rates
   - Alert on email service failures

## Database Query

To check which emails were sent:
```sql
SELECT u.username, u.email, u.created_at 
FROM users 
WHERE u.role IN ('hod', 'staff') 
ORDER BY u.created_at DESC 
LIMIT 10;
```

## Support

For email configuration issues:
1. Check `.env` file SMTP settings
2. Review server console logs
3. Test with a simple Node.js script
4. Contact email service provider support

## Files Modified

- `backend/services/emailService.js` - Added sendAccountCredentials function
- `backend/routes/hods.js` - Import and use sendAccountCredentials
- `backend/routes/staff.js` - Import and use sendAccountCredentials

## Backwards Compatibility

- API endpoints still return credentials in response
- Admins can still see credentials in browser alert
- Email sending doesn't block account creation
- If email fails, account is still created successfully
