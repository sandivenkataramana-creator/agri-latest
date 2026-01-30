import React, { useState, useEffect } from 'react';
import Header from '../components/Header';
import { FiBell, FiSend, FiUsers, FiAlertCircle, FiInfo, FiCheckCircle } from 'react-icons/fi';
import { sendNotification, getHODs, getUsers } from '../services/api';
import './SendNotification.css';

const SendNotification = () => {
  const [formData, setFormData] = useState({
    type: 'info',
    title: '',
    message: '',
    recipientType: 'all', // all, role, user
    role: '',
    userId: ''
  });
  const [users, setUsers] = useState([]);
  const [hods, setHODs] = useState([]);
  const [error, setError] = useState('');
  const [success, setSuccess] = useState('');
  const [isLoading, setIsLoading] = useState(false);

  useEffect(() => {
    fetchUsers();
    fetchHODs();
  }, []);

  const fetchUsers = async () => {
    try {
      const response = await getUsers();
      setUsers(response.data || []);
    } catch (err) {
      console.error('Error fetching users:', err);
    }
  };

  const fetchHODs = async () => {
    try {
      const response = await getHODs();
      setHODs(response.data || []);
    } catch (err) {
      console.error('Error fetching HODs:', err);
    }
  };

  const handleChange = (e) => {
    const { name, value } = e.target;
    setFormData({ ...formData, [name]: value });
    setError('');
    setSuccess('');
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    setError('');
    setSuccess('');

    if (!formData.title || !formData.message) {
      setError('Title and message are required');
      return;
    }

    setIsLoading(true);

    try {
      const response = await sendNotification(formData);
      if (response.data.success) {
        setSuccess('Notification sent successfully!');
        setFormData({
          type: 'info',
          title: '',
          message: '',
          recipientType: 'all',
          role: '',
          userId: ''
        });
      }
    } catch (err) {
      setError(err.response?.data?.error || 'Failed to send notification. Please try again.');
    } finally {
      setIsLoading(false);
    }
  };

  const getTypeIcon = (type) => {
    switch (type) {
      case 'success': return <FiCheckCircle className="icon-success" />;
      case 'warning': return <FiAlertCircle className="icon-warning" />;
      case 'error': return <FiAlertCircle className="icon-error" />;
      default: return <FiInfo className="icon-info" />;
    }
  };

  return (
    <div className="page-container">
      {/* <Header 
        title="Send Notification" 
        subtitle="Send notifications to users" 
      /> */}

      <div className="table-card notification-card">
        <div className="table-header">
          <h3><FiBell /> Create Notification</h3>
        </div>

        {error && (
          <div className="alert alert-error">
            <span>⚠️ {error}</span>
          </div>
        )}

        {success && (
          <div className="alert alert-success">
            <span>✓ {success}</span>
          </div>
        )}

        <form onSubmit={handleSubmit} className="notification-form">
          <div className="form-group form-group-mb">
            <label>Notification Type *</label>
            <div className="type-selector">
              {['info', 'success', 'warning', 'error'].map(type => (
                <label key={type} className="type-radio">
                  <input
                    type="radio"
                    name="type"
                    value={type}
                    checked={formData.type === type}
                    onChange={handleChange}
                  />
                  {getTypeIcon(type)}
                  <span className="type-label">{type}</span>
                </label>
              ))}
            </div>
          </div>

          <div className="form-group form-group-mb">
            <label>Title *</label>
            <input
              type="text"
              name="title"
              value={formData.title}
              onChange={handleChange}
              required
              placeholder="Enter notification title"
              className="form-input"
            />
          </div>

          <div className="form-group form-group-mb">
            <label>Message *</label>
            <textarea
              name="message"
              value={formData.message}
              onChange={handleChange}
              required
              rows="4"
              placeholder="Enter notification message"
              className="form-textarea"
            />
          </div>

          <div className="form-group form-group-mb">
            <label>Send To *</label>
            <select
              name="recipientType"
              value={formData.recipientType}
              onChange={handleChange}
              required
              className="form-select"
            >
              <option value="all">All Users</option>
              <option value="role">By Role</option>
              <option value="user">Specific User</option>
            </select>
          </div>

          {formData.recipientType === 'role' && (
            <div className="form-group form-group-mb">
              <label>Role *</label>
              <select
                name="role"
                value={formData.role}
                onChange={handleChange}
                required
                className="form-select"
              >
                <option value="">Select Role</option>
                <option value="admin">Admin</option>
                <option value="hod">HOD</option>
                <option value="staff">Staff</option>
              </select>
            </div>
          )}

          {formData.recipientType === 'user' && (
            <div className="form-group form-group-mb">
              <label>User *</label>
              <select
                name="userId"
                value={formData.userId}
                onChange={handleChange}
                required
                className="form-select"
              >
                <option value="">Select User</option>
                {users.map(user => (
                  <option key={user.id} value={user.id}>
                    {user.name} ({user.role}) - {user.email}
                  </option>
                ))}
              </select>
            </div>
          )}

          <div className="button-group">
            <button 
              type="submit" 
              className="btn btn-primary"
              disabled={isLoading}
            >
              <FiSend className="btn-icon" />
              {isLoading ? 'Sending...' : 'Send Notification'}
            </button>
            <button 
              type="button" 
              className="btn btn-secondary"
              onClick={() => {
                setFormData({
                  type: 'info',
                  title: '',
                  message: '',
                  recipientType: 'all',
                  role: '',
                  userId: ''
                });
                setError('');
                setSuccess('');
              }}
            >
              Reset
            </button>
          </div>
        </form>
      </div>
    </div>
  );
};

export default SendNotification;

