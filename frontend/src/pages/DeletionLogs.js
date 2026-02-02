import React, { useState, useEffect } from 'react';
import { useLocation } from 'react-router-dom';
import appConfig from '../config/appConfig';
import './DeletionLogs.css';

const DeletionLogs = () => {
  const [logs, setLogs] = useState([]);
  const [loading, setLoading] = useState(false);
  const location = useLocation();
  const q = new URLSearchParams(location.search);
  const initialType = q.get('type') || 'all';
  const [filterType, setFilterType] = useState(initialType);
  const [selectedLog, setSelectedLog] = useState(null);
  const [showDetails, setShowDetails] = useState(false);

  const user = JSON.parse(localStorage.getItem('user') || '{}');
  const isAdmin = user.role === 'admin' || user.role === 'superadmin';

  useEffect(() => {
    if (isAdmin) {
      fetchLogs();
    }
  }, [isAdmin, filterType]);

  const fetchLogs = async () => {
    try {
      setLoading(true);
      const type = filterType && filterType !== 'all' ? `?type=${encodeURIComponent(filterType)}` : '';
      const response = await fetch(`${appConfig.apiBaseUrl}/uploads/deletion-logs${type}`, {
        headers: {
          'Authorization': `Bearer ${user.token}`
        }
      });
      if (response.ok) {
        const data = await response.json();
        setLogs(Array.isArray(data) ? data : []);
      }
    } catch (err) {
      console.error('Error fetching deletion logs:', err);
    } finally {
      setLoading(false);
    }
  };

  const filteredLogs = filterType === 'all' 
    ? logs 
    : logs.filter(log => log.upload_type === filterType);

  const handleViewDetails = (log) => {
    setSelectedLog(log);
    setShowDetails(true);
  };

  return (
    <div className="deletion-logs-container">
      <div className="deletion-logs-header">
        <h2>File Deletion Logs</h2>
        <select
          value={filterType}
          onChange={(e) => setFilterType(e.target.value)}
          style={{
            padding: '8px 12px',
            borderRadius: '6px',
            border: '1px solid #ccc'
          }}
        >
          <option value="all">All Types</option>
          <option value="report">Reports</option>
          <option value="flagship_program">Flagship Programs</option>
          <option value="budget">Budget</option>
        </select>
      </div>

      {loading ? (
        <p style={{ textAlign: 'center', padding: '20px' }}>Loading logs...</p>
      ) : filteredLogs.length === 0 ? (
        <p style={{ textAlign: 'center', padding: '20px', color: '#666' }}>No deletion logs found</p>
      ) : (
        <table className="logs-table">
          <thead>
            <tr>
              <th>File Name</th>
              <th>HOD Name</th>
              <th>Department</th>
              <th>Type</th>
              <th>Deleted By</th>
              <th>Deletion Date</th>
              <th>Action</th>
            </tr>
          </thead>
          <tbody>
            {filteredLogs.map((log, index) => (
              <tr key={index}>
                <td>{log.file_name || 'N/A'}</td>
                <td>{log.hod_name || 'N/A'}</td>
                <td>{log.department || 'N/A'}</td>
                <td>{log.upload_type?.replace(/_/g, ' ') || 'N/A'}</td>
                <td>{log.deleted_by_name || 'N/A'}</td>
                <td>{new Date(log.deleted_at).toLocaleDateString()}</td>
                <td>
                  <button
                    onClick={() => handleViewDetails(log)}
                    style={{
                      padding: '6px 12px',
                      background: '#1976d2',
                      color: 'white',
                      border: 'none',
                      borderRadius: '4px',
                      cursor: 'pointer'
                    }}
                  >
                    View Reason
                  </button>
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      )}

      {showDetails && selectedLog && (
        <div className="modal-overlay">
          <div className="modal-content">
            <h3>Deletion Details</h3>
            <div className="modal-body">
              <div className="detail-group">
                <label>File Name:</label>
                <p>{selectedLog.file_name || 'N/A'}</p>
              </div>
              <div className="detail-group">
                <label>HOD Name:</label>
                <p>{selectedLog.hod_name || 'N/A'}</p>
              </div>
              <div className="detail-group">
                <label>Department:</label>
                <p>{selectedLog.department || 'N/A'}</p>
              </div>
              <div className="detail-group">
                <label>File Type:</label>
                <p>{selectedLog.upload_type?.replace(/_/g, ' ') || 'N/A'}</p>
              </div>
              <div className="detail-group">
                <label>Deleted By:</label>
                <p>{selectedLog.deleted_by_name || 'N/A'}</p>
              </div>
              <div className="detail-group">
                <label>Deletion Date:</label>
                <p>{new Date(selectedLog.deleted_at).toLocaleString()}</p>
              </div>
              <div className="detail-group">
                <label>Deletion Reason:</label>
                <p className="deletion-reason">{selectedLog.deletion_reason || 'No reason provided'}</p>
              </div>
            </div>
            <div className="modal-actions">
              <button
                onClick={() => setShowDetails(false)}
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

export default DeletionLogs;
