const express = require('express');
const router = express.Router();

// Minimal dashboard endpoints returning safe defaults so frontend won't break
// Replace with real queries later as needed

router.get('/stats', (req, res) => {
  res.json({
    total_hods: 0,
    total_beneficiaries: 0,
    total_budget: 0,
    total_files: 0
  });
});

router.get('/quick-stats', (req, res) => {
  res.json({
    hods: 0,
    schemes: 0,
    reports: 0,
    attendance_today: 0
  });
});

router.get('/schemes-summary', (req, res) => {
  res.json([]);
});

router.get('/budget-summary', (req, res) => {
  res.json({ total_allocated: 0, total_utilized: 0, by_hod: [] });
});

router.get('/budget-breakdown', (req, res) => {
  res.json({ breakdown: [] });
});

router.get('/schemes-by-category', (req, res) => {
  res.json([]);
});

router.get('/hods-by-department', (req, res) => {
  res.json([]);
});

router.get('/budget-by-hod', (req, res) => {
  res.json([]);
});

router.get('/schemes-by-hod', (req, res) => {
  res.json([]);
});

router.get('/attendance-by-hod', (req, res) => {
  res.json([]);
});

router.get('/revenue-by-hod', (req, res) => {
  res.json([]);
});

router.get('/revenue-by-department', (req, res) => {
  res.json([]);
});

router.get('/kpi-summary', (req, res) => {
  res.json({ kpis: [] });
});

module.exports = router;
