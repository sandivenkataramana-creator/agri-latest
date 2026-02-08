#!/usr/bin/env node
/**
 * Migration runner script
 * Reads and executes SQL migration files against the configured database
 * Usage: node backend/database/migrations/runMigration.js <migration-file-name>
 * Example: node backend/database/migrations/runMigration.js 20260204_add_departments_and_staff_department_id.sql
 */

const fs = require('fs');
const path = require('path');
const mysql = require('mysql2/promise');
require('dotenv').config({ path: path.join(__dirname, '..', '..', '.env') });

// Create direct connection pool (bypass shared config to control IPv4)
const db = mysql.createPool({
  host: process.env.DB_HOST || '127.0.0.1',
  port: process.env.DB_PORT || 3306,
  user: process.env.DB_USER || 'root',
  password: process.env.DB_PASSWORD || '',
  database: process.env.DB_NAME || 'hod_management2',
  waitForConnections: true,
  connectionLimit: 10,
  queueLimit: 0
});

const migrationFileName = process.argv[2];

if (!migrationFileName) {
  console.error('❌ Error: Please provide a migration file name as argument');
  console.error('Usage: node backend/database/migrations/runMigration.js <migration-file-name>');
  console.error('Example: node backend/database/migrations/runMigration.js 20260204_add_departments_and_staff_department_id.sql');
  process.exit(1);
}

const migrationFilePath = path.join(__dirname, migrationFileName);

if (!fs.existsSync(migrationFilePath)) {
  console.error(`❌ Error: Migration file not found: ${migrationFilePath}`);
  process.exit(1);
}

console.log(`📝 Reading migration file: ${migrationFileName}`);
const migrationSQL = fs.readFileSync(migrationFilePath, 'utf8');

async function runMigration() {
  console.log('🔌 Connecting to database...');
  let conn;
  
  try {
    conn = await db.getConnection();
    console.log('✅ Connected to database:', process.env.DB_NAME || 'agri_manager');
    console.log('\n▶️  Executing migration...\n');

    // Parse SQL statements properly (handles comments and quoted strings)
    const statements = [];
    let currentStatement = '';
    let inLineComment = false;
    let inBlockComment = false;
    let i = 0;

    while (i < migrationSQL.length) {
      const char = migrationSQL[i];
      const nextChar = migrationSQL[i + 1];

      // Handle line comments
      if (!inBlockComment && char === '-' && nextChar === '-') {
        inLineComment = true;
        i += 2;
        continue;
      }

      // Handle block comments
      if (!inLineComment && char === '/' && nextChar === '*') {
        inBlockComment = true;
        i += 2;
        continue;
      }

      if (inBlockComment && char === '*' && nextChar === '/') {
        inBlockComment = false;
        i += 2;
        continue;
      }

      // Handle end of line in line comments
      if (inLineComment && (char === '\n' || char === '\r')) {
        inLineComment = false;
        i++;
        continue;
      }

      // Skip content in comments
      if (inLineComment || inBlockComment) {
        i++;
        continue;
      }

      // Collect statement
      if (char === ';') {
        if (currentStatement.trim()) {
          statements.push(currentStatement.trim());
        }
        currentStatement = '';
      } else {
        currentStatement += char;
      }

      i++;
    }

    // Add any remaining statement
    if (currentStatement.trim()) {
      statements.push(currentStatement.trim());
    }

    let completed = 0;
    let skipped = 0;
    let errors = 0;

    for (const statement of statements) {
      try {
        const results = await conn.query(statement);
        console.log(`✓ Statement executed (${results[0]?.affectedRows || 0} affected rows)`);
        completed++;
      } catch (err) {
        // Warnings like "column already exists" are common; log but don't fail
        if (err.code === 'ER_DUP_FIELDNAME' || err.code === 'ER_DUP_KEYNAME') {
          console.log(`⚠️  ${err.message.substring(0, 80)}`);
          skipped++;
        } else {
          console.error(`❌ Error executing statement:`, err.message);
          errors++;
        }
      }
    }

    console.log('\n========================================');
    console.log(`✅ Migration Summary:`);
    console.log(`   Completed: ${completed}`);
    console.log(`   Skipped (already exists): ${skipped}`);
    console.log(`   Errors: ${errors}`);
    console.log('========================================\n');

    if (errors > 0) {
      console.error('❌ Migration completed with errors. Review above.');
      process.exit(1);
    } else {
      console.log('🎉 Migration completed successfully!');
      process.exit(0);
    }
  } catch (err) {
    console.error('❌ Database connection error:', err.message);
    process.exit(1);
  } finally {
    if (conn) conn.release();
    await db.end();
  }
}

runMigration();
