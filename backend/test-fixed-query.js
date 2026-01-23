const db = require('./config/database');

async function testFixedQuery() {
  try {
    const hodId = 23;
    console.log(`Testing fixed query for HOD ID ${hodId}...\n`);
    
    // First get the HOD name
    const [hodRows] = await db.query('SELECT name FROM hods WHERE id = ?', [hodId]);
    
    if (hodRows.length === 0) {
      console.log('No HOD found with ID', hodId);
      return;
    }
    
    const hodName = hodRows[0].name;
    console.log('HOD Name:', hodName);
    
    // Get schemes using the hod name
    const [results] = await db.query(`
      SELECT s.*, 
             COALESCE(SUM(sba.allocated_amount), 0) as budget_allocated,
             COALESCE(SUM(sba.spent_amount), 0) as budget_utilized
      FROM schemes s 
      LEFT JOIN scheme_budget_allocation sba ON s.id = sba.scheme_id
      WHERE s.hod = ? OR sba.hod_id = ?
      GROUP BY s.id
    `, [hodName, hodId]);
    
    console.log('Query successful!');
    console.log('Number of schemes found:', results.length);
    if (results.length > 0) {
      console.log('\nFirst few schemes:');
      results.slice(0, 3).forEach(scheme => {
        console.log(`  - ${scheme.scheme_name} (${scheme.financial_year})`);
      });
    }
    
  } catch (error) {
    console.error('Error:', error.message);
  } finally {
    process.exit(0);
  }
}

testFixedQuery();
