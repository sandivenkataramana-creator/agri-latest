const mysql = require('mysql2/promise');

async function addTodayAttendance() {
  const connection = await mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: '',
    database: 'hod_management'
  });

  try {
    // Get today's date in MySQL format
    const today = new Date().toISOString().split('T')[0];
    console.log(`Adding attendance for today: ${today}`);

    // Check if we already have attendance for today
    const [existing] = await connection.query(
      'SELECT COUNT(*) as count FROM attendance WHERE date = ?',
      [today]
    );

    if (existing[0].count > 0) {
      console.log(`Already have ${existing[0].count} attendance records for today`);
      // Delete existing and create fresh
      await connection.query('DELETE FROM attendance WHERE date = ?', [today]);
      console.log('Deleted existing records');
    }

    // Get all staff with their HOD ids
    const [staff] = await connection.query('SELECT id, hod_id FROM staff');
    console.log(`Found ${staff.length} staff members`);

    // Add attendance for each staff member
    for (const s of staff) {
      // Randomly assign status and check-in times with clear distribution
      const rand = Math.random();
      let status, checkIn, checkOut;

      if (rand < 0.6) {
        // Present on time (60%)
        status = 'present';
        const hour = 8 + Math.floor(Math.random() * 2); // 8 or 9 AM
        const min = Math.floor(Math.random() * 60);
        checkIn = `${hour.toString().padStart(2, '0')}:${min.toString().padStart(2, '0')}:00`;
        checkOut = '17:30:00';
      } else if (rand < 0.75) {
        // Late (15%)
        status = 'late';
        const hour = 11 + Math.floor(Math.random() * 2); // 11 or 12 AM (after 10:45)
        const min = Math.floor(Math.random() * 60);
        checkIn = `${hour.toString().padStart(2, '0')}:${min.toString().padStart(2, '0')}:00`;
        checkOut = '18:00:00';
      } else if (rand < 0.85) {
        // Absent (10%)
        status = 'absent';
        checkIn = null;
        checkOut = null;
      } else if (rand < 0.92) {
        // Half day (7%)
        status = 'half_day';
        checkIn = '09:00:00';
        checkOut = '13:00:00';
      } else {
        // Leave (8%)
        status = 'on_leave';
        checkIn = null;
        checkOut = null;
      }

      await connection.query(
        `INSERT INTO attendance (staff_id, hod_id, date, status, check_in, check_out, remarks) 
         VALUES (?, ?, ?, ?, ?, ?, ?)`,
        [s.id, s.hod_id, today, status, checkIn, checkOut, 'Auto-generated for today']
      );
    }

    // Count results
    const [counts] = await connection.query(`
      SELECT 
        COUNT(*) as total,
        COUNT(CASE WHEN status = 'present' THEN 1 END) as present,
        COUNT(CASE WHEN status = 'absent' THEN 1 END) as absent,
        COUNT(CASE WHEN status = 'late' THEN 1 END) as late,
        COUNT(CASE WHEN status = 'half_day' THEN 1 END) as half_day,
        COUNT(CASE WHEN status = 'on_leave' THEN 1 END) as on_leave
      FROM attendance WHERE date = ?
    `, [today]);

    console.log('\n=== Today\'s Attendance Summary ===');
    console.log(`Total Records: ${counts[0].total}`);
    console.log(`Present: ${counts[0].present}`);
    console.log(`Late: ${counts[0].late}`);
    console.log(`Absent: ${counts[0].absent}`);
    console.log(`Half Day: ${counts[0].half_day}`);
    console.log(`On Leave: ${counts[0].on_leave}`);

    console.log('\nToday\'s attendance data added successfully!');

  } catch (error) {
    console.error('Error:', error);
  } finally {
    await connection.end();
  }
}

addTodayAttendance();
