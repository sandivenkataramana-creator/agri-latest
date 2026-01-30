// Quick test to fetch dashboard stats
fetch('http://localhost:5000/api/dashboard/stats')
  .then(res => res.json())
  .then(data => {
    console.log('Dashboard Stats Response:');
    console.log(JSON.stringify(data, null, 2));
    
    // Check for staff count
    console.log('\n=== STAFF COUNT INFO ===');
    console.log('Total Staff:', data.totalStaff);
    console.log('Active Staff:', data.activeStaff);
  })
  .catch(err => console.error('Error:', err.message));
