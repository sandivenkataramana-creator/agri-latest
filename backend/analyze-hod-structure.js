/**
 * Analyze current database structure for HODs
 */
const db = require('./config/database');

console.log('\n🔍 ANALYZING HOD STRUCTURE\n');

async function analyzeStructure() {
  try {
    // Check current schema
    console.log('1️⃣  Current HODs table schema:');
    const [hodSchema] = await db.query('DESCRIBE hods');
    console.table(hodSchema);

    // Check for duplicate HOD names/people
    console.log('\n2️⃣  Checking for duplicate HOD names:');
    const [duplicates] = await db.query(`
      SELECT name, COUNT(*) as count, GROUP_CONCAT(id) as ids
      FROM hods
      GROUP BY name
      HAVING COUNT(*) > 1
      ORDER BY count DESC
    `);
    
    if (duplicates.length === 0) {
      console.log('✅ No duplicate HOD names found');
    } else {
      console.log('⚠️  Duplicate HOD names found:');
      console.table(duplicates);
    }

    // Check HOD-Department relationship
    console.log('\n3️⃣  Checking current structure:');
    const [hodDepts] = await db.query(`
      SELECT h.id, h.name, h.department, h.email, h.category_id, COUNT(u.id) as user_count
      FROM hods h
      LEFT JOIN users u ON u.hod_id = h.id AND u.role = 'hod'
      GROUP BY h.id
      ORDER BY h.name
      LIMIT 10
    `);
    
    console.log('Sample HODs with their current structure:');
    console.table(hodDepts);

    // Check users table
    console.log('\n4️⃣  HOD users in system:');
    const [hodUsers] = await db.query(`
      SELECT u.id, u.username, u.email, u.hod_id, h.name as hod_name
      FROM users u
      LEFT JOIN hods h ON u.hod_id = h.id
      WHERE u.role = 'hod'
      LIMIT 10
    `);
    console.table(hodUsers);

    // Check for duplicate emails
    console.log('\n5️⃣  HODs with same person (duplicate emails):');
    const [sameEmailHods] = await db.query(`
      SELECT email, COUNT(*) as count, GROUP_CONCAT(id) as ids, GROUP_CONCAT(name) as names
      FROM hods
      WHERE email IS NOT NULL
      GROUP BY email
      HAVING COUNT(*) > 1
    `);
    
    if (sameEmailHods.length === 0) {
      console.log('✅ No duplicate emails');
    } else {
      console.table(sameEmailHods);
    }

    console.log('\n✅ Analysis complete\n');
    process.exit(0);

  } catch (error) {
    console.error('❌ Error:', error.message);
    process.exit(1);
  }
}

analyzeStructure();
