const db = require('./config/database');

async function showColumns() {
  try {
    const [columns] = await db.query('DESCRIBE schemes');
    console.log('Actual columns in schemes table:');
    columns.forEach(col => {
      console.log(`  ${col.Field} - ${col.Type} ${col.Null === 'YES' ? 'NULL' : 'NOT NULL'} ${col.Key ? `[${col.Key}]` : ''}`);
    });
  } catch (error) {
    console.error('Error:', error.message);
  } finally {
    process.exit(0);
  }
}

showColumns();
