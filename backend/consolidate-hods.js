/**
 * Consolidate duplicate HODs into single records with department mappings
 */
const db = require('./config/database');

console.log('\n🔄 CONSOLIDATING DUPLICATE HODs\n');

async function consolidateHods() {
  try {
    // Define consolidation mapping: keep one ID, delete others
    const consolidations = [
      { name: 'Yasmeen Basha, IAS', keep: 25, remove: [36, 39, 40] },
      { name: 'Chandra Sekhar Reddy, IAS', keep: 42, remove: [44] },
      { name: 'Dr. B. Gopi, IAS', keep: 24, remove: [35] },
      { name: 'K. Surendra Mohan, IAS', keep: 26, remove: [33] }
    ];

    console.log('Processing consolidations:\n');

    for (const item of consolidations) {
      console.log(`\n📌 ${item.name}`);
      console.log(`   Keeping: ${item.keep}, Removing: ${item.remove.join(', ')}`);

      // Get info from all records
      const [allRecords] = await db.query(
        'SELECT * FROM hods WHERE id IN (?, ?)',
        [item.keep, item.remove[0]]
      );

      console.log(`   Current info:`, allRecords.map(r => ({ id: r.id, dept: r.department, email: r.email })));

      // Update kept record with best data (email if available)
      const bestRecord = allRecords.find(r => r.email !== null) || allRecords[0];
      await db.query(
        'UPDATE hods SET email = ?, phone = ? WHERE id = ?',
        [bestRecord.email, bestRecord.phone, item.keep]
      );

      // Remap any users pointing to removed HODs to the kept one
      for (const removeId of item.remove) {
        const [users] = await db.query('SELECT * FROM users WHERE hod_id = ?', [removeId]);
        if (users.length > 0) {
          console.log(`   Moving ${users.length} user(s) from HOD ${removeId} to ${item.keep}`);
          await db.query('UPDATE users SET hod_id = ? WHERE hod_id = ?', [item.keep, removeId]);
        }
      }

      // Store all departments in mapping table
      const [depts] = await db.query(
        'SELECT DISTINCT department, category_id FROM hods WHERE id IN (?)',
        [[item.keep, ...item.remove]]
      );

      for (let i = 0; i < depts.length; i++) {
        const dept = depts[i];
        await db.query(
          'INSERT INTO hod_department_mapping (hod_id, department_name, category_id, is_primary) VALUES (?, ?, ?, ?)',
          [item.keep, dept.department, dept.category_id, i === 0]
        );
      }

      console.log(`   ✅ Stored ${depts.length} department mappings`);

      // Delete duplicate records
      for (const removeId of item.remove) {
        await db.query('DELETE FROM hods WHERE id = ?', [removeId]);
        console.log(`   ✅ Deleted HOD record ${removeId}`);
      }
    }

    console.log('\n✅ ✅ ✅ CONSOLIDATION COMPLETE ✅ ✅ ✅\n');

    // Verify results
    console.log('Verification:');
    const [hodsCount] = await db.query('SELECT COUNT(*) as count FROM hods');
    const [mappingsCount] = await db.query('SELECT COUNT(*) as count FROM hod_department_mapping');
    
    console.log(`  HODs in system: ${hodsCount[0].count}`);
    console.log(`  Department mappings: ${mappingsCount[0].count}`);
    
    console.log('\nNew HOD-Department Mappings:');
    const [mappings] = await db.query(`
      SELECT m.id, h.name, m.department_name, m.is_primary
      FROM hod_department_mapping m
      JOIN hods h ON m.hod_id = h.id
      ORDER BY h.name, m.is_primary DESC
    `);
    
    console.table(mappings);

    process.exit(0);

  } catch (error) {
    console.error('❌ Error:', error.message);
    console.error(error);
    process.exit(1);
  }
}

consolidateHods();
