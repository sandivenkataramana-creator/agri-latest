/**
 * Test HOD creation via API
 */
const axios = require('axios');

// Mock user token (use a valid one from your system)
const API_URL = 'http://localhost:5000/api';

async function testHodCreation() {
  try {
    // Get token from localStorage equivalent - you'll need to replace this with a valid token
    console.log('\n📝 Testing HOD Creation API\n');
    
    // First get a valid token by logging in
    console.log('1️⃣  Step 1: Logging in as superadmin...');
    const loginResponse = await axios.post(`${API_URL}/auth/login`, {
      username: 'superadmin',
      password: 'superadmin123' // Default superadmin password
    });
    
    const token = loginResponse.data.token;
    console.log('✅ Login successful, token:', token.substring(0, 20) + '...\n');
    
    // Now test HOD creation
    console.log('2️⃣  Step 2: Creating new HOD...');
    const testHod = {
      name: 'Test HOD ' + Date.now(),
      department: 'Finance',
      category_id: '',
      email: 'test@example.com',
      phone: '9999999999',
      status: 'active'
    };
    
    console.log('Request body:', testHod);
    
    const hodResponse = await axios.post(`${API_URL}/hods`, testHod, {
      headers: {
        Authorization: `Bearer ${token}`,
        'Content-Type': 'application/json'
      }
    });
    
    console.log('✅ HOD created successfully!');
    console.log('Response:', hodResponse.data);
    
  } catch (error) {
    console.error('❌ Error:');
    console.error('Message:', error.message);
    if (error.response) {
      console.error('Status:', error.response.status);
      console.error('Response data:', error.response.data);
    }
  }
}

testHodCreation();
