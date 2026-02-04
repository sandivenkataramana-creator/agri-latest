# API Integration Guide - AGRI Management System

## Overview

This guide provides step-by-step instructions for integrating third-party attendance systems (biometric machines, time tracking software, etc.) with the AGRI Management System. The integration allows automatic attendance data synchronization.

---

## Table of Contents

1. [Prerequisites](#prerequisites)
2. [Getting Started](#getting-started)
3. [Generating API Keys](#generating-api-keys)
4. [API Endpoints](#api-endpoints)
5. [Authentication](#authentication)
6. [Request & Response Examples](#request--response-examples)
7. [Error Handling](#error-handling)
8. [Testing with Postman](#testing-with-postman)
9. [Troubleshooting](#troubleshooting)
10. [Bulk Upload (Server Downtime Recovery)](#bulk-upload-server-downtime-recovery)

---

## Prerequisites

- Active account with AGRI Management System (superadmin role for API key generation)
- Employee records already created in the system
- Valid employee IDs for all staff members
- Network connectivity to the AGRI system API server
- Postman or similar API testing tool (for testing)

---

## Getting Started

### Step 1: Generate an API Key

1. Login to AGRI Management System as **Superadmin**
2. Navigate to **Third Party Integration** page
3. Click **"Generate New Key"** button
4. Fill in the form:
   - **System Name**: Unique identifier for your integration (e.g., `BIOMETRIC-MAIN-GATE`, `ZKTECO-OFFICE-A`)
     - Must contain only uppercase letters, hyphens, or underscores
     - No spaces allowed
     - Each system must have a unique name
   - **Description/Location**: Include:
     - Physical location (e.g., "Main office entry/exit")
     - Vendor name (e.g., "ZKTeco Machine Model X")
     - HOD managing this system (e.g., "Agriculture Department")
     - Contact person (optional)
5. Click **"Generate Key"**
6. **IMPORTANT**: Copy and save the API key immediately - it will NOT be shown again
7. Store the key securely (never commit to version control, use environment variables)

### Step 2: View Generated Keys

1. Go to **Third Party Integration** page
2. You'll see all generated API keys listed in a table
3. Click the **Eye Icon** next to any key to view its details:
   - System name
   - Status (Active/Inactive)
   - Creation date
   - Last used timestamp
   - Description
4. To generate a new key for the same system:
   - Click the **Eye Icon** → Click **"Regenerate Key"**
   - Old key will be deleted
   - New key will be displayed once
   - Description remains the same

### Step 3: Activate/Deactivate Keys

1. Click the **Toggle Icon** next to any API key
2. Active keys have a green toggle, inactive keys have a gray toggle
3. Third-party systems cannot use inactive keys

---

## API Endpoints

### Base URL

```
https://[your-domain]/api/attendance-import
```

### Endpoints

#### 1. **Single Attendance Record Import**

**Endpoint**: `POST /webhook/attendance`

**Authentication**: API Key in header

**Request Header**:
```
X-Api-Key: YOUR_API_KEY_HERE
Content-Type: application/json
```

**Request Body**:
```json
{
  "employee_id": "EMP001",
  "attendance_date": "2024-02-15",
  "check_in": "09:30:00",
  "check_out": "17:45:00",
  "status": "present",
  "remarks": "Regular working day",
  "device_id": "DEVICE_001"
}
```

**Response Success** (201):
```json
{
  "message": "Attendance record processed successfully",
  "attendance_id": 1234,
  "employee_id": "EMP001",
  "attendance_date": "2024-02-15",
  "status": "present"
}
```

**Response Error** (400/401/500):
```json
{
  "message": "Error description",
  "error": "Detailed error message"
}
```

---

#### 2. **Bulk Attendance Import**

**Endpoint**: `POST /webhook/attendance-bulk`

**Authentication**: API Key in header

**Request Header**:
```
X-Api-Key: YOUR_API_KEY_HERE
Content-Type: application/json
```

**Request Body**:
```json
{
  "records": [
    {
      "employee_id": "EMP001",
      "attendance_date": "2024-02-15",
      "check_in": "09:30:00",
      "check_out": "17:45:00",
      "status": "present",
      "remarks": "Regular working day",
      "device_id": "DEVICE_001"
    },
    {
      "employee_id": "EMP002",
      "attendance_date": "2024-02-15",
      "check_in": "10:15:00",
      "check_out": "18:30:00",
      "status": "late",
      "remarks": "Late arrival",
      "device_id": "DEVICE_001"
    }
  ]
}
```

**Response**:
```json
{
  "message": "Processed 2 records",
  "results": {
    "successful": 2,
    "failed": 0,
    "errors": []
  },
  "timestamp": "2024-02-15T14:30:00.000Z"
}
```

---

#### 3. **Server Downtime Attendance Upload**

**Endpoint**: `POST /attendance-import/bulk-upload-attendance`

**Authentication**: JWT Token (Superadmin role required)

**Purpose**: Upload attendance records when server was down (recovery from PDF/Excel files)

**Request Header**:
```
Authorization: Bearer YOUR_JWT_TOKEN
Content-Type: application/json
```

**Request Body**:
```json
{
  "records": [
    {
      "employee_id": "EMP001",
      "attendance_date": "2024-02-15",
      "check_in": "09:30:00",
      "check_out": "17:45:00",
      "status": "present",
      "remarks": "Recovered from offline data"
    },
    {
      "employee_id": "EMP002",
      "attendance_date": "2024-02-15",
      "check_in": "10:15:00",
      "check_out": "18:30:00",
      "status": "late"
    }
  ]
}
```

**Response**:
```json
{
  "message": "Processed 2 records",
  "results": {
    "successful": 2,
    "failed": 0,
    "errors": []
  },
  "timestamp": "2024-02-15T14:30:00.000Z"
}
```

---

#### 4. **Get API Key Details**

**Endpoint**: `GET /api-keys/:id/view`

**Authentication**: Superadmin JWT Token

**Response**:
```json
{
  "data": {
    "id": 1,
    "system_name": "BIOMETRIC-MAIN",
    "description": "Main office entry/exit - ZKTeco",
    "is_active": true,
    "created_at": "2024-02-01T10:30:00.000Z",
    "last_used_at": "2024-02-15T09:45:00.000Z"
  }
}
```

---

#### 5. **Get All API Keys**

**Endpoint**: `GET /api-keys`

**Authentication**: Superadmin JWT Token

**Response**:
```json
{
  "data": [
    {
      "id": 1,
      "system_name": "BIOMETRIC-MAIN",
      "description": "Main office entry/exit",
      "is_active": true,
      "created_at": "2024-02-01T10:30:00.000Z",
      "last_used_at": "2024-02-15T09:45:00.000Z"
    }
  ]
}
```

---

#### 6. **Get Import Logs**

**Endpoint**: `GET /import-logs`

**Authentication**: Superadmin JWT Token

**Query Parameters**:
- `start_date`: Filter from date (YYYY-MM-DD)
- `end_date`: Filter to date (YYYY-MM-DD)
- `import_status`: 'success' or 'failed'
- `api_key_id`: Specific API key ID

**Response**:
```json
{
  "data": [
    {
      "id": 1,
      "api_key_id": 1,
      "employee_id": "EMP001",
      "attendance_date": "2024-02-15",
      "check_in": "09:30:00",
      "check_out": "17:45:00",
      "status": "present",
      "device_id": "DEVICE_001",
      "import_status": "success",
      "error_message": null,
      "created_at": "2024-02-15T09:35:00.000Z"
    }
  ]
}
```

---

## Authentication

### API Key Authentication (Third-Party Systems)

All third-party webhook endpoints require the API key in the request header:

```bash
X-Api-Key: [YOUR_64_CHARACTER_API_KEY]
```

**Example with cURL**:
```bash
curl -X POST https://your-domain.com/api/attendance-import/webhook/attendance \
  -H "X-Api-Key: your_api_key_here" \
  -H "Content-Type: application/json" \
  -d '{
    "employee_id": "EMP001",
    "attendance_date": "2024-02-15",
    "check_in": "09:30:00",
    "check_out": "17:45:00"
  }'
```

### JWT Token Authentication (Superadmin)

For administrative endpoints, use Bearer token:

```bash
Authorization: Bearer [YOUR_JWT_TOKEN]
```

---

## Request & Response Examples

### Example 1: Basic Attendance Record

**Request**:
```bash
curl -X POST https://api.agri-system.com/api/attendance-import/webhook/attendance \
  -H "X-Api-Key: abc123def456ghi789jkl012mno345pqr678stu901vwx234yza567bcd890ef123" \
  -H "Content-Type: application/json" \
  -d '{
    "employee_id": "EMP001",
    "attendance_date": "2024-02-15",
    "check_in": "09:00:00",
    "check_out": "17:30:00"
  }'
```

**Response**:
```json
{
  "message": "Attendance record processed successfully",
  "attendance_id": 5678,
  "employee_id": "EMP001",
  "attendance_date": "2024-02-15",
  "status": "present"
}
```

---

### Example 2: Bulk Import (5 Records)

**Request**:
```bash
curl -X POST https://api.agri-system.com/api/attendance-import/webhook/attendance-bulk \
  -H "X-Api-Key: abc123def456ghi789jkl012mno345pqr678stu901vwx234yza567bcd890ef123" \
  -H "Content-Type: application/json" \
  -d '{
    "records": [
      {"employee_id": "EMP001", "attendance_date": "2024-02-15", "check_in": "09:00:00", "check_out": "17:30:00"},
      {"employee_id": "EMP002", "attendance_date": "2024-02-15", "check_in": "09:15:00", "check_out": "17:45:00"},
      {"employee_id": "EMP003", "attendance_date": "2024-02-15", "check_in": "10:30:00", "check_out": "18:00:00", "status": "late"},
      {"employee_id": "EMP004", "attendance_date": "2024-02-15", "status": "absent"},
      {"employee_id": "EMP005", "attendance_date": "2024-02-15", "check_in": "09:05:00", "check_out": "17:20:00"}
    ]
  }'
```

**Response**:
```json
{
  "message": "Processed 5 records",
  "results": {
    "successful": 5,
    "failed": 0,
    "errors": []
  },
  "timestamp": "2024-02-15T14:30:00.000Z"
}
```

---

### Example 3: Error Response (Invalid Employee)

**Request**:
```bash
curl -X POST https://api.agri-system.com/api/attendance-import/webhook/attendance \
  -H "X-Api-Key: abc123def456ghi789jkl012mno345pqr678stu901vwx234yza567bcd890ef123" \
  -H "Content-Type: application/json" \
  -d '{
    "employee_id": "INVALID_EMP_ID",
    "attendance_date": "2024-02-15",
    "check_in": "09:00:00",
    "check_out": "17:30:00"
  }'
```

**Response** (404):
```json
{
  "message": "Employee INVALID_EMP_ID not found"
}
```

---

## Error Handling

### Common HTTP Status Codes

| Status | Meaning | Example |
|--------|---------|---------|
| 200 | Success | Record processed |
| 400 | Bad Request | Missing required fields |
| 401 | Unauthorized | Invalid/missing API key |
| 403 | Forbidden | Non-superadmin trying admin endpoint |
| 404 | Not Found | Employee ID not found |
| 409 | Conflict | Duplicate system name |
| 500 | Server Error | Database error |

### Error Response Format

```json
{
  "message": "User-friendly error message",
  "error": "Detailed technical error (optional)"
}
```

### Common Errors & Solutions

| Error | Cause | Solution |
|-------|-------|----------|
| Missing API key | No X-Api-Key header | Add header: `X-Api-Key: your_key` |
| Invalid API key | Wrong/deactivated key | Check key in admin panel, regenerate if needed |
| Employee not found | Employee ID doesn't exist in system | Verify employee ID matches system records |
| Missing required fields | Incomplete request data | Include employee_id and attendance_date |
| System name already exists | Duplicate system name | Use unique system name for new integration |

---

## Testing with Postman

### Step 1: Import Postman Collection

1. Open Postman
2. Click **Import**
3. Select **POSTMAN_COLLECTION.json** (provided with this guide)
4. All endpoints and sample requests will be imported

### Step 2: Set Environment Variables

1. Create a new Postman environment called "AGRI-API"
2. Add variables:
   - `base_url`: `https://your-agri-domain.com/api/attendance-import`
   - `api_key`: `your_api_key_here`
   - `jwt_token`: `your_jwt_token_here`

### Step 3: Run Requests

1. Select the environment
2. Click on any request in the collection
3. Click **Send**
4. Check the response

### Sample Test Sequence

1. **Generate API Key** (requires superadmin JWT)
   - See response for new API key
   - Copy and use in environment

2. **Send Single Attendance**
   - Use the API key from step 1
   - Should get success response

3. **Check Import Logs**
   - View all imported records
   - Verify data accuracy

---

## Bulk Upload (Server Downtime Recovery)

### When to Use

- Server was down for extended period
- You have attendance data in PDF/Excel from that period
- Need to manually upload historical records

### Step-by-Step Process

#### Option A: Using Postman

1. Prepare your data in JSON format (see example below)
2. Create new POST request to: `/bulk-upload-attendance`
3. Add header: `Authorization: Bearer [superadmin_jwt_token]`
4. Paste JSON data in request body
5. Click Send

#### Option B: Using cURL

```bash
curl -X POST https://api.agri-system.com/api/attendance-import/bulk-upload-attendance \
  -H "Authorization: Bearer your_jwt_token" \
  -H "Content-Type: application/json" \
  -d '{
    "records": [
      {
        "employee_id": "EMP001",
        "attendance_date": "2024-02-14",
        "check_in": "09:00:00",
        "check_out": "17:30:00",
        "remarks": "Recovered from offline PDF"
      }
    ]
  }'
```

### Data Format for Bulk Upload

```json
{
  "records": [
    {
      "employee_id": "EMP001",
      "attendance_date": "2024-02-14",
      "check_in": "09:00:00",
      "check_out": "17:30:00",
      "status": "present",
      "remarks": "Recovered from server downtime"
    },
    {
      "employee_id": "EMP002",
      "attendance_date": "2024-02-14",
      "status": "absent",
      "remarks": "Not present on this date"
    }
  ]
}
```

### Data Conversion Tips

**From Excel to JSON**:
1. Export Excel as CSV
2. Use online CSV-to-JSON converter
3. Or use Python:
```python
import pandas as pd
import json

df = pd.read_csv('attendance.csv')
records = df.to_dict('records')
print(json.dumps({'records': records}, indent=2))
```

**From PDF to JSON**:
1. Use PDF extraction tool (e.g., Tabula)
2. Export as CSV
3. Convert CSV to JSON (see above)

---

## API Key Placement in Different Systems

### ZKTeco Biometric Machine

1. Access machine web interface
2. Go to **Settings** → **Network** → **API Configuration**
3. Set webhook URL: `https://your-domain.com/api/attendance-import/webhook/attendance`
4. Set API Key header: Place API key in custom header field
5. Set request format: JSON

### Generic API Integration

**In your application code** (Python example):
```python
import requests

API_KEY = "your_api_key_here"
BASE_URL = "https://your-domain.com/api/attendance-import"

headers = {
    "X-Api-Key": API_KEY,
    "Content-Type": "application/json"
}

attendance_data = {
    "employee_id": "EMP001",
    "attendance_date": "2024-02-15",
    "check_in": "09:00:00",
    "check_out": "17:30:00"
}

response = requests.post(
    f"{BASE_URL}/webhook/attendance",
    json=attendance_data,
    headers=headers
)

print(response.json())
```

---

## Troubleshooting

### Issue: API Key Not Working

**Symptoms**: Getting 401 Unauthorized error

**Solutions**:
1. Verify API key is correct (no extra spaces)
2. Check header name is exactly `X-Api-Key`
3. Verify key is in Active status (check admin panel)
4. Try regenerating the key
5. Check if API key was deleted when HOD was removed

### Issue: Employee Not Found Error

**Symptoms**: Getting 404 error for valid employee ID

**Solutions**:
1. Verify employee ID format matches system
2. Confirm employee exists in Staff table
3. Check employee ID spelling/case sensitivity
4. Verify employee is assigned to a HOD

### Issue: Bulk Import Shows Some Failures

**Symptoms**: Results show successful: 8, failed: 2

**Solutions**:
1. Check error_message in response
2. Verify all employee IDs exist
3. Check date formats (must be YYYY-MM-DD)
4. Verify time formats (must be HH:MM:SS)

### Issue: Import Logs Not Showing

**Symptoms**: Import logs are empty even though data was sent

**Solutions**:
1. Check that API key is active
2. Verify date range in logs filter
3. Check import_status filter (success vs failed)
4. Wait a few seconds and refresh

### Issue: Attendance Not Updating

**Symptoms**: Records sent but not appearing in Dashboard

**Solutions**:
1. Verify source column shows 'third_party' or 'manual_upload'
2. Check attendance date is correct
3. Verify employee is assigned to correct HOD
4. Check for duplicate records
5. Verify import logs show 'success' status

### Support

For additional help:
- Contact System Administrator
- Check system audit logs for error details
- Review API request/response in Postman console
- Check browser console for any client-side errors

---

## Security Best Practices

1. **Never commit API keys** to version control
2. **Use environment variables** to store API keys
3. **Rotate keys periodically** for security
4. **Deactivate unused keys** to prevent unauthorized access
5. **Monitor import logs** for unusual activity
6. **Use HTTPS only** for all API calls
7. **Regenerate keys** if compromised
8. **Log all integrations** for audit trail

---

## Additional Resources

- API Endpoints Reference: See [API Endpoints](#api-endpoints) section
- Postman Collection: `POSTMAN_COLLECTION.json`
- Sample JSON Data: See [Request & Response Examples](#request--response-examples)
- Error Reference: See [Error Handling](#error-handling) section

---

**Last Updated**: February 2024  
**Version**: 1.0  
**Status**: Production Ready
