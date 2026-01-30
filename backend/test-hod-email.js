const { sendAccountCredentials } = require('./services/emailService');

console.log('\n🧪 TESTING HOD ACCOUNT EMAIL SENDING\n');
console.log('========================================\n');

// Simulate HOD data
const testEmail = 'tpcchandicapped@gmail.com'; // Send to same account for testing
const testUsername = 'test.hod.admin';
const testPassword = 'TestPassword123!';
const userType = 'HOD';

console.log('📋 Test Parameters:');
console.log(`   Email: ${testEmail}`);
console.log(`   Username: ${testUsername}`);
console.log(`   Password: ${testPassword}`);
console.log(`   User Type: ${userType}\n`);

console.log('📤 Sending credentials email...\n');

// Add timeout to prevent hanging
const timeout = setTimeout(() => {
  console.log('\n⏱️  Email sending timed out after 15 seconds');
  console.log('This might indicate a network or SMTP server issue');
  process.exit(1);
}, 15000);

sendAccountCredentials(testEmail, testUsername, testPassword, userType)
  .then((result) => {
    clearTimeout(timeout);
    console.log('\n✅ Email send completed!\n');
    console.log('Result:', result);
    console.log('\n========================================');
    console.log('Check your email at:', testEmail);
    console.log('If you don\'t see it, check the spam folder');
    console.log('========================================\n');
    process.exit(0);
  })
  .catch((error) => {
    clearTimeout(timeout);
    console.log('\n❌ Error sending email:\n');
    console.error(error);
    console.log('\n========================================\n');
    process.exit(1);
  });
