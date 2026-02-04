# Integration Architecture Diagrams

## System Architecture Overview

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                        THIRD-PARTY SYSTEM SIDE                              │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│  ┌──────────────────┐  ┌──────────────────┐  ┌──────────────────┐         │
│  │ Biometric        │  │ Time Attendance  │  │ Mobile App       │         │
│  │ Machines         │  │ System           │  │ (GPS Tracking)   │         │
│  │ (Fingerprint)    │  │ (ZKTeco, etc)    │  │                  │         │
│  └────────┬─────────┘  └────────┬─────────┘  └────────┬─────────┘         │
│           │                     │                     │                    │
│           └─────────────────────┼─────────────────────┘                    │
│                                 │                                          │
│                    Collect entry/exit data                                │
│                                 │                                          │
│                                 ▼                                          │
│                    ┌──────────────────────────┐                            │
│                    │ Format JSON with:        │                            │
│                    │ - employee_id            │                            │
│                    │ - attendance_date        │                            │
│                    │ - check_in/check_out     │                            │
│                    │ - device_id              │                            │
│                    └────────────┬─────────────┘                            │
│                                 │                                          │
└─────────────────────────────────┼──────────────────────────────────────────┘
                                  │
                    HTTP POST with x-api-key header
                                  │
                                  ▼
┌─────────────────────────────────────────────────────────────────────────────┐
│                         YOUR SERVER SIDE                                    │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│   POST /api/attendance-import/webhook/attendance                           │
│   Headers: x-api-key: [SECURE_API_KEY]                                    │
│                                                                             │
│   ┌───────────────────────────────────────────────────────────────┐       │
│   │ Authentication Layer                                          │       │
│   │ 1. Extract x-api-key header                                 │       │
│   │ 2. Hash with SHA256                                         │       │
│   │ 3. Compare with database                                    │       │
│   │ 4. Verify API key is active                                 │       │
│   └────────────────┬────────────────────────────────────────────┘       │
│                    │                                                      │
│                    ▼ (API key valid)                                      │
│                                                                             │
│   ┌───────────────────────────────────────────────────────────────┐       │
│   │ Validation Layer                                              │       │
│   │ 1. Check employee_id exists in staff table                   │       │
│   │ 2. Validate date format (YYYY-MM-DD)                         │       │
│   │ 3. Validate time format (HH:MM:SS)                           │       │
│   │ 4. Sanitize input data                                       │       │
│   └────────────────┬────────────────────────────────────────────┘       │
│                    │                                                      │
│                    ▼ (All valid)                                          │
│                                                                             │
│   ┌───────────────────────────────────────────────────────────────┐       │
│   │ Processing Layer                                              │       │
│   │ 1. Auto-detect late status (if check_in > 10:45)             │       │
│   │ 2. Calculate working hours (checkout - checkin)              │       │
│   │ 3. Check if record exists for same date + employee           │       │
│   │ 4. Update OR Insert into attendance table                    │       │
│   │ 5. Mark source as 'third_party'                              │       │
│   │ 6. Store device_id                                           │       │
│   └────────────────┬────────────────────────────────────────────┘       │
│                    │                                                      │
│                    ▼                                                       │
│                                                                             │
│   ┌──────────────────────────────┐  ┌──────────────────────────────┐     │
│   │ Database Write               │  │ Audit Logging                │     │
│   │                              │  │                              │     │
│   │ attendance table:            │  │ attendance_import_logs:      │     │
│   │ ├─ staff_id: 1              │  │ ├─ api_key_id: 1            │     │
│   │ ├─ check_in: 09:30:00       │  │ ├─ employee_id: EMP001      │     │
│   │ ├─ check_out: 18:30:00      │  │ ├─ status: success          │     │
│   │ ├─ status: present          │  │ ├─ check_in: 09:30:00       │     │
│   │ ├─ source: third_party      │  │ ├─ check_out: 18:30:00      │     │
│   │ ├─ device_id: BIOMETRIC_01  │  │ ├─ created_at: TIMESTAMP    │     │
│   │ └─ working_hours: 09:00:00  │  │ └─ error_message: null      │     │
│   │                              │  │                              │     │
│   └──────────────────────────────┘  └──────────────────────────────┘     │
│                                                                             │
│                    ▼                                                       │
│                                                                             │
│   ┌────────────────────────────────────────────────────────────────┐     │
│   │ Response Back to Third-Party System                           │     │
│   │                                                               │     │
│   │ {                                                             │     │
│   │   "message": "Attendance record processed successfully",     │     │
│   │   "attendance_id": 12345,                                   │     │
│   │   "employee_id": "EMP001",                                  │     │
│   │   "status": "present"                                       │     │
│   │ }                                                             │     │
│   └────────────────────────────────────────────────────────────────┘     │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
                                  │
                                  ▼
┌─────────────────────────────────────────────────────────────────────────────┐
│                    FRONTEND DASHBOARD (Admin/User Side)                     │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│  GET /api/attendance                                                       │
│  Shows data with source='third_party'                                     │
│                                                                             │
│  ┌──────────────────────────────────────────────────────────────┐        │
│  │ Attendance Dashboard                                         │        │
│  │                                                              │        │
│  │ Employee │ Date │ Check In │ Check Out │ Status │ Source  │ Device│ │
│  │ ────────────────────────────────────────────────────────────│        │
│  │ EMP001   │ 31/1 │ 09:30   │ 18:30     │ Present│ 3rd Party│ BIOM-01│ │
│  │ EMP002   │ 31/1 │ 10:05   │ 19:00     │ Late   │ 3rd Party│ BIOM-01│ │
│  │ EMP003   │ 31/1 │ Manual  │ -         │ Absent │ Manual   │ -      │ │
│  │                                                              │        │
│  └──────────────────────────────────────────────────────────────┘        │
│                                                                             │
│  ┌──────────────────────────────────────────────────────────────┐        │
│  │ Import Logs (Admin Only)                                     │        │
│  │                                                              │        │
│  │ Employee │ Date │ Status │ Time │ Error                     │        │
│  │ ────────────────────────────────────────────────────────────│        │
│  │ EMP001   │ 31/1 │ ✓ OK   │ 2s   │ -                         │        │
│  │ EMP002   │ 31/1 │ ✓ OK   │ 1s   │ -                         │        │
│  │ EMP999   │ 31/1 │ ✗ FAIL │ 0s   │ Employee not found        │        │
│  │                                                              │        │
│  └──────────────────────────────────────────────────────────────┘        │
│                                                                             │
│  ┌──────────────────────────────────────────────────────────────┐        │
│  │ API Key Management (Superadmin)                             │        │
│  │                                                              │        │
│  │ System      │ Description     │ Status │ Created   │ Action│        │
│  │ ─────────────────────────────────────────────────────────── │        │
│  │ BioMetric-1 │ Main office     │ Active │ 15 Jan    │ [Disable] │        │
│  │ ZKTeco-HQ   │ HQ Biometric    │ Active │ 20 Jan    │ [Disable] │        │
│  │ Mobile-App  │ GPS Tracking    │Inactive│ 10 Jan    │ [Enable]  │        │
│  │                                                              │        │
│  └──────────────────────────────────────────────────────────────┘        │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## Data Flow Sequence Diagram

```
┌──────────────────┐     ┌─────────────┐     ┌────────────┐     ┌──────────┐
│  Biometric       │     │  Your API   │     │  Database  │     │ Frontend │
│  System          │     │  Server     │     │  (MySQL)   │     │ Display  │
└────────┬─────────┘     └──────┬──────┘     └─────┬──────┘     └────┬─────┘
         │                      │                  │                 │
         │  1. Employee enters  │                  │                 │
         │  Reads fingerprint   │                  │                 │
         │                      │                  │                 │
         │  2. POST /webhook/attendance            │                 │
         │  {employee_id, check_in, device_id}    │                 │
         ├─────────────────────────────────────────►                 │
         │                      │                  │                 │
         │                      │  3. Validate API key               │
         │                      │  Hash and compare                  │
         │                      │  (SHA256)                          │
         │                      │                  │                 │
         │                      │  4. Find employee                  │
         │                      │  SELECT * FROM staff WHERE id      │
         │                      ├─────────────────────►              │
         │                      │                  │                 │
         │                      │  5. Check record exists            │
         │                      │  SELECT * FROM attendance...       │
         │                      ├─────────────────────►              │
         │                      │                  │                 │
         │                      │  6. INSERT/UPDATE attendance       │
         │                      │  source='third_party'              │
         │                      ├─────────────────────►              │
         │                      │                  │                 │
         │                      │  7. Log import (success)           │
         │                      │  INSERT INTO import_logs           │
         │                      ├─────────────────────►              │
         │                      │                  │                 │
         │                      │  8. Return 200 OK                  │
         │  ◄─────────────────────────────────────────              │
         │                      │                  │                 │
         │  9. Time passes...   │                  │                 │
         │  Employee exits      │                  │                 │
         │                      │                  │                 │
         │  10. POST /webhook/attendance           │                 │
         │  {employee_id, check_in, check_out}    │                 │
         ├─────────────────────────────────────────►                 │
         │                      │                  │                 │
         │                      │  11. Find existing record          │
         │                      │  UPDATE attendance                 │
         │                      │  SET check_out=...                 │
         │                      ├─────────────────────►              │
         │                      │                  │                 │
         │                      │  12. Log import (success)          │
         │                      ├─────────────────────►              │
         │                      │                  │                 │
         │                      │  13. Return 200 OK                 │
         │  ◄─────────────────────────────────────────              │
         │                      │                  │                 │
         │                      │                  │ 14. Admin loads │
         │                      │                  │ attendance page │
         │                      │                  │                 │
         │                      │ 15. GET /api/attendance            │
         │                      │     WHERE source='third_party'     │
         │                      │◄────────────────────────────────────┤
         │                      │                  │                 │
         │                      │ 16. SELECT from attendance         │
         │                      ├─────────────────────►              │
         │                      │                  │  17. Return data│
         │                      │◄─────────────────────              │
         │                      │                  │                 │
         │                      │                  │  18. Render     │
         │                      │                  │  dashboard      │
         │                      │                  │◄─────────────────┤
         │                      │                  │                 │
         │                      │                  │  Shows:         │
         │                      │                  │  ✓ Entry: 09:30 │
         │                      │                  │  ✓ Exit: 18:30  │
         │                      │                  │  ✓ Device: ...  │
         │                      │                  │  ✓ Source: 3P   │
         │                      │                  │                 │
```

---

## API Key Generation & Validation Flow

```
┌─────────────────────────────────────────────────────────────────────────┐
│                      INITIAL SETUP (One Time)                            │
├─────────────────────────────────────────────────────────────────────────┤
│                                                                         │
│  SUPERADMIN SIDE                                                        │
│  ┌────────────────────────────────┐                                    │
│  │ Click "Generate API Key"       │                                    │
│  │ ├─ System Name: BioMetric      │                                    │
│  │ └─ Description: Main Office    │                                    │
│  └────────────────┬───────────────┘                                    │
│                   │                                                    │
│                   ▼                                                    │
│  ┌────────────────────────────────┐                                    │
│  │ Backend - Generate Key         │                                    │
│  │ ├─ Create random 32 bytes      │                                    │
│  │ ├─ Convert to hex: ABC123...   │                                    │
│  │ └─ Hash with SHA256: XYZ789... │                                    │
│  └────────────────┬───────────────┘                                    │
│                   │                                                    │
│                   ▼                                                    │
│  ┌────────────────────────────────┐                                    │
│  │ Store in Database              │                                    │
│  │ ├─ api_key_hash: XYZ789...     │                                    │
│  │ ├─ system_name: BioMetric      │                                    │
│  │ └─ is_active: 1                │                                    │
│  └────────────────┬───────────────┘                                    │
│                   │                                                    │
│                   ▼                                                    │
│  ┌────────────────────────────────┐                                    │
│  │ Display to Superadmin          │                                    │
│  │ "API Key: ABC123..."           │                                    │
│  │ "Save securely, shown only     │                                    │
│  │  once!"                         │                                    │
│  └────────────────┬───────────────┘                                    │
│                   │                                                    │
│                   │ Share with Third-Party                             │
│                   ▼                                                    │
│                                                                         │
│  THIRD-PARTY SYSTEM SIDE                                              │
│  ┌────────────────────────────────┐                                    │
│  │ Receive API Key: ABC123...     │                                    │
│  │ Store in configuration file    │                                    │
│  │ (environment variable)         │                                    │
│  │ Example:                        │                                    │
│  │ API_KEY=ABC123...              │                                    │
│  └────────────────────────────────┘                                    │
│                                                                         │
│                                                                         │
├─────────────────────────────────────────────────────────────────────────┤
│                     EVERY API CALL (Runtime)                            │
├─────────────────────────────────────────────────────────────────────────┤
│                                                                         │
│  THIRD-PARTY SYSTEM                                                    │
│  ┌───────────────────────────────────────────────────┐                │
│  │ POST /webhook/attendance                          │                │
│  │ Headers:                                          │                │
│  │   x-api-key: ABC123...                           │                │
│  │   Content-Type: application/json                 │                │
│  │ Body:                                             │                │
│  │   {employee_id, date, check_in, check_out}       │                │
│  └────────────────┬────────────────────────────────┘                │
│                   │                                                    │
│                   ▼                                                    │
│                                                                         │
│  YOUR SERVER (Authentication)                                          │
│  ┌───────────────────────────────────────────────────┐                │
│  │ 1. Extract header                                │                │
│  │    api_key_from_header = "ABC123..."             │                │
│  │                                                   │                │
│  │ 2. Hash received key                             │                │
│  │    api_key_hash = SHA256("ABC123...")            │                │
│  │    Result: "XYZ789..."                           │                │
│  │                                                   │                │
│  │ 3. Query database                                │                │
│  │    SELECT * FROM third_party_api_keys            │                │
│  │    WHERE api_key_hash = "XYZ789..."              │                │
│  │    AND is_active = 1                             │                │
│  │                                                   │                │
│  │ 4. Check result                                  │                │
│  │    ├─ Found & Active → Continue                  │                │
│  │    └─ Not Found or Inactive → Return 401         │                │
│  │                                                   │                │
│  │ 5. Update last_used_at timestamp                 │                │
│  │                                                   │                │
│  └───────────────────────────────────────────────────┘                │
│                   │                                                    │
│                   ├─ Success → Process request                        │
│                   └─ Fail    → Return error                            │
│                                                                         │
└─────────────────────────────────────────────────────────────────────────┘
```

---

## Error Handling Flow

```
API Request comes in with x-api-key header
│
▼
┌──────────────────────────────────────────┐
│ Header present?                          │
└───┬────────────────────┬─────────────────┘
    │ No                 │ Yes
    │                    ▼
    │         ┌───────────────────┐
    │         │ API key valid?     │
    │         └───┬──────┬────────┘
    │             │ No   │ Yes
    │             │      ▼
    │             │    ┌──────────────┐
    │             │    │ Employee ID  │
    │             │    │ exists?      │
    │             │    └─┬──┬────────┘
    │             │      │  │
    │             │      │  ▼ Yes
    │             │      │ ┌──────────────┐
    │             │      │ │ Date/Time    │
    │             │      │ │ format valid?│
    │             │      │ └─┬──┬────────┘
    │             │      │   │  │
    │             │      │   │  ▼ Yes
    │             │      │   │ ┌──────────────┐
    │             │      │   │ │ Process &    │
    │             │      │   │ │ Update DB    │
    │             │      │   │ └───┬──────────┘
    │             │      │   │     │
    │             │      │   │     ▼
    │             │      │   │  ┌──────────────┐
    │             │      │   │  │ Log success  │
    │             │      │   │  │ & return 200 │
    │             │      │   │  └──────────────┘
    │             │      │   │
    │    ▼        ▼      ▼   ▼
    │  ┌──────────────────────────────┐
    │  │ Error Response (401/404/400) │
    │  │ + Log Failed Import          │
    │  │ + Return Error Message       │
    │  └──────────────────────────────┘
    │
    └─────────────────┬────────────────┘
                      │
                      ▼
          ┌─────────────────────────┐
          │ attendance_import_logs  │
          │ ├─ import_status: fail  │
          │ ├─ error_message: ...   │
          │ └─ created_at: NOW      │
          └─────────────────────────┘
```

---

## Database Schema Relationship Diagram

```
┌──────────────────────────────────────────────────────────────────┐
│                                                                  │
│  ┌────────────────────┐         ┌────────────────────┐           │
│  │    staff           │         │   attendance       │           │
│  ├────────────────────┤         ├────────────────────┤           │
│  │ id (PK)            │◄────────│ staff_id (FK)      │           │
│  │ employee_id        │  ┌──────│ date               │           │
│  │ name               │  │      │ check_in           │           │
│  │ hod_id             │  │      │ check_out          │           │
│  │ department         │  │      │ status             │ NEW       │
│  └────────────────────┘  │      │ source             │─────┐     │
│           ▲              │      │ device_id          │     │     │
│           │              │      │ working_hours      │     │     │
│           │              │      │ created_at         │     │     │
│           └──────────────┤      │ updated_at         │     │     │
│                          │      └────────────────────┘     │     │
│                          │                                 │     │
│                          │      ┌────────────────────┐     │     │
│                          │      │   third_party_api_ │     │     │
│                          │      │   keys             │     │     │
│                          │      ├────────────────────┤     │     │
│                          │      │ id (PK)            │     │     │
│                          │      │ system_name        │     │     │
│                          │      │ api_key_hash       │     │     │
│                          │      │ description        │     │     │
│                          │      │ is_active          │     │     │
│                          │      │ created_at         │     │     │
│                          │      │ last_used_at       │     │     │
│                          │      └────────────────────┘     │     │
│                          │              ▲                  │     │
│                          │              │                  │     │
│                          │              │ FK               │     │
│                          │              │ (api_key_id)     │     │
│                          └──────────────┼──────────────────┘     │
│                                         │                        │
│                          ┌──────────────┴────────────────┐        │
│                          │   attendance_import_logs (NEW)│        │
│                          ├──────────────────────────────┤        │
│                          │ id (PK)                      │        │
│                          │ api_key_id (FK)              │        │
│                          │ employee_id                  │        │
│                          │ attendance_date              │        │
│                          │ check_in                     │        │
│                          │ check_out                    │        │
│                          │ status                       │        │
│                          │ device_id                    │        │
│                          │ import_status (success/fail) │        │
│                          │ error_message                │        │
│                          │ created_at                   │        │
│                          └──────────────────────────────┘        │
│                                                                  │
│  Relationships:                                                  │
│  • staff 1→ many attendance                                     │
│  • third_party_api_keys 1→ many attendance_import_logs         │
│  • attendance (source field) can reference device from logs    │
│                                                                  │
└──────────────────────────────────────────────────────────────────┘
```

---

## Complete Integration Timeline

```
TIME    │ THIRD-PARTY SYSTEM          │ YOUR SYSTEM               │ DATABASE
────────┼─────────────────────────────┼──────────────────────────┼─────────────────
9:00 AM │ Employee scans entry        │                          │
        │ (fingerprint)               │                          │
        │                             │                          │
        ├─ POST /webhook/attendance   │                          │
        │ └─ employee_id: EMP001      │                          │
        │    check_in: 09:00:00       ├─ Validate key           │
        │    device_id: BIO_01        │ ├─ Find employee        │
        │                             │ ├─ Auto-detect: present │
        │                             │ ├─ Create record        │
        │                             │ └─ Log success          ├─ INSERT
        │                             │                          │ attendance
        │ ◄─ 200 OK                   │                          │
        │   (Record created)          │                          │
────────┼─────────────────────────────┼──────────────────────────┼─────────────────
9:05 AM │ (Time passes...)            │                          │
────────┼─────────────────────────────┼──────────────────────────┼─────────────────
6:00 PM │ Employee scans exit         │                          │
        │ (fingerprint)               │                          │
        │                             │                          │
        ├─ POST /webhook/attendance   │                          │
        │ └─ employee_id: EMP001      │                          │
        │    check_in: 09:00:00       ├─ Validate key           │
        │    check_out: 18:00:00      │ ├─ Find employee        │
        │    device_id: BIO_01        │ ├─ Find existing record │
        │                             │ ├─ Calculate: 9 hrs     │
        │                             │ ├─ Update record        │
        │                             │ └─ Log success          ├─ UPDATE
        │                             │                          │ attendance
        │ ◄─ 200 OK                   │                          │
        │   (Record updated)          │                          │
────────┼─────────────────────────────┼──────────────────────────┼─────────────────
6:05 PM │ (Time passes...)            │                          │
────────┼─────────────────────────────┼──────────────────────────┼─────────────────
8:00 PM │                             │ Admin opens dashboard    │
        │                             ├─ GET /api/attendance    │
        │                             │   WHERE source=3party    ├─ SELECT *
        │                             │   WHERE date = TODAY    │ attendance
        │                             │                          │
        │                             │ ◄─ Returns data         │
        │                             │ ├─ EMP001 (9:00-18:00) │
        │                             │ ├─ Present              │
        │                             │ └─ Source: 3rd Party   │
        │                             │                          │
        │                             │ Display on dashboard:   │
        │                             │ ┌──────────────────┐    │
        │                             │ │ EMP001           │    │
        │                             │ │ Entry:  09:00    │    │
        │                             │ │ Exit:   18:00    │    │
        │                             │ │ Status: Present  │    │
        │                             │ │ Device: BIO_01   │    │
        │                             │ └──────────────────┘    │
        │                             │                          │
────────┼─────────────────────────────┼──────────────────────────┼─────────────────
11:59PM │ End of day batch sync       │                          │
        │ (collect all day's data)    │                          │
        │                             │                          │
        ├─ POST /webhook/attendance-  │                          │
        │       bulk                  │                          │
        │ └─ records: [100+ records]  ├─ Validate all keys      │
        │    {all employees}          │ ├─ Process each record  │
        │                             │ ├─ Bulk insert/update   │
        │ ◄─ 200 OK                   │ └─ Log all             ├─ BULK
        │   (All processed)           │                          │ INSERT/UPDATE
        │                             │                          │
────────┴─────────────────────────────┴──────────────────────────┴─────────────────
```

---

## Security & Authentication Flow

```
┌─────────────────────────────────────────────────────────────────┐
│                    SECURITY FLOW DIAGRAM                        │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  1. API KEY GENERATION (Secure Storage)                         │
│  ┌─────────────────────────────────────────────────┐           │
│  │ Random 32 bytes generated  →  "ABC123XYZ..."   │           │
│  │                                    ▼             │           │
│  │                            SHA256 Hash Function │           │
│  │                                    ▼             │           │
│  │                     "XYZ789..." (Hashed Value)  │           │
│  │                                    ▼             │           │
│  │                   Store ONLY hashed in DB       │           │
│  │                   Show plain key ONLY ONCE      │           │
│  └─────────────────────────────────────────────────┘           │
│                           ▼                                     │
│  2. API REQUEST (Third-Party System)                           │
│  ┌─────────────────────────────────────────────────┐           │
│  │ POST /webhook/attendance                        │           │
│  │ Headers:                                        │           │
│  │   x-api-key: ABC123XYZ...  ◄─ Sent in header   │           │
│  │   Content-Type: application/json               │           │
│  │                                                 │           │
│  │ Body:                                           │           │
│  │ {                                               │           │
│  │   "employee_id": "EMP001",                      │           │
│  │   "attendance_date": "2025-01-31",              │           │
│  │   "check_in": "09:30:00"                        │           │
│  │ }                                               │           │
│  └─────────────────────────────────────────────────┘           │
│                           ▼                                     │
│  3. VALIDATION (Your Server)                                   │
│  ┌─────────────────────────────────────────────────┐           │
│  │ Step 1: Extract header                          │           │
│  │ api_key_from_header = "ABC123XYZ..."           │           │
│  │                                                 │           │
│  │ Step 2: Hash the received key                  │           │
│  │ SHA256("ABC123XYZ...") = "XYZ789..."           │           │
│  │                                                 │           │
│  │ Step 3: Database lookup                        │           │
│  │ SELECT * FROM third_party_api_keys             │           │
│  │ WHERE api_key_hash = "XYZ789..."               │           │
│  │ AND is_active = 1                              │           │
│  │                                                 │           │
│  │ Step 4: Result evaluation                      │           │
│  │ ├─ Found with is_active = 1  →  SUCCESS       │           │
│  │ └─ Not found or inactive     →  401 ERROR     │           │
│  │                                                 │           │
│  │ Step 5: Update last_used_at                    │           │
│  │ UPDATE third_party_api_keys                    │           │
│  │ SET last_used_at = NOW()                       │           │
│  │ WHERE id = [api_key_id]                        │           │
│  └─────────────────────────────────────────────────┘           │
│                           ▼                                     │
│  4. RESPONSE OPTIONS                                           │
│  ┌──────────────────┬──────────────────────────────┐           │
│  │ Auth Success     │ Auth Failed                  │           │
│  ├──────────────────┼──────────────────────────────┤           │
│  │ ✓ Continue to    │ ✗ Return 401                │           │
│  │   validation     │   {"message":               │           │
│  │ ✓ Process data   │    "Invalid API key"}       │           │
│  │ ✓ Update DB      │ ✗ Log to audit trail        │           │
│  │ ✓ Log success    │ ✗ Alert (optional)          │           │
│  │ ✓ Return 200     │                             │           │
│  └──────────────────┴──────────────────────────────┘           │
│                                                                 │
│  5. AUDIT & MONITORING                                         │
│  ┌─────────────────────────────────────────────────┐           │
│  │ All API calls logged to attendance_import_logs  │           │
│  │ ├─ Successful imports: import_status='success'  │           │
│  │ ├─ Failed imports: import_status='failed'       │           │
│  │ ├─ Error details: error_message                 │           │
│  │ ├─ API key used: api_key_id                     │           │
│  │ └─ Timestamp: created_at                        │           │
│  │                                                 │           │
│  │ Can be reviewed later for:                      │           │
│  │ • Security audits                               │           │
│  │ • Usage analysis                                │           │
│  │ • Troubleshooting                               │           │
│  │ • Performance metrics                           │           │
│  └─────────────────────────────────────────────────┘           │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

---

**Last Updated:** January 31, 2025  
**Version:** 1.0  
**Status:** Complete
