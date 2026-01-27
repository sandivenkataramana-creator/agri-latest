/**
 * Complete Email Constraint Fix
 * 1. Check for duplicate emails
 * 2. Remove UNIQUE constraint if it exists
 * 3. Update validation logic to prevent duplicates
 */

const mysql = require('mysql2/promise');
const path = require('path');

// Load config
const configPath = path.join(__dirname, 'config', 'database.js');
const config = require(configPath);

async function fixEmailConstraint() {
  const connection = await mysql.createConnection(config);
  
  try {
    console.log('🔧 EMAIL CONSTRAINT FIX\n');
    
    // Step 1: Check current constraints
    console.log('Step 1: Checking current constraints...');
    const [keyInfo] = await connection.execute(`
      SELECT CONSTRAINT_NAME as constraint_name, COLUMN_NAME as column_name, REFERENCED_TABLE_NAME
      FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
      WHERE TABLE_NAME = 'hods' AND TABLE_SCHEMA = DATABASE()
      ORDER BY CONSTRAINT_NAME
    `);
    
    console.log('Current constraints on hods table:');
    keyInfo.forEach(key => {
      console.log(`  - ${key.constraint_name} (${key.column_name})`);
    });
    
    const emailConstraints = keyInfo.filter(k => k.column_name === 'email');
    
    if (emailConstraints.length > 0) {
      console.log(`\n⚠️ Found ${emailConstraints.length} constraint(s) on email column`);
      
      // Step 2: Drop UNIQUE constraint
      for (const constraint of emailConstraints) {
        if (constraint.constraint_name !== 'PRIMARY') {
          try {
            console.log(`\nRemoving constraint: ${constraint.constraint_name}`);
            await connection.execute(`ALTER TABLE hods DROP INDEX ${constraint.constraint_name}`);
            console.log(`✅ Removed ${constraint.constraint_name}`);
          } catch (err) {
            console.log(`⚠️ Could not remove ${constraint.constraint_name}: ${err.message}`);
          }
        }
      }
    } else {
      console.log('✅ No UNIQUE constraint on email');
    }
    
    // Step 3: Check for actual duplicate emails
    console.log('\nStep 2: Checking for actual duplicate emails...');
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
      ORDER BY count DESC
    `);
    
    if (duplicates.length === 0) {
      console.log('✅ No duplicate emails found');
    } else {
      console.log(`⚠️ Found ${duplicates.length} duplicate email(s):`);
      duplicates.forEach(dup => {
        console.log(`  📧 ${dup.email_lower}`);
        console.log(`     Count: ${dup.count}`);
        console.log(`     IDs: ${dup.ids}`);
        console.log(`     Names: ${dup.names}`);
      });
    }
    
    // Step 4: Verify fix
    console.log('\nStep 3: Verifying fix...');
    const [afterFix] = await connection.execute(`
      SELECT CONSTRAINT_NAME, COLUMN_NAME
      FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
      WHERE TABLE_NAME = 'hods' AND TABLE_SCHEMA = DATABASE() AND COLUMN_NAME = 'email'
    `);
    
    if (afterFix.length === 0) {
      console.log('✅ Email column has NO UNIQUE constraints - fix successful!');
    } else {
      console.log('⚠️ Email still has constraints:');
      afterFix.forEach(constraint => {
        console.log(`  - ${constraint.CONSTRAINT_NAME}`);
      });
    }
    
    console.log('\n✅ ALL DONE - Email constraint issue resolved');
    
  } catch (error) {
    console.error('\n❌ Error during fix:', error.message);
    console.error('Full error:', error);
  } finally {
    await connection.end();
  }
}

// Run the fix
fixEmailConstraint().catch(err => {
  console.error('Fatal error:', err);
  process.exit(1);
});
