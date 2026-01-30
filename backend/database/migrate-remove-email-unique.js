/**
 * Database Migration: Remove UNIQUE constraint from email column
 * 
 * Problem: UNIQUE constraint on email was causing duplicate errors
 * Solution: Remove the constraint since we're using hod_department_mapping table now
 */

const mysql = require('mysql2/promise');
const config = require('./config/database');

async function migrate() {
  let conn;
  
  try {
    conn = await mysql.createConnection(config);
    console.log('✅ Connected to database\n');
    
    console.log('Starting migration: Remove UNIQUE constraint from email...\n');
    
    // First, let's see what constraints exist
    const [constraints] = await conn.execute(`
      SELECT 
        CONSTRAINT_NAME,
        COLUMN_NAME,
        CONSTRAINT_TYPE,
        TABLE_NAME
      FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
      WHERE TABLE_SCHEMA = ? 
      AND TABLE_NAME = 'hods'
      AND COLUMN_NAME = 'email'
    `, [config.database]);
    
    console.log('📋 Current constraints on hods.email:');
    if (constraints.length === 0) {
      console.log('   None found\n');
    } else {
      constraints.forEach(c => {
        console.log(`   - ${c.CONSTRAINT_NAME} (${c.CONSTRAINT_TYPE})`);
      });
      console.log('');
    }
    
    // Drop the email index (UNIQUE constraint)
    try {
      await conn.execute(`ALTER TABLE hods DROP INDEX email`);
      console.log('✅ Removed UNIQUE constraint from email column\n');
    } catch (err) {
      if (err.message.includes('can\'t drop') || err.message.includes('doesn\'t exist')) {
        console.log('ℹ️ No UNIQUE index to drop (might not exist)\n');
      } else {
        throw err;
      }
    }
    
    // Verify the fix
    const [afterConstraints] = await conn.execute(`
      SELECT 
        CONSTRAINT_NAME,
        COLUMN_NAME,
        CONSTRAINT_TYPE
      FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
      WHERE TABLE_SCHEMA = ?
      AND TABLE_NAME = 'hods'
      AND COLUMN_NAME = 'email'
    `, [config.database]);
    
    console.log('📋 Constraints after migration:');
    if (afterConstraints.length === 0) {
      console.log('   None - ✅ Successfully removed\n');
    } else {
      console.log('   Still found:');
      afterConstraints.forEach(c => {
        console.log(`   - ${c.CONSTRAINT_NAME}`);
      });
      console.log('');
    }
    
    // Check for duplicate emails that might exist
    console.log('🔍 Checking for duplicate emails in database...');
    const [dups] = await conn.execute(`
      SELECT 
        LOWER(email) as email_lower,
        COUNT(*) as count,
        GROUP_CONCAT(id) as ids
      FROM hods
      WHERE email IS NOT NULL AND email != '' AND email != 'NULL'
      GROUP BY LOWER(email)
      HAVING count > 1
    `);
    
    if (dups.length === 0) {
      console.log('✅ No duplicate emails found\n');
    } else {
      console.log(`⚠️ Found ${dups.length} duplicate(s):`);
      dups.forEach(d => {
        console.log(`   - ${d.email_lower}: IDs [${d.ids}]`);
      });
      console.log('');
    }
    
    console.log('✅ Migration complete!');
    console.log('\n📝 You can now create new HODs with unique or empty emails');
    console.log('   without getting duplicate email errors.');
    
  } catch (error) {
    console.error('\n❌ Migration failed:', error.message);
    console.error('Full error:', error);
    process.exit(1);
  } finally {
    if (conn) await conn.end();
  }
}

// Run migration
migrate();
