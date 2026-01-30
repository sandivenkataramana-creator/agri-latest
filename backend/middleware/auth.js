let jwt = null;
try {
  jwt = require('jsonwebtoken');
} catch (err) {
  console.warn('Warning: jsonwebtoken not installed - auth endpoints will return 503. Run `npm install` to enable authentication.');
}
const db = require('../config/database');

const JWT_SECRET = process.env.JWT_SECRET || 'change-me-secret';
const JWT_EXPIRES_IN = process.env.JWT_EXPIRES_IN || '8h';

function signToken(payload) {
  if (!jwt) throw new Error('jsonwebtoken is not installed');
  return jwt.sign(payload, JWT_SECRET, { expiresIn: JWT_EXPIRES_IN });
}

async function authenticateJWT(req, res, next) {
  if (!jwt) {
    return res.status(503).json({ error: 'Authentication unavailable. Run `npm install` to enable authentication.' });
  }

  const authHeader = req.headers.authorization;
  if (!authHeader || !authHeader.startsWith('Bearer ')) {
    console.warn('authenticateJWT: missing or malformed Authorization header');
    return res.status(401).json({ error: 'Unauthorized' });
  }

  const token = authHeader.split(' ')[1];
  try {
    const payload = jwt.verify(token, JWT_SECRET);
    // Attach user info
    req.user = payload;
    // Optionally fetch latest user details
    const [rows] = await db.query('SELECT id, username, email, role, hod_id, staff_id FROM users WHERE id = ?', [payload.id]);
    if (rows.length === 0) {
      console.warn('authenticateJWT: user not found for id', payload.id);
      return res.status(401).json({ error: 'User not found' });
    }
    req.user = { ...payload, ...rows[0] };
    next();
  } catch (err) {
    console.warn('authenticateJWT: token verification failed:', err.message);
    return res.status(401).json({ error: 'Invalid token' });
  }
}

// async function handleUpload(req, res, uploadType) {
//   if (!req.file) return res.status(400).json({ error: 'No file uploaded' });

//   const hodId = req.user.hod_id;
//   if (!hodId) return res.status(400).json({ error: 'No hod_id' });

//   const [hod] = await db.query('SELECT id FROM hods WHERE id = ?', [hodId]);
//   if (!hod.length) return res.status(400).json({ error: 'Invalid HOD' });

//   const fileFormat = req.body.fileFormat || req.file.originalname.split('.').pop();
//   const description = req.body.description || '';

//   const [result] = await db.query(
//     'INSERT INTO uploads (file_name, file_path, upload_type, file_format, hod_id, description, uploaded_by, uploaded_at) VALUES (?, ?, ?, ?, ?, ?, ?, NOW())',
//     [
//       req.file.originalname,
//       req.file.path,
//       uploadType,
//       fileFormat,
//       hodId,
//       req.user.id,
//       req.user.username
//     ]

//   );


//   res.json({ success: true, id: result.insertId });
// }

const handleUpload = (uploadType) => {
  return async (req, res) => {
    try {
      if (!req.file) {
        return res.status(400).json({ error: 'No file uploaded' });
      }

      const hodId = req.user?.hod_id;
      if (!hodId) {
        return res.status(400).json({ error: 'No hod_id' });
      }

      const [hod] = await db.query(
        'SELECT id FROM hods WHERE id = ?',
        [hodId]
      );

      if (!hod.length) {
        return res.status(400).json({ error: 'Invalid HOD' });
      }

      const fileFormat =
        req.body.fileFormat || req.file.originalname.split('.').pop();

      const description = req.body.description || '';

      const [result] = await db.query(
  `
  INSERT INTO hod_uploads
  (hod_id, file_name, file_path, file_format, upload_type, description)
  VALUES (?, ?, ?, ?, ?, ?)
  `,
  [
    hodId,
    req.file.originalname,
    req.file.path,
    fileFormat,
    uploadType,
    description
  ]
);
      res.status(201).json({
        success: true,
        id: result.insertId
      });
    } catch (err) {
      console.error('Upload failed:', err);
      res.status(500).json({ error: 'Upload failed' });
    }
  };
};

function requireRole(allowedRoles) {
  return (req, res, next) => {
    if (!req.user || !req.user.role) return res.status(403).json({ error: 'Forbidden' });
    if (Array.isArray(allowedRoles)) {
      if (!allowedRoles.includes(req.user.role)) return res.status(403).json({ error: 'Forbidden' });
      return next();
    }
    if (req.user.role !== allowedRoles) return res.status(403).json({ error: 'Forbidden' });
    next();
  };
}

module.exports = { authenticateJWT, requireRole, signToken ,handleUpload};
