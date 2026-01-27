const mysql = require('mysql2/promise');
const config = require('./config/database');

async function diagnoseEmailIssue() {
  let connection;
  try {
    connection = await mysql.createConnection(config);
    
    console.log('🔍 DIAGNOSTIC: Email Duplicate Issue\n');
    
    // Check for duplicate emails
    console.log('1️⃣ Checking for duplicate emails in hods table...');
    const [duplicates] = await connection.execute(`
      SELECT LOWER(email) as email, COUNT(*) as count, GROUP_CONCAT(id) as ids, GROUP_CONCAT(name) as names
      FROM hods
      WHERE email IS NOT NULL AND email != ''
      GROUP BY LOWER(email)
      HAVING count > 1
      ORDER BY count DESC
    `);
    
    if (duplicates.length > 0) {
      console.log(`\n⚠️ Found ${duplicates.length} duplicate email(s):`);
      duplicates.forEach(dup => {
        console.log(`   📧 ${dup.email}`);
        console.log(`      Count: ${dup.count}`);
        console.log(`      IDs: ${dup.ids}`);
        console.log(`      Names: ${dup.names}`);
      });
    } else {
      console.log('✅ No duplicate emails found!');
    }
    
    // Check total HODs
    const [totalCount] = await connection.execute('SELECT COUNT(*) as total FROM hods');
    console.log(`\n2️⃣ Total HODs in system: ${totalCount[0].total}`);
    
    // Check HODs with emails
    const [withEmail] = await connection.execute(`
      SELECT COUNT(*) as total FROM hods WHERE email IS NOT NULL AND email != ''
    `);
    console.log(`3️⃣ HODs with emails: ${withEmail[0].total}`);
    
    // Check if hod_department_mapping table exists
    const [mappingCheck] = await connection.execute(`
      SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES 
      WHERE TABLE_SCHEMA = ? AND TABLE_NAME = 'hod_department_mapping'
    `, [config.database]);
    
    if (mappingCheck.length > 0) {
      console.log('\n4️⃣ ✅ hod_department_mapping table exists');
      
      const [mappingCount] = await connection.execute(`
        SELECT COUNT(*) as total FROM hod_department_mapping
      `);
      console.log(`   Total mappings: ${mappingCount[0].total}`);
    } else {
      console.log('\n4️⃣ ❌ hod_department_mapping table NOT found');
    }
    
    // Sample HODs
    console.log('\n5️⃣ Sample HODs:');
    const [samples] = await connection.execute(`
      SELECT id, name, email, designation FROM hods ORDER BY id LIMIT 10
    `);
    console.table(samples);
    
    connection.end();
  } catch (error) {
    console.error('❌ Error:', error.message);
    if (connection) connection.end();
  }
}

diagnoseEmailIssue();
