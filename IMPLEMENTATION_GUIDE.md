# Attendance API Integration - Implementation Summary

## What You've Implemented

You now have a complete third-party attendance system integration that allows external systems (biometric machines, time tracking software, etc.) to push attendance data to your application.

---

## Architecture Flow

```
┌─────────────────────────────────────────────────────────────────┐
│ Third-Party System (Biometric Machine / Software)              │
│ - ZKTeco Time Attendance System                                 │
│ - Fingerprint Reader                                            │
│ - Mobile App with GPS                                           │
│ - Any REST API compatible system                                │
└──────────────────────────┬──────────────────────────────────────┘
                          │
                    Generate API Key
                    (One-time setup)
                          │
                          ▼
                   ┌─────────────────┐
                   │ Admin Dashboard │ (superadmin only)
                   │ Generate API    │
                   │ Keys & View     │
                   │ Logs            │
                   └────────┬────────┘
                            │
                    Secure API Key (32 chars)
                            │
                            ▼
┌─────────────────────────────────────────────────────────────────┐
│ Your Server - API Endpoints                                     │
│                                                                 │
│ POST /api/attendance-import/webhook/attendance                 │
│   - Single record: Entry/Exit event                            │
│   - Auto-detection: Late status, working hours                 │
│                                                                 │
│ POST /api/attendance-import/webhook/attendance-bulk            │
│   - Bulk records: End of day upload                            │
│                                                                 │
│ GET /api/attendance-import/api-keys                            │
│ GET /api/attendance-import/import-logs                         │
└──────────────────┬───────────────────────────────────────────────┘
                   │
                   ▼
        ┌─────────────────────────┐
        │ Database               │
        │                        │
        │ attendance            │  (existing)
        │ ├─ staff_id           │
        │ ├─ check_in           │
        │ ├─ check_out          │
        │ ├─ source: third_party│  (NEW)
        │ └─ device_id          │  (NEW)
        │                        │
        │ third_party_api_keys  │  (NEW)
        │ ├─ system_name        │
        │ ├─ api_key_hash       │
        │ └─ is_active          │
        │                        │
        │ attendance_import_logs│  (NEW)
        │ ├─ api_key_id         │
        │ ├─ employee_id        │
        │ ├─ import_status      │
        │ └─ error_message      │
        └─────────────────────────┘
                   │
                   ▼
        ┌──────────────────────────┐
        │ Frontend - Dashboard     │
        │                          │
        │ • View attendance        │
        │ • Filter by department   │
        │ • Download reports       │
        │ • See import status      │
        └──────────────────────────┘
```

---

## Files Created/Modified

### New Files:
1. **[backend/routes/attendanceImport.js](../backend/routes/attendanceImport.js)**
   - All API endpoints for third-party integration
   - API key generation, validation, and management
   - Single and bulk attendance import
   - Import logging and error tracking

2. **[backend/database/attendance_import_schema.sql](../backend/database/attendance_import_schema.sql)**
   - SQL schema for new tables
   - API keys storage
   - Import logs table
   - Indexes for performance

3. **[frontend/src/pages/ThirdPartyIntegration.js](../frontend/src/pages/ThirdPartyIntegration.js)**
   - Admin panel to manage API keys
   - Generate and display new API keys
   - Enable/disable API keys
   - View import logs and history

4. **[frontend/src/pages/ThirdPartyIntegration.css](../frontend/src/pages/ThirdPartyIntegration.css)**
   - Styling for the integration panel

5. **[THIRD_PARTY_INTEGRATION.md](../THIRD_PARTY_INTEGRATION.md)**
   - Complete integration documentation
   - API reference
   - Code examples in cURL, Python, Node.js
   - Troubleshooting guide

### Modified Files:
1. **[backend/server.js](../backend/server.js)**
   - Added route: `app.use('/api/attendance-import', require('./routes/attendanceImport'));`

2. **[frontend/src/services/api.js](../frontend/src/services/api.js)**
   - Added methods for API key management
   - Added methods for import logs

---

## Key Features

### 1. **Push-Based Model (Webhook)**
- Third-party systems push data to your API
- Real-time data sync
- No polling needed
- Third-party system controls when to send

### 2. **Security**
- API Key authentication (SHA256 hashed)
- Only superadmin can generate keys
- Keys can be activated/deactivated
- All API calls are logged

### 3. **Automatic Features**
- **Late Detection**: Automatically marks as "late" if check_in > 10:45 AM
- **Working Hours**: Automatically calculated from check_in to check_out
- **Duplicate Prevention**: Updates existing record for same date+employee
- **Error Logging**: All failed imports are logged with error messages

### 4. **Data Tracking**
- Source field: Marks records as 'third_party' vs 'manual'
- Device ID: Tracks which device/machine sent the data
- Import logs: Complete history of all imports
- Last used timestamp: Monitors API key activity

---

## How It Works - Step by Step

### Step 1: Admin Generates API Key
```
1. Login as superadmin
2. Go to "Third-Party Integration" page
3. Click "Generate New Key"
4. Enter system name: "BioMetric System Main Office"
5. Copy the API key securely
6. Share with third-party system provider
```

### Step 2: Third-Party System Sends Data
```
When employee enters:
POST http://your-server.com/api/attendance-import/webhook/attendance
Headers: x-api-key: abc123...
Body: {
  "employee_id": "EMP001",
  "attendance_date": "2025-01-31",
  "check_in": "09:30:00",
  "device_id": "BIOMETRIC_01"
}

When employee exits:
POST http://your-server.com/api/attendance-import/webhook/attendance
Headers: x-api-key: abc123...
Body: {
  "employee_id": "EMP001",
  "attendance_date": "2025-01-31",
  "check_in": "09:30:00",
  "check_out": "18:30:00",
  "device_id": "BIOMETRIC_01"
}
```

### Step 3: System Processes Data
```
1. Validates API key (SHA256 hash)
2. Finds employee by employee_id
3. Auto-detects late status if check_in > 10:45
4. Calculates working hours
5. Updates or creates attendance record
6. Logs the import (success/failure)
7. Returns response to third-party system
```

### Step 4: View in Dashboard
```
1. Employee attendance is visible in attendance page
2. Source shows "third_party" (different from manual entries)
3. Can filter, search, and download reports
4. Admin can view import logs and statistics
```

---

## API Endpoints

### For Admin (requires authentication token):

#### 1. Generate API Key
```
POST /api/attendance-import/generate-api-key
Authorization: Bearer TOKEN
Content-Type: application/json

{
  "system_name": "BioMetric System",
  "description": "Main office"
}
```

#### 2. List API Keys
```
GET /api/attendance-import/api-keys
Authorization: Bearer TOKEN
```

#### 3. Toggle API Key Status
```
PATCH /api/attendance-import/api-keys/{id}/toggle
Authorization: Bearer TOKEN

{ "is_active": false }
```

#### 4. View Import Logs
```
GET /api/attendance-import/import-logs
Authorization: Bearer TOKEN

Query params:
?start_date=2025-01-01
&end_date=2025-01-31
&import_status=success
&api_key_id=1
```

### For Third-Party Systems (requires API key in header):

#### 1. Single Record Import
```
POST /api/attendance-import/webhook/attendance
x-api-key: YOUR_API_KEY
Content-Type: application/json

{
  "employee_id": "EMP001",
  "attendance_date": "2025-01-31",
  "check_in": "09:30:00",
  "check_out": "18:30:00",
  "status": "present",
  "remarks": "Entry from Gate A",
  "device_id": "BIOMETRIC_01"
}
```

#### 2. Bulk Import
```
POST /api/attendance-import/webhook/attendance-bulk
x-api-key: YOUR_API_KEY
Content-Type: application/json

{
  "records": [
    { ... },
    { ... }
  ]
}
```

---

## Database Schema

### Table: `third_party_api_keys`
```sql
id (INT)
system_name (VARCHAR 255) - Unique
api_key_hash (VARCHAR 255) - SHA256 hashed
description (TEXT)
is_active (BOOLEAN)
created_at (TIMESTAMP)
last_used_at (TIMESTAMP)
```

### Table: `attendance_import_logs`
```sql
id (INT)
api_key_id (INT) - FK to third_party_api_keys
employee_id (VARCHAR 50)
attendance_date (DATE)
check_in (TIME)
check_out (TIME)
status (VARCHAR 50)
device_id (VARCHAR 100)
import_status (ENUM: 'success', 'failed')
error_message (TEXT)
created_at (TIMESTAMP)
```

### Modified: `attendance` table
```sql
Added columns:
- source (VARCHAR 50) - 'manual' or 'third_party'
- device_id (VARCHAR 100) - Device identifier
```

---

## Setup Steps

### 1. Run SQL Schema
Execute [backend/database/attendance_import_schema.sql](../backend/database/attendance_import_schema.sql) to create tables

### 2. Restart Backend Server
The new routes are already registered in server.js

### 3. Access Admin Panel
Navigate to the Third-Party Integration page (add to your navigation menu)

### 4. Generate API Key
Create the first API key for your third-party system

### 5. Configure Third-Party System
Share the API key and documentation with the system provider

---

## Testing the Integration

### Quick Test with cURL
```bash
curl -X POST http://localhost:3000/api/attendance-import/webhook/attendance \
  -H "x-api-key: your-api-key-here" \
  -H "Content-Type: application/json" \
  -d '{
    "employee_id": "EMP001",
    "attendance_date": "2025-01-31",
    "check_in": "09:30:00",
    "check_out": "18:30:00"
  }'
```

### Expected Response
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

## Error Handling

| Scenario | Status | Response |
|----------|--------|----------|
| Missing API key | 401 | `{"message": "Missing API key"}` |
| Invalid API key | 401 | `{"message": "Invalid or inactive API key"}` |
| Employee not found | 404 | `{"message": "Employee EMP999 not found"}` |
| Missing required fields | 400 | `{"message": "employee_id and attendance_date are required"}` |
| Server error | 500 | `{"message": "Failed to process..."}` |

All errors are logged to `attendance_import_logs` table for debugging.

---

## Advanced Features

### 1. **Auto-Detection of Late Status**
- If `check_in > 10:45 AM` → Status = "late"
- If `check_in ≤ 10:45 AM` → Status = "present"

### 2. **Working Hours Calculation**
- Automatically calculated: `check_out - check_in`
- Stored in HH:MM:SS format

### 3. **Upsert Pattern**
- If record exists for same date+employee → Update
- If record doesn't exist → Create new

### 4. **Audit Trail**
- All imports logged to `attendance_import_logs`
- Track success/failure rates
- Monitor API key activity

### 5. **Bulk Import with Partial Success**
- Process multiple records at once
- Continue processing if one fails
- Return success/failure count

---

## Security Considerations

1. **API Key Storage**
   - Never store plain text API keys
   - Always hash with SHA256
   - Only show once when generated

2. **HTTPS**
   - Always use HTTPS in production
   - Validate SSL certificates

3. **Rate Limiting** (Optional - add if needed)
   - Prevent API abuse
   - Implement per-key rate limits

4. **Input Validation**
   - Validate all input data
   - Sanitize employee_id
   - Check date-time formats

5. **Access Control**
   - Only superadmin can manage API keys
   - Regular users can only view their attendance
   - HOD users see their department only

---

## Next Steps (Optional Enhancements)

1. **Real-time Dashboard**
   - Show live attendance updates
   - Display active check-ins

2. **Notifications**
   - Alert on late arrivals
   - Alert on failed imports

3. **Biometric Integration**
   - Connect directly to biometric machines
   - Support multiple devices

4. **Backup Mechanisms**
   - Retry failed imports
   - Queue system for reliability

5. **Analytics**
   - Attendance trends
   - Device performance metrics
   - Import statistics

---

## Troubleshooting

### API Key not working?
- Check if key is active
- Verify exact API key string
- Check if system_name matches

### Employee not found?
- Verify employee_id matches exactly (case-sensitive)
- Check if employee is registered in the system

### Check_in not recorded?
- Verify date format: YYYY-MM-DD
- Verify time format: HH:MM:SS (24-hour)
- Check if employee_id exists

### Import logs not updating?
- Verify API key in header is correct
- Check network connectivity to server
- Check server logs for errors

---

## Support Resources

- Complete Documentation: [THIRD_PARTY_INTEGRATION.md](../THIRD_PARTY_INTEGRATION.md)
- Code Examples: cURL, Python, Node.js, JavaScript
- Admin Panel: ThirdPartyIntegration page
- API Reference: Endpoints listed above

---

**Implementation Date:** January 31, 2025
**Version:** 1.0
**Status:** Ready for Production
