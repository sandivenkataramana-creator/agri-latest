import React, { useState, useEffect } from 'react';
import Header from '../components/Header';
import Modal from '../components/Modal';
import { FiPlus, FiEdit2, FiTrash2, FiMail } from 'react-icons/fi';
import { getHODs, createHOD, updateHOD, deleteHOD, getCategories, createCategory } from '../services/api';
import axios from 'axios';

const HODs = () => {
  const [hods, setHODs] = useState([]);
  const [filteredHods, setFilteredHods] = useState([]);
  const [categories, setCategories] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const [isModalOpen, setIsModalOpen] = useState(false);
  const [isCategoryModalOpen, setIsCategoryModalOpen] = useState(false);
  const [passwordModalOpen, setPasswordModalOpen] = useState(false);
  const [editingHod, setEditingHod] = useState(null);
  const [passwordData, setPasswordData] = useState({ hodId: null, password: '' });
  const [searchText, setSearchText] = useState('');
  const [searchQuery, setSearchQuery] = useState('');
  const [formData, setFormData] = useState({
    name: '',
    department: '',
    category_id: '',
    email: '',
    phone: '',
    status: 'active'
  });
  const [newCategory, setNewCategory] = useState({ name: '', description: '' });
  const [currentPage, setCurrentPage] = useState(0);
  const [pageSize] = useState(10);
  
  // Parse user from localStorage once, at initialization
  const [user] = useState(() => JSON.parse(localStorage.getItem('user') || '{}'));
  const isSuperAdmin = user.role === 'superadmin';
  const isReadOnly = !isSuperAdmin;

  useEffect(() => {
    fetchHODs();
    fetchCategories();
  }, []);

  // Update filtered list whenever data or query changes
  useEffect(() => {
    const q = searchQuery.trim().toLowerCase();
    if (!q) {
      setFilteredHods(hods);
    } else {
      setFilteredHods(
        hods.filter(h => (h.name || '').toLowerCase().includes(q))
      );
    }
    // Reset pagination on new search
    setCurrentPage(0);
  }, [hods, searchQuery]);

  const fetchHODs = async () => {
    try {
      setLoading(true);
      const response = await getHODs();
      setHODs(response.data || []);
      setError(null);
    } catch (err) {
      console.error('Error fetching HODs:', err);
      setError('Failed to fetch HODs. Please make sure the server is running.');
    } finally {
      setLoading(false);
    }
  };

  const handleApplySearch = () => {
    setSearchQuery(searchText);
  };

  const handleClearSearch = () => {
    setSearchText('');
    setSearchQuery('');
  };

  const fetchCategories = async () => {
    try {
      const response = await getCategories();
      setCategories(response.data || []);
    } catch (err) {
      console.error('Error fetching categories:', err);
    }
  };

  const handleOpenModal = (hod = null) => {
    if (isReadOnly) return;
    if (hod) {
      setEditingHod(hod);
      setFormData({
        name: hod.name || '',
        department: hod.department || '',
        category_id: hod.category_id || '',
        email: hod.email || '',
        phone: hod.phone || '',
        status: hod.status || 'active'
      });
    } else {
      setEditingHod(null);
      setFormData({ name: '', department: '', category_id: '', email: '', phone: '', status: 'active' });
    }
    setIsModalOpen(true);
  };

  const handleCloseModal = () => {
    setIsModalOpen(false);
    setEditingHod(null);
    setFormData({ name: '', department: '', category_id: '', email: '', phone: '', status: 'active' });
  };

  const handleCreateCategory = async (e) => {
    e.preventDefault();
    if (isReadOnly) return;
    try {
      await createCategory(newCategory);
      await fetchCategories();
      setIsCategoryModalOpen(false);
      setNewCategory({ name: '', description: '' });
      alert('Category created successfully!');
    } catch (err) {
      console.error('Error creating category:', err);
      alert('Failed to create category. Please try again.');
    }
  };

  const handleChange = (e) => {
    setFormData({ ...formData, [e.target.name]: e.target.value });
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    if (isReadOnly) return;
    try {
      if (editingHod) {
        await updateHOD(editingHod.id, formData);
      } else {
        await createHOD(formData);
      }
      fetchHODs(); // Refresh the list
      handleCloseModal();
    } catch (err) {
      console.error('Error saving HOD:', err);
      
      // Extract error message from response
      const errorMessage = err.response?.data?.error || 
                          err.response?.data?.message || 
                          'Failed to save HOD. Please try again.';
      
      alert(errorMessage);
    }
  };

  const handleDelete = async (id) => {
    if (isReadOnly) return;
    if (window.confirm('Are you sure you want to delete this HOD?')) {
      try {
        await deleteHOD(id);
        fetchHODs(); // Refresh the list
      } catch (err) {
        console.error('Error deleting HOD:', err);
        alert('Failed to delete HOD. Please try again.');
      }
    }
  };

  const handleOpenPasswordModal = (hod) => {
    if (isReadOnly) return;
    setEditingHod(hod);
    setPasswordData({ hodId: hod.id, password: '' });
    setPasswordModalOpen(true);
  };

  const handleSendPassword = async (e) => {
    e.preventDefault();

    try {
      const token = user.token;
      
      // Create the user account with auto-generated password
      const accountResponse = await axios.post(
        `http://localhost:5000/api/hods/${passwordData.hodId}/create-account`,
        {}, // No password needed - backend will auto-generate
        {
          headers: {
            Authorization: `Bearer ${token}`,
            'Content-Type': 'application/json'
          }
        }
      );

      // Show success message
      const credentials = `\n\nLogin Credentials:\nUsername: ${accountResponse.data.username}\nEmail: ${accountResponse.data.email}\n\n✅ A temporary password has been sent to the HOD's email address.`;
      
      alert(`Account created successfully!${credentials}`);
      
      setPasswordModalOpen(false);
      setPasswordData({ hodId: null, password: '' });
      setEditingHod(null);
    } catch (err) {
      console.error('Error creating account:', err);
      alert('Failed to create account. ' + (err.response?.data?.error || 'Please try again.'));
    }
  };

  if (loading) {
    return (
      <div className="page-container">
        {/* <Header title="HODs Management" /> */}
        <div className="loading-message">Loading HODs...</div>
      </div>
    );
  }

  if (error) {
    return (
      <div className="page-container">
        {/* <Header title="HODs Management" /> */}
        <div className="error-message">{error}</div>
      </div>
    );
  }

  return (
    <div className="page-container">
      {/* <Header title="HODs Management" /> */}

      <div className="table-card">
        <div className="table-header">
          <h3>HOD's ({filteredHods.length})</h3>
          <div>
            <div className="search-controls">
              <input
                type="text"
                className="search-input"
                placeholder="Search HODs by name"
                value={searchText}
                onChange={(e) => {
                  const value = e.target.value;
                  setSearchText(value);
                  setSearchQuery(value);
                }}
              />
              <button className="btn btn-secondary" onClick={handleApplySearch}>Search</button>
              {searchQuery && (
                <button className="btn btn-secondary" onClick={handleClearSearch}>Clear</button>
              )}
            </div>
            {!isReadOnly && (
              <button className="btn btn-primary" onClick={() => handleOpenModal()}>
                <FiPlus /> Add HOD
              </button>
            )}
          </div>
        </div>
        <div className="table-wrapper">
          <table>
            <thead>
              <tr style={{ display: 'table-row', verticalAlign: 'inherit', unicodeBidi: 'isolate', borderColor: 'inherit' }}>
                <th>SNO</th>
                <th>Name</th>
                <th>Department</th>
                <th>Category</th>
                <th>Email</th>
                <th>Phone</th>
                <th>Status</th>
                <th>Actions</th>
              </tr>
            </thead>
            <tbody>
              {filteredHods.slice(currentPage * pageSize, (currentPage + 1) * pageSize).map((hod, index) => (
                <tr key={hod.id}>
                  <td><strong>{currentPage * pageSize + index + 1}</strong></td>
                  <td>{hod.name}</td>
                  <td>{hod.department}</td>
                  <td>{hod.category_name}</td>
                  <td>{hod.email}</td>
                  <td>{hod.phone}</td>
                  <td>
                    <span className={`status-badge ${hod.status}`}>{hod.status}</span>
                  </td>
                  <td>
                    <div className="action-buttons">
                      {!isReadOnly && (
                        <>
                          <button className="action-btn edit" onClick={() => handleOpenModal(hod)} title="Edit">
                            <FiEdit2 />
                          </button>
                          <button className="action-btn edit" onClick={() => handleOpenPasswordModal(hod)} title="Send Password">
                            <FiMail />
                          </button>
                          <button className="action-btn delete" onClick={() => handleDelete(hod.id)} title="Delete">
                            <FiTrash2 />
                          </button>
                        </>
                      )}
                    </div>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
        <div className="pagination" style={{ padding: '12px 16px', display: 'flex', justifyContent: 'flex-end', alignItems: 'center', gap: '12px', borderTop: '1px solid #e0e0e0' }}>
          <span style={{ fontSize: '14px', color: '#666' }}>
            {filteredHods.length === 0 ? 0 : currentPage * pageSize + 1}-{Math.min((currentPage + 1) * pageSize, filteredHods.length)} of {filteredHods.length.toLocaleString()}
          </span>
          <button 
            disabled={currentPage === 0} 
            onClick={() => setCurrentPage(currentPage - 1)}
            style={{ padding: '6px 10px', borderRadius: '4px', border: '1px solid #d0d7de', background: 'white', cursor: currentPage === 0 ? 'not-allowed' : 'pointer', opacity: currentPage === 0 ? 0.5 : 1 }}
          >
            &lt;
          </button>
          <button 
            disabled={(currentPage + 1) * pageSize >= filteredHods.length} 
            onClick={() => setCurrentPage(currentPage + 1)}
            style={{ padding: '6px 10px', borderRadius: '4px', border: '1px solid #d0d7de', background: 'white', cursor: (currentPage + 1) * pageSize >= filteredHods.length ? 'not-allowed' : 'pointer', opacity: (currentPage + 1) * pageSize >= filteredHods.length ? 0.5 : 1 }}
          >
            &gt;
          </button>
        </div>
      </div>

      <Modal
        isOpen={isModalOpen}
        onClose={handleCloseModal}
        title={editingHod ? 'Edit HOD' : 'Add New HOD'}
        footer={
          <>
            <button className="btn btn-secondary" onClick={handleCloseModal}>Cancel</button>
            {!isReadOnly && (
              <button className="btn btn-primary" onClick={handleSubmit}>
                {editingHod ? 'Update' : 'Create'}
              </button>
            )}
          </>
        }
      >
        <form onSubmit={handleSubmit}>
          <div className="form-group">
            <label>Name</label>
            <input
              type="text"
              name="name"
              value={formData.name}
              onChange={handleChange}
              required
            />
          </div>
          <div className="form-group">
            <label>Department Category {isSuperAdmin && <button type="button" className="btn-link" onClick={() => setIsCategoryModalOpen(true)} style={{ fontSize: '12px', marginLeft: '8px' }}>+ Create New</button>}</label>
            <select
              name="category_id"
              value={formData.category_id}
              onChange={handleChange}
            >
              <option value="">Select Category (Optional)</option>
              {categories.map(cat => (
                <option key={cat.id} value={cat.id}>{cat.name}</option>
              ))}
            </select>
          </div>
          <div className="form-group">
            <label>Department</label>
            <input
              type="text"
              name="department"
              value={formData.department}
              onChange={handleChange}
              required
            />
          </div>
          <div className="form-group">
            <label>Email</label>
            <input
              type="email"
              name="email"
              value={formData.email}
              onChange={handleChange}
              required
            />
          </div>
          <div className="form-group">
            <label>Phone</label>
            <input
              type="tel"
              name="phone"
              value={formData.phone}
              onChange={handleChange}
              required
            />
          </div>
          <div className="form-group">
            <label>Status</label>
            <select name="status" value={formData.status} onChange={handleChange}>
              <option value="active">Active</option>
              <option value="inactive">Inactive</option>
            </select>
          </div>
        </form>
      </Modal>

      {/* Category Creation Modal */}
      {isSuperAdmin && (
        <Modal
          isOpen={isCategoryModalOpen}
          onClose={() => {
            setIsCategoryModalOpen(false);
            setNewCategory({ name: '', description: '' });
          }}
          title="Create New Category"
          footer={
            <>
              <button className="btn btn-secondary" onClick={() => setIsCategoryModalOpen(false)}>Cancel</button>
              {!isReadOnly && (
                <button className="btn btn-primary" onClick={handleCreateCategory}>Create</button>
              )}
            </>
          }
        >
          <form onSubmit={handleCreateCategory}>
            <div className="form-group">
              <label>Category Name</label>
              <input
                type="text"
                value={newCategory.name}
                onChange={(e) => setNewCategory({ ...newCategory, name: e.target.value })}
                required
                placeholder="e.g., Agriculture, Health, Education"
              />
            </div>
            <div className="form-group">
              <label>Description</label>
              <textarea
                value={newCategory.description}
                onChange={(e) => setNewCategory({ ...newCategory, description: e.target.value })}
                rows="3"
                placeholder="Brief description of the category"
              />
            </div>
          </form>
        </Modal>
      )}

      {/* Password Modal */}
      <Modal
        isOpen={passwordModalOpen}
        onClose={() => {
          setPasswordModalOpen(false);
          setPasswordData({ hodId: null, password: '' });
          setEditingHod(null);
        }}
        title={editingHod ? `Send Password to ${editingHod.name}` : 'Send Password'}
        footer={
          <>
            <button className="btn btn-secondary" onClick={() => {
              setPasswordModalOpen(false);
              setPasswordData({ hodId: null, password: '' });
            }}>Cancel</button>
            <button className="btn btn-primary" onClick={handleSendPassword}>
              Send Password
            </button>
          </>
        }
      >
        <form onSubmit={handleSendPassword}>
          <div className="form-group">
            <label>HOD Email</label>
            <input
              type="email"
              value={editingHod?.email || ''}
              disabled
              style={{ backgroundColor: '#f5f5f5', cursor: 'not-allowed' }}
            />
          </div>
          <div style={{ 
            backgroundColor: '#e3f2fd', 
            padding: '12px', 
            borderRadius: '4px', 
            border: '1px solid #90caf9',
            marginTop: '16px'
          }}>
            <p style={{ margin: '0', color: '#1565c0', fontSize: '14px' }}>
              ✅ <strong>System will auto-generate and send a secure temporary password to the HOD's email.</strong>
            </p>
            <p style={{ margin: '8px 0 0 0', color: '#1565c0', fontSize: '12px' }}>
              The HOD must change the password on first login.
            </p>
          </div>
        </form>
      </Modal>
    </div>
  );
};

export default HODs;
