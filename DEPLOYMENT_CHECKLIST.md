# Deployment & Setup Checklist

## Phase 1: Database Setup ✅

- [ ] **Create Tables**
  ```bash
  # Execute the SQL schema file in your database
  mysql -u root -p your_database < backend/database/attendance_import_schema.sql
  ```
  Creates:
  - `third_party_api_keys`
  - `attendance_import_logs`
  - Adds `source` and `device_id` columns to `attendance`

- [ ] **Verify Tables Created**
  ```sql
  SHOW TABLES LIKE 'third_party%';
  SHOW TABLES LIKE 'attendance%';
  DESCRIBE attendance; -- Check for source and device_id columns
  ```

---

## Phase 2: Backend Setup ✅

- [ ] **Files Already Added**
  - ✅ `backend/routes/attendanceImport.js` - Created
  - ✅ `backend/server.js` - Modified (route registered)

- [ ] **Restart Backend Server**
  ```bash
  npm install  # Install any new dependencies (if needed)
  npm start    # Restart server
  
  # Verify route is accessible
  curl -X GET http://localhost:3000/api/attendance-import/api-keys \
    -H "Authorization: Bearer YOUR_TOKEN"
  ```

- [ ] **Check Server Logs**
  - Look for errors during startup
  - Verify no port conflicts
  - Confirm routes are registered

---

## Phase 3: Frontend Setup ✅

- [ ] **Files Already Added**
  - ✅ `frontend/src/pages/ThirdPartyIntegration.js` - Created
  - ✅ `frontend/src/pages/ThirdPartyIntegration.css` - Created
  - ✅ `frontend/src/services/api.js` - Modified (added functions)

- [ ] **Add Route to Navigation**
  Edit your main App.js or routing config to include:
  ```javascript
  import ThirdPartyIntegration from './pages/ThirdPartyIntegration';
  
  // In your routes
  <Route path="/settings/third-party-integration" element={<ThirdPartyIntegration />} />
  ```

- [ ] **Add Menu Item**
  Add to your Settings or Admin menu:
  ```
  Settings
  ├─ User Management
  ├─ System Configuration
  └─ Third-Party Integration  ← Add this
  ```

- [ ] **Test Frontend Page**
  ```bash
  npm start
  # Navigate to: http://localhost:3000/settings/third-party-integration
  ```

---

## Phase 4: API Key Generation ✅

- [ ] **Login as Superadmin**
  - Access your admin account
  - Navigate to Third-Party Integration page

- [ ] **Generate First API Key**
  - Click "Generate New Key"
  - Enter System Name: e.g., "BioMetric System Main Office"
  - Enter Description: e.g., "Main office attendance tracking"
  - Click "Generate Key"
  - **IMPORTANT:** Copy and save the key securely (shown only once!)

- [ ] **Verify Key Created**
  - Check that key appears in the API Keys table
  - Status should be "Active"
  - Last Used should be "Never"

---

## Phase 5: Testing ✅

- [ ] **Test with cURL** (Single Record)
  ```bash
  curl -X POST http://localhost:3000/api/attendance-import/webhook/attendance \
    -H "x-api-key: YOUR_API_KEY_HERE" \
    -H "Content-Type: application/json" \
    -d '{
      "employee_id": "EMP001",
      "attendance_date": "2025-01-31",
      "check_in": "09:30:00",
      "check_out": "18:30:00",
      "device_id": "TEST_DEVICE"
    }'
  ```
  
  Expected Response:
  ```json
  {
    "message": "Attendance record processed successfully",
    "attendance_id": 1,
    "employee_id": "EMP001",
    "attendance_date": "2025-01-31",
    "status": "present"
  }
  ```

- [ ] **Verify in Database**
  ```sql
  SELECT * FROM attendance WHERE employee_id = 'EMP001' AND date = '2025-01-31';
  -- Should show: source = 'third_party', device_id = 'TEST_DEVICE'
  
  SELECT * FROM attendance_import_logs WHERE employee_id = 'EMP001';
  -- Should show: import_status = 'success'
  ```

- [ ] **Verify in Frontend**
  - Go to Attendance page
  - Should see the test record
  - Click on the row to see details
  - Verify source and device_id fields

- [ ] **Test Bulk Import**
  ```bash
  curl -X POST http://localhost:3000/api/attendance-import/webhook/attendance-bulk \
    -H "x-api-key: YOUR_API_KEY_HERE" \
    -H "Content-Type: application/json" \
    -d '{
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
          "check_in": "10:15:00",
          "check_out": "19:00:00"
        }
      ]
    }'
  ```

- [ ] **Test Error Handling**
  - Missing API key
    ```bash
    curl -X POST http://localhost:3000/api/attendance-import/webhook/attendance \
      -H "Content-Type: application/json" \
      -d '{"employee_id": "EMP001", "attendance_date": "2025-01-31", "check_in": "09:30:00"}'
    ```
    Should return: `{"message": "Missing API key"}`

  - Invalid employee
    ```bash
    curl -X POST http://localhost:3000/api/attendance-import/webhook/attendance \
      -H "x-api-key: YOUR_API_KEY_HERE" \
      -H "Content-Type: application/json" \
      -d '{"employee_id": "INVALID", "attendance_date": "2025-01-31", "check_in": "09:30:00"}'
    ```
    Should return: `{"message": "Employee INVALID not found"}`

- [ ] **Check Import Logs**
  - In admin panel, view Import Logs
  - Should show all test records
  - Filter by success/failed
  - Verify timestamps

---

## Phase 6: Third-Party System Configuration ✅

- [ ] **Prepare Documentation**
  - Provide `QUICK_REFERENCE.md` to third-party system admin
  - Provide `THIRD_PARTY_INTEGRATION.md` for reference
  - Include API key (securely)

- [ ] **Share Integration Details**
  - Base URL: `http://your-domain.com/api/attendance-import`
  - Webhook endpoint: `/webhook/attendance`
  - Bulk endpoint: `/webhook/attendance-bulk`
  - API Key: (provided separately)
  - Sample code in Python, Node.js, cURL

- [ ] **Request Test Data**
  - Ask third-party system to send test records
  - Verify records appear in your system
  - Check import logs for success

---

## Phase 7: Production Deployment ✅

- [ ] **Security Review**
  - [ ] API keys are stored securely (not in code/logs)
  - [ ] Using HTTPS (not HTTP)
  - [ ] Database backups configured
  - [ ] Access logs enabled
  - [ ] Rate limiting configured (optional)

- [ ] **Performance Check**
  - [ ] Database indexes created (already done in schema)
  - [ ] Test bulk import with 1000 records
  - [ ] Monitor query performance
  - [ ] Check database size growth

- [ ] **Monitoring Setup**
  - [ ] Error logging enabled
  - [ ] Success rate monitoring
  - [ ] Alert on repeated failures
  - [ ] Log rotation configured

- [ ] **Documentation**
  - [ ] API documentation deployed
  - [ ] Quick reference guide available
  - [ ] Troubleshooting guide ready
  - [ ] Support contacts documented

- [ ] **Backup & Recovery**
  - [ ] Database backed up
  - [ ] Backup tested (restore verification)
  - [ ] Recovery plan documented
  - [ ] RTO/RPO defined

---

## Phase 8: Live Monitoring ✅

- [ ] **First 24 Hours**
  - Monitor import success rate
  - Check for any errors in logs
  - Verify data accuracy
  - Monitor API key activity

- [ ] **First Week**
  - Track API usage patterns
  - Monitor database growth
  - Check for any issues reported
  - Gather feedback

- [ ] **Ongoing**
  - Monthly review of import logs
  - Quarterly security audit
  - Annual performance review
  - Keep documentation updated

---

## Common Issues & Solutions

| Issue | Solution |
|-------|----------|
| "Missing API key" error | Verify `x-api-key` header is present |
| "Invalid API key" error | Check if API key is correct and active |
| "Employee not found" | Verify employee_id matches exactly |
| Data not appearing | Check import logs for error messages |
| Slow performance | Check database indexes, consider archiving old logs |
| API key leaked | Generate new key, deactivate old one |

---

## Rollback Plan

If something goes wrong:

1. **Disable API Key**
   - Go to admin panel
   - Find the problematic API key
   - Click toggle to deactivate
   - Third-party system will get 401 error

2. **Revert Database**
   ```bash
   # If you have backups
   mysql -u root -p your_database < backup.sql
   ```

3. **Revert Code**
   ```bash
   git revert <commit-hash>
   npm install
   npm restart
   ```

4. **Clean Up**
   - Delete test records
   - Clear import logs
   - Re-verify system

---

## Sign-off Checklist

- [ ] All tests passed
- [ ] Documentation complete
- [ ] Team trained
- [ ] Backups verified
- [ ] Monitoring active
- [ ] Third-party system configured
- [ ] Go-live approved
- [ ] Post-launch monitoring scheduled

---

## Contact Information

| Role | Name | Email | Phone |
|------|------|-------|-------|
| Backend Admin | - | - | - |
| Database Admin | - | - | - |
| Frontend Admin | - | - | - |
| Third-Party Contact | - | - | - |
| Support Lead | - | - | - |

---

## Deployment Timeline

| Phase | Start Date | End Date | Status |
|-------|-----------|----------|--------|
| Database Setup | - | - | - |
| Backend Setup | - | - | - |
| Frontend Setup | - | - | - |
| Testing | - | - | - |
| Third-Party Config | - | - | - |
| Production Deploy | - | - | - |
| Monitoring | - | - | - |

---

**Document Version:** 1.0
**Last Updated:** January 31, 2025
**Status:** Ready for Deployment
