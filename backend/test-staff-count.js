const db = require('./config/database');

(async () => {
  try {
    const [totalStaff] = await db.query('SELECT COUNT(*) as count FROM staff');
    const [activeStaff] = await db.query("SELECT COUNT(*) as count FROM staff WHERE status = 'active'");
    console.log('Total staff:', totalStaff[0].count);
    console.log('Active staff:', activeStaff[0].count);
  } catch (err) {
    console.error('Error:', err.message);
  } finally {
    process.exit(0);
  }
})();
