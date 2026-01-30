# Attendance 500 Error & Filter Issues - Complete Change Log

## Summary
Fixed critical bugs in attendance API that were causing:
- ❌ 500 Internal Server Error on `/api/attendance/statistics`
- ❌ Filters not working for HOD users
- ❌ SQL injection vulnerability in department-wise endpoint

---

## Change 1: Backend Statistics Endpoint
**File**: `backend/routes/attendance.js`  
**Lines**: 119-124 (fixed)

### Problem
Lines 127-129 used undefined variables `whereClause`, `params`, and `hod_id` before they were declared.

### Before (Broken)
```javascript
router.get('/statistics', authenticateJWT, async (req, res) => {
  try {
    const { role, hod_id: userHodId } = req.user;

    // ❌ ERROR: These variables don't exist yet!
    if (role === 'hod') {
      whereClause += ' AND a.hod_id = ?';
      params.push(userHodId);
    } else if (hod_id) {
      whereClause += ' AND a.hod_id = ?';
      params.push(hod_id);
    }

    // NOW they're declared:
    const { start_date, end_date, hod_id, department, period, status, employee_type } = req.query;
    let dateFilter = '';
    let params = [];  // ← Redeclared after being used!
```

### After (Fixed)
```javascript
router.get('/statistics', authenticateJWT, async (req, res) => {
  try {
    const { role, hod_id: userHodId } = req.user;
    const { start_date, end_date, hod_id, department, period, status, employee_type } = req.query;
    
    let dateFilter = '';
    let params = [];
    
    if (start_date && end_date) {
      dateFilter = 'WHERE a.date BETWEEN ? AND ?';
      params = [start_date, end_date];
    } else if (period === 'today') {
      dateFilter = 'WHERE DATE(a.date) = CURDATE()';
    // ... rest of the logic follows properly
```

---

## Change 2: Department-wise Endpoint - Fix 1 (Lines 315-342)
**File**: `backend/routes/attendance.js`

### Problem
Used unsafe `db.escape()` and improperly concatenated SQL

### Before (Vulnerable)
```javascript
router.get('/department-wise', authenticateJWT, async (req, res) => {
  try {
    const { role, hod_id } = req.user;

    let hodCondition = '';
    if (role === 'hod') {
      hodCondition = ` AND h.id = ${db.escape(hod_id)}`;  // ❌ SQL Injection risk!
    }
    const { period, employee_type } = req.query;

    // ...code...

    const whereClause = safeEmployeeType ? `WHERE s.employee_type = ${db.escape(safeEmployeeType)}` : '';
    const params = [];

    const [departments] = await db.query(`
      SELECT ... FROM hods h
      LEFT JOIN staff s ON s.hod_id = h.id
      LEFT JOIN attendance a ON a.staff_id = s.id${attendanceJoinFilter}
      ${whereClause || 'WHERE 1=1'}
      ${hodCondition}  // ❌ Mixed string concatenation with params
      GROUP BY h.id, h.name, h.department
      ORDER BY h.department
    `);  // ❌ No params passed!
```

### After (Safe & Correct)
```javascript
router.get('/department-wise', authenticateJWT, async (req, res) => {
  try {
    const { role, hod_id: userHodId } = req.user;
    const { period, employee_type } = req.query;

    const dateCondition = (() => {
      if (period === 'today') return 'DATE(a.date) = CURDATE()';
      // ...other periods...
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

    const [departments] = await db.query(`
      SELECT 
        h.id as hod_id,
        h.name as hod_name,
        h.department,
        COUNT(DISTINCT s.id) as total_emp,
        COUNT(CASE WHEN a.status = 'present' AND (a.check_in IS NULL OR TIME(a.check_in) <= '10:30:00') THEN 1 END) as present,
        COUNT(CASE WHEN a.status = 'absent' THEN 1 END) as absent,
        COUNT(CASE WHEN a.status = 'late' OR (a.status = 'present' AND a.check_in IS NOT NULL AND TIME(a.check_in) > '10:30:00') THEN 1 END) as late,
        COUNT(CASE WHEN a.status = 'leave' OR a.status = 'on_leave' THEN 1 END) as emp_leave
      FROM hods h
      LEFT JOIN staff s ON s.hod_id = h.id
      LEFT JOIN attendance a ON a.staff_id = s.id${attendanceJoinFilter}
      WHERE ${whereClause}  // ✅ Proper WHERE clause
      GROUP BY h.id, h.name, h.department
      ORDER BY h.department
    `, params);  // ✅ Params passed correctly
```

---

## Change 3: Department-wise Endpoint - Fix 2 (Lines 410-440)
**File**: `backend/routes/attendance.js`

### Before (Vulnerable)
```javascript
    const [employees] = await db.query(`
      SELECT 
        h.id as hod_id,
        h.department,
        s.id as staff_id,
        s.name as staff_name,
        // ... other fields ...
        CASE 
          WHEN a.status = 'late' THEN 'late'
          // ... status mapping ...
        END as display_status
      FROM hods h
      LEFT JOIN staff s ON s.hod_id = h.id
      LEFT JOIN attendance a ON a.staff_id = s.id${attendanceJoinFilter}
      ${whereClause || 'WHERE 1=1'}
      ${hodCondition}  // ❌ Concatenated string variable
      ORDER BY h.department, s.name
    `);  // ❌ No params!
```

### After (Safe & Correct)
```javascript
    const [employees] = await db.query(`
      SELECT 
        h.id as hod_id,
        h.department,
        s.id as staff_id,
        s.name as staff_name,
        s.employee_id,
        s.designation,
        s.phone,
        s.employee_type,
        a.status,
        a.check_in,
        a.check_out,
        a.date,
        a.remarks,
        CASE 
          WHEN a.status = 'late' THEN 'late'
          WHEN a.status = 'present' AND a.check_in IS NOT NULL AND TIME(a.check_in) > '10:30:00' THEN 'late'
          WHEN a.status = 'present' AND (a.check_in IS NULL OR TIME(a.check_in) <= '10:30:00') THEN 'present'
          WHEN a.status = 'absent' THEN 'absent'
          WHEN a.status = 'leave' OR a.status = 'on_leave' THEN 'leave'
          ELSE a.status
        END as display_status
      FROM hods h
      LEFT JOIN staff s ON s.hod_id = h.id
      LEFT JOIN attendance a ON a.staff_id = s.id${attendanceJoinFilter}
      WHERE ${whereClause}  // ✅ Proper WHERE clause
      ORDER BY h.department, s.name
    `, params);  // ✅ Params passed correctly
```

---

## Change 4: Frontend Filter Logic
**File**: `frontend/src/pages/Attendance.js`  
**Lines**: 109-152

### Problem
HOD users were not sending `hod_id` to the backend, so filters didn't work. Also missing dependency in useCallback.

### Before (Broken)
```javascript
  const fetchAttendanceData = useCallback(async () => {
    try {
      setLoading(true);
      const params = { ...filters };

      if (user.role === 'hod') {
        delete params.department; // ❌ Removed but didn't add hod_id!
      }

      // Remove empty params
      Object.keys(params).forEach(key => {
        if (
          params[key] === '' ||
          params[key] === 'all' ||
          params[key] === null ||
          params[key] === undefined
        ) {
          delete params[key];
        }
      });

      // ❌ Now params might have no way to identify which HOD!
      const [attendanceRes, statsRes, deptRes] = await Promise.all([
        getAttendanceFiltered(params),
        getAttendanceStatistics(params),
        getDepartmentWiseAttendance(params)
      ]);

      setAttendance(attendanceRes.data || []);
      setStatistics(statsRes.data || null);
      setDepartmentData(deptRes.data || []);
      setError(null);
    } catch (err) {
      console.error('Error fetching attendance data:', err);
      setError('Failed to fetch attendance data. Please make sure the server is running.');
    } finally {
      setLoading(false);
    }
  }, [filters, user.role]); // ❌ Missing user.hod_id dependency!
```

### After (Fixed)
```javascript
  const fetchAttendanceData = useCallback(async () => {
    try {
      setLoading(true);
      const params = { ...filters };

      // For HOD users, send hod_id instead of department filter (backend scopes by hod_id)
      if (user.role === 'hod' && user.hod_id) {
        params.hod_id = user.hod_id;  // ✅ Add hod_id
        delete params.department; // Remove department from params, backend will scope by hod_id
      }

      // Remove empty params
      Object.keys(params).forEach(key => {
        if (
          params[key] === '' ||
          params[key] === 'all' ||
          params[key] === null ||
          params[key] === undefined
        ) {
          delete params[key];
        }
      });

      console.log('Fetching attendance with params:', params);

      // ✅ Now params has hod_id for HOD users
      const [attendanceRes, statsRes, deptRes] = await Promise.all([
        getAttendanceFiltered(params),
        getAttendanceStatistics(params),
        getDepartmentWiseAttendance(params)
      ]);

      setAttendance(attendanceRes.data || []);
      setStatistics(statsRes.data || null);
      setDepartmentData(deptRes.data || []);
      setError(null);
    } catch (err) {
      console.error('Error fetching attendance data:', err);
      setError('Failed to fetch attendance data. Please make sure the server is running.');
    } finally {
      setLoading(false);
    }
  }, [filters, user.role, user.hod_id]); // ✅ Added user.hod_id dependency
```

---

## Summary of Changes

| File | Lines | Change | Impact |
|------|-------|--------|--------|
| `backend/routes/attendance.js` | 119-124 | Removed undefined variables | 🔴 500 Error Fixed |
| `backend/routes/attendance.js` | 315-342 | Safe parameterized queries | 🔒 SQL Injection Fixed |
| `backend/routes/attendance.js` | 410-440 | Safe parameterized queries | 🔒 SQL Injection Fixed |
| `frontend/src/pages/Attendance.js` | 109-152 | Send hod_id for HOD users | 🟢 Filters Work |
| `frontend/src/pages/Attendance.js` | 152 | Added dependency | 🟢 Proper React Hook |

---

## Verification Checklist

- ✅ No undefined variables
- ✅ All queries use parameterized statements
- ✅ HOD users properly scoped by backend
- ✅ Superadmin can still filter by department
- ✅ No SQL injection vulnerabilities
- ✅ All React dependencies correct
- ✅ No compilation errors
- ✅ Server starts successfully

---

## Testing Commands

```bash
# Test 1: Statistics endpoint works
curl "http://localhost:5000/api/attendance/statistics?period=today"

# Test 2: Superadmin filters by department
curl "http://localhost:5000/api/attendance/statistics?period=today&department=HR"

# Test 3: HOD users get their data
curl "http://localhost:5000/api/attendance/statistics?period=today&hod_id=5"

# Test 4: Filtered records work
curl "http://localhost:5000/api/attendance/filtered?period=today&status=present"

# Test 5: Department-wise endpoint
curl "http://localhost:5000/api/attendance/department-wise?period=today"
```

All endpoints should return ✅ 200 OK with JSON data (no 500 errors).
