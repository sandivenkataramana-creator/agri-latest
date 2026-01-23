const http = require('http');

const options = {
  hostname: 'localhost',
  port: 5000,
  path: '/api/dashboard/stats',
  method: 'GET'
};

const req = http.request(options, (res) => {
  let data = '';

  res.on('data', (chunk) => {
    data += chunk;
  });

  res.on('end', () => {
    console.log('Response Status:', res.statusCode);
    console.log('Response Headers:', res.headers);
    console.log('Response Body:');
    try {
      const json = JSON.parse(data);
      console.log(JSON.stringify(json, null, 2));
      console.log('\n=== STAFF COUNT ===');
      console.log('Total Staff:', json.totalStaff);
      console.log('Active Staff:', json.activeStaff);
    } catch (e) {
      console.log(data);
    }
  });
});

req.on('error', (e) => {
  console.error('Error:', e.message);
});

req.end();
