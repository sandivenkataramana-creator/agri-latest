const db = require('./config/database');

console.log('\n🧪 Testing HOD Creation Endpoint\n');

async function testHodCreation() {
  try {
    // Test data
    const hodData = {
      name: 'Test HOD ' + Date.now(),
      department: 'Test Department',
      category_id: null,
      email: 'test@example.com',
      phone: '9876543210',
      status: 'active'
    };

    console.log('📋 Creating HOD with data:');
    console.log(JSON.stringify(hodData, null, 2));
    console.log('');

    const [result] = await db.query(
      'INSERT INTO hods (name, department, category_id, email, phone, status) VALUES (?, ?, ?, ?, ?, ?)',
      [hodData.name, hodData.department, hodData.category_id, hodData.email, hodData.phone, hodData.status]
    );

    console.log('✅ HOD created successfully!');
    console.log(`ID: ${result.insertId}`);
    console.log(`Rows affected: ${result.affectedRows}`);
    console.log('');

    // Verify the insert
    const [hods] = await db.query('SELECT * FROM hods WHERE id = ?', [result.insertId]);
    console.log('✅ Verification - HOD retrieved:');
    console.log(JSON.stringify(hods[0], null, 2));

    process.exit(0);
  } catch (error) {
    console.error('❌ Error:');
    console.error('Message:', error.message);
    console.error('Code:', error.code);
    console.error('Stack:', error.stack);
    process.exit(1);
  }
}

testHodCreation();
