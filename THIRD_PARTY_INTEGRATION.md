# Third-Party Attendance System Integration Guide

## Overview
This guide explains how to integrate your third-party attendance/biometric system with our agricultural management system.

## Architecture

```
Third-Party System (Biometric Machine)
           ↓
    (Entry/Exit Events)
           ↓
   [Send to Our API]
           ↓
    Our Backend Receives Data
           ↓
   [Process & Store in DB]
           ↓
    Display in Dashboard & Reports
```

---

## Step 1: Generate API Key (Admin Side)

**Who does this?** Your superadmin user in our system

**Process:**
1. Login to the application as superadmin
2. Go to **Settings → Third-Party Integration** (or similar menu)
3. Click **Generate API Key**
4. Enter:
   - System Name: e.g., "BioMetric System Main Office"
   - Description: "Main biometric machine for office entry/exit tracking"
5. Copy and securely save the API Key (it will not be shown again)
6. Share this API Key with the third-party system administrator

**API Endpoint to Generate Key (if using curl/Postman):**
```bash
POST /api/attendance-import/generate-api-key
Authorization: Bearer YOUR_TOKEN
Content-Type: application/json

{
  "system_name": "BioMetric System",
  "description": "Main biometric attendance system"
}

Response:
{
  "message": "API Key generated successfully",
  "apiKey": "a1b2c3d4e5f6g7h8i9j0k1l2m3n4o5p6",
  "system_name": "BioMetric System",
  "note": "Save this API key securely. It will not be shown again."
}
```

---

## Step 2: Configure Third-Party System

**Who does this?** The third-party system administrator

### Single Record Endpoint

**URL:** `{YOUR_SERVER_URL}/api/attendance-import/webhook/attendance`

**Method:** POST

**Headers:**
```
x-api-key: {YOUR_API_KEY}
Content-Type: application/json
```

**Request Body (Every Time Employee Enters or Exits):**
```json
{
  "employee_id": "EMP001",
  "check_in": "09:30:00",
  "check_out": "18:30:00",
  "attendance_date": "2025-01-31",
  "status": "present",
  "remarks": "Entry from Gate A",
  "device_id": "BIOMETRIC_01"
}
```

**Request Parameters:**

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `employee_id` | string | ✅ Yes | Must match employee ID in our system |
| `attendance_date` | date | ✅ Yes | Format: YYYY-MM-DD |
| `check_in` | time | ❌ No | Format: HH:MM:SS (24-hour). Entry time |
| `check_out` | time | ❌ No | Format: HH:MM:SS (24-hour). Exit time |
| `status` | string | ❌ No | 'present', 'absent', 'half_day', 'leave'. Auto-detected if not provided |
| `remarks` | string | ❌ No | Any additional notes |
| `device_id` | string | ❌ No | Device identifier e.g., "BIOMETRIC_01", "GATE_A" |

**Success Response (200):**
```json
{
  "message": "Attendance record processed successfully",
  "attendance_id": 12345,
  "employee_id": "EMP001",
  "attendance_date": "2025-01-31",
  "status": "present"
}
```

**Error Responses:**

```json
// Missing API Key (401)
{
  "message": "Missing API key"
}

// Invalid API Key (401)
{
  "message": "Invalid or inactive API key"
}

// Employee Not Found (404)
{
  "message": "Employee EMP999 not found"
}

// Missing Required Fields (400)
{
  "message": "employee_id and attendance_date are required"
}
```

### Bulk Import Endpoint

**URL:** `{YOUR_SERVER_URL}/api/attendance-import/webhook/attendance-bulk`

**Method:** POST

**Headers:**
```
x-api-key: {YOUR_API_KEY}
Content-Type: application/json
```

**Request Body (Send Multiple Records):**
```json
{
  "records": [
    {
      "employee_id": "EMP001",
      "attendance_date": "2025-01-31",
      "check_in": "09:30:00",
      "check_out": "18:30:00",
      "status": "present",
      "device_id": "BIOMETRIC_01"
    },
    {
      "employee_id": "EMP002",
      "attendance_date": "2025-01-31",
      "check_in": "10:15:00",
      "status": "late",
      "device_id": "BIOMETRIC_01"
    }
  ]
}
```

**Response (200):**
```json
{
  "message": "Processed 2 records",
  "results": {
    "successful": 2,
    "failed": 0,
    "errors": []
  },
  "timestamp": "2025-01-31T14:30:00.000Z"
}
```

---

## Step 3: Test the Integration

### Using cURL

**Test Single Entry:**
```bash
curl -X POST http://your-server.com/api/attendance-import/webhook/attendance \
  -H "x-api-key: YOUR_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "employee_id": "EMP001",
    "attendance_date": "2025-01-31",
    "check_in": "09:30:00",
    "check_out": "18:30:00",
    "device_id": "BIOMETRIC_01"
  }'
```

### Using Python

```python
import requests
import json
from datetime import datetime

API_KEY = "your-api-key-here"
BASE_URL = "http://your-server.com"

def send_attendance(employee_id, check_in, check_out):
    url = f"{BASE_URL}/api/attendance-import/webhook/attendance"
    headers = {
        "x-api-key": API_KEY,
        "Content-Type": "application/json"
    }
    payload = {
        "employee_id": employee_id,
        "attendance_date": datetime.now().strftime("%Y-%m-%d"),
        "check_in": check_in,
        "check_out": check_out,
        "device_id": "BIOMETRIC_01"
    }
    
    response = requests.post(url, headers=headers, json=payload)
    print(response.json())

# Usage
send_attendance("EMP001", "09:30:00", "18:30:00")
```

### Using Node.js/JavaScript

```javascript
const axios = require('axios');

const API_KEY = 'your-api-key-here';
const BASE_URL = 'http://your-server.com';

async function sendAttendance(employeeId, checkIn, checkOut) {
  try {
    const response = await axios.post(
      `${BASE_URL}/api/attendance-import/webhook/attendance`,
      {
        employee_id: employeeId,
        attendance_date: new Date().toISOString().split('T')[0],
        check_in: checkIn,
        check_out: checkOut,
        device_id: 'BIOMETRIC_01'
      },
      {
        headers: {
          'x-api-key': API_KEY,
          'Content-Type': 'application/json'
        }
      }
    );
    console.log(response.data);
  } catch (error) {
    console.error('Error:', error.response?.data || error.message);
  }
}

// Usage
sendAttendance('EMP001', '09:30:00', '18:30:00');
```

---

## Step 4: Implementation Example (Biometric System)

### Pseudo-code for Biometric Machine/Software

```javascript
// When employee scans card for entry
async function handleEntry(employeeId, timestamp) {
  const today = new Date().toISOString().split('T')[0];
  const time = timestamp.toTimeString().split(' ')[0]; // HH:MM:SS
  
  await sendToServer({
    employee_id: employeeId,
    attendance_date: today,
    check_in: time,
    device_id: 'BIOMETRIC_01'
  });
}

// When employee scans card for exit
async function handleExit(employeeId, timestamp) {
  const today = new Date().toISOString().split('T')[0];
  const time = timestamp.toTimeString().split(' ')[0]; // HH:MM:SS
  
  // Get existing record for today
  const existingRecord = await getAttendanceRecord(employeeId, today);
  
  await sendToServer({
    employee_id: employeeId,
    attendance_date: today,
    check_in: existingRecord.check_in, // Send previous check_in
    check_out: time,
    device_id: 'BIOMETRIC_01'
  });
}
```

---

## Status Auto-Detection Logic

Our system automatically determines attendance status if not explicitly provided:

| Condition | Status |
|-----------|--------|
| check_in after 10:45 AM | `late` |
| check_in before 10:45 AM | `present` |
| Only check_in provided | `present` (if before 10:45) or `late` (if after) |
| Only check_out provided | `present` |
| No check_in or check_out | (manual review) |

---

## View Import Logs

**Endpoint:** `GET /api/attendance-import/import-logs`

**Headers:**
```
Authorization: Bearer YOUR_TOKEN
```

**Query Parameters:**
```
?start_date=2025-01-01
&end_date=2025-01-31
&import_status=success
&api_key_id=1
```

**Response:**
```json
{
  "data": [
    {
      "id": 1,
      "api_key_id": 1,
      "employee_id": "EMP001",
      "attendance_date": "2025-01-31",
      "check_in": "09:30:00",
      "check_out": "18:30:00",
      "status": "present",
      "device_id": "BIOMETRIC_01",
      "import_status": "success",
      "error_message": null,
      "created_at": "2025-01-31T14:30:00.000Z"
    }
  ]
}
```

---

## Security Best Practices

1. **API Key Management:**
   - Store API key securely on third-party system
   - Never commit API keys to version control
   - Rotate keys periodically
   - Use environment variables

2. **HTTPS:**
   - Always use HTTPS in production
   - Validate SSL certificates

3. **Rate Limiting:**
   - Implement exponential backoff on failures
   - Don't spam requests

4. **Data Validation:**
   - Validate employee_id exists before sending
   - Use correct date-time formats
   - Check for duplicate entries

5. **Error Handling:**
   - Log all API responses
   - Implement retry mechanism
   - Alert admins on repeated failures

---

## Troubleshooting

### "Invalid or inactive API key"
- Verify API key is correct and not expired
- Check if API key is active in the admin panel
- Make sure header name is exactly `x-api-key` (case-sensitive)

### "Employee not found"
- Verify employee_id matches exactly (case-sensitive)
- Check if employee is registered in the system

### "attendance_date and employee_id are required"
- Ensure both fields are present
- Use correct format: `YYYY-MM-DD` for date

### "Failed to process attendance"
- Check network connectivity
- Verify server is running
- Check request format and body

---

## Common Integration Scenarios

### Scenario 1: Two-Way Entry/Exit System
```javascript
// Employee enters
POST /api/attendance-import/webhook/attendance
{
  "employee_id": "EMP001",
  "attendance_date": "2025-01-31",
  "check_in": "09:30:00",
  "device_id": "GATE_ENTRY"
}

// Employee exits
POST /api/attendance-import/webhook/attendance
{
  "employee_id": "EMP001",
  "attendance_date": "2025-01-31",
  "check_in": "09:30:00",
  "check_out": "18:30:00",
  "device_id": "GATE_EXIT"
}
```

### Scenario 2: End of Day Bulk Upload
```javascript
// Upload all attendance for the day at 23:59
POST /api/attendance-import/webhook/attendance-bulk
{
  "records": [
    // Array of 100+ employees
  ]
}
```

### Scenario 3: Multiple Devices/Locations
```javascript
{
  "employee_id": "EMP001",
  "attendance_date": "2025-01-31",
  "check_in": "09:30:00",
  "check_out": "18:30:00",
  "device_id": "HQ_MAIN_GATE",
  "remarks": "Entry from HQ"
}
```

---

## Support & Issues

For issues or questions:
1. Check this documentation first
2. Review import logs in admin panel
3. Contact system administrator
4. Check server logs for detailed errors

---

## API Summary

| Endpoint | Method | Purpose | Auth |
|----------|--------|---------|------|
| `/attendance-import/generate-api-key` | POST | Generate new API key | Token |
| `/attendance-import/api-keys` | GET | List all API keys | Token |
| `/attendance-import/api-keys/{id}/toggle` | PATCH | Enable/disable key | Token |
| `/attendance-import/webhook/attendance` | POST | Single record import | API Key |
| `/attendance-import/webhook/attendance-bulk` | POST | Bulk records import | API Key |
| `/attendance-import/import-logs` | GET | View import history | Token |

---

**Last Updated:** January 31, 2025
**Version:** 1.0
