import React, { useState, useEffect } from 'react';
import Header from '../components/Header';
import { FiDownload, FiUpload, FiRefreshCw, FiTrash2, FiFileText } from 'react-icons/fi';
import './FlagshipProgrammes.css';
import {
  getFlagshipProgrammes,
  getFlagshipProgrammesByDepartment,
  uploadFlagshipData,
  getImportHistory,
  deleteFlagshipProgramme,
  exportFlagshipProgrammesCSV
} from '../services/api';
import * as XLSX from 'xlsx';

const FlagshipProgrammes = () => {
  const [programmes, setProgrammes] = useState([]);
  const [reports, setReports] = useState([]);
  const [loading, setLoading] = useState(true);
  const [activeTab, setActiveTab] = useState('programmes'); // 'programmes' or 'reports'
  const [importHistory, setImportHistory] = useState([]);
  const [selectedDepartment, setSelectedDepartment] = useState('');
  const [fileData, setFileData] = useState(null);
  const [importType, setImportType] = useState('programme');
  const [departmentInput, setDepartmentInput] = useState('');
  const [uploading, setUploading] = useState(false);
  const [currentPage, setCurrentPage] = useState(0);
  const pageSize = 10;

  const user = JSON.parse(localStorage.getItem('user') || '{}');
  const isSuperAdmin = user.role === 'superadmin';

  // Fetch programmes on mount and when filters change
  useEffect(() => {
    fetchProgrammes();
  }, [selectedDepartment]);

  const fetchProgrammes = async () => {
    try {
      setLoading(true);
      const params = selectedDepartment ? { department: selectedDepartment } : {};
      const response = await getFlagshipProgrammes(params);
      
      // Separate programmes and reports
      const progs = response.data.filter(item => !item.report_date) || [];
      const reps = response.data.filter(item => item.report_date) || [];
      
      setProgrammes(progs);
      setReports(reps);
      
      if (isSuperAdmin) {
        fetchImportHistory();
      }
    } catch (error) {
      console.error('Error fetching programmes:', error);
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

  const handleFileUpload = async (event) => {
    try {
      const file = event.target.files[0];
      if (!file) return;

      setUploading(true);
      
      // Parse Excel file
      const reader = new FileReader();
      reader.onload = async (e) => {
        try {
          const workbook = XLSX.read(e.target.result, { type: 'array' });
          const sheetName = workbook.SheetNames[0];
          const worksheet = workbook.Sheets[sheetName];
          const data = XLSX.utils.sheet_to_json(worksheet);

          if (data.length === 0) {
            alert('No data found in the Excel file');
            setUploading(false);
            return;
          }

          // Upload data
          const response = await uploadFlagshipData({
            file_data: data,
            file_name: file.name,
            import_type: importType,
            department_name: departmentInput || 'General'
          });

          if (response.data.success) {
            alert(`Successfully imported ${response.data.successful} records`);
            setFileData(null);
            setDepartmentInput('');
            fetchProgrammes();
          }
        } catch (error) {
          console.error('Error processing file:', error);
          alert('Error processing file: ' + error.message);
        } finally {
          setUploading(false);
        }
      };
      
      reader.readAsArrayBuffer(file);
    } catch (error) {
      console.error('Error uploading file:', error);
      alert('Error uploading file');
      setUploading(false);
    }
  };

  const handleDelete = async (id) => {
    if (window.confirm('Are you sure you want to delete this item?')) {
      try {
        await deleteFlagshipProgramme(id);
        fetchProgrammes();
      } catch (error) {
        alert('Error deleting item: ' + error.message);
      }
    }
  };

  const handleExport = async () => {
    try {
      const response = await exportFlagshipProgrammesCSV(selectedDepartment);
      const url = window.URL.createObjectURL(new Blob([response.data]));
      const link = document.createElement('a');
      link.href = url;
      link.setAttribute('download', `flagship_${importType}s_${Date.now()}.csv`);
      document.body.appendChild(link);
      link.click();
      link.remove();
    } catch (error) {
      alert('Error exporting data');
    }
  };

  const displayData = activeTab === 'programmes' ? programmes : reports;
  const paginatedData = displayData.slice(currentPage * pageSize, (currentPage + 1) * pageSize);
  const totalPages = Math.ceil(displayData.length / pageSize);

  return (
    <div className="page-container">
      <Header />
      <h4 className="fp-title">Department-wise Flagship Programmes & Reports</h4>
      <div className="fp-content">
        

        {/* Tabs */}
        <div className="fp-tabs">
          <button
            onClick={() => { setActiveTab('programmes'); setCurrentPage(0); }}
            className={`fp-tab ${activeTab === 'programmes' ? 'active' : ''}`}
          >
            <FiFileText style={{ marginRight: '5px' }} /> Flagship Programmes ({programmes.length})
          </button>
          <button
            onClick={() => { setActiveTab('reports'); setCurrentPage(0); }}
            className={`fp-tab ${activeTab === 'reports' ? 'active' : ''}`}
          >
            <FiFileText style={{ marginRight: '5px' }} /> Reports ({reports.length})
          </button>
        </div>

        {/* Controls */}
        <div className="fp-controls">
          <select
            value={selectedDepartment}
            onChange={(e) => { setSelectedDepartment(e.target.value); setCurrentPage(0); }}
            className="fp-select"
          >
            <option value="">All Departments</option>
            <option value="Agriculture">Agriculture</option>
            <option value="Horticulture">Horticulture</option>
            <option value="Animal Husbandry">Animal Husbandry</option>
            <option value="Fisheries">Fisheries</option>
          </select>

          {isSuperAdmin && (
            <>
              <div className="fp-admin-actions">
                <button
                  onClick={handleExport}
                  className="fp-btn fp-export"
                >
                  <FiDownload /> Export CSV
                </button>
                <label className="fp-btn fp-upload">
                  <FiUpload /> Upload Excel
                  <input
                    type="file"
                    accept=".xlsx,.xls,.csv"
                    onChange={handleFileUpload}
                    className="fp-file-input"
                    disabled={uploading}
                  />
                </label>
              </div>
            </>
          )}
        </div>

        {/* Upload Form */}
        {isSuperAdmin && (
          <div className="fp-upload-card">
            <h3>Upload New Data</h3>
            <div className="fp-upload-grid">
              <select
                value={importType}
                onChange={(e) => setImportType(e.target.value)}
                className="fp-input"
              >
                <option value="programme">Flagship Programme</option>
                <option value="report">Report</option>
              </select>
              <input
                type="text"
                placeholder="Department Name (optional)"
                value={departmentInput}
                onChange={(e) => setDepartmentInput(e.target.value)}
                className="fp-input"
              />
              <label className={`fp-upload-label ${uploading ? 'disabled' : ''}`}>
                {uploading ? 'Uploading...' : 'Select Excel File'}
                <input
                  type="file"
                  accept=".xlsx,.xls,.csv"
                  onChange={handleFileUpload}
                  className="fp-file-input"
                  disabled={uploading}
                />
              </label>
            </div>
          </div>
        )}

        {/* Data Table */}
        {loading ? (
          <div className="fp-loading">
            <div className="spinner"></div>
          </div>
        ) : paginatedData.length === 0 ? (
          <div className="fp-empty">
            No {activeTab} found
          </div>
        ) : (
          <div className="table-wrapper">
            <table className="fp-table">
              <thead>
                <tr className="fp-thead-row">
                  <th className="fp-th">Department</th>
                  <th className="fp-th">
                    {activeTab === 'programmes' ? 'Programme Name' : 'Report Name'}
                  </th>
                  {activeTab === 'reports' && (
                    <th className="fp-th">Date</th>
                  )}
                  <th className="fp-th">Data Preview</th>
                  <th className="fp-th fp-th-center">Actions</th>
                </tr>
              </thead>
              <tbody>
                {paginatedData.map((item, idx) => (
                  <tr key={item.id} className="fp-row">
                    <td className="fp-td">{item.department_name || '-'}</td>
                    <td className="fp-td fp-td-strong">
                      {item.programme_name || item.report_name || '-'}
                    </td>
                    {activeTab === 'reports' && (
                      <td className="fp-td">
                        {item.report_date ? new Date(item.report_date).toLocaleDateString('en-IN') : '-'}
                      </td>
                    )}
                    <td className="fp-td fp-preview-cell">
                      {typeof item.data === 'string' ? item.data : JSON.stringify(item.data).substring(0, 100)}...
                    </td>
                    <td className="fp-td fp-td-center">
                      {isSuperAdmin && (
                        <button
                          onClick={() => handleDelete(item.id)}
                          className="fp-delete-btn"
                        >
                          <FiTrash2 size={14} /> Delete
                        </button>
                      )}
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        )}

        {/* Pagination */}
        {totalPages > 1 && (
          <div className="fp-pagination">
            <button
              onClick={() => setCurrentPage(Math.max(0, currentPage - 1))}
              disabled={currentPage === 0}
              className={`fp-page-btn ${currentPage === 0 ? 'disabled' : ''}`}
            >
              Previous
            </button>
            <span className="fp-page-info">
              Page {currentPage + 1} of {totalPages}
            </span>
            <button
              onClick={() => setCurrentPage(Math.min(totalPages - 1, currentPage + 1))}
              disabled={currentPage === totalPages - 1}
              className={`fp-page-btn ${currentPage === totalPages - 1 ? 'disabled' : ''}`}
            >
              Next
            </button>
          </div>
        )}

        {/* Import History */}
        {isSuperAdmin && importHistory.length > 0 && (
          <div className="fp-history">
            <h2>Import History</h2>
            <div className="table-wrapper">
              <table className="fp-table">
                <thead>
                  <tr className="fp-thead-row">
                    <th className="fp-th">File Name</th>
                    <th className="fp-th">Type</th>
                    <th className="fp-th fp-th-center">Total</th>
                    <th className="fp-th fp-th-center">Success</th>
                    <th className="fp-th fp-th-center">Failed</th>
                    <th className="fp-th">Status</th>
                    <th className="fp-th">Date</th>
                  </tr>
                </thead>
                <tbody>
                  {importHistory.slice(0, 10).map((record, idx) => (
                    <tr key={idx} className="fp-row">
                      <td className="fp-td">{record.file_name || '-'}</td>
                      <td className="fp-td">{record.import_type || '-'}</td>
                      <td className="fp-td fp-td-center">{record.total_records || 0}</td>
                      <td className="fp-td fp-td-center fp-success-text">
                        {record.successful_records || 0}
                      </td>
                      <td className="fp-td fp-td-center fp-error-text">
                        {record.failed_records || 0}
                      </td>
                      <td className="fp-td">
                        <span className={`fp-status ${record.status === 'completed' ? 'completed' : 'pending'}`}>
                          {record.status}
                        </span>
                      </td>
                      <td className="fp-td fp-td-small">
                        {new Date(record.created_at).toLocaleDateString('en-IN')}
                      </td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
          </div>
        )}
      </div>
    </div>
  );
};

export default FlagshipProgrammes;
