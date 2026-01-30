const express = require('express');
const router = express.Router();
const db = require('../config/database');
const { authenticateJWT, requireRole } = require('../middleware/auth');
const multer = require('multer');
const path = require('path');
const fs = require('fs');
const PDFDocument = require('pdfkit');
const { Document, Packer, Paragraph, TextRun } = require('docx');
const XLSX = require('xlsx');

// Debug route to verify router mounting
router.get('/test', (req, res) => {
  res.json({ ok: true, message: 'Uploads router is working.' });
});

// Configure multer for file uploads
const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    const uploadDir = path.join(__dirname, '../uploads');
    if (!fs.existsSync(uploadDir)) {
      fs.mkdirSync(uploadDir, { recursive: true });
    }
    cb(null, uploadDir);
  },
  filename: (req, file, cb) => {
    const uniqueSuffix = Date.now() + '-' + Math.round(Math.random() * 1E9);
    cb(null, uniqueSuffix + path.extname(file.originalname));
  }
});

const upload = multer({ storage });

const { handleUpload } = require('../middleware/auth');

// Create uploads table if not exists
const initializeTable = async () => {
  try {
    await db.query(`
      CREATE TABLE IF NOT EXISTS hod_uploads (
        id INT AUTO_INCREMENT PRIMARY KEY,
        hod_id INT NOT NULL,
        file_name VARCHAR(255) NOT NULL,
        file_path VARCHAR(500) NOT NULL,
        file_format VARCHAR(50),
        upload_type ENUM('flagship_program', 'report', 'budget') NOT NULL,
        description TEXT,
        status ENUM('active', 'deleted') DEFAULT 'active' NOT NULL,
        deleted_reason TEXT,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
        FOREIGN KEY (hod_id) REFERENCES hods(id) ON DELETE CASCADE,
        INDEX (hod_id, upload_type),
        INDEX (status),
        INDEX (created_at)
      )
    `);

    await db.query(`
      CREATE TABLE IF NOT EXISTS file_deletion_logs (
        id INT AUTO_INCREMENT PRIMARY KEY,
        file_id INT NOT NULL,
        file_name VARCHAR(255),
        hod_id INT,
        hod_name VARCHAR(255),
        department VARCHAR(255),
        upload_type VARCHAR(50),
        deletion_reason TEXT,
        deleted_by INT,
        deleted_by_name VARCHAR(255),
        deleted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (file_id) REFERENCES hod_uploads(id) ON DELETE SET NULL,
        INDEX (deleted_at),
        INDEX (upload_type)
      )
    `);
  } catch (err) {
    console.error('Error initializing uploads table:', err.message);
  }
};

// Initialize tables on module load
initializeTable();

// Delete flagship_program file with reason tracking (for HODs)
router.delete('/flagship-program/:id', [authenticateJWT, requireRole('hod')], async (req, res) => {
  try {
    const fileId = req.params.id;
    const { reason } = req.body;
    const user = req.user;

    if (!reason || !reason.trim()) {
      return res.status(400).json({ error: 'Deletion reason is required' });
    }

    const [file] = await db.query(
      `SELECT hu.*, h.name as hod_name, h.department
       FROM hod_uploads hu
       LEFT JOIN hods h ON hu.hod_id = h.id
       WHERE hu.id = ? AND hu.hod_id = ? AND hu.upload_type = 'flagship_program'`,
      [fileId, user.hod_id]
    );

    if (!file || file.length === 0) {
      return res.status(404).json({ error: 'File not found' });
    }

    const fileRecord = file[0];

    // Log the deletion in file_deletion_logs
    await db.query(
      `INSERT INTO file_deletion_logs (file_id, file_name, hod_id, hod_name, department, upload_type, deletion_reason, deleted_by, deleted_by_name)
       VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)`,
      [fileId, fileRecord.file_name, fileRecord.hod_id, fileRecord.hod_name, fileRecord.department, fileRecord.upload_type, reason, user.id, user.name]
    );

    // Soft delete: set status to 'deleted' instead of hard delete
    await db.query(
      `UPDATE hod_uploads SET status = 'deleted', deleted_reason = ? WHERE id = ?`,
      [reason, fileId]
    );

    res.json({ success: true, message: 'Flagship programme file deleted successfully' });
  } catch (error) {
    console.error('Error deleting flagship programme file:', error);
    res.status(500).json({ error: error.message });
  }
});

//upload flagship program endpoint (for HOD users)
// router.post('/flagship-program', [authenticateJWT, requireRole('hod')], upload.single('file'), async (req, res) => {
//   try {
//     if (!req.file) {
//       return res.status(400).json({ error: 'No file uploaded' });
//     }
//     const user = req.user;
//     const fileFormat = req.body.fileFormat || req.file.originalname.split('.').pop().toLowerCase();
//     // Validate HOD id is present on authenticated user
//     const hodId = user && user.hod_id;
//     if (!hodId) {
//       return res.status(400).json({ error: 'Authenticated user has no hod_id. Cannot associate upload.' });
//     }
//     // Ensure hod exists to avoid foreign key constraint failure
//     const [hodRows] = await db.query('SELECT id FROM hods WHERE id = ?', [hodId]);
//     if (!hodRows || hodRows.length === 0) {
//       return res.status(400).json({ error: `HOD not found for hod_id=${hodId}. Please ensure HOD record exists.` });
//     }
//     // const uploadType = req.body.upload_type || 'flagship_program';
//     const uploadType = 'flagship_program';
//     const description = req.body.description || '';

//     const [result] = await db.query(
//       `INSERT INTO hod_uploads (hod_id, file_name, file_path, file_format, upload_type, description)
//        VALUES (?, ?, ?, ?, ?, ?)`,
//       [hodId, req.file.originalname, req.file.path, fileFormat, uploadType, description]
//     );
//     res.json({
//       success: true,
//       message: 'File uploaded successfully',
//       file: {
//         id: result.insertId,
//         file_name: req.file.originalname,
//         file_format: fileFormat,
//         file_path: req.file.path,
//         created_at: new Date()
//       }
//     });
//   } catch (error) {
//     console.error('Error uploading file:', error);
//     res.status(500).json({ error: error.message });
//   }
// });


// // Upload file endpoint (for HOD users)
// router.post('/report', [authenticateJWT, requireRole('hod')], upload.single('file'), async (req, res) => {
//   try {
//     if (!req.file) {
//       return res.status(400).json({ error: 'No file uploaded' });
//     }

//     const user = req.user;
//     const fileFormat = req.body.fileFormat || req.file.originalname.split('.').pop().toLowerCase();

//     // Validate HOD id is present on authenticated user
//     const hodId = user && user.hod_id;
//     if (!hodId) {
//       return res.status(400).json({ error: 'Authenticated user has no hod_id. Cannot associate upload.' });
//     }

//     // Ensure hod exists to avoid foreign key constraint failure
//     const [hodRows] = await db.query('SELECT id FROM hods WHERE id = ?', [hodId]);
//     if (!hodRows || hodRows.length === 0) {
//       return res.status(400).json({ error: `HOD not found for hod_id=${hodId}. Please ensure HOD record exists.` });
//     }

//     // const uploadType = req.body.upload_type || 'report';
//     const uploadType = 'report';
//     const description = req.body.description || '';

//     const [result] = await db.query(
//       `INSERT INTO hod_uploads (hod_id, file_name, file_path, file_format, upload_type, description)
//        VALUES (?, ?, ?, ?, ?, ?)`,
//       [hodId, req.file.originalname, req.file.path, fileFormat, uploadType, description]
//     );

//     res.json({
//       success: true,
//       message: 'File uploaded successfully',
//       file: {
//         id: result.insertId,
//         file_name: req.file.originalname,
//         file_format: fileFormat,
//         file_path: req.file.path,
//         created_at: new Date()
//       }
//     });
//   } catch (error) {
//     console.error('Error uploading file:', error);
//     res.status(500).json({ error: error.message });
//   }
// });

// router.post('/report', [authenticateJWT, requireRole('hod')], upload.single('file'),
//   handleUpload('report')
// );

// router.post('/flagship-program', [authenticateJWT, requireRole('hod')], upload.single('file'),
//   handleUpload('flagship_program')
// );

router.post(
  '/report',
  authenticateJWT,
  requireRole('hod'),
  upload.single('file'),
  handleUpload('report')
);

router.post(
  '/flagship-program',
  authenticateJWT,
  requireRole('hod'),
  upload.single('file'),
  handleUpload('flagship_program')
);


// Get reports for a HOD
router.get('/reports', [authenticateJWT, requireRole('hod')], async (req, res) => {
  try {
    const hodId = req.query.hodId || req.user.hod_id;

    const [reports] = await db.query(
      `SELECT id, hod_id, file_name, file_format, upload_type, created_at, description, status
       FROM hod_uploads
       WHERE hod_id = ? AND upload_type = 'report' AND status = 'active'
       ORDER BY created_at DESC`,
      [hodId]
    );

    res.json(reports || []);
  } catch (error) {
    console.error('Error fetching reports:', error);
    res.status(500).json({ error: error.message });
  }
});

// Get flagship programs for a HOD
router.get('/flagship-programs', [authenticateJWT, requireRole('hod')], async (req, res) => {
  try {
    const hodId = req.query.hodId || req.user.hod_id;

    const [programs] = await db.query(
      `SELECT id, hod_id, file_name, file_format, upload_type, created_at, description, status
       FROM hod_uploads
       WHERE hod_id = ? AND upload_type = 'flagship_program' AND status = 'active'
       ORDER BY created_at DESC`,
      [hodId]
    );

    res.json(programs || []);
  } catch (error) {
    console.error('Error fetching flagship programs:', error);
    res.status(500).json({ error: error.message });
  }
});

// Export files
// router.get('/reports/export', [authenticateJWT, requireRole('hod')], async (req, res) => {
//   try {
//     const format = req.query.format || 'pdf';
//     const hodId = req.query.hodId || req.user.hod_id;

//     const [reports] = await db.query(
//       `SELECT file_name, file_format, created_at, description
//        FROM hod_uploads
//        WHERE hod_id = ? AND upload_type = 'report' AND status = 'active'
//        ORDER BY created_at DESC`,
//       [hodId]
//     );

//     // Create export based on format
//     let content;
//     let contentType;
//     let filename;

//     if (format === 'xlsx') {
//       const XLSX = require('xlsx');
//       const ws_data = [
//         ['File Name', 'Format', 'Date Uploaded', 'Description'],
//         ...reports.map(r => [r.file_name, r.file_format, new Date(r.created_at).toLocaleDateString(), r.description || ''])
//       ];
//       const ws = XLSX.utils.aoa_to_sheet(ws_data);
//       const wb = XLSX.utils.book_new();
//       XLSX.utils.book_append_sheet(wb, ws, 'Reports');
//       content = XLSX.write(wb, { bookType: 'xlsx', type: 'buffer' });
//       contentType = 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet';
//       filename = `reports_export_${Date.now()}.xlsx`;
//     } else if (format === 'docx') {
//       // For DOCX, we'll create a simple export. In production, use docx library
//       content = Buffer.from('Reports Export\n\n' + reports.map(r => `${r.file_name} (${r.file_format})`).join('\n'));
//       contentType = 'application/vnd.openxmlformats-officedocument.wordprocessingml.document';
//       filename = `reports_export_${Date.now()}.docx`;
//     } else {
//       // PDF format
//       content = Buffer.from('Reports Export\n\n' + reports.map(r => `${r.file_name} (${r.file_format})`).join('\n'));
//       contentType = 'application/pdf';
//       filename = `reports_export_${Date.now()}.pdf`;
//     }

//     res.setHeader('Content-Type', contentType);
//     res.setHeader('Content-Disposition', `attachment; filename="${filename}"`);
//     res.send(content);
//   } catch (error) {
//     console.error('Error exporting reports:', error);
//     res.status(500).json({ error: error.message });
//   }
// });

// const PDFDocument = require('pdfkit');
// const { Document, Packer, Paragraph, TextRun } = require('docx');
// const XLSX = require('xlsx');

router.get(
  '/export',
  [authenticateJWT, requireRole(['hod', 'admin', 'superadmin'])],
  async (req, res) => {
    try {
      const {
        format = 'pdf',
        uploadType = 'report', // report | flagship_program | budget
        hodId,
        page = 1,
        limit = 50,
        dateFrom,
        dateTo
      } = req.query;

      const offset = (page - 1) * limit;
      const user = req.user;

      /* ===================== ACCESS CONTROL ===================== */
      let whereClause = `WHERE hu.status = 'active'`;
      const params = [];

      // HOD → only own files
      if (user.role === 'hod') {
        whereClause += ` AND hu.hod_id = ?`;
        params.push(user.hod_id);
      }

      // Admin → optional hod filter
      if (user.role !== 'hod' && hodId) {
        whereClause += ` AND hu.hod_id = ?`;
        params.push(hodId);
      }

      // Upload type filter
      if (uploadType) {
        whereClause += ` AND hu.upload_type = ?`;
        params.push(uploadType);
      }

      // Date filters
      if (dateFrom) {
        whereClause += ` AND hu.created_at >= ?`;
        params.push(dateFrom);
      }
      if (dateTo) {
        whereClause += ` AND hu.created_at <= ?`;
        params.push(dateTo);
      }

      /* ===================== QUERY ===================== */
      const [files] = await db.query(
        `
        SELECT 
          hu.file_name,
          hu.file_format,
          hu.upload_type,
          hu.created_at,
          hu.description,
          h.name AS hod_name,
          h.department
        FROM hod_uploads hu
        LEFT JOIN hods h ON hu.hod_id = h.id
        ${whereClause}
        ORDER BY hu.created_at DESC
        LIMIT ? OFFSET ?
        `,
        [...params, Number(limit), Number(offset)]
      );

      if (!files || files.length === 0) {
        return res.status(404).json({ error: 'No files found' });
      }

      /* ===================== PDF ===================== */
      if (format === 'pdf') {
        const doc = new PDFDocument({ margin: 40 });

        res.setHeader('Content-Type', 'application/pdf');
        res.setHeader(
          'Content-Disposition',
          `attachment; filename="export_${Date.now()}.pdf"`
        );

        doc.pipe(res);

        doc.fontSize(18).text('Uploads Export', { align: 'center' });
        doc.moveDown();

        files.forEach((f, i) => {
          doc
            .fontSize(12)
            .text(`${i + 1}. ${f.file_name}`)
            .fontSize(10)
            .text(`Type: ${f.upload_type}`)
            .text(`Format: ${f.file_format}`)
            .text(`HOD: ${f.hod_name || '-'}`)
            .text(`Department: ${f.department || '-'}`)
            .text(`Date: ${new Date(f.created_at).toLocaleDateString()}`)
            .text(`Description: ${f.description || '-'}`);
          doc.moveDown();
        });

        doc.end();
        return;
      }

      /* ===================== DOCX ===================== */
      if (format === 'docx') {
        const doc = new Document({
          sections: [
            {
              children: [
                new Paragraph({
                  children: [
                    new TextRun({
                      text: 'Uploads Export',
                      bold: true,
                      size: 32
                    })
                  ]
                }),
                ...files.map((f, i) =>
                  new Paragraph({
                    spacing: { after: 200 },
                    children: [
                      new TextRun({ text: `${i + 1}. ${f.file_name}`, bold: true }),
                      new TextRun({ text: `\nType: ${f.upload_type}` }),
                      new TextRun({ text: `\nFormat: ${f.file_format}` }),
                      new TextRun({ text: `\nHOD: ${f.hod_name || '-'}` }),
                      new TextRun({ text: `\nDepartment: ${f.department || '-'}` }),
                      new TextRun({
                        text: `\nDate: ${new Date(f.created_at).toLocaleDateString()}`
                      }),
                      new TextRun({ text: `\nDescription: ${f.description || '-'}` })
                    ]
                  })
                )
              ]
            }
          ]
        });

        const buffer = await Packer.toBuffer(doc);

        res.setHeader(
          'Content-Type',
          'application/vnd.openxmlformats-officedocument.wordprocessingml.document'
        );
        res.setHeader(
          'Content-Disposition',
          `attachment; filename="export_${Date.now()}.docx"`
        );

        return res.send(buffer);
      }

      /* ===================== XLSX ===================== */
      if (format === 'xlsx') {
        const wsData = [
          ['File Name', 'Type', 'Format', 'HOD', 'Department', 'Date', 'Description'],
          ...files.map(f => [
            f.file_name,
            f.upload_type,
            f.file_format,
            f.hod_name || '',
            f.department || '',
            new Date(f.created_at).toLocaleDateString(),
            f.description || ''
          ])
        ];

        const ws = XLSX.utils.aoa_to_sheet(wsData);
        const wb = XLSX.utils.book_new();
        XLSX.utils.book_append_sheet(wb, ws, 'Uploads');

        const buffer = XLSX.write(wb, { bookType: 'xlsx', type: 'buffer' });

        res.setHeader(
          'Content-Type',
          'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
        );
        res.setHeader(
          'Content-Disposition',
          `attachment; filename="export_${Date.now()}.xlsx"`
        );

        return res.send(buffer);
      }

      return res.status(400).json({ error: 'Invalid format' });

    } catch (err) {
      console.error('Export error:', err);
      res.status(500).json({ error: err.message });
    }
  }
);

// // Delete file with reason tracking
// router.delete('/report/:id', [authenticateJWT, requireRole('hod')], async (req, res) => {
//   try {
//     const fileId = req.params.id;
//     const { reason } = req.body;
//     const user = req.user;

//     const [file] = await db.query(
//       `SELECT hu.*, h.name as hod_name, h.department
//        FROM hod_uploads hu
//        LEFT JOIN hods h ON hu.hod_id = h.id
//        WHERE hu.id = ? AND hu.hod_id = ?`,
//       [fileId, user.hod_id]
//     );

//     if (!file || file.length === 0) {
//       return res.status(404).json({ error: 'File not found' });
//     }

//     const fileRecord = file[0];

//     // Log the deletion in file_deletion_logs
//     await db.query(
//       `INSERT INTO file_deletion_logs (file_id, file_name, hod_id, hod_name, department, upload_type, deletion_reason, deleted_by, deleted_by_name)
//        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)`,
//       [fileId, fileRecord.file_name, fileRecord.hod_id, fileRecord.hod_name, fileRecord.department, fileRecord.upload_type, reason, user.id, user.name]
//     );

//     // Soft delete: set status to 'deleted' instead of hard delete
//     await db.query(
//       `UPDATE hod_uploads SET status = 'deleted', deleted_reason = ? WHERE id = ?`,
//       [reason, fileId]
//     );

//     // Note: Keep the actual file on disk for audit trail; can implement separate cleanup process

//     res.json({ success: true, message: 'File deleted successfully' });
//   } catch (error) {
//     console.error('Error deleting file:', error);
//     res.status(500).json({ error: error.message });
//   }
// });

// Delete report with reason tracking (SOFT DELETE)
router.delete(
  '/report/:id',
  [authenticateJWT, requireRole('hod')],
  async (req, res) => {
    try {
      const fileId = req.params.id;
      const { reason } = req.body;
      const user = req.user;

      if (!reason || !reason.trim()) {
        return res.status(400).json({ error: 'Deletion reason is required' });
      }

      // 1️⃣ Fetch ONLY active report belonging to this HOD
      const [rows] = await db.query(
        `SELECT hu.*, h.name AS hod_name, h.department
         FROM hod_uploads hu
         LEFT JOIN hods h ON hu.hod_id = h.id
         WHERE hu.id = ?
           AND hu.hod_id = ?
           AND hu.upload_type = 'report'
           AND hu.status != 'deleted'`,
        [fileId, user.hod_id]
      );

      if (rows.length === 0) {
        return res.status(404).json({ error: 'Report not found or already deleted' });
      }

      const fileRecord = rows[0];

      // 2️⃣ Log deletion
      await db.query(
        `INSERT INTO file_deletion_logs
         (file_id, file_name, hod_id, hod_name, department, upload_type,
          deletion_reason, deleted_by, deleted_by_name)
         VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)`,
        [
          fileId,
          fileRecord.file_name,
          fileRecord.hod_id,
          fileRecord.hod_name,
          fileRecord.department,
          'report',
          reason,
          user.id,
          user.name
        ]
      );

      // 3️⃣ ✅ Soft delete (THIS fixes your bug)
      await db.query(
        `UPDATE hod_uploads
         SET status = 'deleted',
             deleted_reason = ?,
             deleted_at = NOW()
         WHERE id = ?`,
        [reason, fileId]
      );

      res.json({ success: true, message: 'Report deleted successfully' });
    } catch (error) {
      console.error('Error deleting report:', error);
      res.status(500).json({ error: error.message });
    }
  }
);

// Get deletion logs (for admin/superadmin)
router.get('/deletion-logs', [authenticateJWT, requireRole(['admin', 'superadmin'])], async (req, res) => {
  try {
    const type = req.query.type || null; // e.g., 'report' or 'flagship_program'
    let query = `SELECT * FROM file_deletion_logs`;
    const params = [];
    if (type) {
      query += ` WHERE upload_type = ?`;
      params.push(type);
    }
    query += ` ORDER BY deleted_at DESC LIMIT 1000`;

    const [logs] = await db.query(query, params);

    res.json(logs || []);
  } catch (error) {
    console.error('Error fetching deletion logs:', error);
    res.status(500).json({ error: error.message });
  }
});

// Get all uploaded files (for admin/superadmin)
router.get('/all-files', [authenticateJWT, requireRole(['admin', 'superadmin'])], async (req, res) => {
  try {
    const uploadType = req.query.type || 'report';

    const [files] = await db.query(
      `SELECT hu.id, hu.hod_id, hu.file_name, hu.file_format, hu.upload_type, hu.created_at, hu.description, hu.status, h.name as hod_name, h.department
       FROM hod_uploads hu
       LEFT JOIN hods h ON hu.hod_id = h.id
       WHERE hu.upload_type = ? AND hu.status = 'active'
       ORDER BY hu.created_at DESC`,
      [uploadType]
    );

    res.json(files || []);
  } catch (error) {
    console.error('Error fetching files:', error);
    res.status(500).json({ error: error.message });
  }
});

// Download file (for admin/superadmin or HOD for own files)
router.get('/download/:id', [authenticateJWT], async (req, res) => {
  try {
    const fileId = req.params.id;
    const user = req.user;

    const [file] = await db.query(
      'SELECT file_path, file_name, status, hod_id FROM hod_uploads WHERE id = ? AND status = "active"',
      [fileId]
    );

    if (!file || file.length === 0) {
      return res.status(404).json({ error: 'File not found or has been deleted' });
    }

    if (!file || file.length === 0) {
      return res.status(404).json({ error: 'File not found' });
    }

    const filePath = file[0].file_path;
    const fileName = file[0].file_name;

    if (!fs.existsSync(filePath)) {
      return res.status(404).json({ error: 'File not found on disk' });
    }

    res.download(filePath, fileName);
  } catch (error) {
    console.error('Error downloading file:', error);
    res.status(500).json({ error: error.message });
  }
});

module.exports = router;
