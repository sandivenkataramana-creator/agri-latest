import React, { useState, useEffect } from 'react';
import { FiKey, FiPlus, FiToggleRight, FiToggleLeft, FiRefreshCw, FiEye, FiChevronDown } from 'react-icons/fi';
import {
  generateThirdPartyApiKey,
  getThirdPartyApiKeys,
  toggleApiKey,
  getImportLogs,
  regenerateApiKey,
  getApiKeyDetails,
  getHODsForApiKey
} from '../services/api';
import './ThirdPartyIntegration.css';

const ThirdPartyIntegration = () => {
  const [apiKeys, setApiKeys] = useState([]);
  // const [importLogs, setImportLogs] = useState([]);
  const [hods, setHods] = useState([]);
  const [loading, setLoading] = useState(false);
  const [showGenerateModal, setShowGenerateModal] = useState(false);
  const [showLogsModal, setShowLogsModal] = useState(false);
  const [showViewKeyModal, setShowViewKeyModal] = useState(false);
  const [showApiKeysList, setShowApiKeysList] = useState(true);
  const [selectedKeyId, setSelectedKeyId] = useState(null);
  const [selectedKeyData, setSelectedKeyData] = useState(null);
  const [recentlyGeneratedKey, setRecentlyGeneratedKey] = useState(null);
  const [loadingKey, setLoadingKey] = useState(false);
  
  const [formData, setFormData] = useState({
    system_name: '',
    description: '',
    hod_id: ''
  });

  const [filterStatus, setFilterStatus] = useState('success');

  // Fetch API Keys
  const fetchApiKeys = async () => {
    try {
      setLoading(true);
      const res = await getThirdPartyApiKeys();
      console.log('[ThirdPartyIntegration] API keys response:', res);
      
      // Response structure: res.data = { data: [...] } from backend
      const keysData = res.data?.data || [];
      console.log('[ThirdPartyIntegration] Setting API keys:', keysData, 'Count:', keysData.length);
      setApiKeys(keysData);
    } catch (err) {
      console.error('Error fetching API keys:', err);
      setApiKeys([]);
      alert('Failed to fetch API keys: ' + (err.response?.data?.message || err.message));
    } finally {
      setLoading(false);
    }
  };

  // Fetch HODs for dropdown
  const fetchHODs = async () => {
    try {
      const res = await getHODsForApiKey();
      console.log('[ThirdPartyIntegration] HODs response:', res);
      
      // Response structure: res.data = { data: [...] } from backend
      const hodsData = res.data?.data || [];
      console.log('[ThirdPartyIntegration] Setting HODs:', hodsData, 'Count:', hodsData.length);
      setHods(hodsData);
    } catch (err) {
      console.error('Error fetching HODs:', err);
      setHods([]);
    }
  };

  // Fetch Import Logs
  // const fetchImportLogs = async () => {
  //   try {
  //     const res = await getImportLogs({ import_status: filterStatus });
  //     // Ensure importLogs is always an array
  //     if (Array.isArray(res.data)) {
  //       setImportLogs(res.data);
  //     } else {
  //       setImportLogs([]);
  //     }
  //   } catch (err) {
  //     console.error('Error fetching import logs:', err);
  //     setImportLogs([]);
  //     alert('Failed to fetch import logs');
  //   }
  // };

  useEffect(() => {
    fetchApiKeys();
    fetchHODs();
  }, []);

  // useEffect(() => {
  //   if (showLogsModal) {
  //     fetchImportLogs();
  //   }
  // }, [showLogsModal, filterStatus]);

  // Generate new API key
  const handleGenerateApiKey = async (e) => {
    e.preventDefault();
    try {
      const res = await generateThirdPartyApiKey(formData);
      
      // Show the key in a dialog
      const generatedKey = res.data.apiKey;
      setRecentlyGeneratedKey(generatedKey); // Store for later display
      const isConfirmed = window.confirm(
        `API Key Generated:\n\n${generatedKey}\n\nClick OK to copy to clipboard (you won't see it again!)`
      );
      
      if (isConfirmed) {
        navigator.clipboard.writeText(generatedKey);
        alert('API Key copied to clipboard!');
      }
      
      setFormData({ system_name: '', description: '', hod_id: '' });
      setShowGenerateModal(false);
      // Wait a moment then refetch to show the new key
      setTimeout(() => {
        fetchApiKeys();
      }, 500);
    } catch (err) {
      console.error('Error generating API key:', err);
      alert(err.response?.data?.message || 'Failed to generate API key');
    }
  };

  // Toggle API Key status
  const handleToggleKey = async (id, currentStatus) => {
    try {
      await toggleApiKey(id, { is_active: !currentStatus });
      fetchApiKeys();
    } catch (err) {
      console.error('Error toggling API key:', err);
      alert('Failed to toggle API key status');
    }
  };

  // View API Key
  const handleViewKey = async (id) => {
    try {
      setLoadingKey(true);
      const res = await getApiKeyDetails(id);
      console.log('[ThirdPartyIntegration] API key details:', res);
      setSelectedKeyId(id);
      // Extract data properly from response
      const keyData = res.data?.data || res.data || {};
      console.log('[ThirdPartyIntegration] Setting key data:', keyData);
      setSelectedKeyData(keyData);
      setShowViewKeyModal(true);
    } catch (err) {
      console.error('Error fetching API key:', err);
      alert('Failed to fetch API key details');
    } finally {
      setLoadingKey(false);
    }
  };

  // Regenerate API Key
  const handleRegenerateKey = async (id) => {
    const confirmed = window.confirm(
      'Regenerate this API key?\n\n⚠️ The old API key will be DELETED and no longer work.\n✓ A new key will be generated with the same description.\n\nMake sure you update the third-party system with the new key!'
    );

    if (!confirmed) return;

    try {
      setLoading(true);
      const res = await regenerateApiKey(id);
      
      // Show the new key in a dialog
      const newKey = res.data.apiKey;
      const isConfirmed = window.confirm(
        `New API Key Generated:\n\n${newKey}\n\nClick OK to copy to clipboard (you won't see it again!)`
      );
      
      if (isConfirmed) {
        navigator.clipboard.writeText(newKey);
        alert('New API Key copied to clipboard!');
      }
      
      setShowViewKeyModal(false);
      setSelectedKeyData(null);
      fetchApiKeys();
    } catch (err) {
      console.error('Error regenerating API key:', err);
      alert(err.response?.data?.message || 'Failed to regenerate API key');
    } finally {
      setLoading(false);
    }
  };

  // Copy API key to clipboard
  const handleCopyKey = (keyValue) => {
    if (keyValue) {
      navigator.clipboard.writeText(keyValue);
      alert('API Key copied to clipboard!');
    }
  };

  const formatDate = (dateString) => {
    if (!dateString) return 'N/A';
    try {
      const date = new Date(dateString);
      if (isNaN(date.getTime())) return 'Invalid Date';
      return date.toLocaleDateString('en-IN', {
        year: 'numeric',
        month: 'short',
        day: '2-digit',
        hour: '2-digit',
        minute: '2-digit'
      });
    } catch (e) {
      return 'Invalid Date';
    }
  };

  return (
    <div className="page-container">
      <div style={{ marginBottom: '30px' }}>
        <h1 style={{ display: 'flex', alignItems: 'center', gap: '10px', marginBottom: '20px' }}>
          <FiKey size={28} /> Third-Party Attendance Integration
        </h1>
        
        <div style={{ background: '#e3f2fd', padding: '15px', borderRadius: '8px', marginBottom: '20px', borderLeft: '4px solid #2196F3' }}>
          <h3 style={{ margin: '0 0 10px 0', color: '#1976D2' }}>Integration Guide</h3>
          <p style={{ margin: '0', fontSize: '14px', color: '#555' }}>
            Generate API keys for third-party attendance systems (biometric machines, time tracking software, etc.) to push attendance data to your system.
          </p>
        </div>

        {/* API Keys Section */}
        <div style={{ background: '#fff', borderRadius: '12px', padding: '20px', marginBottom: '20px', boxShadow: '0 2px 8px rgba(0,0,0,0.1)' }}>
          <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '20px' }}>
            <h2 style={{ margin: 0 }}>API Keys ({apiKeys.length})</h2>
            <div style={{ display: 'flex', gap: '10px' }}>
              <button 
                className="btn btn-secondary"
                onClick={() => fetchApiKeys()}
                title="Refresh API Keys"
                style={{ display: 'flex', alignItems: 'center', gap: '8px' }}
              >
                <FiRefreshCw /> Refresh
              </button>
              <button 
                className="btn btn-secondary"
                onClick={() => setShowApiKeysList(!showApiKeysList)}
                style={{ display: 'flex', alignItems: 'center', gap: '8px' }}
              >
                {showApiKeysList ? 'Hide Keys' : 'View Keys'} <FiChevronDown style={{ transform: showApiKeysList ? 'rotate(180deg)' : 'rotate(0deg)' }} />
              </button>
              <button 
                className="btn btn-primary"
                onClick={() => setShowGenerateModal(true)}
                style={{ display: 'flex', alignItems: 'center', gap: '8px' }}
              >
                <FiPlus /> Generate New Key
              </button>
            </div>
          </div>

          {showApiKeysList && (
            <>
              {loading ? (
                <div style={{ textAlign: 'center', padding: '40px', color: '#999' }}>Loading API keys...</div>
              ) : apiKeys.length === 0 ? (
                <div style={{ textAlign: 'center', padding: '40px', color: '#999' }}>
                  No API keys generated yet. Create one to get started.
                </div>
              ) : (
                <div className="table-wrapper">
                  <table>
                    <thead>
                      <tr>
                        <th>System Name</th>
                        <th>HOD</th>
                        <th>Department</th>
                        <th>Status</th>
                        <th>Created</th>
                        <th>Last Used</th>
                        <th>Actions</th>
                      </tr>
                    </thead>
                    <tbody>
                      {apiKeys.map((key) => {
                        const hodName = hods.find(h => h.id === key.hod_id)?.name || (key.hod_id ? 'Unknown' : 'All HODs');
                        return (
                          <tr key={key.id}>
                            <td><strong>{key.system_name}</strong></td>
                            <td style={{ fontSize: '12px' }}>{hodName}</td>
                            <td style={{ fontSize: '12px', color: '#666' }}>{key.description || '-'}</td>
                            <td>
                              <span style={{
                                padding: '4px 12px',
                                borderRadius: '12px',
                                fontSize: '12px',
                                backgroundColor: key.is_active ? '#e8f5e9' : '#ffebee',
                                color: key.is_active ? '#2e7d32' : '#c62828',
                                fontWeight: '600'
                              }}>
                                {key.is_active ? 'Active' : 'Inactive'}
                              </span>
                            </td>
                            <td style={{ fontSize: '12px' }}>{formatDate(key.created_at)}</td>
                            <td style={{ fontSize: '12px' }}>{key.last_used_at ? formatDate(key.last_used_at) : 'Never'}</td>
                            <td>
                              <div style={{ display: 'flex', gap: '8px' }}>
                                <button
                                  className="action-btn"
                                  onClick={() => handleViewKey(key.id)}
                                  title="View Key"
                                  style={{ padding: '6px' }}
                                >
                                  <FiEye color="#2196F3" />
                                </button>
                                <button
                                  className="action-btn"
                                  onClick={() => handleToggleKey(key.id, key.is_active)}
                                  title={key.is_active ? 'Deactivate' : 'Activate'}
                                  style={{ padding: '6px' }}
                                >
                                  {key.is_active ? <FiToggleRight color="#4CAF50" /> : <FiToggleLeft color="#999" />}
                                </button>
                              </div>
                            </td>
                          </tr>
                        );
                      })}
                    </tbody>
                  </table>
                </div>
              )}
            </>
          )}
        </div>

        {/* Import Logs Section */}
        {/* <div style={{ background: '#fff', borderRadius: '12px', padding: '20px', boxShadow: '0 2px 8px rgba(0,0,0,0.1)' }}>
          <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '20px' }}>
            <h2 style={{ margin: 0 }}>Import Logs</h2>
            <button
              className="btn btn-secondary"
              onClick={() => setShowLogsModal(!showLogsModal)}
              style={{ display: 'flex', alignItems: 'center', gap: '8px' }}
            >
              {showLogsModal ? 'Hide' : 'Show'} Logs
            </button>
          </div>

          {showLogsModal && (
            <div>
              <div style={{ marginBottom: '15px', display: 'flex', gap: '10px', alignItems: 'center' }}>
                <label style={{ fontSize: '12px' }}>Filter:</label>
                <select
                  value={filterStatus}
                  onChange={(e) => setFilterStatus(e.target.value)}
                  style={{
                    padding: '6px 12px',
                    borderRadius: '4px',
                    border: '1px solid #ddd',
                    fontSize: '13px'
                  }}
                >
                  <option value="success">Success</option>
                  <option value="failed">Failed</option>
                </select>
                <button
                  className="btn btn-sm"
                  onClick={fetchImportLogs}
                  style={{ display: 'flex', alignItems: 'center', gap: '4px', padding: '6px 10px' }}
                >
                  <FiRefreshCw size={12} /> Refresh
                </button>
              </div>

              {importLogs.length === 0 ? (
                <div style={{ textAlign: 'center', padding: '30px', color: '#999' }}>
                  No import logs found
                </div>
              ) : (
                <div className="table-wrapper" style={{ maxHeight: '400px', overflow: 'auto' }}>
                  <table>
                    <thead>
                      <tr>
                        <th>Employee ID</th>
                        <th>Date</th>
                        <th>Check In</th>
                        <th>Check Out</th>
                        <th>Status</th>
                        <th>Device</th>
                        <th>Import Status</th>
                        <th>Error</th>
                        <th>Time</th>
                      </tr>
                    </thead>
                    <tbody>
                      {importLogs.map((log, idx) => (
                        <tr key={idx}>
                          <td><strong>{log.employee_id || '-'}</strong></td>
                          <td style={{ fontSize: '12px' }}>{log.attendance_date || '-'}</td>
                          <td style={{ fontSize: '12px' }}>{log.check_in || '-'}</td>
                          <td style={{ fontSize: '12px' }}>{log.check_out || '-'}</td>
                          <td style={{ fontSize: '12px' }}>
                            <span style={{
                              padding: '2px 8px',
                              borderRadius: '4px',
                              backgroundColor: log.status === 'present' ? '#4CAF50' : '#FF9800',
                              color: '#fff',
                              fontSize: '11px'
                            }}>
                              {log.status || '-'}
                            </span>
                          </td>
                          <td style={{ fontSize: '12px' }}>{log.device_id || '-'}</td>
                          <td style={{ fontSize: '12px' }}>
                            <span style={{
                              padding: '2px 8px',
                              borderRadius: '4px',
                              backgroundColor: log.import_status === 'success' ? '#e8f5e9' : '#ffebee',
                              color: log.import_status === 'success' ? '#2e7d32' : '#c62828',
                              fontWeight: '600',
                              fontSize: '11px'
                            }}>
                              {log.import_status}
                            </span>
                          </td>
                          <td style={{ fontSize: '12px', color: '#c62828' }}>
                            {log.error_message ? log.error_message.substring(0, 30) + '...' : '-'}
                          </td>
                          <td style={{ fontSize: '12px' }}>{formatDate(log.created_at)}</td>
                        </tr>
                      ))}
                    </tbody>
                  </table>
                </div>
              )}
            </div>
          )}
        </div> */}
      </div>

      {/* View API Key Modal */}
      {showViewKeyModal && selectedKeyData && (
        <div style={{
          position: 'fixed',
          top: 0,
          left: 0,
          right: 0,
          bottom: 0,
          backgroundColor: 'rgba(0,0,0,0.5)',
          display: 'flex',
          alignItems: 'center',
          justifyContent: 'center',
          zIndex: 1000,
          overflow: 'hidden'
        }} onClick={() => setShowViewKeyModal(false)}>
          <div style={{
            background: '#fff',
            borderRadius: '12px',
            padding: '30px',
            width: '90%',
            maxWidth: '600px',
            maxHeight: '90vh',
            overflowY: 'auto',
            boxShadow: '0 10px 40px rgba(0,0,0,0.2)'
          }} onClick={(e) => e.stopPropagation()}>
            <h2 style={{ marginTop: 0, marginBottom: '10px' }}>API Key Details</h2>
            <p style={{ color: '#666', marginTop: 0, marginBottom: '20px', fontSize: '14px' }}>
              System: <strong>{selectedKeyData.system_name}</strong>
            </p>

            <div style={{ background: '#f5f5f5', padding: '20px', borderRadius: '8px', marginBottom: '20px' }}>
              <div style={{ marginBottom: '15px' }}>
                <label style={{ display: 'block', marginBottom: '8px', fontWeight: '600', color: '#333' }}>
                  API Key Status
                </label>
                <span style={{
                  padding: '6px 14px',
                  borderRadius: '20px',
                  fontSize: '12px',
                  backgroundColor: selectedKeyData.is_active ? '#e8f5e9' : '#ffebee',
                  color: selectedKeyData.is_active ? '#2e7d32' : '#c62828',
                  fontWeight: '600'
                }}>
                  {selectedKeyData.is_active ? '✓ Active' : '✗ Inactive'}
                </span>
              </div>

              <div style={{ marginBottom: '15px' }}>
                <label style={{ display: 'block', marginBottom: '8px', fontWeight: '600', color: '#333' }}>
                  Created At
                </label>
                <p style={{ margin: 0, color: '#666', fontSize: '13px' }}>
                  {formatDate(selectedKeyData.created_at)}
                </p>
              </div>

              <div style={{ marginBottom: '15px' }}>
                <label style={{ display: 'block', marginBottom: '8px', fontWeight: '600', color: '#333' }}>
                  Last Used
                </label>
                <p style={{ margin: 0, color: '#666', fontSize: '13px' }}>
                  {selectedKeyData.last_used_at ? formatDate(selectedKeyData.last_used_at) : 'Never used'}
                </p>
              </div>

              {selectedKeyData.description && (
                <div style={{ marginBottom: '15px' }}>
                  <label style={{ display: 'block', marginBottom: '8px', fontWeight: '600', color: '#333' }}>
                    Description
                  </label>
                  <p style={{ margin: 0, color: '#666', fontSize: '13px', whiteSpace: 'pre-wrap' }}>
                    {selectedKeyData.description}
                  </p>
                </div>
              )}

              {recentlyGeneratedKey && selectedKeyId && (
                <div style={{ background: '#f0f7ff', padding: '15px', borderRadius: '6px', marginBottom: '15px', borderLeft: '4px solid #1976D2' }}>
                  <label style={{ display: 'block', marginBottom: '8px', fontWeight: '600', color: '#1565C0' }}>
                    📋 API Key (Just Generated)
                  </label>
                  <div style={{
                    background: '#fff',
                    padding: '10px',
                    borderRadius: '4px',
                    fontFamily: 'monospace',
                    fontSize: '12px',
                    wordBreak: 'break-all',
                    border: '1px solid #B3E5FC',
                    marginBottom: '8px',
                    maxHeight: '100px',
                    overflowY: 'auto'
                  }}>
                    {recentlyGeneratedKey}
                  </div>
                  <button
                    type="button"
                    onClick={() => {
                      navigator.clipboard.writeText(recentlyGeneratedKey);
                      alert('API Key copied to clipboard!');
                    }}
                    style={{
                      backgroundColor: '#1976D2',
                      color: '#fff',
                      border: 'none',
                      padding: '6px 12px',
                      borderRadius: '4px',
                      cursor: 'pointer',
                      fontSize: '12px',
                      fontWeight: '600'
                    }}
                  >
                    Copy API Key
                  </button>
                </div>
              )}
            </div>

            <div style={{ background: '#e3f2fd', padding: '12px', borderRadius: '6px', marginBottom: '20px', borderLeft: '4px solid #2196F3' }}>
              <p style={{ margin: 0, fontSize: '13px', color: '#1565C0' }}>
                <strong>ℹ️ Note:</strong> For security reasons, API key values cannot be retrieved after they are generated. 
                {!recentlyGeneratedKey && ' Use the Regenerate option if you need a new key.'}
              </p>
            </div>

            <div style={{ display: 'flex', gap: '10px', justifyContent: 'flex-end' }}>
              <button 
                type="button"
                className="btn btn-secondary"
                onClick={() => setShowViewKeyModal(false)}
              >
                Close
              </button>
              <button 
                type="button"
                className="btn btn-warning"
                onClick={() => handleRegenerateKey(selectedKeyId)}
                disabled={loadingKey || loading}
                style={{ display: 'flex', alignItems: 'center', gap: '6px' }}
              >
                <FiRefreshCw size={14} /> Regenerate Key
              </button>
            </div>
          </div>
        </div>
      )}

      {/* Generate API Key Modal */}
      {showGenerateModal && (
        <div style={{
          position: 'fixed',
          top: 0,
          left: 0,
          right: 0,
          bottom: 0,
          backgroundColor: 'rgba(0,0,0,0.5)',
          display: 'flex',
          alignItems: 'center',
          justifyContent: 'center',
          zIndex: 1000,
          overflow: 'hidden'
        }} onClick={() => setShowGenerateModal(false)}>
          <div style={{
            background: '#fff',
            borderRadius: '12px',
            padding: '30px',
            width: '90%',
            maxWidth: '500px',
            maxHeight: '90vh',
            overflowY: 'auto',
            boxShadow: '0 10px 40px rgba(0,0,0,0.2)'
          }} onClick={(e) => e.stopPropagation()}>
            <h2 style={{ marginTop: 0 }}>Generate New API Key</h2>
            
            <div style={{ background: '#fff3e0', padding: '12px', borderRadius: '6px', marginBottom: '20px', borderLeft: '4px solid #ff9800' }}>
              <p style={{ margin: 0, fontSize: '13px', color: '#555' }}>
                <strong>How it works:</strong> Each API key is tied to a specific third-party system (e.g., a Attendence device). The system name should be unique and descriptive.
              </p>
            </div>

            <form onSubmit={handleGenerateApiKey}>
              <div className="form-group">
                <label>System Name * <span style={{ color: '#999', fontSize: '12px' }}>(must be unique)</span></label>
                <input
                  type="text"
                  value={formData.system_name}
                  onChange={(e) => setFormData({ ...formData, system_name: e.target.value.trim() })}
                  placeholder="e.g., ACS_AGRICULTURE, ACS_HORICULTURE"
                  required
                  style={{ textTransform: 'uppercase' }}
                />
                <small style={{ color: '#666', display: 'block', marginTop: '4px' }}>
                  Use uppercase letters, hyphens, or underscores. No spaces. This identifies which system is sending attendance data.
                </small>
              </div>

              <div className="form-group">
                <label>Associated HOD (Optional)</label>
                <select
                  value={formData.hod_id}
                  onChange={(e) => setFormData({ ...formData, hod_id: e.target.value })}
                  style={{ 
                    width: '100%',
                    padding: '8px 12px',
                    border: '1px solid #ddd',
                    borderRadius: '4px',
                    fontSize: '14px'
                  }}
                >
                  <option value="">-- Select HOD (Optional) --</option>
                  {hods.map((hod) => (
                    <option key={hod.id} value={hod.id}>
                      {hod.name} ({hod.department})
                    </option>
                  ))}
                </select>
                <small style={{ color: '#666', display: 'block', marginTop: '4px' }}>
                  Select a specific HOD if this API key is for one department. This is not unique you can select same hod for different departments. Leave blank to allow all HODs to use this key.
                </small>
              </div>

              <div className="form-group">
                <label>Department / Location</label>
                <textarea
                  value={formData.description}
                  onChange={(e) => setFormData({ ...formData, description: e.target.value })}
                  placeholder="e.g., Office location &#10;Department: Agriculture Department"
                  rows="3"
                />
                <small style={{ color: '#666', display: 'block', marginTop: '4px' }}>
                  provide department or location details to help identify this API key later.
                </small>
              </div>

              <div style={{ background: '#fff3e0', padding: '12px', borderRadius: '6px', marginBottom: '20px', borderLeft: '4px solid #FF9800' }}>
                <strong style={{ color: '#E65100' }}>Important:</strong>
                <p style={{ margin: '5px 0 0 0', fontSize: '13px', color: '#666' }}>
                  Never share your API keys publicly. Treat them like passwords. If you suspect a key has been compromised, regenerate it immediately.
                </p>
              </div>

              <div style={{ display: 'flex', gap: '10px', justifyContent: 'flex-end' }}>
                <button 
                  type="button"
                  className="btn btn-secondary"
                  onClick={() => setShowGenerateModal(false)}
                >
                  Cancel
                </button>
                <button 
                  type="submit"
                  className="btn btn-primary"
                >
                  Generate Key
                </button>
              </div>
            </form>
          </div>
        </div>
      )}
    </div>
  );
};

export default ThirdPartyIntegration;
