import React, { useState, useEffect, useRef } from 'react';
import { FiUpload, FiDownload, FiTrash2, FiEye, FiGrid, FiList } from 'react-icons/fi';
import './Reports.css';

const Reports = () => {
  const fileInputRef = useRef(null);
  const [reports, setReports] = useState([]);
  const [loading, setLoading] = useState(false);
  const [viewFormat, setViewFormat] = useState('cards'); // 'cards' or 'list'
  const [uploadedFile, setUploadedFile] = useState(null);
  const [selectedFormat, setSelectedFormat] = useState('pdf');
  const [showDeleteReasonModal, setShowDeleteReasonModal] = useState(false);
  const [deleteReason, setDeleteReason] = useState('');
  const [selectedReportToDelete, setSelectedReportToDelete] = useState(null);
  const [exporting, setExporting] = useState(false);

  const user = JSON.parse(localStorage.getItem('user') || '{}');
  const isHOD = user.role === 'hod';
  const userHodId = user.hod_id;

  useEffect(() => {
    if (isHOD) {
      fetchReports();
    }
  }, [isHOD, userHodId]);

  const fetchReports = async () => {
    try {
      setLoading(true);
      const response = await fetch(`http://localhost:5000/api/uploads/reports?hodId=${userHodId}`, {
        headers: {
          'Authorization': `Bearer ${user.token}`
        }
      });
      if (response.ok) {
        const data = await response.json();
        setReports(Array.isArray(data) ? data : []);
      }
    } catch (err) {
      console.error('Error fetching reports:', err);
    } finally {
      setLoading(false);
    }
  };

  const handleFileSelect = (e) => {
    if (e.target.files.length > 0) {
      setUploadedFile(e.target.files[0]);
    }
  };

  const handleUpload = async () => {
    if (!uploadedFile) {
      alert('Please select a file to upload');
      return;
    }

    try {
      const formData = new FormData();
      formData.append('file', uploadedFile);
      formData.append('upload_type', 'report');
      formData.append('fileFormat', uploadedFile.name.split('.').pop().toLowerCase());

      const response = await fetch('http://localhost:5000/api/uploads/report', {
        method: 'POST',
        headers: {
          'Authorization': `Bearer ${user.token}`
        },
        body: formData
      });

      if (response.ok) {
        alert('Report uploaded successfully');
        setUploadedFile(null);
        if (fileInputRef.current) fileInputRef.current.value = '';
        fetchReports();
      } else {
        throw new Error('Upload failed');
      }
    } catch (err) {
      console.error('Error uploading report:', err);
      alert('Failed to upload report');
    }
  };

  const handleExport = async () => {
    if (reports.length === 0) {
      alert('No reports to export');
      return;
    }

    try {
      setExporting(true);
      const response = await fetch(`http://localhost:5000/api/uploads/reports/export?format=${selectedFormat}&hodId=${userHodId}`, {
        headers: {
          'Authorization': `Bearer ${user.token}`
        }
      });

      if (response.ok) {
        const blob = await response.blob();
        const url = window.URL.createObjectURL(blob);
        const a = document.createElement('a');
        a.href = url;
        a.download = `reports-export.${selectedFormat}`;
        document.body.appendChild(a);
        a.click();
        window.URL.revokeObjectURL(url);
        document.body.removeChild(a);
      }
    } catch (err) {
      console.error('Error exporting reports:', err);
      alert('Failed to export reports');
    } finally {
      setExporting(false);
    }
  };

  const handleDeleteClick = (report) => {
    setSelectedReportToDelete(report);
    setShowDeleteReasonModal(true);
  };

  // const handleConfirmDelete = async () => {
  //   if (!deleteReason.trim()) {
  //     alert('Please provide a reason for deletion');
  //     return;
  //   }

  //   try {
  //     const response = await fetch(`http://localhost:5000/api/uploads/report/${selectedReportToDelete.id}`, {
  //       method: 'DELETE',
  //       headers: {
  //         'Authorization': `Bearer ${user.token}`,
  //         'Content-Type': 'application/json'
  //       },
  //       body: JSON.stringify({ reason: deleteReason })
  //     });

  //     if (response.ok) {
  //       alert('Report deleted successfully');
  //       setShowDeleteReasonModal(false);
  //       setDeleteReason('');
  //       setSelectedReportToDelete(null);
  //       fetchReports();
  //     }
  //   } catch (err) {
  //     console.error('Error deleting report:', err);
  //     alert('Failed to delete report');
  //   }
  // };
  const handleConfirmDelete = async () => {
  if (!deleteReason.trim()) {
    alert('Please provide a reason for deletion');
    return;
  }

  try {
    const response = await fetch(
      `http://localhost:5000/api/uploads/report/${selectedReportToDelete.id}`,
      {
        method: 'DELETE',
        headers: {
          'Authorization': `Bearer ${user.token}`,
          'Content-Type': 'application/json'
        },
        body: JSON.stringify({ reason: deleteReason })
      }
    );

    if (!response.ok) {
      throw new Error('Delete failed');
    }

    // ✅ REMOVE FROM UI IMMEDIATELY
    setReports(prev =>
      prev.filter(r => r.id !== selectedReportToDelete.id)
    );

    setShowDeleteReasonModal(false);
    setDeleteReason('');
    setSelectedReportToDelete(null);

    alert('Report deleted successfully');
  } catch (err) {
    console.error('Error deleting report:', err);
    alert('Failed to delete report');
  }
};


  return (
    <div className="reports-container">
      <div className="reports-header">
        <h2>Reports</h2>
        <div className="reports-actions">
          <div>
            <label style={{ marginRight: '10px' }}>Export Format:</label>
            <select 
              value={selectedFormat} 
              onChange={(e) => setSelectedFormat(e.target.value)}
              style={{
                padding: '8px',
                borderRadius: '6px',
                border: '1px solid #ccc',
                marginRight: '10px'
              }}
            >
              <option value="pdf">PDF</option>
              <option value="xlsx">Excel</option>
              <option value="docx">Word</option>
            </select>
            <button 
              onClick={handleExport}
              disabled={exporting}
              style={{
                padding: '8px 16px',
                background: '#388e3c',
                color: 'white',
                border: 'none',
                borderRadius: '6px',
                cursor: exporting ? 'not-allowed' : 'pointer',
                marginRight: '10px',
                display: 'flex',
                alignItems: 'center',
                gap: '6px'
              }}
            >
              <FiDownload /> Export
            </button>
          </div>
          <div>
            <button onClick={() => setViewFormat(viewFormat === 'cards' ? 'list' : 'cards')}
              style={{
                padding: '8px 12px',
                background: '#1976d2',
                color: 'white',
                border: 'none',
                borderRadius: '6px',
                cursor: 'pointer',
                marginRight: '10px'
              }}
            >
              {viewFormat === 'cards' ? <FiList /> : <FiGrid />}
            </button>
            <input 
              ref={fileInputRef}
              type="file" 
              onChange={handleFileSelect}
              style={{ display: 'none' }}
            />
            <button 
              onClick={() => fileInputRef.current?.click()}
              style={{
                padding: '8px 16px',
                background: '#2e7d32',
                color: 'white',
                border: 'none',
                borderRadius: '6px',
                cursor: 'pointer',
                display: 'flex',
                alignItems: 'center',
                gap: '6px'
              }}
            >
              <FiUpload /> Choose File
            </button>
          </div>
        </div>
      </div>

      {uploadedFile && (
        <div style={{
          padding: '12px',
          background: '#e8f5e9',
          borderRadius: '6px',
          marginBottom: '16px',
          display: 'flex',
          justifyContent: 'space-between',
          alignItems: 'center'
        }}>
          <span>{uploadedFile.name}</span>
          <button 
            onClick={handleUpload}
            style={{
              padding: '6px 12px',
              background: '#2e7d32',
              color: 'white',
              border: 'none',
              borderRadius: '4px',
              cursor: 'pointer'
            }}
          >
            Upload
          </button>
        </div>
      )}

      {loading ? (
        <p>Loading reports...</p>
      ) : reports.length === 0 ? (
        <p style={{ textAlign: 'center', color: '#666', marginTop: '32px' }}>No reports uploaded yet</p>
      ) : (
        <>
          {viewFormat === 'cards' ? (
            <div style={{
              display: 'grid',
              gridTemplateColumns: 'repeat(auto-fill, minmax(250px, 1fr))',
              gap: '16px'
            }}>
              {reports
  .filter(report => report.status !== 'deleted')
  .map(report => (
                <div key={report.id} style={{
                  padding: '16px',
                  border: '1px solid #e0e0e0',
                  borderRadius: '8px',
                  background: '#fafafa'
                }}>
                  <h4>{report.file_name}</h4>
                  <p style={{ fontSize: '12px', color: '#666', marginTop: '8px' }}>
                    Format: <strong>{report.file_format?.toUpperCase()}</strong>
                  </p>
                  <p style={{ fontSize: '12px', color: '#666' }}>
                    {new Date(report.created_at).toLocaleDateString()}
                  </p>
                  <div style={{ display: 'flex', gap: '8px', marginTop: '12px' }}>
                    <button
                      onClick={async () => {
                        const url = `${process.env.REACT_APP_API_URL || 'http://localhost:5000'}/api/uploads/download/${report.id}`;
                        const response = await fetch(url, {
                          headers: { 'Authorization': `Bearer ${user.token}` }
                        });
                        if (!response.ok) {
                          alert('Failed to download file');
                          return;
                        }
                        const blob = await response.blob();
                        const a = document.createElement('a');
                        a.href = window.URL.createObjectURL(blob);
                        a.download = report.file_name;
                        document.body.appendChild(a);
                        a.click();
                        window.URL.revokeObjectURL(a.href);
                        document.body.removeChild(a);
                      }}
                      style={{
                        padding: '6px 12px',
                        background: '#1976d2',
                        color: 'white',
                        border: 'none',
                        borderRadius: '4px',
                        cursor: 'pointer',
                        flex: 1,
                        display: 'flex',
                        alignItems: 'center',
                        justifyContent: 'center',
                        gap: '4px'
                      }}
                    >
                      <FiDownload /> Download
                    </button>
                    <button 
                      onClick={() => handleDeleteClick(report)}
                      style={{
                        padding: '6px 12px',
                        background: '#d32f2f',
                        color: 'white',
                        border: 'none',
                        borderRadius: '4px',
                        cursor: 'pointer'
                      }}
                    >
                      <FiTrash2 />
                    </button>
                  </div>
                </div>
              ))}
            </div>
          ) : (
            <table style={{
              width: '100%',
              borderCollapse: 'collapse',
              marginTop: '16px'
            }}>
              <thead>
                <tr style={{ background: '#f5f5f5', borderBottom: '2px solid #ddd' }}>
                  <th style={{ padding: '12px', textAlign: 'left' }}>File Name</th>
                  <th style={{ padding: '12px', textAlign: 'left' }}>Format</th>
                  <th style={{ padding: '12px', textAlign: 'left' }}>Date</th>
                  <th style={{ padding: '12px', textAlign: 'center' }}>Actions</th>
                </tr>
              </thead>
              <tbody>
               {reports
  .filter(report => report.status !== 'deleted')
  .map(report => ( 
                  <tr key={report.id} style={{ borderBottom: '1px solid #eee' }}>
                    <td style={{ padding: '12px' }}>{report.file_name}</td>
                    <td style={{ padding: '12px' }}>{report.file_format?.toUpperCase()}</td>
                    <td style={{ padding: '12px' }}>{new Date(report.created_at).toLocaleDateString()}</td>
                    <td style={{ padding: '12px', textAlign: 'center' }}>
                      <button
                        onClick={async () => {
                          const url = `${process.env.REACT_APP_API_URL || 'http://localhost:5000'}/api/uploads/download/${report.id}`;
                          const response = await fetch(url, {
                            headers: { 'Authorization': `Bearer ${user.token}` }
                          });
                          if (!response.ok) {
                            alert('Failed to download file');
                            return;
                          }
                          const blob = await response.blob();
                          const a = document.createElement('a');
                          a.href = window.URL.createObjectURL(blob);
                          a.download = report.file_name;
                          document.body.appendChild(a);
                          a.click();
                          window.URL.revokeObjectURL(a.href);
                          document.body.removeChild(a);
                        }}
                        style={{
                          padding: '6px 12px',
                          background: '#1976d2',
                          color: 'white',
                          border: 'none',
                          borderRadius: '4px',
                          cursor: 'pointer',
                          marginRight: '8px'
                        }}
                      >
                        <FiDownload />
                      </button>
                      <button 
                        onClick={() => handleDeleteClick(report)}
                        style={{
                          padding: '6px 12px',
                          background: '#d32f2f',
                          color: 'white',
                          border: 'none',
                          borderRadius: '4px',
                          cursor: 'pointer'
                        }}
                      >
                        <FiTrash2 />
                      </button>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          )}
        </>
      )}

      {showDeleteReasonModal && (
        <div style={{
          position: 'fixed',
          top: 0,
          left: 0,
          right: 0,
          bottom: 0,
          background: 'rgba(0,0,0,0.5)',
          display: 'flex',
          alignItems: 'center',
          justifyContent: 'center',
          zIndex: 1000
        }}>
          <div style={{
            background: 'white',
            padding: '24px',
            borderRadius: '8px',
            minWidth: '400px',
            boxShadow: '0 2px 16px rgba(0,0,0,0.2)'
          }}>
            <h3>Delete Report</h3>
            <p>Please provide a reason for deleting this report:</p>
            <textarea
              value={deleteReason}
              onChange={(e) => setDeleteReason(e.target.value)}
              placeholder="Enter reason..."
              style={{
                width: '100%',
                minHeight: '100px',
                padding: '8px',
                borderRadius: '4px',
                border: '1px solid #ccc',
                marginBottom: '16px',
                fontFamily: 'Arial, sans-serif'
              }}
            />
            <div style={{ display: 'flex', gap: '12px', justifyContent: 'flex-end' }}>
              <button
                onClick={() => {
                  setShowDeleteReasonModal(false);
                  setDeleteReason('');
                  setSelectedReportToDelete(null);
                }}
                style={{
                  padding: '8px 16px',
                  background: '#ccc',
                  border: 'none',
                  borderRadius: '4px',
                  cursor: 'pointer'
                }}
              >
                Cancel
              </button>
              <button
                onClick={handleConfirmDelete}
                style={{
                  padding: '8px 16px',
                  background: '#d32f2f',
                  color: 'white',
                  border: 'none',
                  borderRadius: '4px',
                  cursor: 'pointer'
                }}
              >
                Delete
              </button>
            </div>
          </div>
        </div>
      )}
    </div>
  );
};

export default Reports;
