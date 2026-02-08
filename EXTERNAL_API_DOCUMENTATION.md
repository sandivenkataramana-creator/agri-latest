# 📋 External API Integration Documentation

## Agriculture Management System - Third-Party Integration Guide

**Version:** 1.0  
**Last Updated:** February 2026  
**Base URL:** `https://your-domain.com/api`

---

## 📌 Overview

This document provides integration guidelines for third-party systems (Biometric devices, HRMS, Time & Attendance systems) to:

1. **Register Employees** - Sync employee data from external systems
2. **Record Attendance** - Send check-in/check-out data

---

## 🔐 Authentication

All API requests require **Header-based authentication**:

| Header | Required | Description |
|--------|----------|-------------|
| `x-hod-id` | ✅ Yes | The HOD (Head of Department) ID |
| `x-department-id` | ✅ Yes | The Department ID |
| `Content-Type` | ✅ Yes | Must be `application/json` |

> 💡 **Note:** HOD ID and Department ID will be provided by the system administrator.

---

## 📡 API Endpoints

### 🏥 Health Check API

**Endpoint:** `GET /api/health`

Use this endpoint to verify API connectivity and server status before integration.

---

#### Request

```http
GET /api/health HTTP/1.1
Host: your-domain.com
```

> 💡 **Note:** No authentication headers required for health check.

---

#### Success Response

**Status Code:** `200 OK`

```json
{
  "status": "OK",
  "message": "Server is running"
}
```

---

#### Usage

Use this endpoint to:
- Verify server is online before sending data
- Test network connectivity
- Monitor server availability

---

### 1️⃣ Employee Registration API

**Endpoint:** `POST /api/staff/register-device`

Use this endpoint to register new employees or update existing employee information.

---

#### Request Headers

```http
POST /api/staff/register-device HTTP/1.1
Host: your-domain.com
Content-Type: application/json
x-hod-id: 1
x-department-id: 1
```

---

#### Request Body (Single Employee)

```json
{
  "employee_id": "EMP001",
  "name": "John Doe",
  "email": "john.doe@company.com",
  "phone": "9876543210",
  "designation": "Software Engineer",
  "role": "Developer",
  "shift": "9:00 AM - 6:00 PM",
  "status": "active",
  "job_type": "Full Time",
  "person_id": "PID001"
}
```

---

#### Request Body (Multiple Employees - Bulk Registration)

```json
[
  {
    "employee_id": "EMP001",
    "name": "John Doe",
    "email": "john.doe@company.com",
    "phone": "9876543210",
    "designation": "Software Engineer",
    "role": "Developer",
    "shift": "9:00 AM - 6:00 PM",
    "status": "active",
    "job_type": "Full Time"
  },
  {
    "employee_id": "EMP002",
    "name": "jane smith",
    "email": "jane.smith@company.com",
    "phone": "9876543211",
    "designation": "HR Manager",
    "role": "HR Lead",
    "shift": "10:00 AM - 7:00 PM",
    "status": "active",
    "job_type": "Contract"
  },
  {
    "employee_id": "EMP003",
    "name": "BOB WILSON",
    "email": "bob@company.com",
    "phone": "9876543212",
    "designation": "Security",
    "role": "Guard",
    "shift": "Night Shift",
    "status": "active",
    "job_type": "Outsource"
  }
]
```

---

#### Field Specifications

| Field | Type | Required | Max Length | Description |
|-------|------|----------|------------|-------------|
| `employee_id` | string | ✅ **Yes** | 50 | Unique employee identifier from your system |
| `name` | string | ✅ **Yes** | 100 | Full name (auto-formatted to Title Case) |
| `email` | string | ❌ No | 100 | Employee email address |
| `phone` | string | ❌ No | 20 | Contact number |
| `designation` | string | ❌ No | 100 | Job designation/title |
| `role` | string | ❌ No | 100 | Role from external system (displayed as Designation in UI) |
| `shift` | string | ❌ No | 100 | Shift timing (stored as provided, no validation) |
| `status` | string | ❌ No | 20 | Employee status (default: `active`) |
| `job_type` | string | ❌ No | 50 | Employment type (mapped to employee_type) |
| `person_id` | string | ❌ No | 50 | Secondary ID from biometric system |

---

#### ✅ Validations Applied

| Rule | Description |
|------|-------------|
| `employee_id` Required | Must be provided for each record |
| `name` Required | Must be provided for each record |
| Name Auto-Format | Names are converted to Title Case (e.g., "JOHN DOE" → "John Doe") |
| Upsert Logic | If employee_id exists, record is **updated**; otherwise **inserted** |
| HOD/Department | Must be valid IDs that exist in the system |

---

#### 🔄 Job Type to Employee Type Mapping

Your `job_type` value is automatically mapped to our `employee_type`:

| Your job_type Value | Mapped to employee_type | UI Display Color |
|---------------------|------------------------|------------------|
| `Full Time`, `Full-time`, `Fulltime`, `FULL TIME` | `regular` | 🔵 Blue |
| `Part Time`, `Part-time`, `Parttime`, `PART TIME` | `regular` | 🔵 Blue |
| `Contract`, `Contractor`, `CONTRACT` | `contract` | 🟠 Orange |
| `Outsource`, `Consultant`, `Temp`, `Temporary` | `outsource` | 🟣 Purple |
| (empty/null/unknown) | `regular` | 🔵 Blue |

---

#### Success Response (All Records Processed)

**Status Code:** `200 OK`

```json
{
  "message": "Staff sync completed",
  "results": {
    "total": 3,
    "inserted": 2,
    "updated": 1,
    "failed": 0,
    "errors": []
  },
  "timestamp": "2026-02-07T10:30:00.000Z"
}
```

---

#### Partial Success Response (Some Records Failed)

**Status Code:** `207 Multi-Status`

```json
{
  "message": "Staff sync completed",
  "results": {
    "total": 3,
    "inserted": 1,
    "updated": 1,
    "failed": 1,
    "errors": [
      {
        "employee_id": "EMP003",
        "error": "Database constraint violation"
      }
    ]
  },
  "timestamp": "2026-02-07T10:30:00.000Z"
}
```

---

#### Error Responses

**Missing Headers (400)**
```json
{
  "message": "hod_id and department_id are required (use headers x-hod-id, x-department-id)"
}
```

**Invalid HOD ID (400)**
```json
{
  "message": "Invalid HOD ID"
}
```

**Invalid Department ID (400)**
```json
{
  "message": "Invalid Department ID"
}
```

**Missing Required Fields (400)**
```json
{
  "message": "All records failed to process",
  "results": {
    "total": 1,
    "inserted": 0,
    "updated": 0,
    "failed": 1,
    "errors": [
      {
        "employee_id": "unknown",
        "error": "employee_id and name are required"
      }
    ]
  }
}
```

---

### 2️⃣ Attendance Recording API

**Endpoint:** `POST /api/attendance-import/webhook/attendance`

Use this endpoint to record employee check-in and check-out times.

---

#### Request Headers

```http
POST /api/attendance-import/webhook/attendance HTTP/1.1
Host: your-domain.com
Content-Type: application/json
x-hod-id: 1
x-department-id: 1
```

---

#### Request Body

```json
{
  "employee_id": "EMP001",
  "attendance_date": "2026-02-07",
  "check_in": "09:15:00",
  "check_out": "18:30:00",
  "status": "present",
  "device_id": "BIO-001",
  "device_ip": "192.168.1.100",
  "timestamp": "2026-02-07 09:15:00"
}
```

---

#### Field Specifications

| Field | Type | Required | Format | Description |
|-------|------|----------|--------|-------------|
| `employee_id` | string | ✅ **Yes** | - | Employee ID (must be registered first) |
| `attendance_date` | string | ✅ **Yes** | `YYYY-MM-DD` | Date of attendance |
| `check_in` | string | ❌ No | `HH:MM:SS` or `YYYY-MM-DD HH:MM:SS` | Check-in time |
| `check_out` | string | ❌ No | `HH:MM:SS` or `YYYY-MM-DD HH:MM:SS` | Check-out time |
| `status` | string | ❌ No | - | Attendance status |
| `device_id` | string | ❌ No | - | Biometric device identifier |
| `device_ip` | string | ❌ No | - | Device IP address |
| `timestamp` | string | ❌ No | `YYYY-MM-DD HH:MM:SS` | Record timestamp |

---

#### ✅ Validations Applied

| Rule | Description |
|------|-------------|
| `employee_id` Required | Must be provided |
| `attendance_date` Required | Must be provided |
| Employee Must Exist | Employee must be registered with matching HOD & Department |
| Date Format | Accepts `YYYY-MM-DD` or `YYYY-MM-DDTHH:MM:SS` (date extracted) |
| Time Format | Accepts `HH:MM:SS` or `YYYY-MM-DD HH:MM:SS` (time extracted) |
| Upsert Logic | If attendance exists for same employee+date, record is **updated** |

---

#### 📊 Status Values

| Status | Description |
|--------|-------------|
| `present` | Employee is present |
| `absent` | Employee is absent |
| `late` | Employee arrived late |
| `half_day` or `half` | Half day attendance |
| `leave` or `on_leave` | Employee is on leave |

> 💡 **Note:** Status is stored as provided (case-insensitive). If not provided, the system may use auto-status based on check-in time.

---

#### Auto-Calculated Fields

| Field | Calculation |
|-------|-------------|
| `working_hours` | Automatically calculated from check_in and check_out using MySQL |
| `source` | Set to `third_party` for all external records |

---

#### Success Response

**Status Code:** `200 OK`

```json
{
  "success": true,
  "message": "Attendance recorded",
  "data": {
    "id": 12345,
    "employee_id": "EMP001",
    "date": "2026-02-07",
    "check_in": "09:15:00",
    "check_out": "18:30:00",
    "status": "present",
    "working_hours": "09:15:00",
    "action": "created"
  }
}
```

---

#### Update Response (Same employee + date)

**Status Code:** `200 OK`

```json
{
  "success": true,
  "message": "Attendance updated",
  "data": {
    "id": 12345,
    "employee_id": "EMP001",
    "date": "2026-02-07",
    "check_in": "09:15:00",
    "check_out": "18:45:00",
    "status": "present",
    "working_hours": "09:30:00",
    "action": "updated"
  }
}
```

---

#### Error Responses

**Missing Headers (401)**
```json
{
  "message": "hod_id and department_id are required"
}
```

**Missing Required Fields (400)**
```json
{
  "message": "employee_id and attendance_date are required"
}
```

**Employee Not Found (403)**
```json
{
  "message": "Employee EMP999 not found"
}
```

---

## 📱 What's Displayed in UI

### Staff/Employee Table

| Column | Source Field | Description |
|--------|--------------|-------------|
| Employee ID | `employee_id` | Unique identifier |
| Name | `name` | Auto-formatted to Title Case |
| Department | From `hod_id` relation | Department name |
| Employee Type | `employee_type` (mapped from `job_type`) | Color-coded badge |
| Designation | `role` | Role from external system |
| Email | `email` | Contact email (clickable) |
| Phone | `phone` | Contact number (clickable) |
| Status | `status` | Active/Inactive |

---

### Attendance Table

| Column | Source Field | Description |
|--------|--------------|-------------|
| Employee ID | `employee_id` | From staff relation |
| Name | `name` | From staff relation |
| Department | `department` | From HOD relation |
| Employee Type | `employee_type` | Color-coded badge |
| Designation | `role` | From staff relation |
| Date | `date` | Attendance date |
| Check In | `check_in` | Time formatted (12-hour) |
| Check Out | `check_out` | Time formatted (12-hour) |
| Working Hours | `working_hours` | Auto-calculated |
| Status | `status` | Color-coded badge |

---

### Status Popup Card (Click on Status)

| Column | Source Field | Description |
|--------|--------------|-------------|
| Employee ID | `employee_id` | Unique identifier |
| Name | `name` | Employee name |
| Phone | `phone` | Clickable `tel:` link |
| Email | `email` | Clickable `mailto:` link |
| Check In | `check_in` | Time formatted |
| Check Out | `check_out` | Time formatted |

---

## 🔄 Integration Workflow

### Recommended Flow

```
┌─────────────────────────────────────────────────────────────┐
│                     INITIAL SETUP                           │
├─────────────────────────────────────────────────────────────┤
│  1. Get x-hod-id and x-department-id from administrator     │
│  2. Register all employees using /api/staff/register-device │
└─────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────┐
│                    DAILY OPERATION                          │
├─────────────────────────────────────────────────────────────┤
│  3. When employee punches IN:                               │
│     POST /api/attendance-import/webhook/attendance          │
│     with check_in time                                      │
│                                                             │
│  4. When employee punches OUT:                              │
│     POST /api/attendance-import/webhook/attendance          │
│     with check_out time (same employee_id + date)          │
└─────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────┐
│                    PERIODIC SYNC                            │
├─────────────────────────────────────────────────────────────┤
│  5. Sync employee data periodically (daily/weekly)          │
│     to update any changes (name, phone, designation, etc.)  │
└─────────────────────────────────────────────────────────────┘
```

---

## ⚠️ Important Notes

### 1. Check-in/Check-out Time
- Send the **punch time** as recorded by your biometric device
- Time is stored as provided without validation
- Multiple employees can have the same check-in/check-out time
- Format: `HH:MM:SS` (24-hour format)

**Example:**
```json
// Employee 1 - punch time from Device A
{ "employee_id": "EMP001", "check_in": "09:15:00" }

// Employee 2 - punch time from Device B (same time is OK)
{ "employee_id": "EMP002", "check_in": "09:15:00" }

// Employee 3 - punch time from Device A
{ "employee_id": "EMP003", "check_in": "09:20:45" }
```


### 2. Date Format
Always use **ISO format** for dates:
- ✅ `2026-02-07` 
- ✅ `2026-02-07T09:15:00`
- ❌ `07-02-2026`
- ❌ `07/02/2026`

### 3. Time Format
Use **24-hour format**:
- ✅ `09:15:00` or `09:15`
- ✅ `18:30:00` or `18:30`
- ❌ `9:15 AM`
- ❌ `6:30 PM`

### 4. Employee Registration Before Attendance
Always register employees **before** sending attendance data. Attendance will fail if employee doesn't exist.

### 5. Shift Timing
The `shift` field is stored as-is without validation. You can send any format:
- `9:00 AM - 6:00 PM`
- `09:00-18:00`
- `Morning Shift`
- `Night Shift`

---

## 🧪 Testing with cURL

### Health Check (Test Connectivity)
```bash
curl -X GET https://your-domain.com/api/health
```

**Expected Response:**
```json
{"status":"OK","message":"Server is running"}
```

### Register Employee
```bash
curl -X POST https://your-domain.com/api/staff/register-device \
  -H "Content-Type: application/json" \
  -H "x-hod-id: 1" \
  -H "x-department-id: 1" \
  -d '{
  "employee_id":"EMP010",
  "name":"John Doe",
  "email":"john.doe@company.com",
  "phone":"3214569787",
  "role":"Developer",
  "shift":"Morning (09:00 - 18:00)",
  "status":"active",
  "job_type":"Contract",     //Contract / full time / part time / outsource
  "timestamp":"2026-02-05T10:30:00.000Z" 
}'
```

### Record Attendance
```bash
curl -X POST https://your-domain.com/api/attendance-import/webhook/attendance 
  -H "Content-Type: application/json" \
  -H "x-hod-id: 1" \
  -H "x-department-id: 1" \
  -d '{
    "employee_id": "EMP001",
    "attendance_date": "2026-02-07",
    "check_in": "09:15:00",
    "status": "present"
  }'
```

---

## 📧 Support

For integration support or to obtain your HOD ID and Department ID, please contact:
- **Email:** support@your-domain.com
- **Technical Team:** [Your contact details]

---

## 📜 Changelog

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | Feb 2026 | Initial release |

---

*Document generated for third-party integration purposes.*
