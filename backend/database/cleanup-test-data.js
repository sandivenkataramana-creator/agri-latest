const pool = require('../config/database');

const cleanup = async () => {
  try {
    console.log('Cleaning up test data...');
    
    // Delete the test ACS entry
    await pool.query(`DELETE FROM third_party_api_keys WHERE system_name = 'ACS'`);
    console.log('✓ Deleted test ACS entry');

    console.log('\n✓ Cleanup complete! You can now generate a new API key.');
    process.exit(0);
  } catch (err) {
    console.error('✗ Error during cleanup:', err.message);
    process.exit(1);
  }
};

cleanup();
