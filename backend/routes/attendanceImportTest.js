const express = require('express');
const router = express.Router();

console.log('[attendanceImport-test] Module loaded');

// Simple test route
router.get('/test', (req, res) => {
  console.log('[attendanceImport-test] test endpoint hit');
  res.json({ message: 'Test OK' });
});

module.exports = router;
