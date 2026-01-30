const mysql = require('mysql2/promise');
const config = require('./config/database');

async function checkDatabaseState() {
  let connection;
  try {
    connection = await mysql.createConnection(config);
    console.log('\n🔍 DATABASE STATE CHECK\n');
    
    // Check for duplicate emails (case-insensitive)
    console.log('1. Checking for duplicate emails...');
    const [duplicates] = await connection.execute(`
      SELECT 
        LOWER(email) as email_lower,
        COUNT(*) as count,
        GROUP_CONCAT(id ORDER BY id) as ids,
        GROUP_CONCAT(name ORDER BY id) as names
      FROM hods
      WHERE email IS NOT NULL AND email != '' AND email != 'NULL'
      GROUP BY LOWER(email)
      HAVING count > 1
    `);
    
    if (duplicates.length > 0) {
      console.log(`   ⚠️ Found ${duplicates.length} duplicate email(s):`);
      duplicates.forEach(dup => {
        console.log(`      📧 ${dup.email_lower}: IDs [${dup.ids}], Names: ${dup.names}`);
      });
    } else {
      console.log('   ✅ No duplicate emails found\n');
    }
    
    // Check UNIQUE constraint on email
    console.log('2. Checking table constraints...');
    const [constraints] = await connection.execute(`
      SELECT CONSTRAINT_NAME, COLUMN_NAME, CONSTRAINT_TYPE
      FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
      WHERE TABLE_NAME = 'hods' AND TABLE_SCHEMA = ?
      AND (CONSTRAINT_NAME = 'email' OR COLUMN_NAME = 'email')
    `, [config.database]);
    
    if (constraints.length > 0) {
      console.log('   Email constraints found:');
      constraints.forEach(c => {
        console.log(`      - ${c.CONSTRAINT_NAME}: ${c.CONSTRAINT_TYPE} on ${c.COLUMN_NAME}`);
      });
    } else {
      console.log('   No UNIQUE constraints on email found');
    }
    
    // Get all emails to see what's stored
    console.log('\n3. All emails in hods table:');
    const [allEmails] = await connection.execute(`
      SELECT id, name, email FROM hods WHERE email IS NOT NULL AND email != '' AND email != 'NULL' ORDER BY email
    `);
    
    console.log(`   Total with emails: ${allEmails.length}`);
    allEmails.forEach(row => {
      console.log(`      ID ${row.id}: ${row.name} (${row.email})`);
    });
    
    console.log('\n4. Sample NULL/empty emails:');
    const [nullEmails] = await connection.execute(`
      SELECT id, name, email FROM hods WHERE email IS NULL OR email = '' OR email = 'NULL' LIMIT 5
    `);
    console.log(`   Total with NULL/empty: ${nullEmails.length}`);
    nullEmails.forEach(row => {
      console.log(`      ID ${row.id}: ${row.name} (${row.email === null ? 'NULL' : '"' + row.email + '"'})`);
    });
    
    connection.end();
  } catch (error) {
    console.error('Error:', error.message);
    if (connection) connection.end();
  }
}

checkDatabaseState();
