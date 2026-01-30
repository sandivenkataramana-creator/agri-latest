const nodemailer = require('nodemailer');
require('dotenv').config();

console.log('\n========== EMAIL CONFIGURATION TEST ==========\n');

// Display configuration
console.log('Configuration:');
console.log('SMTP_HOST:', process.env.SMTP_HOST);
console.log('SMTP_PORT:', process.env.SMTP_PORT);
console.log('SMTP_USER:', process.env.SMTP_USER);
console.log('SMTP_PASSWORD:', process.env.SMTP_PASSWORD ? '[SET]' : '[NOT SET]');
console.log('');

// Create transporter
const transporter = nodemailer.createTransport({
  host: process.env.SMTP_HOST || 'smtp.gmail.com',
  port: parseInt(process.env.SMTP_PORT) || 587,
  secure: false,
  auth: {
    user: process.env.SMTP_USER,
    pass: process.env.SMTP_PASSWORD
  },
  tls: {
    rejectUnauthorized: false
  }
});

console.log('Testing SMTP connection...\n');

// Test connection
transporter.verify((error, success) => {
  if (error) {
    console.log('❌ SMTP Connection Failed:');
    console.log('Error:', error.message);
    console.log('\n⚠️  TROUBLESHOOTING:');
    console.log('1. Check if SMTP_USER and SMTP_PASSWORD are correct in .env');
    console.log('2. For Gmail: Use App Password, not your regular password');
    console.log('3. Make sure port 587 is not blocked by firewall');
    console.log('4. Check that SMTP_HOST is: smtp.gmail.com');
    process.exit(1);
  } else {
    console.log('✓ SMTP Connection Successful!');
    console.log('\nSending test email...\n');

    // Send test email
    const testEmail = process.env.SMTP_USER; // Send to the same email
    
    const mailOptions = {
      from: `"HOD System Test" <${process.env.SMTP_USER}>`,
      to: testEmail,
      subject: 'Test Email - HOD Management System',
      html: `
        <div style="font-family: Arial, sans-serif;">
          <h2>Test Email Successful!</h2>
          <p>This is a test email from your HOD Management System.</p>
          <p><strong>Configuration Details:</strong></p>
          <ul>
            <li>SMTP Host: ${process.env.SMTP_HOST}</li>
            <li>SMTP Port: ${process.env.SMTP_PORT}</li>
            <li>From: ${process.env.SMTP_USER}</li>
            <li>To: ${testEmail}</li>
            <li>Timestamp: ${new Date().toLocaleString()}</li>
          </ul>
          <p>If you received this email, the email system is working correctly!</p>
        </div>
      `
    };

    transporter.sendMail(mailOptions, (error, info) => {
      if (error) {
        console.log('❌ Email Failed to Send:');
        console.log('Error:', error.message);
        console.log('\n⚠️  TROUBLESHOOTING:');
        console.log('1. Verify SMTP credentials are correct');
        console.log('2. For Gmail, make sure you created an "App Password"');
        console.log('3. Check internet connection');
        console.log('4. Try with a simpler password (avoid special characters)');
        process.exit(1);
      } else {
        console.log('✓ Test Email Sent Successfully!');
        console.log('Message ID:', info.messageId);
        console.log('\nCheck your email inbox at: ' + testEmail);
        console.log('If you don\'t see it within 30 seconds, check spam folder.');
        console.log('\n========== TEST COMPLETE ==========\n');
        process.exit(0);
      }
    });
  }
});

// Timeout after 10 seconds
setTimeout(() => {
  console.log('⏱️  Test timed out after 10 seconds');
  console.log('Possible issues:');
  console.log('- Network connectivity problem');
  console.log('- SMTP server not responding');
  console.log('- Firewall blocking SMTP port 587');
  process.exit(1);
}, 10000);
