const mysql = require('mysql2/promise');
const config = require('./config/database');

async function removeUniqueConstraint() {
  let connection;
  try {
    connection = await mysql.createConnection(config);
    
    console.log('🔧 Removing UNIQUE constraint from email column...\n');
    
    // Drop the UNIQUE constraint
    try {
      await connection.execute(`ALTER TABLE hods DROP INDEX email`);
      console.log('✅ UNIQUE constraint removed from email column');
    } catch (err) {
      if (err.message.includes('check that column/key exists')) {
        console.log('ℹ️ No UNIQUE constraint found on email (already removed or never existed)');
      } else {
        throw err;
      }
    }
    
    // Verify the constraint is gone
    const [constraints] = await connection.execute(`
      SELECT CONSTRAINT_NAME, COLUMN_NAME
      FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
      WHERE TABLE_NAME = 'hods' 
      AND TABLE_SCHEMA = ?
      AND COLUMN_NAME = 'email'
    `, [config.database]);
    
    console.log('\nVerification:');
    if (constraints.length === 0) {
      console.log('✅ Email column has no UNIQUE constraint now');
    } else {
      console.log('⚠️ Remaining constraints on email:');
      constraints.forEach(c => {
        console.log(`   - ${c.CONSTRAINT_NAME}`);
      });
    }
    
    // Check for duplicate emails to see what's actually in the database
    console.log('\nChecking for duplicate emails...');
    const [duplicates] = await connection.execute(`
      SELECT 
        LOWER(email) as email_lower,
        COUNT(*) as count,
        GROUP_CONCAT(id ORDER BY id) as ids
      FROM hods
      WHERE email IS NOT NULL AND email != ''
      GROUP BY LOWER(email)
      HAVING count > 1
    `);
    
    if (duplicates.length > 0) {
      console.log(`⚠️ Found ${duplicates.length} duplicate email(s):`);
      duplicates.forEach(dup => {
        console.log(`   - ${dup.email_lower}: IDs [${dup.ids}]`);
      });
      console.log('\n❌ Still have duplicate emails - need to fix this first!');
    } else {
      console.log('✅ No duplicate emails in database');
    }
    
    connection.end();
  } catch (error) {
    console.error('❌ Error:', error.message);
    if (connection) connection.end();
    process.exit(1);
  }
}

removeUniqueConstraint();
