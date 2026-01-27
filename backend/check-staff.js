const db = require('./config/database');

(async () => {
  try {
    const [tables] = await db.query("SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = DATABASE()");
    console.log('Tables:', tables.map(t => t.TABLE_NAME).join(', '));
    
    // Check if staff table exists
    const staffExists = tables.some(t => t.TABLE_NAME === 'staff');
    console.log('Staff table exists:', staffExists);
    
    if (staffExists) {
      const [staffCount] = await db.query('SELECT COUNT(*) as count FROM staff');
      console.log('Total staff count:', staffCount[0].count);
      
      const [staffData] = await db.query('SELECT * FROM staff LIMIT 3');
      console.log('Sample staff data:', JSON.stringify(staffData, null, 2));
    } else {
      console.log('Staff table does not exist. Checking schema...');
      const [columns] = await db.query("SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = DATABASE()");
      console.log('Available columns:', [...new Set(columns.map(c => c.TABLE_NAME))].join(', '));
    }
  } catch (err) {
    console.error('Error:', err.message);
  } finally {
    process.exit(0);
  }
})();
