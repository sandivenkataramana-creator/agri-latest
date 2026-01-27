const db = require('./config/database');

(async () => {
  try {
    await db.query(`CREATE TABLE hod_department_mapping (
      id INT AUTO_INCREMENT PRIMARY KEY,
      hod_id INT NOT NULL,
      department_name VARCHAR(255) NOT NULL,
      category_id INT,
      is_primary BOOLEAN DEFAULT FALSE,
      created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
      updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
      KEY (hod_id),
      KEY (category_id),
      UNIQUE KEY (hod_id, department_name),
      FOREIGN KEY (hod_id) REFERENCES hods(id) ON DELETE CASCADE,
      FOREIGN KEY (category_id) REFERENCES categories(id) ON DELETE SET NULL
    )`);
    console.log('✅ Created hod_department_mapping table with correct schema');
    process.exit(0);
  } catch(err) {
    console.error('❌', err.message);
    process.exit(1);
  }
})();
