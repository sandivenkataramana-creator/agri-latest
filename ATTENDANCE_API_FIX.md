# Attendance API - 500 Error Fix & Filter Issues

## Issues Fixed

### 1. **Backend Issue: 500 Error in `/api/attendance/statistics`**

**Root Cause**: Lines 127-129 in `routes/attendance.js` had undefined variables being used before declaration.

```javascript
// ❌ BROKEN (Lines 127-129)
if (role === 'hod') {
  whereClause += ' AND a.hod_id = ?';  // whereClause not yet declared!
  params.push(userHodId);
} else if (hod_id) {
  whereClause += ' AND a.hod_id = ?';
  params.push(hod_id);  // hod_id not yet extracted!
}

// Then later:
const { start_date, end_date, hod_id, department, period, status, employee_type } = req.query;
let dateFilter = '';
let params = [];  // Redeclared here!
```

**Fix**: Removed the problematic lines and moved variable declarations to the beginning:

```javascript
// ✅ FIXED
const { role, hod_id: userHodId } = req.user;
const { start_date, end_date, hod_id, department, period, status, employee_type } = req.query;

let dateFilter = '';
let params = [];
```

---

### 2. **Backend Issue: Department-wise Endpoint Uses `db.escape()` (SQL Injection Risk)**

**Root Cause**: The `/department-wise` endpoint used `db.escape()` which is deprecated and unsafe.

```javascript
// ❌ BROKEN
let hodCondition = '';
if (role === 'hod') {
  hodCondition = ` AND h.id = ${db.escape(hod_id)}`;  // Unsafe!
}
const whereClause = safeEmployeeType ? `WHERE s.employee_type = ${db.escape(safeEmployeeType)}` : '';
```

**Fix**: Converted to parameterized queries:

```javascript
// ✅ FIXED
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

// Then use WHERE clause with params:
const [departments] = await db.query(`
  SELECT ... FROM hods h ...
  WHERE ${whereClause}
  ...
`, params);
```

---

### 3. **Frontend Issue: Filters Not Being Sent Properly for HOD Users**

**Root Cause**: HOD users were removing the department filter without sending the `hod_id` to the backend.

```javascript
// ❌ BROKEN
const fetchAttendanceData = useCallback(async () => {
  const params = { ...filters };
  
  if (user.role === 'hod') {
    delete params.department; // Removing but not replacing with hod_id!
  }
  
  Object.keys(params).forEach(key => {
    if (params[key] === '' || params[key] === 'all' || ...) {
      delete params[key];
    }
  });
  
  // Now params has no hod_id, no department, backend can't scope!
  const [attendanceRes, statsRes, deptRes] = await Promise.all([
    getAttendanceFiltered(params),
    getAttendanceStatistics(params),
    getDepartmentWiseAttendance(params)
  ]);
}, [filters, user.role]); // Missing user.hod_id dependency!
```

**Fix**: Send `hod_id` explicitly for HOD users:

```javascript
// ✅ FIXED
const fetchAttendanceData = useCallback(async () => {
  const params = { ...filters };

  // For HOD users, send hod_id instead of department filter (backend scopes by hod_id)
  if (user.role === 'hod' && user.hod_id) {
    params.hod_id = user.hod_id;
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

  const [attendanceRes, statsRes, deptRes] = await Promise.all([
    getAttendanceFiltered(params),
    getAttendanceStatistics(params),
    getDepartmentWiseAttendance(params)
  ]);
}, [filters, user.role, user.hod_id]); // ← Added user.hod_id dependency
```

---

## Flow Overview After Fixes

### For Superadmin:
```
Frontend:
  filters = { period: 'today', status: 'all', department: '', ... }
  → params = { period: 'today', status: 'all', department: 'HR', ... }
  
Backend:
  /api/attendance/statistics?period=today&department=HR
  → Query: WHERE DATE(a.date) = CURDATE() AND h.department = ?
  → Returns data for HR department only
```

### For HOD:
```
Frontend:
  filters = { period: 'today', status: 'all', department: 'HR', ... }
  → params = { period: 'today', status: 'all', hod_id: 5, ... }  // ← Replaces department with hod_id
  
Backend:
  /api/attendance/statistics?period=today&hod_id=5
  → if (role === 'hod') {
      dateFilter += ' AND a.hod_id = ?';  // ← Always scoped by HOD
      params.push(userHodId);
    }
  → Query: WHERE DATE(a.date) = CURDATE() AND a.hod_id = 5
  → Returns data for HOD #5 only
```

---

## Files Modified

1. **backend/routes/attendance.js**
   - Line 119: Removed undefined variables from statistics endpoint
   - Lines 315-342: Fixed department-wise endpoint with parameterized queries
   - Lines 410-440: Fixed employees query with proper WHERE clause

2. **frontend/src/pages/Attendance.js**
   - Lines 109-152: Updated fetchAttendanceData to send hod_id for HOD users
   - Added user.hod_id to dependency array

---

## API Endpoint Fixes Summary

### ✅ `/api/attendance/statistics`
- **Before**: 500 Internal Server Error
- **After**: Returns summary, monthly/daily trends, and department-wise statistics
- **Parameters**: `period`, `hod_id`, `department`, `employee_type`, `start_date`, `end_date`
- **HOD Scope**: Automatically scoped by userHodId when role='hod'

### ✅ `/api/attendance/filtered`
- **Before**: Department filter not working correctly
- **After**: Works with both superadmin and HOD filters
- **Parameters**: `hod_id`, `department`, `period`, `status`, `employee_type`
- **HOD Scope**: Forces hod_id = userHodId when role='hod'

### ✅ `/api/attendance/department-wise`
- **Before**: SQL injection vulnerability with db.escape()
- **After**: Safe parameterized queries
- **Parameters**: `period`, `employee_type`
- **HOD Scope**: Returns only user's department when role='hod'

---

## Testing Checklist

- [x] No SQL errors or undefined variables
- [x] Backend server starts without errors
- [x] Statistics endpoint receives proper parameters
- [x] HOD users are scoped to their department
- [x] Superadmin can filter by any department
- [x] Filters work for all periods (today, week, month, etc.)
- [x] Department-wise endpoint uses safe queries

---

## How to Test

### Test 1: Superadmin viewing all departments
```bash
curl "http://localhost:5000/api/attendance/statistics?period=today"
```

### Test 2: Superadmin filtering by department
```bash
curl "http://localhost:5000/api/attendance/statistics?period=today&department=HR"
```

### Test 3: HOD viewing only their data (backend forces scope)
```bash
# Frontend sends hod_id
curl "http://localhost:5000/api/attendance/statistics?period=today&hod_id=5"
# Backend receives JWT with role='hod' and hod_id=5 and restricts results
```

### Test 4: Filtered attendance records
```bash
curl "http://localhost:5000/api/attendance/filtered?period=today&status=present"
```

---

## Summary

✅ **Fixed 500 Error** in statistics endpoint  
✅ **Fixed SQL Injection** in department-wise endpoint  
✅ **Fixed Filter Issues** for HOD users  
✅ **Improved Security** by using parameterized queries  
✅ **Added HOD Scoping** to enforce role-based access  

All changes maintain backward compatibility while fixing the errors.
