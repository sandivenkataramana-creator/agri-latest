/**
 * Test creating a HOD with a NEW email to verify the system works
 */
const db = require('./config/database');

console.log('\n🧪 TEST: Creating HOD with NEW email\n');

async function testCreateHod() {
  try {
    // Step 1: Use a completely new email
    const newEmail = `newhod${Date.now()}@example.com`;
    
    console.log('📋 Test data:');
    console.log('  Name: New Test HOD');
    console.log('  Department: Test Department');
    console.log('  Email:', newEmail);
    console.log('  Phone: 9876543210');
    console.log('');

    // Step 2: Insert directly to verify it works
    console.log('Step 1: Testing direct database insert...');
    const [result] = await db.query(
      'INSERT INTO hods (name, department, email, phone, status) VALUES (?, ?, ?, ?, ?)',
      ['New Test HOD', 'Test Department', newEmail, '9876543210', 'active']
    );
    
    console.log('✅ Direct insert successful, ID:', result.insertId);
    const hodId = result.insertId;

    // Step 3: Clean up
    console.log('\nStep 2: Cleaning up test data...');
    await db.query('DELETE FROM hods WHERE id = ?', [hodId]);
    console.log('✅ Cleaned up');

    console.log('\n✅ ✅ ✅ TEST PASSED ✅ ✅ ✅');
    console.log('\nThe database is working correctly!');
    console.log('Try creating a HOD with one of these emails:');
    console.log(`  - ${newEmail}`);
    console.log(`  - hod${Date.now()}@yourdomain.com`);
    console.log(`  - Or leave email blank (empty)\n`);

    process.exit(0);

  } catch (error) {
    console.error('\n❌ Error:');
    console.error('Message:', error.message);
    console.error('Code:', error.code);
    
    if (error.code === 'ER_DUP_ENTRY') {
      console.error('\n⚠️  This email already exists in the database!');
      console.error('Try using a different email address.');
    }
    
    process.exit(1);
  }
}

testCreateHod();
