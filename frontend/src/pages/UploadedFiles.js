import React, { useState, useEffect } from 'react';
import { FiDownload, FiTrash2, FiEye, FiGrid, FiList } from 'react-icons/fi';
import appConfig from '../config/appConfig';
import './UploadedFiles.css';

const UploadedFiles = () => {
  const [files, setFiles] = useState([]);
  const [loading, setLoading] = useState(false);
  const [viewFormat, setViewFormat] = useState('cards');
  const [filterType, setFilterType] = useState('report');
  const [selectedFile, setSelectedFile] = useState(null);
  const [showDetails, setShowDetails] = useState(false);
  const [showViewModal, setShowViewModal] = useState(false);

  const user = JSON.parse(localStorage.getItem('user') || '{}');
  const isAdmin = user.role === 'admin' || user.role === 'superadmin';

  useEffect(() => {
    if (isAdmin) {
      fetchFiles();
    }
  }, [filterType, isAdmin]);

  const fetchFiles = async () => {
    try {
      setLoading(true);
      const response = await fetch(`${appConfig.apiBaseUrl}/uploads/all-files?type=${filterType}`, {
        headers: {
          'Authorization': `Bearer ${user.token}`
        }
      });
      if (response.ok) {
        const data = await response.json();
        setFiles(Array.isArray(data) ? data : []);
      }
    } catch (err) {
      console.error('Error fetching files:', err);
    } finally {
      setLoading(false);
    }
  };

  const handleDownload = async (fileId) => {
    try {
      const response = await fetch(`${appConfig.apiBaseUrl}/uploads/download/${fileId}`, {
        headers: {
          'Authorization': `Bearer ${user.token}`
        }
      });
      if (response.ok) {
        const blob = await response.blob();
        const url = window.URL.createObjectURL(blob);
        const a = document.createElement('a');
        a.href = url;
        a.download = files.find(f => f.id === fileId)?.file_name || 'download';
        document.body.appendChild(a);
        a.click();
        window.URL.revokeObjectURL(url);
        document.body.removeChild(a);
      }
    } catch (err) {
      console.error('Error downloading file:', err);
      alert('Failed to download file');
    }
  };

  return (
    <div className="uploaded-files-container">
      <div className="uploaded-files-header">
        <h2>Uploaded Files</h2>
        <div className="file-controls">
          <select
            value={filterType}
            onChange={(e) => {
              setFilterType(e.target.value);
              setViewFormat('cards');
            }}
            style={{
              padding: '8px 12px',
              borderRadius: '6px',
              border: '1px solid #ccc',
              marginRight: '10px'
            }}
          >
            <option value="report">Reports (HOD Uploads)</option>
            <option value="flagship_program">Flagship Programs</option>
            <option value="budget">Budget</option>
          </select>
          <button
            onClick={() => setViewFormat(viewFormat === 'cards' ? 'list' : 'cards')}
            style={{
              padding: '8px 12px',
              background: '#1976d2',
              color: 'white',
              border: 'none',
              borderRadius: '6px',
              cursor: 'pointer',
              display: 'flex',
              alignItems: 'center',
              gap: '6px'
            }}
          >
            {viewFormat === 'cards' ? <FiList /> : <FiGrid />}
          </button>
        </div>
      </div>

      {loading ? (
        <p style={{ textAlign: 'center', padding: '20px' }}>Loading files...</p>
      ) : files.length === 0 ? (
        <p style={{ textAlign: 'center', padding: '20px', color: '#666' }}>No files found</p>
      ) : (
        <>
          {viewFormat === 'cards' ? (
            <div className="files-grid">
              {files.map(file => (
                <div key={file.id} className="file-card">
                  <h4>{file.file_name}</h4>
                  <div className="file-info">
                    <p><strong>HOD:</strong> {file.hod_name || 'N/A'}</p>
                    <p><strong>Department:</strong> {file.department || 'N/A'}</p>
                    <p><strong>Format:</strong> {file.file_format?.toUpperCase()}</p>
                    <p><strong>Date:</strong> {new Date(file.created_at).toLocaleDateString()}</p>
                  </div>
                  <div className="file-actions">
                    <button
                      onClick={() => {
                        setSelectedFile(file);
                        setShowViewModal(true);
                      }}
                      style={{
                        padding: '6px 12px',
                        background: '#1976d2',
                        color: 'white',
                        border: 'none',
                        borderRadius: '4px',
                        cursor: 'pointer',
                        display: 'flex',
                        alignItems: 'center',
                        justifyContent: 'center',
                        gap: '4px',
                        flex: 1
                      }}
                    >
                      <FiEye /> View
                    </button>
                  </div>
                </div>
              ))}
            </div>
          ) : (
            <table className="files-table">
              <thead>
                <tr>
                  <th>File Name</th>
                  <th>HOD Name</th>
                  <th>Department</th>
                  <th>Format</th>
                  <th>Date Uploaded</th>
                  <th>Actions</th>
                </tr>
              </thead>
              <tbody>
                {files.map(file => (
                  <tr key={file.id}>
                    <td>{file.file_name}</td>
                    <td>{file.hod_name || 'N/A'}</td>
                    <td>{file.department || 'N/A'}</td>
                    <td>{file.file_format?.toUpperCase()}</td>
                    <td>{new Date(file.created_at).toLocaleDateString()}</td>
                    <td>
                      <button
                        onClick={() => {
                          setSelectedFile(file);
                          setShowViewModal(true);
                        }}
                        style={{
                          padding: '4px 8px',
                          background: '#1976d2',
                          color: 'white',
                          border: 'none',
                          borderRadius: '4px',
                          cursor: 'pointer'
                        }}
                      >
                        <FiEye />
                      </button>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          )}
        </>
      )}

      {showViewModal && selectedFile && (
        <div className="modal-overlay" onClick={() => setShowViewModal(false)}>
          <div className="modal-content" onClick={(e) => e.stopPropagation()}>
            <h3>File: {selectedFile.file_name}</h3>
            <div className="modal-body" style={{ padding: '20px', background: '#f9f9f9', borderRadius: '6px', marginBottom: '16px', minHeight: '150px' }}>
              <p><strong>File Name:</strong> {selectedFile.file_name}</p>
              <p><strong>HOD Name:</strong> {selectedFile.hod_name || 'N/A'}</p>
              <p><strong>Department:</strong> {selectedFile.department || 'N/A'}</p>
              <p><strong>File Format:</strong> {selectedFile.file_format?.toUpperCase()}</p>
              <p><strong>Upload Type:</strong> {selectedFile.upload_type?.replace(/_/g, ' ')}</p>
              <p><strong>Status:</strong> {selectedFile.status ? (selectedFile.status.toLowerCase() === 'active' ? 'Active' : 'Deleted') : 'Active'}</p>
              <p><strong>Date Uploaded:</strong> {new Date(selectedFile.created_at).toLocaleString()}</p>
            </div>
            <div className="modal-actions" style={{ display: 'flex', gap: '10px', justifyContent: 'flex-end' }}>
              <button
                onClick={() => {
                  if (selectedFile.status && selectedFile.status.toLowerCase() !== 'active') {
                    alert('This file has been deleted and is not available for download.');
                    return;
                  }
                  handleDownload(selectedFile.id);
                }}
                style={{
                  padding: '8px 16px',
                  background: (selectedFile.status && selectedFile.status.toLowerCase() !== 'active') ? '#999' : '#388e3c',
                  color: 'white',
                  border: 'none',
                  borderRadius: '4px',
                  cursor: (selectedFile.status && selectedFile.status.toLowerCase() !== 'active') ? 'not-allowed' : 'pointer',
                  display: 'flex',
                  alignItems: 'center',
                  gap: '6px'
                }}
                disabled={selectedFile.status && selectedFile.status.toLowerCase() !== 'active'}
              >
                <FiDownload /> Download
              </button>
              <button
                onClick={() => setShowViewModal(false)}
                style={{
                  padding: '8px 16px',
                  background: '#ccc',
                  border: 'none',
                  borderRadius: '4px',
                  cursor: 'pointer'
                }}
              >
                Close
              </button>
            </div>
          </div>
        </div>
      )}
    </div>
  );
};

export default UploadedFiles;
