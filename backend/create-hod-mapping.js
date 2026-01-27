/**
 * Migration to implement HOD-Department mapping table
 * This separates HOD identity from their department assignments
 */
const db = require('./config/database');

console.log('\n📊 HOD-DEPARTMENT MAPPING MIGRATION\n');

async function runMigration() {
  try {
    console.log('Step 1: Creating hod_department_mapping table...');
    
    // Create the new mapping table
    await db.query(`
      CREATE TABLE IF NOT EXISTS hod_department_mapping (
        id INT AUTO_INCREMENT PRIMARY KEY,
        hod_id INT NOT NULL UNIQUE,
        department_name VARCHAR(255) NOT NULL,
        category_id INT,
        is_primary BOOLEAN DEFAULT TRUE,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
        KEY (hod_id),
        KEY (category_id),
        FOREIGN KEY (hod_id) REFERENCES hods(id) ON DELETE CASCADE,
        FOREIGN KEY (category_id) REFERENCES categories(id) ON DELETE SET NULL
      )
    `);
    
    console.log('✅ hod_department_mapping table created\n');

    console.log('Step 2: Finding duplicate HODs to consolidate...\n');
    
    // Get all duplicate HODs
    const [duplicates] = await db.query(`
      SELECT name, GROUP_CONCAT(id) as ids
      FROM hods
      GROUP BY name
      HAVING COUNT(*) > 1
    `);

    console.log(`Found ${duplicates.length} HODs that appear multiple times:\n`);

    for (const dup of duplicates) {
      console.log(`  📌 "${dup.name}" appears in records: ${dup.ids}`);
    }

    console.log('\n✅ Analysis complete. To proceed with consolidation, run:');
    console.log('   node consolidate-hods.js\n');

    process.exit(0);

  } catch (error) {
    console.error('❌ Error:', error.message);
    process.exit(1);
  }
}

runMigration();
