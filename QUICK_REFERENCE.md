# Quick Reference for Third-Party System Integration

## 🚀 Getting Started

### Your API Details
```
Base URL: http://your-domain.com/api/attendance-import
Authentication: x-api-key header
Method: POST
Content-Type: application/json
```

---

## 📝 API Endpoints

### 1. Single Entry/Exit Record
**URL:** `/webhook/attendance`

**When to use:** Every time an employee scans (entry or exit)

**Request:**
```json
{
  "employee_id": "EMP001",
  "attendance_date": "2025-01-31",
  "check_in": "09:30:00",
  "check_out": null,
  "device_id": "GATE_01"
}
```

**Response (Success):**
```json
{
  "message": "Attendance record processed successfully",
  "attendance_id": 12345,
  "status": "present"
}
```

---

### 2. Bulk Records (End of Day)
**URL:** `/webhook/attendance-bulk`

**When to use:** Import all day's records at once (recommended for EOD sync)

**Request:**
```json
{
  "records": [
    {
      "employee_id": "EMP001",
      "attendance_date": "2025-01-31",
      "check_in": "09:30:00",
      "check_out": "18:30:00"
    },
    {
      "employee_id": "EMP002",
      "attendance_date": "2025-01-31",
      "check_in": "10:05:00",
      "check_out": "19:00:00"
    }
  ]
}
```

**Response:**
```json
{
  "message": "Processed 2 records",
  "results": {
    "successful": 2,
    "failed": 0,
    "errors": []
  }
}
```

---

## 🔐 Authentication

**Header:**
```
x-api-key: YOUR_API_KEY_HERE
```

**Example cURL:**
```bash
curl -X POST http://your-server.com/api/attendance-import/webhook/attendance \
  -H "x-api-key: abc123xyz789..." \
  -H "Content-Type: application/json" \
  -d '{...}'
```

---

## 📊 Field Reference

| Field | Type | Required | Example | Notes |
|-------|------|----------|---------|-------|
| `employee_id` | String | ✅ | `EMP001` | Must exist in system |
| `attendance_date` | Date | ✅ | `2025-01-31` | Format: YYYY-MM-DD |
| `check_in` | Time | ❌ | `09:30:00` | Format: HH:MM:SS (24h) |
| `check_out` | Time | ❌ | `18:30:00` | Can be null initially |
| `status` | String | ❌ | `present` | 'present', 'absent', 'late', 'half_day', 'leave' |
| `remarks` | String | ❌ | `Entry from Gate A` | Optional notes |
| `device_id` | String | ❌ | `GATE_01` | Device identifier |

---

## ⚡ Status Auto-Detection

If you don't send `status`, we auto-detect:

```
If check_in > 10:45 AM  →  Status = "late"
If check_in ≤ 10:45 AM  →  Status = "present"
```

---

## 🛠️ Implementation Examples

### Python
```python
import requests
from datetime import datetime

API_KEY = "your-api-key"
BASE_URL = "http://your-server.com/api/attendance-import"

def send_entry(employee_id):
    data = {
        "employee_id": employee_id,
        "attendance_date": datetime.now().strftime("%Y-%m-%d"),
        "check_in": datetime.now().strftime("%H:%M:%S"),
        "device_id": "BIOMETRIC_01"
    }
    
    response = requests.post(
        f"{BASE_URL}/webhook/attendance",
        headers={"x-api-key": API_KEY},
        json=data
    )
    print(response.json())

# Usage
send_entry("EMP001")
```

### Node.js
```javascript
const axios = require('axios');

const API_KEY = 'your-api-key';
const BASE_URL = 'http://your-server.com/api/attendance-import';

async function sendEntry(employeeId) {
  const today = new Date().toISOString().split('T')[0];
  const now = new Date().toTimeString().split(' ')[0];
  
  try {
    const response = await axios.post(
      `${BASE_URL}/webhook/attendance`,
      {
        employee_id: employeeId,
        attendance_date: today,
        check_in: now,
        device_id: 'BIOMETRIC_01'
      },
      {
        headers: { 'x-api-key': API_KEY }
      }
    );
    console.log(response.data);
  } catch (error) {
    console.error('Error:', error.response?.data || error.message);
  }
}

// Usage
sendEntry('EMP001');
```

### JavaScript (Fetch API)
```javascript
const API_KEY = 'your-api-key';
const BASE_URL = 'http://your-server.com/api/attendance-import';

async function sendEntry(employeeId) {
  const today = new Date().toISOString().split('T')[0];
  const now = new Date().toTimeString().split(' ')[0];
  
  const response = await fetch(
    `${BASE_URL}/webhook/attendance`,
    {
      method: 'POST',
      headers: {
        'x-api-key': API_KEY,
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        employee_id: employeeId,
        attendance_date: today,
        check_in: now,
        device_id: 'BIOMETRIC_01'
      })
    }
  );
  
  const result = await response.json();
  console.log(result);
}

// Usage
sendEntry('EMP001');
```

### cURL
```bash
# Single entry
curl -X POST http://your-server.com/api/attendance-import/webhook/attendance \
  -H "x-api-key: YOUR_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "employee_id": "EMP001",
    "attendance_date": "2025-01-31",
    "check_in": "09:30:00",
    "device_id": "GATE_01"
  }'

# Bulk import
curl -X POST http://your-server.com/api/attendance-import/webhook/attendance-bulk \
  -H "x-api-key: YOUR_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "records": [
      {"employee_id": "EMP001", "attendance_date": "2025-01-31", "check_in": "09:30:00", "check_out": "18:30:00"},
      {"employee_id": "EMP002", "attendance_date": "2025-01-31", "check_in": "10:05:00", "check_out": "19:00:00"}
    ]
  }'
```

---

## ✅ Success Scenarios

### Entry Recorded
```json
{
  "message": "Attendance record processed successfully",
  "attendance_id": 12345,
  "employee_id": "EMP001",
  "attendance_date": "2025-01-31",
  "status": "present"
}
```

### Exit Recorded (auto-updates)
```json
{
  "message": "Attendance record processed successfully",
  "attendance_id": 12345,
  "employee_id": "EMP001",
  "attendance_date": "2025-01-31",
  "status": "present"
}
```

---

## ❌ Error Scenarios

### Invalid API Key
```json
{
  "message": "Invalid or inactive API key"
}
```

### Employee Not Found
```json
{
  "message": "Employee EMP999 not found"
}
```

### Missing Required Fields
```json
{
  "message": "employee_id and attendance_date are required"
}
```

### Server Error
```json
{
  "message": "Failed to process attendance record"
}
```

---

## 📋 Checklist Before Going Live

- [ ] API key is securely stored (not in code)
- [ ] Using HTTPS in production (not HTTP)
- [ ] Employee IDs match exactly between systems
- [ ] Time format is correct (24-hour HH:MM:SS)
- [ ] Date format is correct (YYYY-MM-DD)
- [ ] Error handling implemented (retry logic)
- [ ] Logging implemented on your side
- [ ] Testing completed with test employee
- [ ] Network connectivity verified
- [ ] DNS resolution works for your domain

---

## 🔄 Recommended Flow

```
1. Employee scans entry
   ↓
   POST /webhook/attendance with check_in
   ↓
   Response: Record created
   
2. Employee scans exit
   ↓
   POST /webhook/attendance with check_out
   ↓
   Response: Record updated

3. End of day (optional)
   ↓
   POST /webhook/attendance-bulk (all records)
   ↓
   Response: All synced
```

---

## 📞 Support

If you encounter issues:

1. Check if API key is active (ask admin)
2. Verify employee exists in system
3. Check network connectivity
4. Review error message in response
5. Check server logs (request admin)
6. Contact system administrator

---

## 🔗 Additional Resources

- Full Documentation: See `THIRD_PARTY_INTEGRATION.md`
- API Reference: See `IMPLEMENTATION_GUIDE.md`
- Support Email: admin@your-domain.com

---

**Last Updated:** January 31, 2025
**Version:** 1.0
