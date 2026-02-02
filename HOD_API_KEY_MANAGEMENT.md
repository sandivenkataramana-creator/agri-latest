# HOD-Specific API Key Management Guide

## Overview

This document clarifies how API keys work with different HOD (Head of Department) scenarios and provides best practices for managing attendance integrations across multiple departments.

---

## Table of Contents

1. [Current Architecture](#current-architecture)
2. [Single HOD Scenario](#single-hod-scenario)
3. [Multiple HODs with Shared System](#multiple-hods-with-shared-system)
4. [API Key Regeneration & HOD Deletion](#api-key-regeneration--hod-deletion)
5. [System Name Conflicts](#system-name-conflicts)
6. [Best Practices](#best-practices)
7. [Troubleshooting](#troubleshooting)

---

## Current Architecture

### How It Works Today

The current implementation uses **system-level API keys**, not HOD-specific keys. This means:

- **One API key can send attendance for multiple employees from different HODs**
- API keys are identified by `system_name` (e.g., "BIOMETRIC-MAIN-GATE")
- When attendance data is received, the system looks up the employee ID and determines their HOD automatically
- The `hod_id` is determined from the employee's staff record, not from the API key

### Database Schema

```sql
third_party_api_keys Table:
- id (Primary Key)
- system_name (UNIQUE) -- e.g., "BIOMETRIC-MAIN-GATE"
- api_key_hash (stores encrypted key)
- description (notes about the system)
- is_active (boolean)
- created_at
- last_used_at
```

**Key Point**: There is **NO `hod_id` field** in the third_party_api_keys table currently.

---

## Single HOD Scenario

### Scenario 1: One Department, One Biometric Machine

**Setup**:
- Agriculture Department has a biometric machine at main gate
- All Agriculture Department staff use this one biometric machine
- System Name: `BIOMETRIC-AGRICULTURE-MAIN`

**How It Works**:
1. Biometric machine sends attendance with employee ID (e.g., "EMP_AGR_001")
2. System looks up employee in staff table
3. Finds that employee belongs to Agriculture HOD
4. Attendance record is created with that HOD's ID
5. HOD can see all their staff's attendance

**Data Flow**:
```
Biometric Machine
       ↓
   (sends employee_id)
       ↓
   API Endpoint /webhook/attendance
       ↓
   Look up employee_id in staff table
       ↓
   Get hod_id from employee's record
       ↓
   Create attendance record with that hod_id
       ↓
   Agriculture HOD sees attendance in Dashboard
```

---

## Multiple HODs with Shared System

### Scenario 2: Multiple Departments Share One Biometric Machine

**Situation**:
- Office building has ONE biometric machine at the main gate
- Multiple departments use the same gate (Agriculture, Revenue, Animal Husbandry, etc.)
- All staff from different departments scan the same machine

**How It Works**:
1. Setup:
   - Create ONE API key: `BIOMETRIC-BUILDING-MAIN-GATE`
   - All departments configure this machine with the SAME API key

2. When employee scans:
   - Employee ID is sent to system
   - System identifies which HOD the employee belongs to
   - Attendance is recorded under that employee's HOD
   - Each HOD only sees their own staff's attendance

3. Result:
   - One biometric machine = One API key
   - Multiple departments' attendance = Automatically separated by HOD
   - Each HOD sees only their staff's data

**Data Flow**:
```
Building Main Gate Biometric Machine (Shared by ALL departments)
       ↓
   (sends: EMP_AGR_001, EMP_REV_002, EMP_ANH_003, etc.)
       ↓
   API Key: BIOMETRIC-BUILDING-MAIN-GATE
       ↓
   For each employee_id:
       - Look up which HOD they belong to
       - Create attendance record with that HOD's ID
       ↓
   Result:
   - Agriculture HOD sees: EMP_AGR_001, EMP_AGR_005, etc.
   - Revenue HOD sees: EMP_REV_002, EMP_REV_010, etc.
   - Animal Husbandry HOD sees: EMP_ANH_003, EMP_ANH_011, etc.
```

**Advantages**:
- Simple infrastructure (one machine)
- One API key to manage
- No manual HOD assignment needed
- System automatically routes data correctly

---

## API Key Regeneration & HOD Deletion

### Regeneration Scenario

**Question**: "When I regenerate an API key, does it affect different HODs?"

**Answer**: YES - Regeneration affects ALL HODs that receive attendance from this system.

**What Happens When You Regenerate**:

1. Old API key is **DELETED** from database
2. New API key is created with **SAME system name** and **SAME description**
3. Old key **STOPS WORKING** immediately
4. All biometric machines using old key will fail
5. You must update ALL machines/systems with new key

**Step-by-Step Example**:

```
Before Regeneration:
- System Name: BIOMETRIC-MAIN
- API Key: abc123def456ghi789jkl012mno345...
- Services: Agriculture HOD + Revenue HOD + Animal Husbandry HOD

Action: Click "Regenerate" in admin panel

After Regeneration:
- System Name: BIOMETRIC-MAIN (same)
- Old API Key: DELETED (no longer works)
- New API Key: xyz789uvw456rst123lmn890opq567...
- Services: Still serves Agriculture + Revenue + Animal Husbandry

Required Action:
- Update Agriculture biometric machine with new key
- Update Revenue biometric machine with new key
- Update Animal Husbandry biometric machine with new key
- OR: If ONE shared machine: just update that one machine
```

### HOD Deletion Scenario

**Question**: "When a HOD is deleted, are their API keys also deleted?"

**Answer**: NO - API keys are **NOT deleted** when a HOD is deleted.

**What Actually Happens**:

1. HOD is deleted from system
2. All staff from that HOD become orphaned (no HOD assigned)
3. API key still exists and continues to work
4. New attendance records from that API key:
   - Look for employee ID in staff table
   - Find that employee has no HOD (hod_id = NULL)
   - Record is created but cannot be attributed to any department
   - System may show orphaned attendance records

**Proper Deletion Procedure**:

To safely delete a HOD with active API integration:

1. **Option A: Transfer Staff to Another HOD**
   - Move all staff from old HOD to new HOD
   - Delete old HOD
   - API key continues to work (attendance now records under new HOD)
   - No orphaned records

2. **Option B: Deactivate API Key First**
   - Go to Third Party Integration
   - Find the API key serving that HOD
   - Click Toggle to deactivate it
   - Then delete the HOD
   - Prevents new orphaned attendance records

3. **Option C: Regenerate with New HOD Info**
   - Update the API key description with new HOD information
   - Update biometric machines to send attendance to new HOD
   - Then delete old HOD

---

## System Name Conflicts

### Issue: Cannot Use Same System Name for Different Departments

**Current Behavior**:
- System names must be **globally unique**
- You CANNOT create two API keys with the same system name
- Even if they serve different HODs

### Why This Design?

The system prioritizes:
1. **Simplicity** - No complex HOD-specific logic
2. **Flexibility** - One API key can serve multiple HODs
3. **Clarity** - System name clearly identifies the physical biometric/integration point

### Solution: Use Descriptive System Names

Instead of this (won't work):
```
❌ System Name: ATTENDANCE-SYSTEM (for Agriculture HOD)
❌ System Name: ATTENDANCE-SYSTEM (for Revenue HOD)
// Error: System name already exists
```

Use this (works):
```
✓ System Name: ATTENDANCE-AGRICULTURE
✓ System Name: ATTENDANCE-REVENUE
✓ System Name: BIOMETRIC-MAIN-GATE (serves all departments)
```

### System Name Naming Convention

**Recommended Pattern**:

```
[DEVICE_TYPE]-[LOCATION]-[OPTIONAL_HOD]

Examples:
BIOMETRIC-MAIN-GATE          (central, serves all HODs)
BIOMETRIC-BUILDING-A         (building, serves all in that building)
ZKTECO-AGRICULTURE-OFFICE    (specific to Agriculture HOD)
FINGERPRINT-REVENUE-DEPT     (specific to Revenue HOD)
ATTENDANCE-API-INTEGRATION   (API import)
```

---

## Best Practices

### 1. Documentation

**For Each API Key, Document**:
```
System Name: BIOMETRIC-MAIN-GATE
Description:
  - Physical Location: Building A, Ground Floor
  - Device Type: ZKTeco BioPad
  - Connected HODs: Agriculture, Revenue, Animal Husbandry
  - Number of Staff: ~150
  - Vendor: ZKTeco Support +91-XXXX-XXXX
  - IT Contact: admin@agri.com
  - Last Maintenance: 2024-02-01
  - Next Key Rotation: 2024-05-01
```

### 2. Key Rotation Schedule

**Recommended**: Rotate API keys every 3-6 months

```
Action Plan for Regeneration:
1. Schedule: Avoid peak hours
2. Notify: All affected HOD heads
3. Test: With test employee ID first
4. Update: All biometric machines with new key
5. Verify: Check import logs for successful data
6. Confirm: Each HOD confirms their data is flowing
```

### 3. Monitoring

**Weekly Tasks**:
- Check import logs for failures
- Monitor "last_used_at" timestamp
- Verify all expected HODs have attendance records

**Monthly Tasks**:
- Review log summary by API key
- Check for any orphaned records
- Verify all devices still connected

### 4. For Shared Systems

**If one biometric serves multiple HODs**:
```
✓ Use ONE API key with clear system name
✓ Document all HODs in description
✓ Don't create separate keys for each HOD
✓ Let system route data automatically
✓ Verify each HOD receives correct data
```

### 5. For Separate Systems

**If each HOD has its own biometric**:
```
✓ Create separate API key for each system
✓ Use HOD name in system_name
✓ Update system_name if HOD status changes
✓ Deactivate key if HOD is deleted
✓ Delete key only after 90 days of inactivity
```

---

## Troubleshooting

### Issue 1: Some HODs Not Getting Attendance Data

**Symptoms**:
- Revenue HOD sees attendance, but Agriculture HOD doesn't
- Only some employees have records

**Possible Causes**:
1. Employees not assigned to HOD in staff table
2. Employee ID format mismatch (case sensitive)
3. Different biometric machine using different API key

**Solution**:
1. Verify all employees are assigned to a HOD
   ```sql
   SELECT * FROM staff WHERE hod_id IS NULL;
   ```
2. Check import logs for errors
3. Verify system names of biometric machines
4. Confirm all machines use same API key

### Issue 2: New HOD Added But Not Receiving Data

**Symptoms**:
- New department created
- Added staff members
- But no attendance appearing

**Likely Cause**:
- Staff from new HOD use a biometric machine with DIFFERENT API key
- OR: Staff not yet added to system

**Solution**:
1. Ensure staff records exist in system
2. Verify staff are assigned to new HOD
3. Check which API key the biometric machine is using
4. If different key, verify that key is active

### Issue 3: Orphaned Attendance Records After HOD Deletion

**Symptoms**:
- Deleted a HOD
- Now seeing attendance records with no HOD
- Dashboard shows "Unknown Department"

**Solution**:
1. Check which API key was serving that HOD
2. Transfer orphaned staff to another HOD (if possible)
3. Deactivate that API key to prevent more orphaned records
4. Manually correct hod_id for orphaned records:
   ```sql
   UPDATE attendance SET hod_id = [new_hod_id] WHERE hod_id IS NULL AND attendance_date >= [date_deleted];
   ```

### Issue 4: Same Employee in Multiple HODs Showing Wrong HOD

**Symptoms**:
- Employee appears in multiple HODs
- Attendance showing under wrong HOD

**Root Cause**:
- Staff table has duplicate records with different hod_ids
- OR: Employee not properly transferred before HOD changes

**Solution**:
1. Check for duplicate employee records
2. Correct hod_id in staff table for that employee
3. Verify only one hod_id per employee_id
4. Delete duplicate staff records

---

## API Key Lifecycle Management

### Creation
```
1. Determine: Is this for one HOD or multiple HODs?
2. Create: API key with descriptive system_name
3. Document: Which HODs will use this key
4. Configure: Biometric machine with API key
5. Test: Send sample attendance record
6. Verify: Data appears in correct HOD's dashboard
```

### Active Use
```
1. Monitor: Check import logs weekly
2. Verify: Each HOD receives expected records
3. Track: last_used_at timestamp
4. Alert: If not used for 7+ days
```

### Maintenance
```
1. Every 3-6 months: Review and rotate key
2. If Changed: Update system description
3. When HOD Changes: Update documentation
4. Document: Any configuration changes
```

### Deactivation
```
1. Notify: All affected HODs
2. Deactivate: Toggle key to inactive
3. Wait: 7-14 days to ensure no pending data
4. Delete: Remove key if not used
5. Archive: Store API key history for audit
```

---

## FAQ

**Q: Can one employee belong to multiple HODs?**
A: No. One employee can only have one hod_id in the staff table. If an employee moves departments, update their hod_id.

**Q: What if two HODs share a biometric machine but want separate API keys?**
A: Currently, they must share one API key. The system routes attendance automatically by looking up the employee's HOD. Creating separate keys won't help.

**Q: Can I assign an API key to a specific HOD?**
A: The current system doesn't support HOD-specific API keys. One key serves all HODs that have employees using that biometric machine. Feature can be added if needed.

**Q: What happens to historical attendance if I delete an API key?**
A: Historical data is NOT deleted. Only the key is removed. The attendance records remain in the database, but new data cannot be pushed with that key.

**Q: Can I reuse a deleted system_name for a new API key?**
A: No. System names must be unique and permanent (unless explicitly deleted and fully purged from database).

**Q: How do I know which API key serves which HODs?**
A: Check the "description" field and the import logs. Import logs show which API key_id created each record.

---

## Future Enhancements

Potential improvements for future versions:

1. **HOD-Specific API Keys**
   - Restrict each API key to specific HODs
   - Prevent cross-HOD data leakage
   - Better access control

2. **API Key Namespace**
   - Allow same system_name per HOD
   - Each HOD manages their own keys
   - Better for decentralized systems

3. **Department Mapping**
   - Link API keys to HODs directly
   - Automatic validation
   - Better error messages

4. **Key Sharing Rules**
   - Define which HODs can share a key
   - Explicit configuration
   - Audit trail of who approved sharing

---

## Support & Questions

For clarification on:
- **HOD-specific behavior**: Contact System Administrator
- **API key management**: See [API Integration Guide](API_INTEGRATION_GUIDE.md)
- **Staff assignment**: Check staff management module
- **Attendance data**: Review import logs

---

**Document Version**: 1.0  
**Last Updated**: February 2024  
**Status**: Production Ready
