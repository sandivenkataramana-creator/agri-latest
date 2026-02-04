const pool = require('../config/database');

const setupTables = async () => {
  try {
    console.log('Starting database table setup...');
    
    // Create hods table first (if it doesn't exist)
    await pool.query(`
      CREATE TABLE IF NOT EXISTS hods (
        id INT PRIMARY KEY AUTO_INCREMENT,
        name VARCHAR(255) NOT NULL,
        department VARCHAR(255),
        email VARCHAR(255),
        phone VARCHAR(20),
        is_active BOOLEAN DEFAULT 1,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        INDEX idx_name (name),
        INDEX idx_is_active (is_active)
      )
    `);
    console.log('✓ Created hods table');
    
    // Create third_party_api_keys table
    await pool.query(`
      CREATE TABLE IF NOT EXISTS third_party_api_keys (
        id INT PRIMARY KEY AUTO_INCREMENT,
        system_name VARCHAR(255) NOT NULL,
        api_key_hash VARCHAR(255) NOT NULL UNIQUE,
        hod_id INT,
        description TEXT,
        is_active BOOLEAN DEFAULT 1,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        last_used_at TIMESTAMP NULL,
        FOREIGN KEY (hod_id) REFERENCES hods(id) ON DELETE SET NULL,
        UNIQUE KEY unique_system_per_hod (system_name, hod_id),
        INDEX idx_api_key_hash (api_key_hash),
        INDEX idx_system_name (system_name),
        INDEX idx_is_active (is_active),
        INDEX idx_hod_id (hod_id)
      )
    `);;
    console.log('✓ Created third_party_api_keys table');

    // Create attendance_import_logs table
    await pool.query(`
      CREATE TABLE IF NOT EXISTS attendance_import_logs (
        id INT PRIMARY KEY AUTO_INCREMENT,
        api_key_id INT NOT NULL,
        employee_id VARCHAR(50),
        attendance_date DATE,
        check_in TIME,
        check_out TIME,
        status VARCHAR(50),
        device_id VARCHAR(100),
        import_status ENUM('success', 'failed') DEFAULT 'success',
        error_message TEXT,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (api_key_id) REFERENCES third_party_api_keys(id) ON DELETE CASCADE,
        INDEX idx_api_key_id (api_key_id),
        INDEX idx_employee_id (employee_id),
        INDEX idx_attendance_date (attendance_date),
        INDEX idx_created_at (created_at),
        INDEX idx_import_status (import_status)
      )
    `);
    console.log('✓ Created attendance_import_logs table');

    // Add columns to attendance table if they don't exist
    await pool.query(`
      ALTER TABLE attendance ADD COLUMN IF NOT EXISTS source VARCHAR(50) DEFAULT 'manual'
    `);
    console.log('✓ Added source column to attendance table');

    await pool.query(`
      ALTER TABLE attendance ADD COLUMN IF NOT EXISTS device_id VARCHAR(100)
    `);
    console.log('✓ Added device_id column to attendance table');

    // Add hod_id column to third_party_api_keys if it doesn't exist
    await pool.query(`
      ALTER TABLE third_party_api_keys ADD COLUMN IF NOT EXISTS hod_id INT
    `);
    console.log('✓ Added hod_id column to third_party_api_keys table');

    // Fix the unique constraint - change from unique(system_name) to unique(system_name, hod_id)
    try {
      // Drop old unique constraint if it exists
      await pool.query(`
        ALTER TABLE third_party_api_keys DROP INDEX IF EXISTS system_name
      `);
      console.log('ℹ Dropped old system_name unique constraint');
    } catch (e) {
      console.log('ℹ Old constraint didn\'t exist or couldn\'t be dropped');
    }

    try {
      // Add new composite unique constraint
      await pool.query(`
        ALTER TABLE third_party_api_keys ADD UNIQUE KEY IF NOT EXISTS unique_system_per_hod (system_name, hod_id)
      `);
      console.log('✓ Added composite unique constraint (system_name, hod_id)');
    } catch (e) {
      console.log('ℹ Composite unique constraint already exists');
    }

    // Add foreign key and index for hod_id
    try {
      await pool.query(`
        ALTER TABLE third_party_api_keys ADD CONSTRAINT fk_apikey_hod FOREIGN KEY (hod_id) REFERENCES hods(id) ON DELETE SET NULL
      `);
      console.log('✓ Added foreign key for hod_id');
    } catch (fkErr) {
      // Constraint might already exist, continue
      console.log('ℹ Foreign key already exists or couldn\'t be added');
    }

    try {
      await pool.query(`
        ALTER TABLE third_party_api_keys ADD INDEX IF NOT EXISTS idx_hod_id (hod_id)
      `);
      console.log('✓ Added hod_id index');
    } catch (idxErr) {
      console.log('ℹ Index already exists or couldn\'t be added');
    }

    // Add indexes
    await pool.query(`
      ALTER TABLE attendance ADD INDEX IF NOT EXISTS idx_source (source)
    `);
    console.log('✓ Added source index to attendance table');

    console.log('\n✓ All database tables created successfully!');
    process.exit(0);
  } catch (err) {
    console.error('✗ Error setting up database tables:', err.message);
    console.error('Full error:', err);
    process.exit(1);
  }
};

setupTables();
