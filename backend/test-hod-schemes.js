const db = require('./config/database');

async function testQuery() {
  try {
    console.log('Testing GET /api/schemes/hod/23 query...\n');
    
    // First, check if schemes table has hod_id column
    console.log('1. Checking schemes table structure:');
    const [columns] = await db.query('DESCRIBE schemes');
    const hodIdColumn = columns.find(col => col.Field === 'hod_id');
    console.log('hod_id column exists:', !!hodIdColumn);
    if (hodIdColumn) {
      console.log('Column details:', hodIdColumn);
    }
    
    // Check if scheme_budget_allocation table exists
    console.log('\n2. Checking scheme_budget_allocation table:');
    try {
      const [sbaColumns] = await db.query('DESCRIBE scheme_budget_allocation');
      console.log('scheme_budget_allocation table exists with columns:', sbaColumns.map(c => c.Field).join(', '));
    } catch (err) {
      console.log('scheme_budget_allocation table does NOT exist:', err.message);
    }
    
    // Try the original query
    console.log('\n3. Running the original query:');
    const [results] = await db.query(`
      SELECT s.*, 
             COALESCE(SUM(sba.allocated_amount), 0) as budget_allocated,
             COALESCE(SUM(sba.spent_amount), 0) as budget_utilized
      FROM schemes s 
      LEFT JOIN scheme_budget_allocation sba ON s.id = sba.scheme_id
      WHERE s.hod_id = ?
      GROUP BY s.id
    `, [23]);
    
    console.log('Query successful!');
    console.log('Number of schemes found:', results.length);
    if (results.length > 0) {
      console.log('First scheme:', results[0].name || results[0].scheme_name);
    }
    
  } catch (error) {
    console.error('Error:', error.message);
    console.error('Full error:', error);
  } finally {
    process.exit(0);
  }
}

testQuery();
