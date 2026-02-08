
const express = require('express');
const router = express.Router();
const db = require('../config/database');
const { authenticateJWT, requireRole } = require('../middleware/auth');

const superAdminOnly = [authenticateJWT, requireRole('superadmin')];

// Get all attendance records
router.get('/', async (req, res) => {
  try {
    const [results] = await db.query(`
      SELECT a.*, s.name as staff_name, s.employee_id, h.name as hod_name, h.department 
      FROM attendance a 
      LEFT JOIN staff s ON a.staff_id = s.id 
      LEFT JOIN hods h ON a.hod_id = h.id 
      ORDER BY a.date DESC
    `);
    res.json(results);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Get attendance by date range
router.get('/range', async (req, res) => {
  try {
    const { start_date, end_date } = req.query;
    const [results] = await db.query(`
      SELECT a.*, s.name as staff_name, s.employee_id, h.name as hod_name 
      FROM attendance a 
      LEFT JOIN staff s ON a.staff_id = s.id 
      LEFT JOIN hods h ON a.hod_id = h.id 
      WHERE a.date BETWEEN ? AND ?
      ORDER BY a.date DESC
    `, [start_date, end_date]);
    res.json(results);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Get attendance by HOD
router.get('/hod/:hodId', async (req, res) => {
  try {
    const [results] = await db.query(`
      SELECT a.*, s.name as staff_name, s.employee_id 
      FROM attendance a 
      LEFT JOIN staff s ON a.staff_id = s.id 
      WHERE a.hod_id = ?
      ORDER BY a.date DESC
    `, [req.params.hodId]);
    res.json(results);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Get attendance summary by HOD
router.get('/summary/by-hod', async (req, res) => {
  try {
    const [results] = await db.query(`
      SELECT 
        h.id as hod_id,
        h.name as hod_name,
        h.department,
        COUNT(*) as total_records,
        COUNT(CASE WHEN a.status = 'present' THEN 1 END) as present_count,
        COUNT(CASE WHEN a.status = 'absent' THEN 1 END) as absent_count,
        COUNT(CASE WHEN LOWER(a.status) IN ('half_day','half') THEN 1 END) as half_day,
        COUNT(CASE WHEN LOWER(a.status) IN ('on_leave', 'leave') THEN 1 END) as leave_count
      FROM hods h
      LEFT JOIN attendance a ON h.id = a.hod_id
      GROUP BY h.id, h.name, h.department
    `);
    res.json(results);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Create attendance record
router.post('/', ...superAdminOnly, async (req, res) => {
  try {
    const { staff_id, hod_id, date, status, check_in, check_out, remarks } = req.body;
    const [result] = await db.query(
      'INSERT INTO attendance (staff_id, hod_id, date, status, check_in, check_out, remarks) VALUES (?, ?, ?, ?, ?, ?, ?)',
      [staff_id, hod_id, date, status || 'present', check_in, check_out, remarks]
    );
    res.status(201).json({ id: result.insertId, message: 'Attendance recorded successfully' });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Update attendance record
router.put('/:id', ...superAdminOnly, async (req, res) => {
  try {
    const { staff_id, hod_id, date, status, check_in, check_out, remarks } = req.body;
    await db.query(
      'UPDATE attendance SET staff_id = ?, hod_id = ?, date = ?, status = ?, check_in = ?, check_out = ?, remarks = ? WHERE id = ?',
      [staff_id, hod_id, date, status, check_in, check_out, remarks, req.params.id]
    );
    res.json({ message: 'Attendance updated successfully' });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Delete attendance record
router.delete('/:id', ...superAdminOnly, async (req, res) => {
  try {
    await db.query('DELETE FROM attendance WHERE id = ?', [req.params.id]);
    res.json({ message: 'Attendance deleted successfully' });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Get attendance statistics with filters
router.get('/statistics', authenticateJWT, async (req, res) => {
  try {
    const { role, hod_id: userHodId } = req.user;
    const { start_date, end_date, hod_id, department, period, status, employee_type } = req.query;
    
    console.log('[Attendance Statistics] Request received with params:', { period, hod_id, department, employee_type });
    console.log('[Attendance Statistics] User role:', role, 'User hod_id:', userHodId);
    
    let dateFilter = '';
    let params = [];
    
    if (start_date && end_date) {
      dateFilter = 'WHERE a.date BETWEEN ? AND ?';
      params = [start_date, end_date];
    } else if (period === 'today') {
      dateFilter = 'WHERE DATE(a.date) = CURDATE()';
    } else if (period === 'week') {
      dateFilter = 'WHERE a.date >= DATE_SUB(CURDATE(), INTERVAL 7 DAY)';
    } else if (period === 'month') {
      dateFilter = 'WHERE a.date >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH)';
    } else if (period === 'quarter') {
      dateFilter = 'WHERE a.date >= DATE_SUB(CURDATE(), INTERVAL 3 MONTH)';
    } else if (period === 'year') {
      dateFilter = 'WHERE a.date >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR)';
    }
    
    // HOD restriction - force hod_id for HOD users
    if (role === 'hod') {
      dateFilter += dateFilter ? ' AND a.hod_id = ?' : 'WHERE a.hod_id = ?';
      params.push(userHodId);
    } else if (hod_id) {
      dateFilter += dateFilter ? ' AND a.hod_id = ?' : 'WHERE a.hod_id = ?';
      params.push(hod_id);
    }

    if (department) {
      dateFilter += dateFilter ? ' AND h.department = ?' : 'WHERE h.department = ?';
      params.push(department);
    }

    if (employee_type && employee_type !== 'all') {
      dateFilter += dateFilter ? ' AND s.employee_type = ?' : 'WHERE s.employee_type = ?';
      params.push(employee_type);
    }
    
    // Get summary statistics - use status directly from DB
    const [summary] = await db.query(`
      SELECT 
        COUNT(*) as total_records,
        COUNT(CASE WHEN LOWER(a.status) = 'present' THEN 1 END) as present,
        COUNT(CASE WHEN LOWER(a.status) = 'absent' THEN 1 END) as absent,
        COUNT(CASE WHEN LOWER(a.status) IN ('half_day','half') THEN 1 END) as half_day,
        COUNT(CASE WHEN LOWER(a.status) IN ('on_leave', 'leave') THEN 1 END) as on_leave,
        COUNT(CASE WHEN LOWER(a.status) = 'late' THEN 1 END) as late,
        COUNT(CASE WHEN LOWER(a.status) NOT IN ('present', 'absent', 'half_day', 'on_leave', 'leave', 'late') OR a.status IS NULL THEN 1 END) as other,
        COUNT(DISTINCT a.staff_id) as unique_staff,
        COUNT(DISTINCT a.date) as working_days
      FROM attendance a
      LEFT JOIN staff s ON a.staff_id = s.id
      LEFT JOIN hods h ON a.hod_id = h.id
      ${dateFilter}
    `, params);
    
    // Get monthly trend data - use status directly from DB
    const [monthlyTrend] = await db.query(`
      SELECT 
        DATE_FORMAT(a.date, '%Y-%m') as month,
        DATE_FORMAT(a.date, '%b %Y') as month_label,
        COUNT(CASE WHEN LOWER(a.status) = 'present' THEN 1 END) as present,
        COUNT(CASE WHEN LOWER(a.status) = 'absent' THEN 1 END) as absent,
        COUNT(CASE WHEN LOWER(a.status) IN ('half_day','half') THEN 1 END) as half_day,
        COUNT(CASE WHEN LOWER(a.status) IN ('on_leave', 'leave') THEN 1 END) as on_leave,
        COUNT(CASE WHEN LOWER(a.status) = 'late' THEN 1 END) as late
      FROM attendance a
      LEFT JOIN staff s ON a.staff_id = s.id
      LEFT JOIN hods h ON a.hod_id = h.id
      ${dateFilter}
      GROUP BY DATE_FORMAT(a.date, '%Y-%m'), DATE_FORMAT(a.date, '%b %Y')
      ORDER BY month DESC
      LIMIT 12
    `, params);
    
    // Build daily trend filter - Include today's data when period is 'today'
    let dailyFilter = '';
    let dailyParams = [];
    
    if (period === 'today') {
      dailyFilter = 'WHERE DATE(a.date) = CURDATE()';
    } else {
      dailyFilter = 'WHERE a.date >= DATE_SUB(CURDATE(), INTERVAL 30 DAY)';
    }
    
    // if (hod_id) {
    //   dailyFilter += ' AND a.hod_id = ?';
    //   dailyParams.push(hod_id);
    // }
    if (role === 'hod') {
  dailyFilter += ' AND a.hod_id = ?';
  dailyParams.push(userHodId);
} else if (hod_id) {
  dailyFilter += ' AND a.hod_id = ?';
  dailyParams.push(hod_id);
}

    if (department) {
      dailyFilter += ' AND h.department = ?';
      dailyParams.push(department);
    }
    if (employee_type && employee_type !== 'all') {
      dailyFilter += ' AND s.employee_type = ?';
      dailyParams.push(employee_type);
    }

    // Get daily trend for last 30 days - use status directly from DB
    const [dailyTrend] = await db.query(`
      SELECT 
        DATE_FORMAT(a.date, '%Y-%m-%d') as day,
        DATE_FORMAT(a.date, '%d %b') as day_label,
        COUNT(CASE WHEN LOWER(a.status) = 'present' THEN 1 END) as present,
        COUNT(CASE WHEN LOWER(a.status) = 'absent' THEN 1 END) as absent,
       COUNT(CASE WHEN LOWER(a.status) IN ('half_day','half') THEN 1 END) as half_day,
        COUNT(CASE WHEN LOWER(a.status) IN ('on_leave', 'leave') THEN 1 END) as on_leave,
        COUNT(CASE WHEN LOWER(a.status) = 'late' THEN 1 END) as late
      FROM attendance a
      LEFT JOIN staff s ON a.staff_id = s.id
      LEFT JOIN hods h ON a.hod_id = h.id
      ${dailyFilter}
      GROUP BY DATE_FORMAT(a.date, '%Y-%m-%d'), DATE_FORMAT(a.date, '%d %b')
      ORDER BY day DESC
    `, dailyParams);
    
    // Build department-wise filter with staff join for employee_type
    let deptFilter = '';
    let deptParams = [];
    
    // Date filters
    if (start_date && end_date) {
      deptFilter = 'WHERE a.date BETWEEN ? AND ?';
      deptParams = [start_date, end_date];
    } else if (period === 'today') {
      deptFilter = 'WHERE DATE(a.date) = CURDATE()';
    } else if (period === 'week') {
      deptFilter = 'WHERE a.date >= DATE_SUB(CURDATE(), INTERVAL 7 DAY)';
    } else if (period === 'month') {
      deptFilter = 'WHERE a.date >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH)';
    } else if (period === 'quarter') {
      deptFilter = 'WHERE a.date >= DATE_SUB(CURDATE(), INTERVAL 3 MONTH)';
    } else if (period === 'year') {
      deptFilter = 'WHERE a.date >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR)';
    }
    
    // 🔐 HOD restriction
    if (role === 'hod') {
      deptFilter += deptFilter ? ' AND a.hod_id = ?' : 'WHERE a.hod_id = ?';
      deptParams.push(userHodId);
    } else if (hod_id) {
      deptFilter += deptFilter ? ' AND a.hod_id = ?' : 'WHERE a.hod_id = ?';
      deptParams.push(hod_id);
    }
    
    // Employee type
    if (employee_type && employee_type !== 'all') {
      deptFilter += deptFilter ? ' AND s.employee_type = ?' : 'WHERE s.employee_type = ?';
      deptParams.push(employee_type);
    }


    // Get department-wise summary - use status directly from DB
    const [departmentWise] = await db.query(`
      SELECT 
        h.department,
        h.name as hod_name,
        COUNT(CASE WHEN LOWER(a.status) = 'present' THEN 1 END) as present,
        COUNT(CASE WHEN LOWER(a.status) = 'absent' THEN 1 END) as absent,
        COUNT(CASE WHEN LOWER(a.status) IN ('half_day','half') THEN 1 END) as half_day,
        COUNT(CASE WHEN LOWER(a.status) IN ('on_leave', 'leave') THEN 1 END) as on_leave,
        COUNT(CASE WHEN LOWER(a.status) = 'late' THEN 1 END) as late,
        COUNT(*) as total
      FROM attendance a
      LEFT JOIN hods h ON a.hod_id = h.id
      LEFT JOIN staff s ON a.staff_id = s.id
      ${deptFilter}
      GROUP BY h.id, h.department, h.name
    `, deptParams);
    
    console.log('[Attendance Statistics] Query - dateFilter:', dateFilter);
    console.log('[Attendance Statistics] Query - params:', params);
    console.log('[Attendance Statistics] Summary:', summary[0]);
    console.log('[Attendance Statistics] Daily trend records:', dailyTrend?.length || 0);
    console.log('[Attendance Statistics] Monthly trend records:', monthlyTrend?.length || 0);
    console.log('[Attendance Statistics] Department wise records:', departmentWise?.length || 0);
    
    res.json({
      summary: summary[0],
      monthlyTrend: monthlyTrend.reverse(),
      dailyTrend: dailyTrend.reverse(),
      departmentWise
    });
  } catch (error) {
    console.error('[Attendance Statistics] ERROR:', error);
    console.error('[Attendance Statistics] Error details:', error.message);
    res.status(500).json({ error: error.message });
  }
});

// Get department-wise attendance with employee lists
router.get('/department-wise', authenticateJWT, async (req, res) => {
  try {
    const { role, hod_id: userHodId } = req.user;
    const { period, employee_type } = req.query;

    console.log('[Attendance Department-wise] Request received with params:', { period, employee_type });
    console.log('[Attendance Department-wise] User role:', role, 'User hod_id:', userHodId);

    const dateCondition = (() => {
      if (period === 'today') return 'DATE(a.date) = CURDATE()';
      if (period === 'week') return 'a.date >= DATE_SUB(CURDATE(), INTERVAL 7 DAY)';
      if (period === 'month') return 'a.date >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH)';
      if (period === 'quarter') return 'a.date >= DATE_SUB(CURDATE(), INTERVAL 3 MONTH)';
      if (period === 'year') return 'a.date >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR)';
      return '';
    })();

    const attendanceJoinFilter = dateCondition ? ` AND ${dateCondition}` : '';
    
    let whereClause = '1=1';
    const params = [];
    
    // 🔐 HOD restriction - force HOD users to see only their data
    if (role === 'hod') {
      whereClause = 'h.id = ?';
      params.push(userHodId);
    }
    
    // Employee type filter
    if (employee_type && employee_type !== 'all') {
      whereClause += ' AND s.employee_type = ?';
      params.push(employee_type);
    }

    // Get all departments with their attendance counts and employee details
    // const [departments] = await db.query(`
    //   SELECT 
    //     h.id as hod_id,
    //     h.name as hod_name,
    //     h.department,
    //     COUNT(DISTINCT s.id) as total_emp,
    //     COUNT(CASE WHEN a.status = 'present' AND (a.check_in IS NULL OR TIME(a.check_in) <= '10:30:00') THEN 1 END) as present,
    //     COUNT(CASE WHEN a.status = 'absent' THEN 1 END) as absent,
    //     COUNT(CASE WHEN a.status = 'late' OR (a.status = 'present' AND a.check_in IS NOT NULL AND TIME(a.check_in) > '10:30:00') THEN 1 END) as late,
    //     COUNT(CASE WHEN a.status = 'leave' OR a.status = 'on_leave' THEN 1 END) as emp_leave
    //   FROM hods h
    //   LEFT JOIN staff s ON s.hod_id = h.id
    //   LEFT JOIN attendance a ON a.staff_id = s.id${attendanceJoinFilter}
    //   ${whereClause}
    //   GROUP BY h.id, h.name, h.department
    //   ORDER BY h.department
    // `, params);
    const [departments] = await db.query(`
      SELECT 
        h.id as hod_id,
        h.name as hod_name,
        h.department,
        COUNT(DISTINCT s.id) as total_emp,
        COUNT(CASE WHEN LOWER(a.status) = 'present' THEN 1 END) as present,
        COUNT(CASE WHEN LOWER(a.status) = 'absent' THEN 1 END) as absent,
        COUNT(CASE WHEN LOWER(a.status) = 'late' THEN 1 END) as late,
        COUNT(CASE WHEN LOWER(a.status) IN ('half_day','half') THEN 1 END) as half_day,
        COUNT(CASE WHEN LOWER(a.status) IN ('on_leave', 'leave') THEN 1 END) as emp_leave
      FROM hods h
      LEFT JOIN staff s ON s.hod_id = h.id
      LEFT JOIN attendance a ON a.staff_id = s.id${attendanceJoinFilter}
      WHERE ${whereClause}
      GROUP BY h.id, h.name, h.department
      ORDER BY h.department
    `, params);


    // Get detailed employee list for each status in each department
    // const [employees] = await db.query(`
    //   SELECT 
    //     h.id as hod_id,
    //     h.department,
    //     s.id as staff_id,
    //     s.name as staff_name,
    //     s.employee_id,
    //     s.designation,
    //     s.phone,
    //     s.employee_type,
    //     a.status,
    //     a.check_in,
    //     a.check_out,
    //     a.date,
    //     a.remarks,
    //     CASE 
    //       WHEN a.status = 'late' THEN 'late'
    //       WHEN a.status = 'present' AND a.check_in IS NOT NULL AND TIME(a.check_in) > '10:30:00' THEN 'late'
    //       WHEN a.status = 'present' AND (a.check_in IS NULL OR TIME(a.check_in) <= '10:30:00') THEN 'present'
    //       WHEN a.status = 'absent' THEN 'absent'
    //       WHEN a.status = 'leave' OR a.status = 'on_leave' THEN 'leave'
    //       ELSE a.status
    //     END as display_status
    //   FROM hods h
    //   LEFT JOIN staff s ON s.hod_id = h.id
    //   LEFT JOIN attendance a ON a.staff_id = s.id${attendanceJoinFilter}
    //   ${whereClause}
    //   ORDER BY h.department, s.name
    // `, params);
    const [employees] = await db.query(`
      SELECT 
        h.id as hod_id,
        h.department,
        s.id as staff_id,
        s.name as staff_name,
        s.employee_id,
        s.designation,
        s.role,
        s.phone,
        s.email,
        s.employee_type,
        a.status,
        a.check_in,
        a.check_out,
        a.date,
        a.remarks,
        CASE 
          WHEN LOWER(a.status) IN ('on_leave', 'leave') THEN 'leave'
          WHEN LOWER(a.status) IN ('half_day', 'half') THEN 'half_day'
          ELSE LOWER(a.status)
        END as display_status
      FROM hods h
      LEFT JOIN staff s ON s.hod_id = h.id
      LEFT JOIN attendance a ON a.staff_id = s.id${attendanceJoinFilter}
      WHERE ${whereClause}
      ORDER BY h.department, s.name
    `, params);


    // Organize employees by department and status
    const departmentData = departments.map(dept => {
      const deptEmployees = employees.filter(e => e.hod_id === dept.hod_id);
      
      return {
        ...dept,
        employees: {
          total: deptEmployees,
          present: deptEmployees.filter(e => e.display_status === 'present'),
          absent: deptEmployees.filter(e => e.display_status === 'absent'),
          half_day: deptEmployees.filter(e => e.display_status === 'half_day'),
          late: deptEmployees.filter(e => e.display_status === 'late'),
          leave: deptEmployees.filter(e => e.display_status === 'leave')
        }
      };
    });

    console.log('[Attendance Department-wise] Total departments:', departmentData?.length || 0);
    console.log('[Attendance Department-wise] Sample dept:', departmentData?.[0]);

    res.json(departmentData);
  } catch (error) {
    console.error('[Attendance Department-wise] ERROR:', error);
    console.error('[Attendance Department-wise] Error details:', error.message);
    res.status(500).json({ error: error.message });
  }
});

// Get filtered attendance records
router.get('/filtered', authenticateJWT, async (req, res) => {
  try {
    console.log("/////////////////////////////////////")

        const { role, hod_id: userHodId } = req.user;

    // 🔐 FORCE HOD SCOPE
    if (role === 'hod') {
      req.query.hod_id = userHodId;
    }

    const { start_date, end_date, hod_id, department, status, period, employee_type } = req.query;
    
    console.log('[Attendance Filtered] Request received with params:', { period, hod_id, department, status, employee_type });
    console.log('[Attendance Filtered] User role:', role, 'User hod_id:', userHodId);
    
    let whereClause = '1=1';
    let params = [];
    
    if (start_date && end_date) {
      whereClause += ' AND a.date BETWEEN ? AND ?';
      params.push(start_date, end_date);
    } else if (period === 'today') {
      whereClause += ' AND DATE(a.date) = CURDATE()';
    } else if (period === 'week') {
      whereClause += ' AND a.date >= DATE_SUB(CURDATE(), INTERVAL 7 DAY)';
    } else if (period === 'month') {
      whereClause += ' AND a.date >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH)';
    } else if (period === 'quarter') {
      whereClause += ' AND a.date >= DATE_SUB(CURDATE(), INTERVAL 3 MONTH)';
    } else if (period === 'year') {
      whereClause += ' AND a.date >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR)';
    }
    
    if (hod_id) {
      whereClause += ' AND a.hod_id = ?';
      params.push(hod_id);
    }

    if (department) {
      whereClause += ' AND h.department = ?';
      params.push(department);
    }

    if (employee_type && employee_type !== 'all') {
      whereClause += ' AND s.employee_type = ?';
      params.push(employee_type);
    }
    
    if (status && status !== 'all') {
      if (status === 'leave') {
        whereClause += " AND LOWER(a.status) IN ('on_leave', 'leave')";
      } else if (status === 'half' || status === 'half_day') {
        whereClause += " AND LOWER(a.status) IN ('half_day', 'half')";
      } else {
        whereClause += ' AND LOWER(a.status) = ?';
        params.push(status.toLowerCase());
      }
    }
    
    const [results] = await db.query(`
      SELECT 
        a.id,
        a.staff_id,
        a.hod_id,
        a.department_id,
        a.date,
        a.status,
        a.check_in,
        a.check_out,
        a.working_hours,
        a.device_id,
        a.device_ip,
        a.record_timestamp,
        a.source,
        a.created_at,
        a.updated_at,
        s.name as staff_name, 
        s.employee_id,
        s.designation,
        s.role,
        s.phone,
        s.email,
        s.employee_type,
        h.name as hod_name, 
        h.department,
        CASE 
          WHEN LOWER(a.status) IN ('on_leave', 'leave') THEN 'leave'
          WHEN LOWER(a.status) IN ('half_day', 'half') THEN 'half_day'
          ELSE LOWER(a.status)
        END as display_status,
        COALESCE(a.working_hours, 
          CASE 
            WHEN a.check_in IS NOT NULL AND a.check_out IS NOT NULL 
            THEN TIMEDIFF(a.check_out, a.check_in)
            ELSE NULL
          END
        ) as calculated_working_hours
      FROM attendance a 
      LEFT JOIN staff s ON a.staff_id = s.id 
      LEFT JOIN hods h ON a.hod_id = h.id 
      WHERE ${whereClause}
      ORDER BY a.date DESC, a.check_in DESC
      LIMIT 1000
    `, params);
    console.log('[Attendance Filtered] Total records found:', results?.length || 0);
    console.log('[Attendance Filtered] Sample record:', results?.[0]);
    
    res.json(results);
  } catch (error) {
    console.error('[Attendance Filtered] ERROR:', error);
    console.error('[Attendance Filtered] Error details:', error.message);
    res.status(500).json({ error: error.message });
  }
});

// Get staff who don't have attendance for a specific date (potential absentees)
router.get('/absent-staff/:date', authenticateJWT, async (req, res) => {
  try {
    const { date } = req.params;
    const { role, hod_id: userHodId } = req.user;
    const { hod_id, department, employee_type } = req.query;
    
    console.log('[Absent Staff] Checking for date:', date);
    
    let whereClause = '1=1';
    let params = [date];
    
    // HOD restriction
    if (role === 'hod') {
      whereClause += ' AND s.hod_id = ?';
      params.push(userHodId);
    } else if (hod_id) {
      whereClause += ' AND s.hod_id = ?';
      params.push(hod_id);
    }
    
    if (department) {
      whereClause += ' AND h.department = ?';
      params.push(department);
    }
    
    if (employee_type && employee_type !== 'all') {
      whereClause += ' AND s.employee_type = ?';
      params.push(employee_type);
    }
    
    // Get all active staff who DON'T have attendance record for the given date
    const [absentStaff] = await db.query(`
      SELECT 
        s.id as staff_id,
        s.employee_id,
        s.name as staff_name,
        s.designation,
        s.employee_type,
        s.hod_id,
        h.name as hod_name,
        h.department
      FROM staff s
      LEFT JOIN hods h ON s.hod_id = h.id
      WHERE s.id NOT IN (
        SELECT staff_id FROM attendance WHERE DATE(date) = ?
      )
      AND ${whereClause}
      ORDER BY h.department, s.name
    `, params);
    
    console.log('[Absent Staff] Found', absentStaff.length, 'staff without attendance');
    
    res.json({
      date,
      total_absent: absentStaff.length,
      staff: absentStaff
    });
  } catch (error) {
    console.error('[Absent Staff] Error:', error);
    res.status(500).json({ error: error.message });
  }
});

// Auto-mark absent staff for a specific date
// This inserts "absent" records for all staff who don't have attendance
// When they check in via external system, the record will be updated via upsert
router.post('/mark-absent', ...superAdminOnly, async (req, res) => {
  try {
    const { date, hod_id, department, employee_type } = req.body;
    const targetDate = date || new Date().toISOString().split('T')[0];
    
    console.log('[Mark Absent] Processing for date:', targetDate);
    
    let whereClause = '1=1';
    let params = [targetDate];
    
    if (hod_id) {
      whereClause += ' AND s.hod_id = ?';
      params.push(hod_id);
    }
    
    if (department) {
      whereClause += ' AND h.department = ?';
      params.push(department);
    }
    
    if (employee_type && employee_type !== 'all') {
      whereClause += ' AND s.employee_type = ?';
      params.push(employee_type);
    }
    
    // Get staff who don't have attendance for the date
    const [absentStaff] = await db.query(`
      SELECT 
        s.id as staff_id,
        s.hod_id,
        h.id as department_id
      FROM staff s
      LEFT JOIN hods h ON s.hod_id = h.id
      WHERE s.id NOT IN (
        SELECT staff_id FROM attendance WHERE DATE(date) = ?
      )
      AND ${whereClause}
    `, params);
    
    console.log('[Mark Absent] Found', absentStaff.length, 'staff to mark absent');
    
    if (absentStaff.length === 0) {
      return res.json({
        message: 'No staff to mark absent',
        date: targetDate,
        marked_absent: 0
      });
    }
    
    // Insert absent records using upsert (so if they check in later, it updates)
    let markedCount = 0;
    for (const staff of absentStaff) {
      try {
        await db.query(`
          INSERT INTO attendance (staff_id, hod_id, department_id, date, status, source, created_at)
          VALUES (?, ?, ?, ?, 'absent', 'auto_absent', NOW())
          ON DUPLICATE KEY UPDATE
            status = CASE 
              WHEN status = 'absent' OR status IS NULL THEN 'absent'
              ELSE status
            END,
            updated_at = NOW()
        `, [staff.staff_id, staff.hod_id, staff.department_id, targetDate]);
        markedCount++;
      } catch (insertErr) {
        console.error('[Mark Absent] Error marking staff', staff.staff_id, ':', insertErr.message);
      }
    }
    
    console.log('[Mark Absent] Successfully marked', markedCount, 'as absent');
    
    res.json({
      message: `Marked ${markedCount} staff as absent`,
      date: targetDate,
      marked_absent: markedCount,
      total_found: absentStaff.length
    });
  } catch (error) {
    console.error('[Mark Absent] Error:', error);
    res.status(500).json({ error: error.message });
  }
});

module.exports = router;
