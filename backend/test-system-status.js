/**
 * Check authentication and database status
 */
const db = require('./config/database');

console.log('\n🔍 SYSTEM STATUS CHECK\n');

async function checkSystem() {
  try {
    // Test database connection
    console.log('1️⃣  Testing database connection...');
    const [tables] = await db.query('SHOW TABLES');
    console.log('✅ Database connected. Tables found:', tables.length);

    // Get superadmin user
    console.log('\n2️⃣  Checking superadmin user...');
    const [users] = await db.query('SELECT id, username, role FROM users WHERE role = ? LIMIT 1', ['superadmin']);
    if (users.length > 0) {
      console.log('✅ Superadmin found:');
      console.log('   ID:', users[0].id);
      console.log('   Username:', users[0].username);
      console.log('   Role:', users[0].role);
    } else {
      console.log('⚠️  No superadmin user found');
    }

    // Check HODs table structure
    console.log('\n3️⃣  Checking HODs table...');
    const [hodCount] = await db.query('SELECT COUNT(*) as count FROM hods');
    console.log('✅ HODs in database:', hodCount[0].count);

    // Try to insert a test HOD
    console.log('\n4️⃣  Attempting test insert...');
    const testName = 'API Test HOD ' + Date.now();
    const [result] = await db.query(
      'INSERT INTO hods (name, department, email, phone, status) VALUES (?, ?, ?, ?, ?)',
      [testName, 'Test Dept', 'test@example.com', '9999999999', 'active']
    );
    console.log('✅ Test insert successful');
    console.log('   Inserted ID:', result.insertId);
    
    // Clean up
    console.log('\n5️⃣  Cleaning up test data...');
    await db.query('DELETE FROM hods WHERE id = ?', [result.insertId]);
    console.log('✅ Test data cleaned up');

    console.log('\n✅ ✅ ✅ ALL CHECKS PASSED ✅ ✅ ✅\n');
    process.exit(0);

  } catch (error) {
    console.error('\n❌ ERROR:');
    console.error('Message:', error.message);
    console.error('Code:', error.code);
    console.error('Stack:', error.stack);
    process.exit(1);
  }
}

checkSystem();
