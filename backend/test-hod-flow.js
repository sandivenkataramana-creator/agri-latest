/**
 * Test script to debug HOD account creation and email sending
 * This simulates the exact flow when "Send Password" is clicked
 */

const db = require('./config/database');
const { sendAccountCredentials } = require('./services/emailService');

console.log('\n========================================');
console.log('🧪 HOD ACCOUNT CREATION & EMAIL TEST');
console.log('========================================\n');

async function testHodAccountFlow() {
  try {
    // 1. Get an existing HOD from database
    console.log('📋 Step 1: Fetching existing HOD from database...\n');
    const [hods] = await db.query('SELECT * FROM hods LIMIT 1');
    
    if (hods.length === 0) {
      console.log('❌ No HODs found in database. Cannot proceed with test.');
      process.exit(1);
    }

    const hod = hods[0];
    console.log(`✅ Found HOD: ${hod.name}`);
    console.log(`   Email: ${hod.email}`);
    console.log(`   ID: ${hod.id}\n`);

    // 2. Check if user account already exists
    console.log('📋 Step 2: Checking if user account already exists...\n');
    const [existingUser] = await db.query(
      'SELECT id, username FROM users WHERE hod_id = ? AND role = ?',
      [hod.id, 'hod']
    );

    if (existingUser.length > 0) {
      console.log(`⚠️  User account already exists for this HOD`);
      console.log(`   User ID: ${existingUser[0].id}`);
      console.log(`   Username: ${existingUser[0].username}\n`);
    } else {
      console.log(`✅ No existing user account - will create new one\n`);
    }

    // 3. Simulate password generation
    console.log('📋 Step 3: Generating temporary password...\n');
    const generateTemporaryPassword = () => {
      const length = 12;
      const uppercase = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
      const lowercase = 'abcdefghijklmnopqrstuvwxyz';
      const numbers = '0123456789';
      const special = '!@#$%^&*';
      const all = uppercase + lowercase + numbers + special;
      
      let password = '';
      password += uppercase[Math.floor(Math.random() * uppercase.length)];
      password += lowercase[Math.floor(Math.random() * lowercase.length)];
      password += numbers[Math.floor(Math.random() * numbers.length)];
      password += special[Math.floor(Math.random() * special.length)];
      
      for (let i = 4; i < length; i++) {
        password += all[Math.floor(Math.random() * all.length)];
      }
      
      return password.split('').sort(() => Math.random() - 0.5).join('');
    };

    const password = generateTemporaryPassword();
    console.log(`✅ Generated password: ${password}\n`);

    // 4. Generate username
    console.log('📋 Step 4: Generating username...\n');
    let username = hod.name.toLowerCase().replace(/\s+/g, '.');
    let finalUsername = username;
    let counter = 1;

    while (true) {
      const [existing] = await db.query('SELECT id FROM users WHERE username = ?', [finalUsername]);
      if (existing.length === 0) break;
      finalUsername = `${username}${counter}`;
      counter++;
    }
    
    console.log(`✅ Generated username: ${finalUsername}\n`);

    // 5. Send email
    console.log('📋 Step 5: Sending credentials email...\n');
    console.log('📧 Calling sendAccountCredentials() with:');
    console.log(`   Email: ${hod.email}`);
    console.log(`   Username: ${finalUsername}`);
    console.log(`   Password: ${password}`);
    console.log(`   User Type: HOD\n`);

    const emailResult = await sendAccountCredentials(hod.email, finalUsername, password, 'HOD');
    
    console.log('\n✅ Email sending completed!\n');
    console.log('Email Result:', emailResult);
    
    if (emailResult.success) {
      console.log('\n✅ ✅ ✅ EMAIL SENT SUCCESSFULLY! ✅ ✅ ✅');
      console.log(`\nMessage ID: ${emailResult.messageId}`);
      console.log(`Sent to: ${emailResult.email}`);
      console.log('\n📬 Check your email inbox (including spam folder) at:');
      console.log(`   ${hod.email}`);
    } else {
      console.log('\n❌ ❌ ❌ EMAIL FAILED! ❌ ❌ ❌');
      console.log(`Error: ${emailResult.error}`);
      console.log('\n⚠️  Troubleshooting steps:');
      console.log('1. Check SMTP credentials in .env file');
      console.log('2. Verify Gmail account and App Password');
      console.log('3. Check firewall/network connectivity');
      console.log('4. Run: node test-email.js to verify SMTP connection');
    }

    console.log('\n========================================\n');
    process.exit(0);

  } catch (error) {
    console.error('\n❌ ERROR during test:');
    console.error(error);
    process.exit(1);
  }
}

// Run the test
testHodAccountFlow();
