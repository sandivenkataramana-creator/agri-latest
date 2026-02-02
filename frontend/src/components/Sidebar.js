import React, { useState } from 'react';
import { NavLink, useLocation } from 'react-router-dom';
import { 
  FiHome, 
  FiUsers, 
  FiFileText, 
  FiTrash2 ,
  FiDollarSign, 
  FiTarget, 
  FiUserCheck,
  FiCalendar,
  FiSettings,
  FiClipboard,
  FiChevronLeft,
  FiChevronRight,
  FiUserPlus,
  FiBell,
  FiMail,
  FiUpload,
  FiDownload,
  FiChevronDown,
  FiKey
} from 'react-icons/fi';

const Sidebar = ({ isCollapsed, onToggle }) => {
  const user = JSON.parse(localStorage.getItem('user') || '{}');
  const role = user.role || 'staff';
  const isAdmin = role === 'admin';
  const isSuperAdmin = role === 'superadmin';
  const isAdminLike = isAdmin || isSuperAdmin;
  const isHOD = role === 'hod';
  const [query, setQuery] = useState('');
  const location = useLocation();
  const [expandedItems, setExpandedItems] = useState({});

  const toggleExpanded = (key) => {
    setExpandedItems(prev => ({
      ...prev,
      [key]: !prev[key]
    }));
  };

  // Menu items based on role
  const getMainMenuItems = () => {
    const baseItems = [
      { path: '/', icon: <FiHome />, label: 'Dashboard' }
    ];

    if (isAdminLike) {
      return [
        ...baseItems,
        { path: '/beneficiaries', icon: <FiUsers />, label: 'Beneficiaries' },
        { path: '/employees', icon: <FiUsers />, label: 'Employees' },
        { path: '/schemes', icon: <FiFileText />, label: 'Schemes' },
           {
          icon: <FiFileText  />,
          label: 'Flagship Programs & Reports',
          key: 'flagship_reports',
          subItems: [
            { path: '/uploaded-files', label: 'Uploaded Files' },
            { path: '/deletion-logs', label: 'Deletion Logs' }
          ]
        },
        // { path: '/flagship-programmes', icon: <FiFileText />, label: 'Flagship Programs & Reports' },
        { path: '/budget', icon: <FiDollarSign />, label: 'Budget' },
      ];
    } else if (isHOD) {
      return [
        ...baseItems,
        { path: '/beneficiaries', icon: <FiUsers />, label: 'Beneficiaries' },
        { path: '/schemes', icon: <FiFileText />, label: 'My Schemes' },
        {
          icon: <FiUserCheck />,
          label: 'Employees',
          key: 'employees',
          subItems: [
            { path: '/dao', label: 'DAO' },
            { path: '/attendance', label: 'Attendance' }
          ]
        },
        //  { path: '/uploaded-files', icon: <FiUpload />, label: 'Uploaded Files' },
        // { path: '/deletion-logs', icon: <FiFileText />, label: 'Deletion Logs' },
      
        {
          icon: <FiUpload />,
          label: 'Upload',
          key: 'upload',
          subItems: [
            { path: '/flagship-programmes', label: 'Flagship Programs' },
            { path: '/reports', label: 'Reports' }
          ]
        },
        { path: '/budget', icon: <FiDollarSign />, label: 'Budget' },
      ];
    } else {
      return [
        ...baseItems,
        { path: '/attendance', icon: <FiCalendar />, label: 'My Attendance' },
      ];
    }
  };

  const getMonitoringItems = () => {
    if (isAdminLike) {
      const items = [
        { path: '/kpis', icon: <FiTarget />, label: 'KPIs' },
        { path: '/nodal-officers', icon: <FiClipboard />, label: 'Nodal Officers' },
       
      ];

      if (isSuperAdmin) {
        items.push(
          { path: '/send-notification', icon: <FiBell />, label: 'Send Notification' },
          { path: '/send-message', icon: <FiMail />, label: 'Send Message' },
          { path: '/third-party-integration', icon: <FiKey />, label: 'Third-Party Integration' }
        );
      }

      return items;
    }
    return [];
  };

  const mainMenuItems = getMainMenuItems();
  const monitoringItems = getMonitoringItems();

  const normalize = (s) => (s || '').toLowerCase();
  const q = normalize(query);
  const filterItems = (items) => !q ? items : items.filter(i => normalize(i.label).includes(q));
  const filteredMain = filterItems(mainMenuItems);
  const filteredMonitoring = filterItems(monitoringItems);

  return (
    <aside className={`sidebar ${isCollapsed ? 'collapsed' : ''}`}>
      <div className="sidebar-header">
        {!isCollapsed && (
          <>
            <h1>Navigation Menu</h1>
            <p>Quick Access</p>
          </>
        )}
        <button 
          className="sidebar-toggle" 
          onClick={onToggle}
          title={isCollapsed ? 'Expand sidebar' : 'Collapse sidebar'}
        >
          {isCollapsed ? <FiChevronRight /> : <FiChevronLeft />}
        </button>
      </div>
      <nav className="nav-menu">
        {!isCollapsed && (
          <div className="sidebar-search">
            <input
              type="text"
              placeholder="Search menu..."
              value={query}
              onChange={(e) => setQuery(e.target.value)}
            />
          </div>
        )}
        {!isCollapsed && <div className="nav-section">Main Menu</div>}
        {filteredMain.map((item) => {
          const itemKey = item.key || item.path || item.label;
          const isExpanded = expandedItems[itemKey];
          const isItemActive = item.path ? location.pathname === item.path : false;
          
          if (item.subItems) {
            return (
              <div key={itemKey}>
                <button
                  className={`nav-item nav-item-expandable ${isExpanded ? 'expanded' : ''} ${item.subItems.some(sub => location.pathname === sub.path) ? 'active' : ''}`}
                  onClick={() => toggleExpanded(item.key)}
                  title={isCollapsed ? item.label : ''}
                >
                  {item.icon}
                  {!isCollapsed && (
                    <>
                      <span>{item.label}</span>
                      <FiChevronDown className="chevron-icon" />
                    </>
                  )}
                </button>
                {!isCollapsed && isExpanded && (
                  <div className="nav-sub-items">
                    {item.subItems.map((subItem) => (
                      <NavLink
                        key={subItem.path || subItem.label}
                        to={subItem.path}
                        className={({ isActive }) => `nav-sub-item ${isActive ? 'active' : ''}`}
                      >
                        {subItem.label}
                      </NavLink>
                    ))}
                  </div>
                )}
              </div>
            );
          }

          return (
            <NavLink
              key={item.path || item.label}
              to={item.path}
              className={({ isActive }) => `nav-item ${isActive ? 'active' : ''}`}
              title={isCollapsed ? item.label : ''}
            >
              {item.icon}
              {!isCollapsed && <span>{item.label}</span>}
            </NavLink>
          );
        })}
        
        
        {filteredMonitoring.length > 0 && (
          <>
            {!isCollapsed && <div className="nav-section">Monitoring</div>}
            {filteredMonitoring.map((item) => (
              <NavLink
                key={item.path}
                to={item.path}
                className={({ isActive }) => `nav-item ${isActive ? 'active' : ''}`}
                title={isCollapsed ? item.label : ''}
              >
                {item.icon}
                {!isCollapsed && <span>{item.label}</span>}
              </NavLink>
            ))}
          </>
        )}
        
        {!isCollapsed && <div className="nav-section">Settings</div>}
        {isSuperAdmin && (
          <NavLink to="/register-user" className="nav-item" title={isCollapsed ? 'Register User' : ''}>
            <FiUserPlus />
            {!isCollapsed && <span>Register User</span>}
          </NavLink>
        )}
        <NavLink to="/settings" className="nav-item" title={isCollapsed ? 'Settings' : ''}>
          <FiSettings />
          {!isCollapsed && <span>Settings</span>}
        </NavLink>
      </nav>
    </aside>
  );
};

export default Sidebar;
