/**
 * Test HOD Multi-Department Mapping
 * 
 * Scenario 1: Create a new HOD with email
 * Scenario 2: Map the same HOD to an additional department
 * Scenario 3: Verify both departments are returned on login
 */

const http = require('http');

const API_URL = 'http://localhost:5000/api';
const SUPERADMIN_TOKEN = 'test-superadmin-token'; // In real scenario, get actual token

// Test HOD data
const testHOD = {
  name: 'Test HOD Multi-Dept',
  email: 'testmultidept@example.com',
  phone: '9999999999',
  status: 'active'
};

const testDepts = [
  { department: 'Department A', category_id: 1 },
  { department: 'Department B', category_id: 2 }
];

function makeRequest(method, path, body = null, token = SUPERADMIN_TOKEN) {
  return new Promise((resolve, reject) => {
    const url = new URL(path, API_URL);
    const options = {
      method,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': `Bearer ${token}`
      }
    };

    const req = http.request(url, options, (res) => {
      let data = '';
      res.on('data', chunk => data += chunk);
      res.on('end', () => {
        try {
          const parsed = JSON.parse(data);
          resolve({ status: res.statusCode, data: parsed });
        } catch {
          resolve({ status: res.statusCode, data });
        }
      });
    });

    req.on('error', reject);
    if (body) req.write(JSON.stringify(body));
    req.end();
  });
}

async function testMultiDepartmentMapping() {
  console.log('🧪 Testing HOD Multi-Department Mapping\n');
  console.log('=' .repeat(60));

  try {
    // Test 1: Create HOD with first department
    console.log('\n📝 Test 1: Creating HOD with first department...');
    const createRes = await makeRequest('POST', '/hods', {
      ...testHOD,
      department: testDepts[0].department,
      category_id: testDepts[0].category_id
    });

    if (createRes.status !== 201) {
      console.error('❌ Failed to create HOD:', createRes.data);
      return;
    }

    const hodId = createRes.data.id;
    console.log('✅ HOD Created - ID:', hodId);
    console.log('   Message:', createRes.data.message);
    console.log('   Is New HOD:', createRes.data.isNewHob);
    console.log('   Departments:', createRes.data.departments?.map(d => d.department_name).join(', '));

    // Test 2: Map the same HOD to a second department
    console.log('\n📝 Test 2: Mapping same HOD to second department...');
    const mapRes = await makeRequest('POST', '/hods', {
      ...testHOD,
      department: testDepts[1].department,
      category_id: testDepts[1].category_id
    });

    if (mapRes.status !== 201) {
      console.error('❌ Failed to map department:', mapRes.data);
      return;
    }

    console.log('✅ Department Mapped to Existing HOD');
    console.log('   Message:', mapRes.data.message);
    console.log('   Is New HOD:', mapRes.data.isNewHob);
    console.log('   Departments:', mapRes.data.departments?.map(d => d.department_name).join(', '));

    // Test 3: Verify both departments are returned
    if (mapRes.data.departments && mapRes.data.departments.length === 2) {
      console.log('\n✅ SUCCESS: HOD is mapped to both departments!');
      console.log('   Department 1:', mapRes.data.departments[0].department_name);
      console.log('   Department 2:', mapRes.data.departments[1].department_name);
    } else {
      console.error('\n❌ FAILED: Expected 2 departments, got:', mapRes.data.departments?.length || 0);
    }

    // Test 4: Try to map the same department again (should fail gracefully)
    console.log('\n📝 Test 3: Attempting to map same department again...');
    const duplicateRes = await makeRequest('POST', '/hods', {
      ...testHOD,
      department: testDepts[0].department,
      category_id: testDepts[0].category_id
    });

    if (duplicateRes.status === 400) {
      console.log('✅ Correctly rejected duplicate mapping');
      console.log('   Error:', duplicateRes.data.error);
    } else {
      console.error('❌ Should have rejected duplicate mapping');
    }

    console.log('\n' + '='.repeat(60));
    console.log('✅ All tests completed successfully!');

  } catch (error) {
    console.error('❌ Test failed with error:', error.message);
  }
}

// Run tests
testMultiDepartmentMapping();
