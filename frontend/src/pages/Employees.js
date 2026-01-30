import React, { useState } from 'react';
import HODs from './HODs';
import DAO from './DAO';
import Staff from './Staff';
import Attendance from './Attendance';
import './Employees.css';

const Employees = () => {
  const user = JSON.parse(localStorage.getItem('user') || '{}');
  const isHOD = user.role === 'hod';
  
  const [activeTab, setActiveTab] = useState(isHOD ? 'dao' : 'hods');

  const adminTabs = [
    { id: 'hods', label: 'HODs', component: HODs },
    { id: 'dao', label: 'DAO', component: DAO },
    { id: 'staff', label: 'Staff', component: Staff },
    { id: 'attendance', label: 'Attendance', component: Attendance },
  ];

  const hodTabs = [
    { id: 'dao', label: 'DAO', component: DAO },
    { id: 'attendance', label: 'Attendance', component: Attendance },
  ];

  const tabs = isHOD ? hodTabs : adminTabs;
  const ActiveComponent = tabs.find(tab => tab.id === activeTab)?.component;

  return (
    <div className="employees-container">
      <div className="employees-tabs">
        {tabs.map(tab => (
          <button
            key={tab.id}
            className={`tab-button ${activeTab === tab.id ? 'active' : ''}`}
            onClick={() => setActiveTab(tab.id)}
          >
            {tab.label}
          </button>
        ))}
      </div>
      <div className="tab-content">
        {ActiveComponent && <ActiveComponent />}
      </div>
    </div>
  );
};

export default Employees;