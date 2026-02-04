import React, { useState, useEffect, useRef } from 'react';
import Header from '../components/Header';
import { FiDownload, FiUpload, FiRefreshCw, FiTrash2, FiFileText, FiList, FiGrid, FiEye } from 'react-icons/fi';
import {
  uploadFlagshipData,
  getImportHistory,
  deleteFlagshipProgramme,
  exportFlagshipProgrammesCSV
} from '../services/api';
import appConfig from '../config/appConfig';
import * as XLSX from 'xlsx';
import api from '../services/api';

const FlagshipProgrammes = () => {
  const fileInputRef = useRef(null);
  const [flagshipUploads, setFlagshipUploads] = useState([]);
  const [viewFormat, setViewFormat] = useState('cards'); // 'cards' or 'list'
  const [loading, setLoading] = useState(true);
  const [activeTab, setActiveTab] = useState('programmes'); // 'programmes' or 'reports'
  const [importHistory, setImportHistory] = useState([]);
  const [selectedDepartment, setSelectedDepartment] = useState('');
  const [fileData, setFileData] = useState(null);
  const [importType, setImportType] = useState('programme');
  const [departmentInput, setDepartmentInput] = useState('');
  const [uploading, setUploading] = useState(false);
  const [currentPage, setCurrentPage] = useState(0);
  const [uploadedFile, setUploadedFile] = useState(null);
  const [selectedExportFormat, setSelectedExportFormat] = useState('csv');
  const [exporting, setExporting] = useState(false);
  const [showExportOptions, setShowExportOptions] = useState(false);
  const pageSize = 10;

  const user = JSON.parse(localStorage.getItem('user') || '{}');
  const isSuperAdmin = user.role === 'superadmin';
  const isHOD = user.role === 'hod';
  const userHodId = user.hod_id;

  // Fetch programmes on mount and when filters change
  useEffect(() => {
    fetchFlagshipUploads();
  }, [selectedDepartment]);

  const fetchFlagshipUploads = async () => {
    try {
      setLoading(true);
      // Use uploads API for all flagship uploads
      const token = JSON.parse(localStorage.getItem('user') || '{}').token;
      let url = `${appConfig.apiBaseUrl}/uploads/flagship-programs`;
      if (!isHOD && selectedDepartment) {
        url += `?department=${encodeURIComponent(selectedDepartment)}`;
      }
      const res = await fetch(url, {
        headers: { Authorization: `Bearer ${token}` }
      });
      const data = await res.json();
      setFlagshipUploads(Array.isArray(data) ? data : []);
      if (isSuperAdmin) fetchImportHistory();
    } catch (error) {
      console.error('Error fetching flagship uploads:', error);
    } finally {
      setLoading(false);
    }
  };

  const fetchImportHistory = async () => {
    try {
      const response = await getImportHistory();
      setImportHistory(response.data || []);
    } catch (error) {
      console.error('Error fetching import history:', error);
    }
  };

  const handleFileSelect = (e) => {
    if (e.target.files.length > 0) {
      setUploadedFile(e.target.files[0]);
    }
  };

  const handleFileUpload = async () => {
    if (!uploadedFile) return;

    try {
      setUploading(true);

      // If HOD: send raw file to uploads endpoint (accept any file type)
      if (isHOD) {
        try {
          const formData = new FormData();
          formData.append('file', uploadedFile);
          formData.append('fileFormat', (uploadedFile.name.split('.').pop() || '').toLowerCase());
          // mark this upload as a flagship_program when uploading from this page
          formData.append('upload_type', 'flagship_program');

          // Use axios instance with correct baseURL and auth interceptor
          const res = await api.post('/uploads/flagship-program', formData, {
            headers: { 'Content-Type': 'multipart/form-data' }
          });

          if (res && res.data) {
            alert(res.data.message || 'File uploaded successfully');
          } else {
            alert('File uploaded (no response body)');
          }

          setUploadedFile(null);
          setDepartmentInput('');
          if (fileInputRef.current) fileInputRef.current.value = '';
          fetchFlagshipUploads();
        } catch (err) {
          console.error('HOD upload error:', err);
          const msg = err.response && err.response.data && err.response.data.error
            ? err.response.data.error
            : err.message || 'Upload failed';
          alert('Error uploading file: ' + msg);
        } finally {
          setUploading(false);
        }
        return;
      }

      // Superadmin path: parse Excel/CSV and import via existing endpoint
      const reader = new FileReader();
      reader.onload = async (e) => {
        try {
          const workbook = XLSX.read(e.target.result, { type: 'array' });
          const sheetName = workbook.SheetNames[0];
          const worksheet = workbook.Sheets[sheetName];
          const data = XLSX.utils.sheet_to_json(worksheet);

          if (data.length === 0) {
            alert('No data found in the file');
            setUploading(false);
            return;
          }

          const response = await uploadFlagshipData({
            file_data: data,
            file_name: uploadedFile.name,
            import_type: importType,
            department_name: departmentInput || 'General'
          });

          if (response.data.success) {
            alert(`Successfully imported ${response.data.successful} records`);
            setUploadedFile(null);
            setDepartmentInput('');
            if (fileInputRef.current) fileInputRef.current.value = '';
            fetchFlagshipUploads();
          }
        } catch (error) {
          console.error('Error processing file:', error);
          alert('Error processing file: ' + error.message);
        } finally {
          setUploading(false);
        }
      };

      reader.readAsArrayBuffer(uploadedFile);
    } catch (error) {
      console.error('Error uploading file:', error);
      alert('Error uploading file');
      setUploading(false);
    }
  };

  const [showDeleteReasonModal, setShowDeleteReasonModal] = useState(false);
  const [deleteReason, setDeleteReason] = useState('');
  const [selectedToDelete, setSelectedToDelete] = useState(null);

  const handleDelete = (item) => {
    setSelectedToDelete(item);
    setShowDeleteReasonModal(true);
  };

  const handleConfirmDelete = async () => {
    if (!deleteReason.trim()) {
      alert('Please provide a reason for deletion');
      return;
    }
    try {
      await deleteFlagshipProgramme(selectedToDelete.id, { reason: deleteReason });
      setShowDeleteReasonModal(false);
      setDeleteReason('');
      setSelectedToDelete(null);
      fetchFlagshipUploads();
    } catch (error) {
      alert('Error deleting item: ' + (error.message || 'Unknown error'));
    }
  };

  const handleExport = async () => {
    try {
      setExporting(true);
      const response = await exportFlagshipProgrammesCSV(selectedDepartment);
      
      let content = response.data;
      let filename = `flagship_${importType}s_${Date.now()}`;
      let contentType = 'text/csv';

      if (selectedExportFormat === 'xlsx') {
        // Convert CSV to XLSX
        const lines = content.split('\n');
        const data = lines.map(line => line.split(','));
        const ws = XLSX.utils.aoa_to_sheet(data);
        const wb = XLSX.utils.book_new();
        XLSX.utils.book_append_sheet(wb, ws, 'Data');
        XLSX.writeFile(wb, `${filename}.xlsx`);
        setExporting(false);
        return;
      } else if (selectedExportFormat === 'docx') {
        contentType = 'application/vnd.openxmlformats-officedocument.wordprocessingml.document';
        filename += '.docx';
      } else {
        filename += '.csv';
      }

      const url = window.URL.createObjectURL(new Blob([content]));
      const link = document.createElement('a');
      link.href = url;
      link.setAttribute('download', filename);
      document.body.appendChild(link);
      link.click();
      link.remove();
    } catch (error) {
      alert('Error exporting data');
    } finally {
      setExporting(false);
    }
  };

  // Only show active files
  const displayData = flagshipUploads.filter(f => f.status !== 'deleted');
  const paginatedData = displayData.slice(currentPage * pageSize, (currentPage + 1) * pageSize);
  const totalPages = Math.ceil(displayData.length / pageSize);


  return (
    <>
      {/* Controls and View Toggle */}
      <div className="reports-header">
        <h2>Flagship Programmes</h2>
        <div className="reports-actions">
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
            onClick={handleFileUpload}
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
        <p>Loading flagship programmes...</p>
      ) : displayData.length === 0 ? (
        <p style={{ textAlign: 'center', color: '#666', marginTop: '32px' }}>No flagship programmes uploaded yet</p>
      ) : (
        <>
          {viewFormat === 'cards' ? (
            <div style={{
              display: 'grid',
              gridTemplateColumns: 'repeat(auto-fill, minmax(250px, 1fr))',
              gap: '16px'
            }}>
              {displayData.map(item => (
                <div key={item.id} style={{
                  padding: '16px',
                  border: '1px solid #e0e0e0',
                  borderRadius: '8px',
                  background: '#fafafa'
                }}>
                  <h4>{item.file_name}</h4>
                  <p style={{ fontSize: '12px', color: '#666', marginTop: '8px' }}>
                    Format: <strong>{item.file_format?.toUpperCase()}</strong>
                  </p>
                  <p style={{ fontSize: '12px', color: '#666' }}>
                    {new Date(item.created_at).toLocaleDateString()}
                  </p>
                  <div style={{ display: 'flex', gap: '8px', marginTop: '12px' }}>
                    <button
                      onClick={async () => {
                        const url = `${appConfig.apiBaseUrl}/uploads/download/${item.id}`;
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
                        a.download = item.file_name;
                        document.body.appendChild(a);
                        a.click();
                        window.URL.revokeObjectURL(a.href);
                        document.body.removeChild(a);
                      }}
                      style={{
                        padding: '6px 12px',
                        background: '#388e3c',
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
                      onClick={() => handleDelete(item)}
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
                {displayData.map(item => (
                  <tr key={item.id} style={{ borderBottom: '1px solid #eee' }}>
                    <td style={{ padding: '12px' }}>{item.file_name}</td>
                    <td style={{ padding: '12px' }}>{item.file_format?.toUpperCase()}</td>
                    <td style={{ padding: '12px' }}>{new Date(item.created_at).toLocaleDateString()}</td>
                    <td style={{ padding: '12px', textAlign: 'center' }}>
                      <button
                        onClick={async () => {
                          const url = `${appConfig.apiBaseUrl}/uploads/download/${item.id}`;
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
                          a.download = item.file_name;
                          document.body.appendChild(a);
                          a.click();
                          window.URL.revokeObjectURL(a.href);
                          document.body.removeChild(a);
                        }}
                        style={{
                          padding: '6px 12px',
                          background: '#388e3c',
                          color: 'white',
                          border: 'none',
                          borderRadius: '4px',
                          cursor: 'pointer',
                          marginRight: '8px'
                        }}
                      >
                        <FiDownload /> Download
                      </button>
                      <button
                        onClick={() => handleDelete(item)}
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

      {/* Delete Reason Modal (moved outside table/card map) */}
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
            <h3>Delete File</h3>
            <p>Please provide a reason for deleting this file:</p>
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
                  setSelectedToDelete(null);
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
    </>
  );
}

export default FlagshipProgrammes;
