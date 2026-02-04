# Bulk Attendance Upload Guide - Server Downtime Recovery

## Overview

This guide explains how to upload previous attendance records when the server was down or when you need to manually import historical data from PDF/Excel files (e.g., from biometric machines offline data or recovery scenarios).

---

## When to Use This Guide

✓ Server was down and you have offline attendance data  
✓ Biometric machine stored data while offline  
✓ Need to recover historical attendance records  
✓ Uploading attendance from PDF reports  
✓ Uploading attendance from Excel spreadsheets  
✓ Recovering data after database issues  

---

## Prerequisites

- **Role**: Superadmin access required
- **Data Format**: Attendance records (employee ID, date, check-in, check-out)
- **Tools**: 
  - Postman or cURL (for API upload)
  - Python or Excel (for data conversion)
- **Source Data**: PDF, Excel, CSV, or JSON

---

## Step-by-Step Process

### Step 1: Prepare Your Attendance Data

#### If Data is in Excel/PDF

**Example Excel Format**:

| Employee ID | Date | Check In | Check Out | Status | Remarks |
|------------|------|----------|-----------|--------|---------|
| EMP001 | 02-14-2024 | 09:00 | 17:30 | Present | |
| EMP002 | 02-14-2024 | 09:15 | 17:45 | Present | |
| EMP003 | 02-14-2024 | | | Absent | Sick leave |
| EMP004 | 02-14-2024 | 10:45 | 18:30 | Late | Traffic delay |

**Export from Excel as CSV**:
1. Open Excel file
2. File → Save As
3. Format: CSV (Comma Separated Values)
4. Save to computer

---

### Step 2: Convert Data to JSON Format

#### Option A: Using Python (Recommended)

**Script: `convert_to_json.py`**

```python
import pandas as pd
import json
from datetime import datetime

# Read Excel or CSV file
df = pd.read_csv('attendance.csv')  # or pd.read_excel('attendance.xlsx')

# Convert to proper format
records = []
for idx, row in df.iterrows():
    # Parse date (handle multiple formats)
    date_str = str(row['Date'])
    try:
        date_obj = pd.to_datetime(date_str)
        attendance_date = date_obj.strftime('%Y-%m-%d')
    except:
        print(f"Error parsing date in row {idx+1}: {date_str}")
        continue

    # Parse times (if empty, set to None)
    check_in = str(row.get('Check In', '')).strip() if pd.notna(row.get('Check In')) else None
    check_out = str(row.get('Check Out', '')).strip() if pd.notna(row.get('Check Out')) else None

    record = {
        'employee_id': str(row['Employee ID']).strip(),
        'attendance_date': attendance_date,
        'status': str(row.get('Status', 'present')).lower() if pd.notna(row.get('Status')) else 'present'
    }

    # Only add times if they exist and are not empty
    if check_in and check_in != 'nan':
        record['check_in'] = check_in

    if check_out and check_out != 'nan':
        record['check_out'] = check_out

    # Add remarks if available
    if pd.notna(row.get('Remarks')):
        record['remarks'] = f"Recovered from offline: {row['Remarks']}"
    else:
        record['remarks'] = "Recovered from offline attendance data"

    records.append(record)

# Create final JSON
output = {
    'records': records
}

# Save to file
with open('attendance_upload.json', 'w') as f:
    json.dump(output, f, indent=2)

print(f"✓ Successfully converted {len(records)} records")
print(f"✓ Saved to: attendance_upload.json")
```

**Run the script**:
```bash
python convert_to_json.py
```

**Output**: `attendance_upload.json` ready for upload

---

#### Option B: Using Online CSV to JSON Converter

1. Go to: https://csvjson.com/csv2json
2. Paste your CSV data
3. Click "Convert"
4. Copy the JSON output
5. Format it as:
```json
{
  "records": [
    // paste converted data here
  ]
}
```

---

#### Option C: Manual JSON Creation

If you have only a few records:

```json
{
  "records": [
    {
      "employee_id": "EMP001",
      "attendance_date": "2024-02-14",
      "check_in": "09:00:00",
      "check_out": "17:30:00",
      "status": "present",
      "remarks": "Recovered from offline data - Feb 14"
    },
    {
      "employee_id": "EMP002",
      "attendance_date": "2024-02-14",
      "check_in": "09:15:00",
      "check_out": "17:45:00",
      "status": "present",
      "remarks": "Recovered from offline data - Feb 14"
    }
  ]
}
```

---

### Step 3: Validate Your JSON

Before uploading, validate your JSON:

**Online Validator**: https://jsonlint.com/

Copy your JSON → Paste in validator → Should show "✓ Valid JSON"

**Common Format Issues**:
```
❌ Wrong: date: "14-02-2024"  →  ✓ Right: "2024-02-14"
❌ Wrong: time: "9:00 AM"     →  ✓ Right: "09:00:00"
❌ Wrong: "Absent"            →  ✓ Right: "absent"
```

---

### Step 4: Upload via Postman

#### Method 1: Using Postman (Easiest)

1. **Open Postman**
2. **Create New Request**:
   - Method: `POST`
   - URL: `https://your-domain.com/api/attendance-import/bulk-upload-attendance`

3. **Add Authentication Header**:
   - Header Name: `Authorization`
   - Value: `Bearer [your_superadmin_jwt_token]`

4. **Set Request Body**:
   - Click "Body" tab
   - Select "Raw"
   - Select "JSON" from dropdown
   - Paste your JSON data

5. **Send Request**

6. **Check Response**:
   ```json
   {
     "message": "Processed 100 records",
     "results": {
       "successful": 98,
       "failed": 2,
       "errors": [
         {"employee_id": "EMP999", "error": "Employee not found"},
         {"employee_id": "EMP888", "error": "Invalid date format"}
       ]
     },
     "timestamp": "2024-02-15T14:30:00.000Z"
   }
   ```

---

#### Method 2: Using cURL (Command Line)

```bash
curl -X POST https://your-domain.com/api/attendance-import/bulk-upload-attendance \
  -H "Authorization: Bearer YOUR_SUPERADMIN_JWT_TOKEN" \
  -H "Content-Type: application/json" \
  -d @attendance_upload.json
```

---

#### Method 3: Using Python

```python
import requests
import json

# Load your attendance data
with open('attendance_upload.json', 'r') as f:
    data = json.load(f)

# Set up request
url = 'https://your-domain.com/api/attendance-import/bulk-upload-attendance'
headers = {
    'Authorization': 'Bearer YOUR_SUPERADMIN_JWT_TOKEN',
    'Content-Type': 'application/json'
}

# Send request
response = requests.post(url, json=data, headers=headers)

# Check response
if response.status_code == 200:
    result = response.json()
    print(f"✓ Success: {result['results']['successful']} records")
    if result['results']['errors']:
        print(f"✗ Failed: {result['results']['failed']} records")
        for error in result['results']['errors']:
            print(f"  - {error['employee_id']}: {error['error']}")
else:
    print(f"✗ Error: {response.status_code}")
    print(response.json())
```

---

### Step 5: Verify Upload

After uploading:

1. **Check Import Results**:
   - Look for error count in response
   - Review which records failed

2. **View in Admin Panel**:
   - Go to **Third Party Integration** page
   - Check **Import Logs** section
   - Filter for **"manual_upload"** source

3. **Verify in Dashboard**:
   - Go to **Attendance** page
   - Filter by date of upload
   - Check that records appear for correct HODs and employees

4. **Fix Failed Records**:
   - If any failed, correct the data
   - Reupload the corrected records

---

## JSON Format Reference

### Full Record Format

```json
{
  "records": [
    {
      "employee_id": "EMP001",
      "attendance_date": "2024-02-14",
      "check_in": "09:00:00",           // Optional - format HH:MM:SS
      "check_out": "17:30:00",          // Optional - format HH:MM:SS
      "status": "present",              // Optional - values: present, late, absent, half-day
      "remarks": "Note about this record",  // Optional - max 500 chars
      "hod_id": 1                       // Optional - if not provided, uses employee's assigned HOD
    }
  ]
}
```

### Minimal Record (Only Required Fields)

```json
{
  "records": [
    {
      "employee_id": "EMP001",
      "attendance_date": "2024-02-14"
    }
  ]
}
```

### Status Values

| Status | Meaning |
|--------|---------|
| `present` | Employee present during work hours |
| `late` | Employee arrived after 10:45 AM |
| `absent` | Employee not present |
| `half-day` | Employee present for partial day |

---

## Data Conversion Examples

### Example 1: From Biometric Machine Export

**Machine Export (CSV)**:
```csv
Employee_ID,DATE,IN_TIME,OUT_TIME
EMP001,2024-02-14,09:00:00,17:30:00
EMP002,2024-02-14,09:15:00,17:45:00
EMP003,2024-02-14,,
```

**Convert to JSON**:
```json
{
  "records": [
    {
      "employee_id": "EMP001",
      "attendance_date": "2024-02-14",
      "check_in": "09:00:00",
      "check_out": "17:30:00",
      "status": "present",
      "remarks": "Imported from biometric machine"
    },
    {
      "employee_id": "EMP002",
      "attendance_date": "2024-02-14",
      "check_in": "09:15:00",
      "check_out": "17:45:00",
      "status": "present",
      "remarks": "Imported from biometric machine"
    },
    {
      "employee_id": "EMP003",
      "attendance_date": "2024-02-14",
      "status": "absent",
      "remarks": "Imported from biometric machine"
    }
  ]
}
```

---

### Example 2: From PDF Report (Manual Entry)

**PDF Contains**:
```
Date: February 14, 2024
Employee | Status | Check In | Check Out | Remarks
EMP001   | Present| 09:00   | 17:30    | -
EMP002   | Late   | 10:45   | 18:00    | Delayed
EMP003   | Absent | -       | -        | Sick
```

**Converted to JSON**:
```json
{
  "records": [
    {
      "employee_id": "EMP001",
      "attendance_date": "2024-02-14",
      "check_in": "09:00:00",
      "check_out": "17:30:00",
      "status": "present",
      "remarks": "Recovered from PDF - Feb 14 report"
    },
    {
      "employee_id": "EMP002",
      "attendance_date": "2024-02-14",
      "check_in": "10:45:00",
      "check_out": "18:00:00",
      "status": "late",
      "remarks": "Delayed - recovered from PDF"
    },
    {
      "employee_id": "EMP003",
      "attendance_date": "2024-02-14",
      "status": "absent",
      "remarks": "Sick - recovered from PDF"
    }
  ]
}
```

---

### Example 3: From Excel Multi-Day Export

**Excel Data**:
```
Employee ID | Date        | Time In | Time Out | Department
EMP001      | 02/13/2024  | 09:00   | 17:30    | Agriculture
EMP001      | 02/14/2024  | 09:15   | 17:45    | Agriculture
EMP002      | 02/13/2024  | 10:30   | 18:00    | Revenue
EMP002      | 02/14/2024  | 09:00   | 17:30    | Revenue
```

**Converted to JSON**:
```json
{
  "records": [
    {
      "employee_id": "EMP001",
      "attendance_date": "2024-02-13",
      "check_in": "09:00:00",
      "check_out": "17:30:00",
      "status": "present",
      "remarks": "Batch import - Excel"
    },
    {
      "employee_id": "EMP001",
      "attendance_date": "2024-02-14",
      "check_in": "09:15:00",
      "check_out": "17:45:00",
      "status": "present",
      "remarks": "Batch import - Excel"
    },
    {
      "employee_id": "EMP002",
      "attendance_date": "2024-02-13",
      "check_in": "10:30:00",
      "check_out": "18:00:00",
      "status": "late",
      "remarks": "Batch import - Excel"
    },
    {
      "employee_id": "EMP002",
      "attendance_date": "2024-02-14",
      "check_in": "09:00:00",
      "check_out": "17:30:00",
      "status": "present",
      "remarks": "Batch import - Excel"
    }
  ]
}
```

---

## Error Handling

### Common Upload Errors

| Error | Cause | Solution |
|-------|-------|----------|
| `Employee not found` | Employee ID doesn't exist in system | Verify employee ID, add employee if missing |
| `Invalid date format` | Date not in YYYY-MM-DD format | Convert date to YYYY-MM-DD |
| `Missing required field` | employee_id or attendance_date missing | Add required fields |
| `Invalid time format` | Time not in HH:MM:SS format | Convert to HH:MM:SS (24-hour) |
| `Duplicate record` | Same employee, date already exists | Will update existing record |

### Handling Failures

**If some records fail**:

1. Review error message
2. Correct the data
3. Reupload only the failed records
4. System will update existing records if they already exist

Example response with errors:
```json
{
  "message": "Processed 100 records",
  "results": {
    "successful": 98,
    "failed": 2,
    "errors": [
      {
        "employee_id": "EMP999",
        "error": "Employee not found"
      },
      {
        "employee_id": "EMP888",
        "error": "Invalid date format: 14-02-2024 (expected YYYY-MM-DD)"
      }
    ]
  }
}
```

---

## Large File Uploads

### For 1000+ Records

**Recommended Approach**:

1. **Split into Batches**:
   - Upload 1000 records at a time
   - Wait for success confirmation
   - Then upload next batch

2. **Python Script for Batch Upload**:

```python
import json
import requests

def upload_in_batches(json_file, batch_size=1000):
    with open(json_file, 'r') as f:
        data = json.load(f)
    
    records = data['records']
    total = len(records)
    
    for i in range(0, total, batch_size):
        batch = records[i:i+batch_size]
        batch_num = (i // batch_size) + 1
        total_batches = (total + batch_size - 1) // batch_size
        
        print(f"\n[Batch {batch_num}/{total_batches}] Uploading {len(batch)} records...")
        
        # Upload this batch
        response = requests.post(
            'https://your-domain.com/api/attendance-import/bulk-upload-attendance',
            json={'records': batch},
            headers={
                'Authorization': 'Bearer YOUR_TOKEN',
                'Content-Type': 'application/json'
            }
        )
        
        if response.status_code == 200:
            result = response.json()['results']
            print(f"  ✓ Successful: {result['successful']}")
            if result['failed'] > 0:
                print(f"  ✗ Failed: {result['failed']}")
        else:
            print(f"  ✗ Error: {response.status_code}")

# Run
upload_in_batches('attendance_upload.json', batch_size=1000)
```

---

## Best Practices

1. **Always Backup**: Keep original files before conversion
2. **Validate First**: Test with small batch before uploading thousands
3. **Document**: Record dates and quantities uploaded
4. **Verify**: Check logs after upload to confirm success
5. **Remarks**: Use remarks field to indicate data source/recovery date
6. **Date Range**: Keep records within 30-60 days to avoid cluttering history
7. **Employee IDs**: Ensure consistency with system records

---

## Frequently Asked Questions

**Q: Can I upload duplicate dates for same employee?**
A: Yes. If a record already exists for that employee/date, it will be updated with new data.

**Q: Do I need to specify HOD?**
A: No. System automatically finds HOD from employee's staff record. Only use hod_id if you want to override.

**Q: What time format should I use?**
A: 24-hour format: HH:MM:SS (e.g., 09:00:00, 17:30:00, not 9:00 AM)

**Q: Can I upload records from past years?**
A: Yes, any date format (YYYY-MM-DD) works. System stores all historical records.

**Q: What if employee was transferred to different HOD?**
A: Upload with the original HOD. Then transfer employee in staff table for future records.

**Q: Is there a maximum number of records?**
A: No hard limit, but upload in batches of 1000 for best performance.

**Q: Can I schedule automatic uploads?**
A: Not via UI currently. Use Python script with cron job (Linux) or Task Scheduler (Windows).

---

## Support

For issues with:
- **Data conversion**: Use Python script or contact IT
- **Upload errors**: Review error messages and correct data
- **Verification**: Check Import Logs in admin panel
- **Technical help**: Contact System Administrator

---

**Document Version**: 1.0  
**Last Updated**: February 2024  
**Status**: Production Ready
