import React, { useState, useEffect } from 'react';
import Header from '../components/Header';
import { FiUser, FiMail, FiUserPlus } from 'react-icons/fi';
import { registerUser, getHODs, getCategories } from '../services/api';
import './RegisterUser.css';

const RegisterUser = () => {
  const [formData, setFormData] = useState({
    username: '',
    email: '',
    name: '',
    role: 'staff',
    hod_id: '',
    staff_id: '',
    category_id: ''
  });

  const [error, setError] = useState('');
  const [success, setSuccess] = useState('');
  const [isLoading, setIsLoading] = useState(false);
  const [hods, setHODs] = useState([]);
  const [categories, setCategories] = useState([]);

  useEffect(() => {
    fetchHODs();
    fetchCategories();
  }, []);

  const fetchHODs = async () => {
    try {
      const response = await getHODs();
      setHODs(response.data || []);
    } catch (err) {
      console.error(err);
    }
  };

  const fetchCategories = async () => {
    try {
      const response = await getCategories();
      setCategories(response.data || []);
    } catch (err) {
      console.error(err);
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

    if (!formData.email.includes('@')) {
      setError('Please enter a valid email address');
      return;
    }

    if (formData.role === 'hod' && !formData.category_id) {
      setError('Please select a department category for HOD');
      return;
    }

    if (formData.role === 'staff' && !formData.hod_id) {
      setError('Please select a HOD for Staff');
      return;
    }

    setIsLoading(true);

    try {
      const response = await registerUser({
        ...formData,
        hod_id: formData.hod_id || null,
        staff_id: formData.staff_id || null,
        category_id: formData.category_id || null
      });

      if (response.data.success) {
        setSuccess(`User "${formData.name}" registered successfully! Temporary password sent to email.`);
        setFormData({
          username: '',
          email: '',
          name: '',
          role: 'staff',
          hod_id: '',
          staff_id: '',
          category_id: ''
        });
      }
    } catch (err) {
      setError(err.response?.data?.error || 'Registration failed');
    } finally {
      setIsLoading(false);
    }
  };

  return (
    <div className="page-container">
      <div className="table-card">
        <div className="table-header">
          <h3><FiUserPlus /> Create New User Account</h3>
        </div>

        {error && <div className="alert alert-error">⚠️ {error}</div>}
        {success && <div className="alert alert-success">✓ {success}</div>}

        <form className="register-form" onSubmit={handleSubmit}>
          <div className="form-grid">
            <div className="form-group">
              <label>Full Name *</label>
              <div className="input-wrapper">
                <FiUser className="input-icon" />
                <input name="name" value={formData.name} onChange={handleChange} required />
              </div>
            </div>

            <div className="form-group">
              <label>Email Address *</label>
              <div className="input-wrapper">
                <FiMail className="input-icon" />
                <input name="email" value={formData.email} onChange={handleChange} required />
              </div>
            </div>
          </div>

          <div className="form-grid">
            <div className="form-group">
              <label>Username *</label>
              <div className="input-wrapper">
                <FiUser className="input-icon" />
                <input name="username" value={formData.username} onChange={handleChange} required />
              </div>
            </div>

            <div className="form-group">
              <label>Role *</label>
              <select name="role" value={formData.role} onChange={handleChange}>
                <option value="admin">Admin</option>
                <option value="hod">HOD</option>
                <option value="staff">Staff</option>
              </select>
            </div>
          </div>

          {formData.role === 'hod' && (
            <div className="form-group">
              <label>Department Category *</label>
              <select name="category_id" value={formData.category_id} onChange={handleChange}>
                <option value="">Select Category</option>
                {categories.map(c => <option key={c.id} value={c.id}>{c.name}</option>)}
              </select>
            </div>
          )}

          {formData.role === 'staff' && (
            <div className="form-group">
              <label>HOD *</label>
              <select name="hod_id" value={formData.hod_id} onChange={handleChange}>
                <option value="">Select HOD</option>
                {hods.map(h => <option key={h.id} value={h.id}>{h.name}</option>)}
              </select>
            </div>
          )}

          <div className="info-box">
            <p><strong>ℹ️ Note:</strong> Temporary password will be sent via email.</p>
          </div>

          <div className="form-actions">
            <button className="btn btn-primary" disabled={isLoading}>
              {isLoading ? 'Creating...' : 'Create User'}
            </button>
            <button
              type="button"
              className="btn btn-secondary"
              onClick={() => {
                setFormData({
                  username: '',
                  email: '',
                  name: '',
                  role: 'staff',
                  hod_id: '',
                  staff_id: '',
                  category_id: ''
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

export default RegisterUser;
