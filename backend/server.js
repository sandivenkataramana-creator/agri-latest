const express = require('express');
const cors = require('cors');
const path = require('path');

// Load environment-specific .env file
// Development: loads .env
// Production: loads .env.production (when NODE_ENV=production)
const envFile = process.env.NODE_ENV === 'production' ? '.env.production' : '.env';
require('dotenv').config({ path: path.join(__dirname, envFile) });

console.log(`[Server] ==========================================`);
console.log(`[Server] Environment: ${process.env.NODE_ENV || 'development'}`);
console.log(`[Server] Config loaded from: ${envFile}`);
console.log(`[Server] ==========================================`);

const app = express();

// Better logging for debugging unexpected exits
process.on('uncaughtException', (err) => {
  console.error('UNCAUGHT EXCEPTION:', err);
  console.error('Stack:', err.stack);
  // Don't exit on SMTP errors
  if (err.code === 'EAUTH') {
    console.log('Continuing despite SMTP authentication error...');
    return;
  }
  // Try to keep going
  // process.exit(1);
});
process.on('unhandledRejection', (reason, promise) => {
  console.error('UNHANDLED REJECTION at:', promise, 'reason:', reason);
  if (reason && reason.stack) {
    console.error('Stack:', reason.stack);
  }
});

// Middleware
app.use(cors());
app.use(express.json());

// Simple request logger to see incoming requests
app.use((req, res, next) => {
  console.log(`${new Date().toISOString()} - ${req.method} ${req.url}`);
  next();
});

// Routes
app.use('/api/auth', require('./routes/auth'));
app.use('/api/dashboard', require('./routes/dashboard'));
app.use('/api/categories', require('./routes/categories'));
app.use('/api/locations', require('./routes/locations'));
app.use('/api/hods', require('./routes/hods'));
app.use('/api/schemes', require('./routes/schemes'));
app.use('/api/beneficiaries', require('./routes/beneficiaries'));
app.use('/api/staff', require('./routes/staff'));
app.use('/api/budget', require('./routes/budget'));
app.use('/api/flagship-programmes', require('./routes/flagshipProgrammes'));
app.use('/api/kpis', require('./routes/kpis'));
app.use('/api/nodal-officers', require('./routes/nodalOfficers'));
app.use('/api/dao', require('./routes/dao'));
app.use('/api/attendance', require('./routes/attendance'));
app.use('/api/attendance-import', require('./routes/attendanceImport'));
app.use('/api/revenue', require('./routes/revenue'));
app.use('/api/search', require('./routes/search'));
app.use('/api/notifications', require('./routes/notifications'));
app.use('/api/messages', require('./routes/messages'));
app.use('/api/users', require('./routes/users'));
app.use('/api/uploads', require('./routes/uploads'));

// Health check
app.get('/api/health', (req, res) => {
  res.json({ status: 'OK', message: 'Server is running' });
});

// Error handling middleware (logs server-side errors)
app.use((err, req, res, next) => {
  console.error('Express error middleware caught:', err);
  res.status(500).json({ error: err.message || 'Internal Server Error' });
});

const PORT = process.env.PORT || 5000;

// Start import worker (bull) to process import jobs - non-blocking
try {
  const importQueue = require('./queues/importQueue');
  console.log('Import queue initialized');
} catch (err) {
  console.warn('Import queue not started (Redis might be unavailable):', err.message);
}

// =====================================================
// AUTO-MARK ABSENT FEATURE
// Marks all staff as absent at day start
// When they check in via external system, status updates
// =====================================================
const markAllStaffAbsent = async () => {
  try {
    const db = require('./config/database');
    
    // Get current date from database (ensures consistency with DB timezone)
    const [[{ today }]] = await db.query(`SELECT CURDATE() as today`);
    
    console.log(`[Auto-Absent] Starting auto-absent marking for ${today} (using DB time)...`);
    
    // Get all active staff who DON'T already have attendance for today
    const [staffWithoutAttendance] = await db.query(`
      SELECT 
        s.id as staff_id,
        s.hod_id,
        h.id as department_id
      FROM staff s
      LEFT JOIN hods h ON s.hod_id = h.id
      WHERE s.id NOT IN (
        SELECT staff_id FROM attendance WHERE DATE(date) = CURDATE()
      )
    `);
    
    console.log(`[Auto-Absent] Found ${staffWithoutAttendance.length} staff without attendance records`);
    
    if (staffWithoutAttendance.length === 0) {
      console.log(`[Auto-Absent] All staff already have attendance records for today`);
      return;
    }
    
    // Insert absent records for all staff
    // Skip department_id to avoid foreign key issues (it's nullable)
    let markedCount = 0;
    for (const staff of staffWithoutAttendance) {
      try {
        await db.query(`
          INSERT INTO attendance (staff_id, hod_id, date, status, source, created_at)
          VALUES (?, ?, CURDATE(), 'absent', 'auto_absent', NOW())
          ON DUPLICATE KEY UPDATE id = id
        `, [staff.staff_id, staff.hod_id]);
        markedCount++;
      } catch (insertErr) {
        // Ignore duplicate key errors
        if (insertErr.code !== 'ER_DUP_ENTRY') {
          console.error(`[Auto-Absent] Error for staff ${staff.staff_id}:`, insertErr.message);
        }
      }
    }
    
    console.log(`[Auto-Absent] Successfully marked ${markedCount} staff as absent for ${today}`);
  } catch (err) {
    console.error('[Auto-Absent] Error:', err.message);
  }
};

// Schedule auto-absent to run at midnight
const scheduleAutoAbsent = () => {
  const now = new Date();
  const night = new Date(
    now.getFullYear(),
    now.getMonth(),
    now.getDate() + 1, // next day
    0, 0, 0 // midnight
  );
  const msToMidnight = night.getTime() - now.getTime();
  
  console.log(`[Auto-Absent] Scheduled next run in ${Math.round(msToMidnight / 1000 / 60)} minutes (at midnight)`);
  
  setTimeout(() => {
    markAllStaffAbsent();
    // Schedule for next day
    setInterval(markAllStaffAbsent, 24 * 60 * 60 * 1000); // Run every 24 hours
  }, msToMidnight);
};

// If this file is run directly, start the HTTP server. This allows tests to import the app without listening.
if (require.main === module) {
  app.listen(PORT, '0.0.0.0', () => {
    console.log(`Server running on port ${PORT}`);
    
    // Run auto-absent marking on server startup (marks absent for today)
    setTimeout(() => {
      markAllStaffAbsent();
      scheduleAutoAbsent(); // Schedule for future days
    }, 5000); // Wait 5 seconds for DB connection to be ready
  });
}

module.exports = app;
