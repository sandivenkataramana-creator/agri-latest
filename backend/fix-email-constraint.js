const mysql = require('mysql2');
const config = require('./config/database');

const connection = mysql.createConnection(config);

connection.connect((err) => {
  if (err) {
    console.error('Connection failed:', err.message);
    process.exit(1);
  }
  
  console.log('Connected to database\n');
  
  // First check current state
  connection.query(`
    SELECT CONSTRAINT_NAME, COLUMN_NAME, CONSTRAINT_TYPE
    FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
    WHERE TABLE_NAME = 'hods' AND TABLE_SCHEMA = ?
  `, [config.database], (err, constraints) => {
    if (err) throw err;
    
    console.log('Current constraints on hods table:');
    console.log(constraints.filter(c => c.COLUMN_NAME === 'email'));
    
    // Drop UNIQUE constraint
    connection.query(`ALTER TABLE hods DROP INDEX email`, (err) => {
      if (err && !err.message.includes('check that column/key exists')) {
        console.error('Error dropping constraint:', err.message);
      } else if (err) {
        console.log('ℹ️ No UNIQUE index to drop');
      } else {
        console.log('✅ Dropped UNIQUE constraint');
      }
      
      // Verify
      connection.query(`
        SELECT CONSTRAINT_NAME, COLUMN_NAME, CONSTRAINT_TYPE
        FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
        WHERE TABLE_NAME = 'hods' AND TABLE_SCHEMA = ? AND COLUMN_NAME = 'email'
      `, [config.database], (err, constraints) => {
        if (err) throw err;
        
        console.log('\nAfter fix - Email constraints:');
        console.log(constraints.length === 0 ? 'None' : constraints);
        
        connection.end();
      });
    });
  });
});
