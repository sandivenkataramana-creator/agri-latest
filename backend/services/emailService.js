const nodemailer = require('nodemailer');
require('dotenv').config();
const appConfig = require('../config/appConfig');

// Debug: Log SMTP configuration on startup
console.log('Email Service Initializing...');
console.log('SMTP_HOST:', process.env.SMTP_HOST);
console.log('SMTP_PORT:', process.env.SMTP_PORT);
console.log('SMTP_USER:', process.env.SMTP_USER ? '✓ Configured' : '✗ Missing');
console.log('SMTP_PASSWORD:', process.env.SMTP_PASSWORD ? '✓ Configured' : '✗ Missing');

// Create reusable transporter
const transporter = nodemailer.createTransport({
  host: process.env.SMTP_HOST || 'smtp.gmail.com',
  port: parseInt(process.env.SMTP_PORT) || 587,
  secure: false, // true for 465, false for other ports
  auth: {
    user: process.env.SMTP_USER,
    pass: process.env.SMTP_PASSWORD
  },
  tls: {
    rejectUnauthorized: false // Allow self-signed certificates (for Gmail)
  }
});

// Verify transporter configuration (don't crash if it fails)
transporter.verify()
  .then(() => {
    console.log('✓ SMTP Server is ready to send emails');
  })
  .catch((error) => {
    console.log('✗ SMTP Configuration Error:', error.message || error);
    console.log('Email functionality will be limited. Server will continue running.');
    console.log('Make sure SMTP credentials are correct in .env file');
  });

// Email templates
const emailTemplates = {
  registrationSuccess: (name, username, password) => `
    <!DOCTYPE html>
    <html>
    <head>
      <style>
        body { font-family: Arial, sans-serif; line-height: 1.6; color: #333; }
        .container { max-width: 600px; margin: 0 auto; padding: 20px; }
        .header { background: #1b5e20; color: white; padding: 20px; text-align: center; border-radius: 8px 8px 0 0; }
        .content { background: #f9f9f9; padding: 30px; border-radius: 0 0 8px 8px; }
        .button { display: inline-block; padding: 12px 24px; background: #1b5e20; color: white; text-decoration: none; border-radius: 5px; margin: 20px 0; }
        .credentials { background: #fff; padding: 15px; border-left: 4px solid #1b5e20; margin: 20px 0; }
        .footer { text-align: center; margin-top: 20px; color: #666; font-size: 12px; }
      </style>
    </head>
    <body>
      <div class="container">
        <div class="header">
          <h1>Welcome to HOD Management System</h1>
        </div>
        <div class="content">
          <h2>Registration Successful!</h2>
          <p>Dear ${name},</p>
          <p>Your account has been successfully registered in the Telangana State HOD Management System.</p>
          
          <div class="credentials">
            <h3>Your Login Credentials:</h3>
            <p><strong>Username:</strong> ${username}</p>
            <p><strong>Email:</strong> ${username.includes('@') ? username : 'Use your registered email'}</p>
            <p><strong>Temporary Password:</strong> ${password}</p>
          </div>
          
          <p><strong>Important:</strong> For security reasons, please change your password immediately after your first login.</p>
          
          <a href="${appConfig.frontendUrl}/change-password" class="button">Change Password</a>
          
          <p>If you have any questions, please contact the system administrator.</p>
          
          <div class="footer">
            <p>© 2024 Government of Telangana. All Rights Reserved.</p>
            <p>This is an automated email. Please do not reply.</p>
          </div>
        </div>
      </div>
    </body>
    </html>
  `,

  forgotPasswordOTP: (name, otp) => `
    <!DOCTYPE html>
    <html>
    <head>
      <style>
        body { font-family: Arial, sans-serif; line-height: 1.6; color: #333; }
        .container { max-width: 600px; margin: 0 auto; padding: 20px; }
        .header { background: #1b5e20; color: white; padding: 20px; text-align: center; border-radius: 8px 8px 0 0; }
        .content { background: #f9f9f9; padding: 30px; border-radius: 0 0 8px 8px; }
        .otp-box { background: #fff; padding: 20px; text-align: center; border: 2px dashed #1b5e20; margin: 20px 0; }
        .otp-code { font-size: 32px; font-weight: bold; color: #1b5e20; letter-spacing: 5px; }
        .footer { text-align: center; margin-top: 20px; color: #666; font-size: 12px; }
        .warning { background: #fff3cd; padding: 15px; border-left: 4px solid #ffc107; margin: 20px 0; }
      </style>
    </head>
    <body>
      <div class="container">
        <div class="header">
          <h1>Password Reset Request</h1>
        </div>
        <div class="content">
          <h2>Hello ${name},</h2>
          <p>You have requested to reset your password for the HOD Management System.</p>
          
          <div class="otp-box">
            <p>Your One-Time Password (OTP) is:</p>
            <div class="otp-code">${otp}</div>
            <p style="font-size: 12px; margin-top: 10px;">This OTP is valid for 10 minutes only.</p>
          </div>
          
          <div class="warning">
            <p><strong>Security Notice:</strong></p>
            <p>If you did not request this password reset, please ignore this email or contact the administrator immediately.</p>
          </div>
          
          <p>Enter this OTP on the password reset page to create a new password.</p>
          
          <div class="footer">
            <p>© 2024 Government of Telangana. All Rights Reserved.</p>
            <p>This is an automated email. Please do not reply.</p>
          </div>
        </div>
      </div>
    </body>
    </html>
  `,

  passwordChanged: (name, newPassword = null) => `
    <!DOCTYPE html>
    <html>
    <head>
      <style>
        body { font-family: Arial, sans-serif; line-height: 1.6; color: #333; }
        .container { max-width: 600px; margin: 0 auto; padding: 20px; }
        .header { background: #1b5e20; color: white; padding: 20px; text-align: center; border-radius: 8px 8px 0 0; }
        .content { background: #f9f9f9; padding: 30px; border-radius: 0 0 8px 8px; }
        .success-box { background: #d4edda; padding: 15px; border-left: 4px solid #28a745; margin: 20px 0; }
        .password-box { background: #fff; padding: 15px; border: 2px solid #1b5e20; margin: 20px 0; text-align: center; border-radius: 6px; }
        .password-label { font-size: 12px; color: #666; }
        .password-value { font-size: 18px; font-weight: bold; color: #1b5e20; letter-spacing: 2px; font-family: monospace; }
        .footer { text-align: center; margin-top: 20px; color: #666; font-size: 12px; }
      </style>
    </head>
    <body>
      <div class="container">
        <div class="header">
          <h1>Password Changed Successfully</h1>
        </div>
        <div class="content">
          <h2>Hello ${name},</h2>
          
          <div class="success-box">
            <p><strong>Your password has been successfully changed.</strong></p>
          </div>
          
          ${newPassword ? `
          <div class="password-box">
            <p class="password-label">Your New Password:</p>
            <p class="password-value">${newPassword}</p>
            <p style="font-size: 12px; color: #666; margin-top: 10px;">Please keep this password safe and secure.</p>
          </div>
          ` : ''}
          
          <p>If you did not make this change or did not request this, please contact the system administrator immediately.</p>
          
          <div class="footer">
            <p>© 2024 Government of Telangana. All Rights Reserved.</p>
            <p>This is an automated email. Please do not reply.</p>
          </div>
        </div>
      </div>
    </body>
    </html>
  `
};

// Send email function
const sendEmail = (to, subject, html) => {
  return new Promise((resolve, reject) => {
    console.log(`\n📧 EMAIL SEND REQUEST`);
    console.log(`To: ${to}`);
    console.log(`Subject: ${subject}`);
    console.log(`SMTP Credentials Check:`);
    console.log(`  SMTP_USER: ${process.env.SMTP_USER ? '✓ Set' : '✗ Missing'}`);
    console.log(`  SMTP_PASSWORD: ${process.env.SMTP_PASSWORD ? '✓ Set' : '✗ Missing'}`);
    
    if (!process.env.SMTP_USER || !process.env.SMTP_PASSWORD) {
      console.error('❌ SMTP credentials not configured');
      resolve({ 
        success: false, 
        error: 'SMTP credentials not configured in .env file',
        message: 'Email service not available'
      });
      return;
    }

    console.log(`📧 Attempting to send email...`);
    
    const mailOptions = {
      from: `"HOD Management System" <${process.env.SMTP_USER}>`,
      to: to,
      subject: subject,
      html: html
    };

    transporter.sendMail(mailOptions, (error, info) => {
      if (error) {
        console.error(`\n❌ Error sending email to ${to}`);
        console.error(`Error message: ${error.message}`);
        console.error(`Error code: ${error.code}`);
        console.error(`Full error:`, error);
        console.error('');
        resolve({ 
          success: false, 
          error: error.message,
          email: to
        });
      } else {
        console.log(`✅ Email sent successfully to ${to}`);
        console.log(`Message ID: ${info.messageId}\n`);
        resolve({ success: true, messageId: info.messageId, email: to });
      }
    });
  });
};

// Send registration success email
const sendRegistrationEmail = async (email, name, username, password) => {
  const subject = 'Registration Successful - HOD Management System';
  const html = emailTemplates.registrationSuccess(name, username, password);
  return await sendEmail(email, subject, html);
};

// Send forgot password OTP email
const sendForgotPasswordEmail = async (email, name, otp) => {
  const subject = 'Password Reset OTP - HOD Management System';
  const html = emailTemplates.forgotPasswordOTP(name, otp);
  return await sendEmail(email, subject, html);
};

// Send password changed notification
const sendPasswordChangedEmail = async (email, name, newPassword = null) => {
  const subject = 'Password Changed - HOD Management System';
  const html = emailTemplates.passwordChanged(name, newPassword);
  return await sendEmail(email, subject, html);
};

// Send account credentials for HOD or Staff
const sendAccountCredentials = async (email, username, password, userType = 'HOD') => {
  console.log(`\n🔐 SENDING ACCOUNT CREDENTIALS EMAIL`);
  console.log(`User Type: ${userType}`);
  console.log(`Email: ${email}`);
  console.log(`Username: ${username}`);
  
  const subject = `Your ${userType} Account Credentials - HOD Management System`;
  const htmlContent = `
    <!DOCTYPE html>
    <html>
    <head>
      <style>
        body { font-family: Arial, sans-serif; line-height: 1.6; color: #333; }
        .container { max-width: 600px; margin: 0 auto; padding: 20px; }
        .header { background: #1b5e20; color: white; padding: 20px; text-align: center; border-radius: 8px 8px 0 0; }
        .content { background: #f9f9f9; padding: 30px; border-radius: 0 0 8px 8px; }
        .credentials { background: #fff; padding: 20px; border-left: 4px solid #1b5e20; margin: 20px 0; font-family: 'Courier New', monospace; }
        .credential-item { margin: 15px 0; }
        .credential-label { font-weight: bold; color: #1b5e20; }
        .credential-value { background: #f0f0f0; padding: 8px 12px; border-radius: 4px; margin-top: 5px; word-break: break-all; }
        .important { background: #fff3cd; padding: 15px; border-left: 4px solid #ffc107; margin: 20px 0; }
        .button { display: inline-block; padding: 12px 24px; background: #1b5e20; color: white; text-decoration: none; border-radius: 5px; margin: 20px 0; }
        .footer { text-align: center; margin-top: 20px; color: #666; font-size: 12px; }
      </style>
    </head>
    <body>
      <div class="container">
        <div class="header">
          <h1>Account Created Successfully</h1>
        </div>
        <div class="content">
          <p>Dear ${userType},</p>
          <p>Your ${userType} account has been created successfully in the HOD Management System. Here are your login credentials:</p>
          
          <div class="credentials">
            <div class="credential-item">
              <div class="credential-label">Username:</div>
              <div class="credential-value">${username}</div>
            </div>
            <div class="credential-item">
              <div class="credential-label">Password:</div>
              <div class="credential-value">${password}</div>
            </div>
            <div class="credential-item">
              <div class="credential-label">Email:</div>
              <div class="credential-value">${email}</div>
            </div>
          </div>
          
          <div class="important">
            <strong>Important Security Notes:</strong>
            <ul>
              <li>Keep your credentials confidential and do not share them with anyone</li>
              <li>Change your password immediately after your first login</li>
              <li>If you did not request this account, please contact the system administrator immediately</li>
              <li>Make sure to log out when using shared devices</li>
            </ul>
          </div>
          
          <p><strong>How to Login:</strong></p>
          <ol>
            <li>Visit the login page</li>
            <li>Enter your username or email</li>
            <li>Enter your password</li>
            <li>Click the Login button</li>
          </ol>
          
          <a href="${appConfig.frontendUrl}/login" class="button">Go to Login</a>
          
          <p>If you have any questions or need assistance, please contact the system administrator.</p>
          
          <div class="footer">
            <p>© 2024 Government of Telangana. All Rights Reserved.</p>
            <p>This is an automated email. Please do not reply.</p>
          </div>
        </div>
      </div>
    </body>
    </html>
  `;
  
  console.log(`Calling sendEmail function...`);
  const result = await sendEmail(email, subject, htmlContent);
  console.log(`sendAccountCredentials result:`, result);
  return result;
};

module.exports = {
  sendEmail,
  sendRegistrationEmail,
  sendForgotPasswordEmail,
  sendPasswordChangedEmail,
  sendAccountCredentials
};