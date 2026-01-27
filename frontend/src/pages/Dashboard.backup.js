import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import Header from '../components/Header';
import ListModal from '../components/ListModal';
import { Pie, Bar, Line, Doughnut } from 'react-chartjs-2';
import ChartDataLabels from 'chartjs-plugin-datalabels';
import * as XLSX from 'xlsx';
import { FiUsers, FiCheckCircle, FiActivity, FiPieChart, FiFilter, FiBarChart2 } from 'react-icons/fi';
import { BiWallet } from 'react-icons/bi';
import {
  Chart as ChartJS,
  CategoryScale,
  LinearScale,
  BarElement,
  PointElement,
  LineElement,
  Title,
  Tooltip,
  Legend,
  ArcElement,
  Filler
} from 'chart.js';
import {
  getSchemes,
  getSchemesByHODId,
  getBudgetByHODId,
  getAttendanceByHODId,
  getHODs,
  getDashboardStats,
  getDashboardQuickStats,
  getDashboardSchemesSummary,
  getDashboardBudgetSummary,
  getSchemesByCategory,
  getHODsByDepartment,
  getBudgetByHOD,
  getSchemesByHOD,
  getAttendanceByHOD,
  getRevenueByHOD,
  getRevenueByDepartment,
  getDashboardBudgetBreakdown,
  getAttendance
} from '../services/api';
ChartJS.register(
  CategoryScale,
  LinearScale,
  BarElement,
  PointElement,
  LineElement,
  Title,
  Tooltip,
  Legend,
  ArcElement,
  Filler
);

const Dashboard = () => {
  const navigate = useNavigate();
  const [stats, setStats] = useState({
    totalHods: 0,
    activeHods: 0,
    totalSchemes: 0,
    activeSchemes: 0,
    totalStaff: 0,
    activeStaff: 0,
    totalBudget: 0,
    todayAttendance: {
      total: 0,
      present: 0,
      absent: 0,
      late: 0,
      halfDay: 0,
      onLeave: 0
    },
    utilizedBudget: 0,
    totalPrograms: 0,
    activePrograms: 0,
    inactivePrograms: 0
  });
  const [quickStats, setQuickStats] = useState({
    budgetUtilization: 0,
    totalBudget: 0,
    utilizedBudget: 0,
    remainingBudget: 0,
    districtsCovered: 0,
    beneficiaries: 0,
    attendanceRate: 0,
    nodalOfficers: 0
  });
  const [schemesSummary, setSchemesSummary] = useState({
    year: '',
    total: { total: 0, central: 0, state: 0 },
    active: { total: 0, central: 0, state: 0 },
    inactive: { total: 0, central: 0, state: 0 }
  });
  const [budgetSummary, setBudgetSummary] = useState({
    year: '',
    total: { total: 0, central: 0, state: 0 },
    utilized: { total: 0, central: 0, state: 0 },
    remaining: { total: 0, central: 0, state: 0 }
  });
  const [budgetBreakdown, setBudgetBreakdown] = useState({
    year: '',
    estimated: { total: 0, central: 0, state: 0 },
    sanction: { total: 0, central: 0, state: 0 },
    pending: { total: 0, central: 0, state: 0 }
  });
  const [schemesByCategory, setSchemesByCategory] = useState([]);
  const [hodsByDepartment, setHODsByDepartment] = useState([]);
  const [budgetByHOD, setBudgetByHOD] = useState([]);
  const [schemesByHOD, setSchemesByHOD] = useState([]);
  const [attendanceByHOD, setAttendanceByHOD] = useState([]);
  const [revenueByHOD, setRevenueByHOD] = useState([]);
  const [revenueByDepartment, setRevenueByDepartment] = useState([]);
  const [allHODs, setAllHODs] = useState([]);
  const [selectedHOD, setSelectedHOD] = useState('');
  const [selectedHODTable, setSelectedHODTable] = useState({ schemes: '', budget: '', attendance: '', revenue: '' });
  const [revenueDetails, setRevenueDetails] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const [filters, setFilters] = useState({ year: 'All', month: 'All', date: '', hod_id: '' });
  const [modalOpen, setModalOpen] = useState(false);
  const [modalData, setModalData] = useState({ title: '', items: [], columns: [] });
  // Chart filter states
  const [chartFilters, setChartFilters] = useState({
    revenue: { hod_id: '' },
    schemes: { hod_id: '' },
    budget: { hod_id: '' },
    attendance: { hod_id: '' }
  });
  const [openFilterDropdown, setOpenFilterDropdown] = useState(null);
  // Scheme type selection (all, state, central)
  const [selectedSchemeType, setSelectedSchemeType] = useState('all');
  const [allSchemes, setAllSchemes] = useState([]);
  // Schemes year filter
  const [schemesYearFilter, setSchemesYearFilter] = useState('');
  // Schemes HOD filter
  const [schemesHODFilter, setSchemesHODFilter] = useState('');
  // Budget Summary year filter (independent)
  const [budgetSummaryYearFilter, setBudgetSummaryYearFilter] = useState('');
  // Budget Breakdown year filter (independent)
  const [budgetBreakdownYearFilter, setBudgetBreakdownYearFilter] = useState('');
  // Budget by HOD year filter (independent)
  const [budgetByHODYearFilter, setBudgetByHODYearFilter] = useState('');
  // Attendance status selection (all, present, absent, late, leave)
  const [selectedAttendanceStatus, setSelectedAttendanceStatus] = useState('all');
  // Budget type selection (utilized, remaining)
  const [selectedBudgetType, setSelectedBudgetType] = useState('all');
  // Budget summary view selection (overall vs status)
  const [selectedBudgetView, setSelectedBudgetView] = useState('overall');
  // Attendance date range filter
  const [attendanceDatePeriod, setAttendanceDatePeriod] = useState('today');
  const [customDateRange, setCustomDateRange] = useState({ start: '', end: '' });
  // Detailed data for tables when HOD is selected
  const [schemesDetails, setSchemesDetails] = useState([]);
  const [budgetDetails, setBudgetDetails] = useState([]);
  const [attendanceDetails, setAttendanceDetails] = useState([]);

  useEffect(() => {
    // initial load
    fetchHODsList();
    fetchDashboardData();
  }, []);

  useEffect(() => {
    // Refetch data when HOD filter changes
    if (selectedHOD) {
      fetchDashboardData({ ...filters, hod_id: selectedHOD });
      fetchDetailedTableData(selectedHOD);
    } else {
      fetchDashboardData();
      setSchemesDetails([]);
      setBudgetDetails([]);
      setAttendanceDetails([]);
    }
  }, [selectedHOD]);

  useEffect(() => {
    // Fetch full schemes list - always load for HOD filtering capability
    const loadAllSchemes = async () => {
      try {
        const response = await getSchemes();
        setAllSchemes(response.data || []);
      } catch (err) {
        console.error('Error fetching schemes list:', err);
      }
    };

    if (allSchemes.length === 0) {
      loadAllSchemes();
    }
  }, [allSchemes.length]);

  // Fetch schemesDetails when chart filter changes
  useEffect(() => {
    if (chartFilters.schemes.hod_id) {
      getSchemesByHODId(chartFilters.schemes.hod_id)
        .then(res => setSchemesDetails(res.data || []))
        .catch(err => console.error('Error fetching schemes details:', err));
    } else if (!selectedHOD && !selectedHODTable.schemes) {
      setSchemesDetails([]);
    }
  }, [chartFilters.schemes.hod_id]);

  const fetchDetailedTableData = async (hodId) => {
    try {
      const [schemesRes, budgetRes, attendanceRes] = await Promise.all([
        getSchemesByHODId(hodId),
        getBudgetByHODId(hodId),
        getAttendanceByHODId(hodId)
      ]);
      setSchemesDetails(schemesRes.data || []);
      setBudgetDetails(budgetRes.data || []);
      setAttendanceDetails(attendanceRes.data || []);
    } catch (err) {
      console.error('Error fetching detailed table data:', err);
    }
  };

  const fetchHODsList = async () => {
    try {
      const response = await getHODs();
      setAllHODs(response.data || []);
    } catch (err) {
      console.error('Error fetching HODs list:', err);
    }
  };

  const fetchDashboardData = async (overrideFilters = null) => {
    const f = overrideFilters || filters;
    const params = {};
    if (f.year && f.year !== 'All') params.year = f.year;
    if (f.month && f.month !== 'All') params.month = f.month;
    if (f.date) params.date = f.date;
    if (f.hod_id) params.hod_id = f.hod_id;

    // Default to current financial year for schemes summary if not explicitly provided
    const now = new Date();
    const y = now.getFullYear();
    const m = now.getMonth() + 1;
    const fyStart = m >= 4 ? y : y - 1;
    const currentFY = `${fyStart}-${String(fyStart + 1).slice(2)}`;
    const schemesSummaryParams = {
      ...params,
      year: schemesYearFilter || params.year || currentFY
    };

    try {
      setLoading(true);
      
      // Fetch all dashboard data in parallel (pass filters as query params)
      const [
        statsRes,
        quickStatsRes,
        schemesSummaryRes,
        budgetSummaryRes,
        categoryRes,
        hodsDeptRes,
        budgetRes,
        schemesHODRes,
        attendanceRes,
        revenueRes,
        revenueDeptRes,
        budgetBreakdownRes
      ] = await Promise.all([
        getDashboardStats(params),
        getDashboardQuickStats(params),
        getDashboardSchemesSummary(schemesSummaryParams),
        getDashboardBudgetSummary(schemesSummaryParams),
        getSchemesByCategory(params),
        getHODsByDepartment(params),
        getBudgetByHOD(params),
        getSchemesByHOD(params),
        getAttendanceByHOD(params),
        getRevenueByHOD(params),
        getRevenueByDepartment(params),
        getDashboardBudgetBreakdown(schemesSummaryParams)
      ]);

      // Set stats
      setStats({
        totalHods: statsRes.data.totalHods || 0,
        activeHods: statsRes.data.activeHods || 0,
        totalSchemes: statsRes.data.totalSchemes || 0,
        activeSchemes: statsRes.data.activeSchemes || 0,
        totalStaff: statsRes.data.totalStaff || 0,
        activeStaff: statsRes.data.activeStaff || 0,
        totalBudget: parseFloat(statsRes.data.totalBudget) || 0,
        utilizedBudget: parseFloat(statsRes.data.utilizedBudget) || 0,
        todayAttendance: statsRes.data.todayAttendance || {
          total: 0,
          present: 0,
          absent: 0,
          late: 0,
          halfDay: 0,
          onLeave: 0
        },
        totalPrograms: statsRes.data.totalPrograms || 0,
        activePrograms: statsRes.data.activePrograms || 0,
        inactivePrograms: statsRes.data.inactivePrograms || 0
      });

      // Set quick stats
      setQuickStats({
        budgetUtilization: quickStatsRes.data.budgetUtilization || 0,
        totalBudget: parseFloat(quickStatsRes.data.totalBudget) || 0,
        utilizedBudget: parseFloat(quickStatsRes.data.utilizedBudget) || 0,
        remainingBudget: parseFloat(quickStatsRes.data.remainingBudget) || 0,
        districtsCovered: quickStatsRes.data.districtsCovered || 0,
        beneficiaries: quickStatsRes.data.beneficiaries || 0,
        attendanceRate: quickStatsRes.data.attendanceRate || 0,
        nodalOfficers: quickStatsRes.data.nodalOfficers || 0
      });

      // Schemes summary (Central + State)
      setSchemesSummary({
        year: schemesSummaryRes.data?.year || schemesSummaryParams.year,
        total: {
          total: schemesSummaryRes.data?.total?.total || 0,
          central: schemesSummaryRes.data?.total?.central || 0,
          state: schemesSummaryRes.data?.total?.state || 0
        },
        active: {
          total: schemesSummaryRes.data?.active?.total || 0,
          central: schemesSummaryRes.data?.active?.central || 0,
          state: schemesSummaryRes.data?.active?.state || 0
        },
        inactive: {
          total: schemesSummaryRes.data?.inactive?.total || 0,
          central: schemesSummaryRes.data?.inactive?.central || 0,
          state: schemesSummaryRes.data?.inactive?.state || 0
        }
      });

      setBudgetSummary({
        year: budgetSummaryRes.data?.year || schemesSummaryParams.year,
        total: {
          total: budgetSummaryRes.data?.total?.total || 0,
          central: budgetSummaryRes.data?.total?.central || 0,
          state: budgetSummaryRes.data?.total?.state || 0
        },
        utilized: {
          total: budgetSummaryRes.data?.utilized?.total || 0,
          central: budgetSummaryRes.data?.utilized?.central || 0,
          state: budgetSummaryRes.data?.utilized?.state || 0
        },
        remaining: {
          total: budgetSummaryRes.data?.remaining?.total || 0,
          central: budgetSummaryRes.data?.remaining?.central || 0,
          state: budgetSummaryRes.data?.remaining?.state || 0
        }
      });

      setBudgetBreakdown({
        year: budgetBreakdownRes.data?.year || schemesSummaryParams.year,
        estimated: {
          total: budgetBreakdownRes.data?.estimated?.total || 0,
          central: budgetBreakdownRes.data?.estimated?.central || 0,
          state: budgetBreakdownRes.data?.estimated?.state || 0
        },
        sanction: {
          total: budgetBreakdownRes.data?.sanction?.total || 0,
          central: budgetBreakdownRes.data?.sanction?.central || 0,
          state: budgetBreakdownRes.data?.sanction?.state || 0
        },
        pending: {
          total: budgetBreakdownRes.data?.pending?.total || 0,
          central: budgetBreakdownRes.data?.pending?.central || 0,
          state: budgetBreakdownRes.data?.pending?.state || 0
        }
      });

      // Set schemes by category
      setSchemesByCategory(categoryRes.data || []);

      // Set HODs by department
      setHODsByDepartment(hodsDeptRes.data || []);

      // Set budget by HOD
      setBudgetByHOD(budgetRes.data || []);

      // Set schemes by HOD
      setSchemesByHOD(schemesHODRes.data || []);

      // Set attendance by HOD
      setAttendanceByHOD(attendanceRes.data || []);

      // Set revenue by HOD
      setRevenueByHOD(revenueRes.data || []);

      // Set revenue by department
      setRevenueByDepartment(revenueDeptRes.data || []);

      setLoading(false);
    } catch (error) {
      console.error('Error fetching dashboard data:', error);
      setError('Failed to fetch dashboard data. Please make sure the server is running.');
      setLoading(false);
    }
  };

  // Refresh only Budget Summary for a selected year (avoids changing other sections)
  const refreshBudgetSummary = async (year) => {
    // Determine effective year (fallback to current FY logic from fetchDashboardData)
    const now = new Date();
    const y = now.getFullYear();
    const m = now.getMonth() + 1;
    const fyStart = m >= 4 ? y : y - 1;
    const currentFY = `${fyStart}-${String(fyStart + 1).slice(2)}`;
    const effectiveYear = year || schemesYearFilter || filters.year || currentFY;

    try {
      const res = await getDashboardBudgetSummary({ year: effectiveYear });
      setBudgetSummary({
        year: res.data?.year || effectiveYear,
        total: {
          total: res.data?.total?.total || 0,
          central: res.data?.total?.central || 0,
          state: res.data?.total?.state || 0
        },
        utilized: {
          total: res.data?.utilized?.total || 0,
          central: res.data?.utilized?.central || 0,
          state: res.data?.utilized?.state || 0
        },
        remaining: {
          total: res.data?.remaining?.total || 0,
          central: res.data?.remaining?.central || 0,
          state: res.data?.remaining?.state || 0
        }
      });
      setBudgetSummaryYearFilter(effectiveYear);
    } catch (err) {
      console.error('Error refreshing budget summary:', err);
    }
  };

  // Refresh only Budget Breakdown for a selected year (avoids changing other sections)
  const refreshBudgetBreakdown = async (year) => {
    const now = new Date();
    const y = now.getFullYear();
    const m = now.getMonth() + 1;
    const fyStart = m >= 4 ? y : y - 1;
    const currentFY = `${fyStart}-${String(fyStart + 1).slice(2)}`;
    const effectiveYear = year || schemesYearFilter || filters.year || currentFY;

    try {
      const res = await getDashboardBudgetBreakdown({ year: effectiveYear });
      setBudgetBreakdown({
        year: res.data?.year || effectiveYear,
        estimated: {
          total: res.data?.estimated?.total || 0,
          central: res.data?.estimated?.central || 0,
          state: res.data?.estimated?.state || 0
        },
        sanction: {
          total: res.data?.sanction?.total || 0,
          central: res.data?.sanction?.central || 0,
          state: res.data?.sanction?.state || 0
        },
        pending: {
          total: res.data?.pending?.total || 0,
          central: res.data?.pending?.central || 0,
          state: res.data?.pending?.state || 0
        }
      });
      setBudgetBreakdownYearFilter(effectiveYear);
    } catch (err) {
      console.error('Error refreshing budget breakdown:', err);
    }
  };

  const formatCSBreakdown = (central, state) => {
    return `(C:${central} S:${state})`;
  };

  const formatCSBudgetBreakdown = (central, state) => {
    return `(C:${formatCurrency(central)} S:${formatCurrency(state)})`;
  };

  const formatPercent = (count, total) => {
    const t = Number(total) || 0;
    const c = Number(count) || 0;
    if (t <= 0) return '0%';
    return `${((c / t) * 100).toFixed(1)}%`;
  };

  const formatCurrency = (value) => {
    if (typeof value === 'string') value = parseFloat(value);
    if (isNaN(value)) return 'Γé╣0';
    if (value >= 10000000) {
      return `Γé╣${(value / 10000000).toFixed(2)} Cr`;
    } else if (value >= 100000) {
      return `Γé╣${(value / 100000).toFixed(2)} L`;
    }
    return `Γé╣${value.toLocaleString()}`;
  };

  const formatBeneficiaries = (count) => {
    if (count >= 100000) {
      return `${(count / 100000).toFixed(0)}L+`;
    } else if (count >= 1000) {
      return `${(count / 1000).toFixed(0)}K+`;
    }
    return count.toString();
  };

  const formatCompactNumber = (value) => {
    if (value === null || value === undefined) return '0';
    const v = Number(value);
    if (isNaN(v)) return String(value);
    if (Math.abs(v) >= 1000000) return `${(v / 1000000).toFixed(2)}M`;
    if (Math.abs(v) >= 1000) return `${(v / 1000).toFixed(2)}K`;
    return v.toString();
  };

  const handleRefresh = () => {
    fetchDashboardData();
  };

  // Handle chart filter change
  const handleChartFilterChange = (chartType, hodId) => {
    setChartFilters(prev => ({
      ...prev,
      [chartType]: { hod_id: hodId }
    }));
    setOpenFilterDropdown(null);
  };

  // Toggle filter dropdown
  const toggleFilterDropdown = (chartType) => {
    setOpenFilterDropdown(openFilterDropdown === chartType ? null : chartType);
  };

  // Close dropdown when clicking outside
  useEffect(() => {
    const handleClickOutside = (e) => {
      if (!e.target.closest('.chart-filter-container')) {
        setOpenFilterDropdown(null);
      }
    };
    document.addEventListener('click', handleClickOutside);
    return () => document.removeEventListener('click', handleClickOutside);
  }, []);

  // Get filtered data for each chart
  const getFilteredRevenueData = () => {
    if (chartFilters.revenue.hod_id) {
      return revenueByHOD.filter(item => item.hod_name === allHODs.find(h => h.id === parseInt(chartFilters.revenue.hod_id))?.name);
    }
    return revenueByHOD;
  };

  const getFilteredSchemesData = () => {
    if (chartFilters.schemes.hod_id) {
      return schemesByHOD.filter(item => item.hod_name === allHODs.find(h => h.id === parseInt(chartFilters.schemes.hod_id))?.name);
    }
    return schemesByHOD;
  };

  const getFilteredBudgetData = () => {
    if (chartFilters.budget.hod_id) {
      return budgetByHOD.filter(item => item.hod_name === allHODs.find(h => h.id === parseInt(chartFilters.budget.hod_id))?.name);
    }
    return budgetByHOD;
  };

  const getFilteredAttendanceData = () => {
    if (chartFilters.attendance.hod_id) {
      return attendanceByHOD.filter(item => item.hod_name === allHODs.find(h => h.id === parseInt(chartFilters.attendance.hod_id))?.name);
    }
    return attendanceByHOD;
  };

  // Render filter dropdown
  const renderFilterDropdown = (chartType) => {
    if (openFilterDropdown !== chartType) return null;
    return (
      <div style={{
        position: 'absolute',
        top: '100%',
        right: 0,
        backgroundColor: 'white',
        border: '1px solid #ddd',
        borderRadius: '8px',
        boxShadow: '0 4px 12px rgba(0,0,0,0.15)',
        zIndex: 1000,
        minWidth: '200px',
        padding: '8px 0'
      }}>
        <div style={{ padding: '8px 12px', borderBottom: '1px solid #eee', fontWeight: '600', color: '#333' }}>
          Filter by HOD
        </div>
        <div 
          style={{ 
            padding: '8px 12px', 
            cursor: 'pointer',
            backgroundColor: !chartFilters[chartType].hod_id ? '#e8f5e9' : 'transparent',
            color: !chartFilters[chartType].hod_id ? '#2e7d32' : '#333'
          }}
          onClick={() => handleChartFilterChange(chartType, '')}
        >
          All HODs
        </div>
        {allHODs.map(hod => (
          <div 
            key={hod.id}
            style={{ 
              padding: '8px 12px', 
              cursor: 'pointer',
              backgroundColor: chartFilters[chartType].hod_id === String(hod.id) ? '#e8f5e9' : 'transparent',
              color: chartFilters[chartType].hod_id === String(hod.id) ? '#2e7d32' : '#333'
            }}
            onClick={() => handleChartFilterChange(chartType, String(hod.id))}
            onMouseEnter={(e) => e.target.style.backgroundColor = chartFilters[chartType].hod_id === String(hod.id) ? '#e8f5e9' : '#f5f5f5'}
            onMouseLeave={(e) => e.target.style.backgroundColor = chartFilters[chartType].hod_id === String(hod.id) ? '#e8f5e9' : 'transparent'}
          >
            {hod.name}
          </div>
        ))}
      </div>
    );
  };

  const handleExport = () => {
    // Create a new workbook
    const wb = XLSX.utils.book_new();
    
    // Dashboard Statistics Sheet
    const statsData = [
      ['Dashboard Statistics', ''],
      ['', ''],
      ['Metric', 'Value'],
      ['Total HODs', stats.totalHods],
      ['Total Schemes', stats.totalSchemes],
      ['Total Staff', stats.totalStaff],
      ['Total Budget', formatCurrency(stats.totalBudget)],
      ['Utilized Budget', formatCurrency(stats.utilizedBudget)],
      ['Budget Utilization %', `${quickStats.budgetUtilization}%`],
      ['Districts Covered', quickStats.districtsCovered],
      ['Beneficiaries', formatCompactNumber(quickStats.beneficiaries)],
      ['Attendance Rate %', `${quickStats.attendanceRate}%`],
      ['Nodal Officers', quickStats.nodalOfficers]
    ];
    const wsStats = XLSX.utils.aoa_to_sheet(statsData);
    
    // Add styling (header row)
    wsStats['!cols'] = [{ wch: 25 }, { wch: 20 }];
    XLSX.utils.book_append_sheet(wb, wsStats, 'Statistics');
    
    // Schemes by HOD Sheet
    const schemesData = [
      ['Schemes by HOD', ''],
      ['', ''],
      ['HOD Name', 'Total Schemes', 'Total Budget', 'Status']
    ];
    const filteredSchemes = selectedHOD 
      ? schemesDetails.map(s => [s.hod_name || allHODs.find(h => h.id === parseInt(selectedHOD))?.name, s.name, formatCurrency(s.total_budget), s.status])
      : schemesByHOD.map(s => [s.hod_name, s.scheme_count, formatCurrency(s.total_budget), 'Active']);
    
    if (selectedHOD && schemesDetails.length > 0) {
      schemesData.push(['', '', '', '']);
      schemesData.push(['Detailed Schemes:', '', '', '']);
      schemesData.push(['Scheme Name', 'HOD', 'Budget', 'Status']);
      schemesDetails.forEach(s => {
        schemesData.push([s.name, s.hod_name || allHODs.find(h => h.id === parseInt(selectedHOD))?.name, formatCurrency(s.total_budget), s.status]);
      });
    } else {
      schemesData.push(...filteredSchemes);
    }
    
    const wsSchemes = XLSX.utils.aoa_to_sheet(schemesData);
    wsSchemes['!cols'] = [{ wch: 30 }, { wch: 15 }, { wch: 20 }, { wch: 15 }];
    XLSX.utils.book_append_sheet(wb, wsSchemes, 'Schemes');
    
    // Budget by HOD Sheet
    const budgetData = [
      ['Budget by HOD', ''],
      ['', ''],
      ['HOD', 'Department', 'Allocated', 'Utilized', 'Utilization %']
    ];
    const filteredBudget = selectedHOD && budgetDetails.length > 0
      ? budgetDetails.map(b => [
          allHODs.find(h => h.id === parseInt(selectedHOD))?.name || b.hod_name,
          b.department || '',
          formatCurrency(b.allocated_amount),
          formatCurrency(b.utilized_amount),
          `${((b.utilized_amount / b.allocated_amount) * 100).toFixed(1)}%`
        ])
      : budgetByHOD.map(b => [
          b.hod_name,
          b.department,
          formatCurrency(b.allocated),
          formatCurrency(b.utilized),
          `${((b.utilized / b.allocated) * 100).toFixed(1)}%`
        ]);
    budgetData.push(...filteredBudget);
    
    const wsBudget = XLSX.utils.aoa_to_sheet(budgetData);
    wsBudget['!cols'] = [{ wch: 25 }, { wch: 20 }, { wch: 18 }, { wch: 18 }, { wch: 15 }];
    XLSX.utils.book_append_sheet(wb, wsBudget, 'Budget');
    
    // Attendance Summary Sheet
    const attendanceData = [
      ['Attendance Summary by HOD', ''],
      ['', ''],
      ['Department/HOD', 'Present', 'Absent', 'Half Day', 'On Leave', 'Attendance %']
    ];
    const filteredAttendance = selectedHOD && attendanceDetails.length > 0
      ? (() => {
          const summary = attendanceDetails.reduce((acc, a) => {
            acc.present = acc.present + (a.status === 'present' ? 1 : 0);
            acc.absent = acc.absent + (a.status === 'absent' ? 1 : 0);
            acc.half_day = acc.half_day + (a.status === 'half_day' ? 1 : 0);
            acc.on_leave = acc.on_leave + (a.status === 'on_leave' ? 1 : 0);
            return acc;
          }, { present: 0, absent: 0, half_day: 0, on_leave: 0 });
          const total = summary.present + summary.absent + summary.half_day + summary.on_leave;
          const percentage = total > 0 ? ((summary.present / total) * 100).toFixed(1) : 0;
          return [[
            allHODs.find(h => h.id === parseInt(selectedHOD))?.name || 'Selected HOD',
            summary.present,
            summary.absent,
            summary.half_day,
            summary.on_leave,
            `${percentage}%`
          ]];
        })()
      : attendanceByHOD.map(a => {
          const total = a.present + a.absent + a.half_day + (a.on_leave || 0);
          const percentage = total > 0 ? ((a.present / total) * 100).toFixed(1) : 0;
          return [a.hod_name, a.present, a.absent, a.half_day, a.on_leave || 0, `${percentage}%`];
        });
    attendanceData.push(...filteredAttendance);
    
    const wsAttendance = XLSX.utils.aoa_to_sheet(attendanceData);
    wsAttendance['!cols'] = [{ wch: 25 }, { wch: 12 }, { wch: 12 }, { wch: 12 }, { wch: 12 }, { wch: 15 }];
    XLSX.utils.book_append_sheet(wb, wsAttendance, 'Attendance');
    
    // Write file
    const fileName = `dashboard_export_${new Date().toISOString().split('T')[0]}.xlsx`;
    XLSX.writeFile(wb, fileName);
  };

  // Pie chart for HODs by Department (like reference image)
  const hodsByDepartmentChartData = {
    labels: hodsByDepartment.map(item => {
      const count = item.count || 0;
      const countLabel = count >= 1000 ? `${(count / 1000).toFixed(0)}K` : count.toString();
      return `${item.category} (${countLabel})`;
    }),
    datasets: [{
      data: hodsByDepartment.map(item => item.count || 0),
      backgroundColor: [
        '#FFD700', // Yellow/Gold
        '#9C27B0', // Purple
        '#FF9800', // Orange
        '#00BCD4', // Teal/Cyan
        '#2196F3', // Light Blue
        '#E91E63', // Pink
        '#4CAF50', // Green
        '#F44336'  // Red
      ],
      borderWidth: 0,
      hoverOffset: 4
    }]
  };

  const schemesCategoryChartData = {
    labels: schemesByCategory.map(item => item.category),
    datasets: [{
      data: schemesByCategory.map(item => item.budget),
      backgroundColor: [
        '#1565c0',
        '#2e7d32',
        '#ef6c00',
        '#7b1fa2',
        '#c62828',
        '#00838f'
      ],
      borderWidth: 0
    }]
  };

  const budgetHODChartData = {
    labels: budgetByHOD.map(item => item.department),
    datasets: [
      {
        label: 'Allocated',
        data: budgetByHOD.map(item => item.allocated / 10000000),
        backgroundColor: '#1565c0',
        borderRadius: 4,
      },
      {
        label: 'Utilized',
        data: budgetByHOD.map(item => item.utilized / 10000000),
        backgroundColor: '#2e7d32',
        borderRadius: 4,
      }
    ]
  };

  // Pie chart for Schemes by HOD
  const schemesHODPieChartData = {
    labels: schemesByHOD.map(item => item.hod_name),
    datasets: [{
      data: schemesByHOD.map(item => item.scheme_count || 0),
      backgroundColor: [
        '#1565c0', // Blue
        '#2e7d32', // Green
        '#ef6c00', // Orange
        '#7b1fa2', // Purple
        '#c62828', // Red
        '#00838f', // Teal
        '#FFD700', // Gold
        '#E91E63', // Pink
        '#795548', // Brown
        '#607D8B'  // Blue Grey
      ],
      borderWidth: 2,
      borderColor: '#ffffff',
      hoverOffset: 8
    }]
  };

  // Stacked bar chart for Budget by HOD (Allocated, Utilized, Remaining with Cr formatting)
  const filteredBudgetData = getFilteredBudgetData();
  const budgetHODStackedBarData = {
    labels: filteredBudgetData.map(item => item.hod_name || 'Unknown'),
    datasets: [
      {
        label: 'Allocated',
        data: filteredBudgetData.map(item => (item.allocated || 0) / 10000000), // Convert to Cr
        backgroundColor: '#1976d2', // Blue
        stack: 'budget',
        borderRadius: 4,
        borderSkipped: false,
        categoryPercentage: 0.7,
        barPercentage: 0.95
      },
      {
        label: 'Utilized',
        data: filteredBudgetData.map(item => (item.utilized || 0) / 10000000), // Convert to Cr
        backgroundColor: '#2e7d32', // Green
        stack: 'budget',
        borderRadius: 4,
        borderSkipped: false,
        categoryPercentage: 0.7,
        barPercentage: 0.95
      },
      {
        label: 'Remaining',
        data: filteredBudgetData.map(item => ((item.allocated || 0) - (item.utilized || 0)) / 10000000), // Convert to Cr
        backgroundColor: '#ff9800', // Orange
        stack: 'budget',
        borderRadius: 4,
        borderSkipped: false,
        categoryPercentage: 0.7,
        barPercentage: 0.95
      }
    ]
  };

  // Options for stacked budget bar chart
  const budgetHODStackedBarOptions = {
    responsive: true,
    maintainAspectRatio: false,
    indexAxis: 'x',
    plugins: {
      legend: {
        position: 'top',
        labels: {
          usePointStyle: true,
          padding: 15,
          font: { size: 12, weight: '600' },
          color: '#333'
        }
      },
      tooltip: {
        backgroundColor: 'rgba(0,0,0,0.85)',
        padding: 12,
        titleFont: { size: 12, weight: 'bold' },
        bodyFont: { size: 11 },
        callbacks: {
          label: function(context) {
            return `${context.dataset.label}: ₹${context.parsed.y.toFixed(2)} Cr`;
          },
          afterLabel: function(context) {
            const total = context.chart.data.datasets
              .reduce((sum, ds) => sum + (ds.data[context.dataIndex] || 0), 0);
            if (context.datasetIndex === context.chart.data.datasets.length - 1) {
              return `Total: ₹${total.toFixed(2)} Cr`;
            }
            return '';
          }
        }
      },
      datalabels: {
        color: '#fff',
        anchor: 'center',
        align: 'center',
        font: { size: 9, weight: 'bold' },
        formatter: function(value) {
          return value > 0 ? value.toFixed(1) : '';
        },
        display: function(context) {
          return context.dataset.data[context.dataIndex] > 0.05;
        }
      }
    },
    scales: {
      x: {
        stacked: true,
        grid: { display: false },
        ticks: {
          font: { size: 10, weight: '600' },
          maxRotation: 65,
          minRotation: 45,
          autoSkip: false
        }
      },
      y: {
        stacked: true,
        beginAtZero: true,
        grid: { color: 'rgba(0,0,0,0.05)' },
        ticks: {
          font: { size: 11, weight: '600' },
          callback: function(value) {
            return value.toFixed(1);
          }
        },
        title: {
          display: true,
          text: 'Budget (₹ Cr)',
          font: { size: 12, weight: 'bold' }
        }
      }
    }
  };

  // Bar chart for Attendance by HOD (Present, Absent, Half Day, Late, Leave)
  const filteredAttendanceData = getFilteredAttendanceData();
  const attendanceTotalsForChart = filteredAttendanceData.reduce((acc, item) => {
    acc.present += item.present || 0;
    acc.absent += item.absent || 0;
    acc.half_day += item.half_day || 0;
    acc.late += item.late || 0;
    acc.on_leave += item.on_leave || 0;
    return acc;
  }, { present: 0, absent: 0, half_day: 0, late: 0, on_leave: 0 });

  // Calculate total staff for center text
  const totalStaffForAttendance = attendanceTotalsForChart.present + attendanceTotalsForChart.absent + 
    attendanceTotalsForChart.half_day + attendanceTotalsForChart.late + attendanceTotalsForChart.on_leave;

  const attendanceHODBarChartData = {
    labels: ['Attendance Status'],
    datasets: [
      {
        label: 'Present',
        data: [attendanceTotalsForChart.present],
        backgroundColor: '#4CAF50',
        borderRadius: 6,
        borderSkipped: false,
        categoryPercentage: 0.7,
        barPercentage: 0.8
      },
      {
        label: 'Absent',
        data: [attendanceTotalsForChart.absent],
        backgroundColor: '#F44336',
        borderRadius: 6,
        borderSkipped: false,
        categoryPercentage: 0.7,
        barPercentage: 0.8
      },
      {
        label: 'Half Day',
        data: [attendanceTotalsForChart.half_day],
        backgroundColor: '#FF9800',
        borderRadius: 6,
        borderSkipped: false,
        categoryPercentage: 0.7,
        barPercentage: 0.8
      },
      {
        label: 'Late',
        data: [attendanceTotalsForChart.late],
        backgroundColor: '#9C27B0',
        borderRadius: 6,
        borderSkipped: false,
        categoryPercentage: 0.7,
        barPercentage: 0.8
      },
      {
        label: 'Leave',
        data: [attendanceTotalsForChart.on_leave],
        backgroundColor: '#2196F3',
        borderRadius: 6,
        borderSkipped: false,
        categoryPercentage: 0.7,
        barPercentage: 0.8
      }
    ]
  };

  const attendanceBarChartOptions = {
    responsive: true,
    maintainAspectRatio: false,
    indexAxis: 'y',
    plugins: {
      legend: {
        position: 'top',
        labels: {
          usePointStyle: true,
          padding: 12,
          font: { size: 11, weight: '600' },
          color: '#333'
        }
      },
      tooltip: {
        backgroundColor: 'rgba(0,0,0,0.85)',
        padding: 10,
        cornerRadius: 6,
        callbacks: {
          label: function(context) {
            const value = Number(context.parsed?.x ?? context.parsed) || 0;
            const label = context.dataset.label || 'Value';
            return label + ': ' + value.toLocaleString();
          }
        }
      },
      datalabels: {
        color: '#fff',
        anchor: 'end',
        align: 'end',
        offset: -4,
        font: { size: 11, weight: '700' },
        formatter: function(value) {
          return Number(value) > 0 ? Number(value).toLocaleString() : '';
        },
        display: function(context) {
          return Number(context.dataset.data[context.dataIndex]) > 0;
        }
      }
    },
    scales: {
      x: {
        stacked: true,
        beginAtZero: true,
        grid: { color: 'rgba(0,0,0,0.05)' },
        ticks: {
          font: { size: 10, weight: '600' },
          callback: function(value) {
            return Number(value).toLocaleString();
          }
        }
      },
      y: {
        stacked: true,
        grid: { display: false },
        ticks: {
          font: { size: 11, weight: '600' }
        }
      }
    }
  };

  // Custom plugin for center text in donut chart - uses actual staff count from stats
  const centerTextPlugin = {
    id: 'centerText',
    beforeDraw: function(chart) {
      // This plugin is only for pie/doughnut charts, skip for bar charts
      return;
    }
  };

  // HOD Revenue Donut Chart Data - Dynamic colors for any number of departments
  const filteredRevenueData = getFilteredRevenueData();
  
  // Generate dynamic colors for any number of departments
  const generateDynamicColors = (count) => {
    const baseColors = [
      '#4CAF50', // Green
      '#2196F3', // Blue
      '#FF9800', // Orange
      '#9C27B0', // Purple
      '#F44336', // Red
      '#00BCD4', // Cyan
      '#FFEB3B', // Yellow
      '#E91E63', // Pink
      '#3F51B5', // Indigo
      '#009688', // Teal
      '#FF5722', // Deep Orange
      '#607D8B', // Blue Grey
      '#795548', // Brown
      '#8BC34A', // Light Green
      '#03A9F4' // Light Blue
    ];
    const colors = [];
    for (let i = 0; i < count; i++) {
      colors.push(baseColors[i % baseColors.length]);
    }
    return colors;
  };

  // Calculate total revenue for center text
  const totalRevenue = filteredRevenueData.reduce((sum, item) => sum + (Number(item.total_revenue) || 0), 0);
  
  // Format revenue for display
  const formatRevenueShort = (value) => {
    if (value >= 10000000) return `${(value / 10000000).toFixed(1)}Cr`;
    if (value >= 100000) return `${(value / 100000).toFixed(1)}L`;
    if (value >= 1000) return `${(value / 1000).toFixed(1)}K`;
    return value.toString();
  };
  const hodRevenueChartData = {
    labels: filteredRevenueData.map(item => item.department || item.hod_name || 'Unknown'),
    datasets: [{
      data: filteredRevenueData.map(item => Number(item.total_revenue) || 0),
      backgroundColor: generateDynamicColors(filteredRevenueData.length),
      borderWidth: 2,
      borderColor: '#ffffff',
      hoverOffset: 8,
      spacing: 2
    }]
  };

  // Custom plugin for center text in revenue donut chart
  const revenueCenterTextPlugin = {
    id: 'revenueCenterText',
    afterDraw: function(chart) {
      const { ctx, chartArea, width, height } = chart;
      if (!chartArea) return;
      
      const dataset = chart.data.datasets[0];
      if (!dataset) return;
      
      const total = dataset.data.reduce((a, b) => Number(a) + Number(b), 0);
      
      ctx.save();
      
      // Calculate center - use chartArea for accurate center
      const centerX = (chartArea.left + chartArea.right) / 2;
      const centerY = (chartArea.top + chartArea.bottom) / 2;
      
      // Draw "Total Revenue" text
      ctx.font = 'bold 11px "Segoe UI", sans-serif';
      ctx.fillStyle = '#666';
      ctx.textAlign = 'center';
      ctx.textBaseline = 'middle';
      ctx.fillText('Total Revenue', centerX, centerY - 12);
      
      // Format total revenue
      const safeTotal = Number(total);

let displayValue = 'Γé╣0';
if (!isNaN(safeTotal)) {
  if (safeTotal >= 10000000) displayValue = `Γé╣${(safeTotal / 10000000).toFixed(2)} Cr`;
  else if (safeTotal >= 100000) displayValue = `Γé╣${(safeTotal / 100000).toFixed(2)} L`;
  else displayValue = `Γé╣${safeTotal.toLocaleString()}`;
}

      
      // Draw total amount
      ctx.font = 'bold 16px "Segoe UI", sans-serif';
      ctx.fillStyle = '#333';
      ctx.fillText(displayValue, centerX, centerY + 15);
      
      ctx.restore();
    }
  };

  // Helper function to get status color
  const getStatusColor = (status) => {
    switch (status?.toUpperCase()) {
      case 'COMPLETED': return 'rgba(76, 175, 80, 0.8)'; // Green
      case 'PLANNED': return 'rgba(255, 193, 7, 0.8)';   // Yellow
      case 'ACTIVE': return 'rgba(33, 150, 243, 0.8)';   // Blue
      default: return 'rgba(158, 158, 158, 0.8)';        // Grey
    }
  };

  // Schemes HOD wise - Combined Bar and Line Chart Data
  const filteredSchemesData = getFilteredSchemesData();
  
  // When HOD is selected via chart filter, show scheme-wise data with status colors
  const isSchemeWiseView = chartFilters.schemes.hod_id && schemesDetails.length > 0;
  
  const schemesHODBarLineData = isSchemeWiseView ? {
    labels: schemesDetails.map(item => item.name?.split(' ').slice(0, 3).join(' ') || 'Unknown'),
    datasets: [
      {
        type: 'bar',
        label: 'Scheme Budget',
        data: schemesDetails.map(item => (item.total_budget || 0) / 100000), // In Lakhs
        backgroundColor: schemesDetails.map(item => getStatusColor(item.status)),
        borderRadius: 6,
        borderSkipped: false,
        yAxisID: 'y',
        order: 2
      },
      {
        type: 'line',
        label: 'Utilized Budget (L)',
        data: schemesDetails.map(item => (item.budget_utilized || 0) / 100000),
        borderColor: '#FF5722',
        backgroundColor: 'rgba(255, 87, 34, 0.1)',
        borderWidth: 3,
        pointBackgroundColor: '#FF5722',
        pointBorderColor: '#ffffff',
        pointBorderWidth: 2,
        pointRadius: 6,
        pointHoverRadius: 8,
        tension: 0.4,
        fill: true,
        yAxisID: 'y1',
        order: 1
      }
    ]
  } : {
    labels: filteredSchemesData.map(item => item.hod_name?.split(' ').slice(0, 2).join(' ') || 'Unknown'),
    datasets: [
      {
        type: 'bar',
        label: 'Scheme Count',
        data: filteredSchemesData.map(item => item.scheme_count || 0),
        backgroundColor: [
          'rgba(21, 101, 192, 0.8)',
          'rgba(46, 125, 50, 0.8)',
          'rgba(239, 108, 0, 0.8)',
          'rgba(123, 31, 162, 0.8)',
          'rgba(198, 40, 40, 0.8)',
          'rgba(0, 131, 143, 0.8)',
          'rgba(255, 215, 0, 0.8)',
          'rgba(233, 30, 99, 0.8)'
        ],
        borderRadius: 6,
        borderSkipped: false,
        yAxisID: 'y',
        order: 2
      },
      {
        type: 'line',
        label: 'Budget Trend (Cr)',
        data: filteredSchemesData.map(item => (item.total_budget || 0) / 10000000),
        borderColor: '#FF5722',
        backgroundColor: 'rgba(255, 87, 34, 0.1)',
        borderWidth: 3,
        pointBackgroundColor: '#FF5722',
        pointBorderColor: '#ffffff',
        pointBorderWidth: 2,
        pointRadius: 6,
        pointHoverRadius: 8,
        tension: 0.4,
        fill: true,
        yAxisID: 'y1',
        order: 1
      }
    ]
  };

  const revenueChartData = {
    labels: revenueByDepartment.map(item => item.department),
    datasets: [{
      data: revenueByDepartment.map(item => item.total_revenue),
      backgroundColor: [
        '#FFD700', // Yellow/Gold
        '#9C27B0', // Purple
        '#FF9800', // Orange
        '#00BCD4', // Teal/Cyan
        '#2196F3', // Light Blue
        '#E91E63', // Pink
        '#4CAF50', // Green
        '#F44336', // Red
        '#795548', // Brown
        '#607D8B'  // Blue Grey
      ],
      borderWidth: 2,
      borderColor: '#ffffff',
      hoverOffset: 8
    }]
  };

  // Calculate attendance totals for pie chart
  const attendanceTotals = attendanceByHOD.reduce((acc, item) => {
    acc.present += item.present || 0;
    acc.absent += item.absent || 0;
    acc.half_day += item.half_day || 0;
    acc.on_leave += item.on_leave || 0;
    return acc;
  }, { present: 0, absent: 0, half_day: 0, on_leave: 0 });

  const attendanceChartData = {
    labels: ['Present', 'Absent', 'Half Day', 'On Leave'],
    datasets: [{
      data: [
        attendanceTotals.present,
        attendanceTotals.absent,
        attendanceTotals.half_day,
        attendanceTotals.on_leave
      ],
      // backgroundColor: [
      //   '#4CAF50', // Green for present
      //   '#F44336', // Red for absent
      //   '#FF9800', // Orange for half day
      //   '#2196F3'  // Blue for on leave
      // ],
      distance:30,
      connectedWidth:1,
      connectorColor: '#555',

      // borderWidth: 3,
      // borderColor: '#ffffff',
      // hoverOffset: 8
    }]
  };

  const handleChartClick = async (chartType, clickedItem) => {
    try {
      let items = [];
      let columns = [];
      let title = '';

      if (chartType === 'hodsByDepartment') {
        // Get HODs by department
        const allHODs = await getHODs();
        const matchingHODs = allHODs.data.filter(h => h.department === clickedItem);
        items = matchingHODs.map(hod => ({
          name: hod.name,
          department: hod.department,
          email: hod.email,
          phone: hod.phone,
          status: hod.status
        }));
        title = `HODs - ${clickedItem}`;
        columns = [
          { key: 'name', label: 'HOD Name' },
          { key: 'department', label: 'Department' },
          { key: 'email', label: 'Email' },
          { key: 'phone', label: 'Phone' },
          { key: 'status', label: 'Status' }
        ];
      } else if (chartType === 'schemesByCategory') {
        // Get schemes by category - show HODs with schemes in this category
        const allSchemes = await getSchemesByHOD();
        items = allSchemes.data || [];
        title = `HODs with Schemes - ${clickedItem}`;
        columns = [
          { key: 'hod_name', label: 'HOD Name' },
          { key: 'department', label: 'Department' },
          { key: 'scheme_count', label: 'Schemes' },
          { key: 'total_budget', label: 'Total Budget' }
        ];
      } else if (chartType === 'budgetByHOD') {
        // Get HOD details - show all HODs in this department
        const hodData = budgetByHOD.find(h => h.department === clickedItem);
        if (hodData) {
          const allHODs = await getHODs();
          const matchingHODs = allHODs.data.filter(h => h.department === clickedItem);
          items = matchingHODs.map(hod => ({
            name: hod.name,
            department: hod.department,
            email: hod.email,
            phone: hod.phone,
            status: hod.status
          }));
          title = `HODs - ${clickedItem}`;
          columns = [
            { key: 'name', label: 'HOD Name' },
            { key: 'department', label: 'Department' },
            { key: 'email', label: 'Email' },
            { key: 'phone', label: 'Phone' },
            { key: 'status', label: 'Status' }
          ];
        }
      } else if (chartType === 'revenueByDepartment') {
        // Get revenue by department - show HODs in this department
        const deptData = revenueByDepartment.find(d => d.department === clickedItem);
        if (deptData) {
          const allHODs = await getHODs();
          const matchingHODs = allHODs.data.filter(h => h.department === clickedItem);
          items = matchingHODs.map(hod => ({
            name: hod.name,
            department: hod.department,
            email: hod.email,
            phone: hod.phone
          }));
          title = `HODs in ${clickedItem} Department`;
          columns = [
            { key: 'name', label: 'HOD Name' },
            { key: 'department', label: 'Department' },
            { key: 'email', label: 'Email' },
            { key: 'phone', label: 'Phone' }
          ];
        }
      } else if (chartType === 'revenueByHOD') {
        // Get HOD revenue details
        const hodData = revenueByHOD.find(h => h.hod_name === clickedItem);
        if (hodData) {
          const allHODs = await getHODs();
          const hod = allHODs.data.find(h => h.name === clickedItem);
          if (hod) {
            items = [{ ...hodData, department: hod.department }];
            title = `Revenue Details - ${clickedItem}`;
            columns = [
              { key: 'hod_name', label: 'HOD Name' },
              { key: 'department', label: 'Department' },
              { key: 'total_revenue', label: 'Revenue' }
            ];
          }
        }
      } else if (chartType === 'attendanceByHOD') {
        // Get attendance details for HOD
        const hodData = attendanceByHOD.find(h => h.hod_name === clickedItem);
        if (hodData) {
          items = [hodData];
          title = `Attendance Details - ${clickedItem}`;
          columns = [
            { key: 'hod_name', label: 'HOD Name' },
            { key: 'department', label: 'Department' },
            { key: 'present', label: 'Present' },
            { key: 'absent', label: 'Absent' },
            { key: 'half_day', label: 'Half Day' },
            { key: 'on_leave', label: 'On Leave' }
          ];
        }
      } else if (chartType === 'attendanceByStatus') {
        // Get attendance list by status (Present, Absent, Half Day, Late, Leave)
        const statusMap = {
          'Present': 'present',
          'Absent': 'absent',
          'Half Day': 'half_day',
          'Late': 'late',
          'Leave': 'on_leave'
        };
        const statusKey = statusMap[clickedItem] || clickedItem.toLowerCase();
        
        try {
          const attendanceResponse = await getAttendance();
          const allAttendance = attendanceResponse.data || [];
          
          // Filter by status
          const filteredAttendance = allAttendance.filter(item => {
            if (clickedItem === 'Present') return item.status === 'present';
            if (clickedItem === 'Absent') return item.status === 'absent';
            if (clickedItem === 'Half Day') return item.status === 'half_day';
            if (clickedItem === 'Late') return item.status === 'late';
            if (clickedItem === 'Leave') return item.status === 'on_leave' || item.status === 'leave';
            return false;
          });
          
          items = filteredAttendance.map(item => ({
            staff_name: item.staff_name || item.name || 'Unknown',
            department: item.department || '-',
            date: item.date ? new Date(item.date).toLocaleDateString() : '-',
            check_in: item.check_in || '-',
            check_out: item.check_out || '-',
            status: item.status || clickedItem
          }));
          
          title = `${clickedItem} Staff List (${items.length})`;
          columns = [
            { key: 'staff_name', label: 'Staff Name' },
            { key: 'department', label: 'Department' },
            { key: 'date', label: 'Date' },
            { key: 'check_in', label: 'Check In' },
            { key: 'check_out', label: 'Check Out' }
          ];
        } catch (err) {
          console.error('Error fetching attendance by status:', err);
          items = [];
        }
      }

      if (items.length > 0) {
        setModalData({ title, items, columns });
        setModalOpen(true);
      }
    } catch (error) {
      console.error('Error fetching chart details:', error);
      alert('Error loading details. Please try again.');
    }
  };

  const formatModalItem = (item, key) => {
    if (key === 'total_budget' || key === 'total_revenue' || key === 'allocated' || key === 'utilized') {
      return formatCurrency(item[key]);
    }
    return item[key] || '-';
  };

  const pieChartOptions = {
    responsive: true,
    maintainAspectRatio: false,
    layout: {
      padding: {
        left: 5,
        right: 5,
        top: 5,
        bottom: 5
      }
    },
    plugins: {
      legend: {
        position: 'right',
        align: 'center',
        maxHeight: 180,
        labels: {
          padding: 10,
          usePointStyle: true,
          pointStyle: 'circle',
          boxWidth: 10,
          font: {
            size: 11,
            weight: '500',
            family: "'Segoe UI', sans-serif"
          },
          generateLabels: function(chart) {
            const data = chart.data;
            if (data.labels.length && data.datasets.length) {
              const total = data.datasets[0].data.reduce((a, b) => a + b, 0);
              return data.labels.map((label, i) => {
                const value = data.datasets[0].data[i];
                const percentage = total > 0 ? ((value / total) * 100).toFixed(1) : 0;
                const truncatedLabel = label.length > 20 ? label.substring(0, 18) + '..' : label;
                return {
                  text: `${truncatedLabel} (${percentage}%)`,
                  fillStyle: data.datasets[0].backgroundColor[i],
                  strokeStyle: '#ffffff',
                  lineWidth: 1,
                  hidden: false,
                  index: i
                };
              });
            }
            return [];
          }
        }
      },
      tooltip: {
        backgroundColor: 'rgba(0, 0, 0, 0.8)',
        padding: 12,
        titleFont: {
          size: 14,
          weight: 'bold'
        },
        bodyFont: {
          size: 13
        },
        callbacks: {
          label: function(context) {
            const label = context.label || '';
            const value = context.parsed || 0;
            const total = context.dataset.data.reduce((a, b) => a + b, 0);
            const percentage = total > 0 ? ((value / total) * 100).toFixed(1) : 0;
            return `${label}: ${formatCurrency(value)} (${percentage}%)`;
          }
        }
      },
      datalabels: {
        color: '#fff',
        font: {
          size: 11,
          weight: 'bold'
        },
        anchor: 'center',
        align: 'center',
        formatter: function(value, context) {
          const total = context.dataset.data.reduce((a, b) => a + b, 0);
          const percentage = total > 0 ? ((value / total) * 100).toFixed(0) : 0;
          return percentage >= 5 ? `${percentage}%` : '';
        },
        display: function(context) {
          const total = context.dataset.data.reduce((a, b) => a + b, 0);
          const value = context.dataset.data[context.dataIndex];
          const percentage = total > 0 ? ((value / total) * 100) : 0;
          return percentage >= 5;
        }
      }
    },
    elements: {
      arc: {
        borderWidth: 2,
        borderColor: '#ffffff'
      }
    },
    onClick: (event, elements) => {
      if (elements.length > 0) {
        const element = elements[0];
        const chart = event.chart;
        const index = element.index;
        const department = hodsByDepartment[index]?.category;
        if (department) {
          handleChartClick('hodsByDepartment', department);
        }
      }
    }
  };

  const chartOptions = {
    responsive: true,
    maintainAspectRatio: false,
    plugins: {
      legend: {
        position: 'bottom',
        labels: {
          padding: 20,
          usePointStyle: true,
          font: {
            size: 11
          }
        }
      },
      tooltip: {
        callbacks: {
          label: function(context) {
            let label = context.label || '';
            if (label) {
              label += ': ';
            }
            if (context.parsed !== null) {
              if (context.dataset.label === 'Allocated' || context.dataset.label === 'Utilized') {
                label += formatCurrency(context.parsed.y * 10000000);
              } else {
                label += formatCurrency(context.parsed);
              }
            }
            return label;
          }
        }
      }
    },
    onClick: (event, elements) => {
      if (elements.length > 0) {
        const element = elements[0];
        const chart = event.chart;
        const label = chart.data.labels[element.index];
        handleChartClick('schemesByCategory', label);
      }
    }
  };

  const barOptions = {
    ...chartOptions,
    plugins: {
      ...chartOptions.plugins,
      legend: {
        ...chartOptions.plugins.legend,
        position: 'top'
      },
      tooltip: {
        callbacks: {
          label: function(context) {
            let label = context.dataset.label || '';
            if (label) {
              label += ': ';
            }
            if (context.parsed.y !== null) {
              if (context.dataset.label === 'Allocated' || context.dataset.label === 'Utilized') {
                label += formatCurrency(context.parsed.y * 10000000);
              } else {
                label += context.parsed.y;
              }
            }
            return label;
          }
        }
      }
    },
    onClick: (event, elements) => {
      if (elements.length > 0) {
        const element = elements[0];
        const chart = event.chart;
        const label = chart.data.labels[element.index];
        handleChartClick('budgetByHOD', label);
      }
    },
    scales: {
      y: {
        beginAtZero: true,
        grid: {
          color: 'rgba(0,0,0,0.05)'
        },
        title: {
          display: true,
          text: 'Amount (Cr)',
          font: { size: 11 }
        },
        ticks: {
          callback: function(value) {
            return formatCurrency(value * 10000000);
          }
        }
      },
      x: {
        grid: {
          display: false
        }
      }
    }
  };

  // Schemes Bar + Line Chart Options
  const schemesBarLineOptions = {
    responsive: true,
    maintainAspectRatio: false,
    interaction: {
      mode: 'index',
      intersect: false,
    },
    plugins: {
      legend: {
        position: 'top',
        labels: {
          padding: 15,
          usePointStyle: true,
          font: {
            size: 12,
            weight: '500'
          }
        }
      },
      tooltip: {
        backgroundColor: 'rgba(0, 0, 0, 0.85)',
        padding: 12,
        titleFont: { size: 14, weight: 'bold' },
        bodyFont: { size: 13 },
        callbacks: {
          label: function(context) {
            let label = context.dataset.label || '';
            if (label) {
              label += ': ';
            }
            if (context.dataset.type === 'line') {
              label += formatCurrency(context.parsed.y * 10000000);
            } else {
              label += context.parsed.y + ' schemes';
            }
            return label;
          }
        }
      }
    },
    scales: {
      y: {
        type: 'linear',
        display: true,
        position: 'left',
        beginAtZero: true,
        title: {
          display: true,
          text: 'Scheme Count',
          font: { size: 11, weight: '600' }
        },
        grid: {
          color: 'rgba(0, 0, 0, 0.06)'
        },
        ticks: {
          stepSize: 1
        }
      },
      y1: {
        type: 'linear',
        display: true,
        position: 'right',
        beginAtZero: true,
        title: {
          display: true,
          text: 'Budget (Cr)',
          font: { size: 11, weight: '600' }
        },
        grid: {
          drawOnChartArea: false,
        },
        ticks: {
          callback: function(value) {
            return 'Γé╣' + value + 'Cr';
          }
        }
      },
      x: {
        grid: {
          display: false
        },
        ticks: {
          font: { size: 10 },
          maxRotation: 45,
          minRotation: 45
        }
      }
    }
  };

  // HOD Revenue Donut Chart Options with center text and amount labels
  const hodRevenuePieOptions = {
    responsive: true,
    maintainAspectRatio: false,
    cutout: '60%',
    layout: {
      padding: {
        top: 5,
        bottom: 5,
        left: 5,
        right: 5
      }
    },
    plugins: {
      legend: {
        display: true,
        position: 'right',
        align: 'center',
        maxHeight: 180,
        labels: {
          padding: 8,
          usePointStyle: true,
          pointStyle: 'circle',
          boxWidth: 10,
          font: {
            size: 10,
            weight: '500'
          },
          generateLabels: function(chart) {
            const data = chart.data;
            if (data.labels.length && data.datasets.length) {
              const total = data.datasets[0].data.reduce((a, b) => Number(a) + Number(b), 0);
              return data.labels.map((label, i) => {
                const value = Number(data.datasets[0].data[i]) || 0;
                const percentage = total > 0 ? (value / total) * 100 : 0;
                const pctText = percentage > 0 && percentage < 1 ? '<1' : percentage.toFixed(0);
                const truncatedLabel = label.length > 18 ? label.substring(0, 16) + '..' : label;
                return {
                  text: `${truncatedLabel} (${pctText}%)`,
                  fillStyle: data.datasets[0].backgroundColor[i],
                  strokeStyle: '#ffffff',
                  lineWidth: 1,
                  hidden: false,
                  index: i
                };
              });
            }
            return [];
          }
        }
      },
      tooltip: {
        backgroundColor: 'rgba(0, 0, 0, 0.85)',
        padding: 12,
        titleFont: { size: 14, weight: 'bold' },
        bodyFont: { size: 13 },
        callbacks: {
          label: function(context) {
            const value = context.parsed || 0;
            const total = context.dataset.data.reduce((a, b) => Number(a) + Number(b), 0);
            const percentage = total > 0 ? ((value / total) * 100).toFixed(1) : 0;
            return `Revenue: Γé╣${formatRevenueShort(value)} (${percentage}%)`;
          }
        }
      },
      datalabels: {
        color: '#fff',
        font: {
          size: 11,
          weight: 'bold',
          family: "'Segoe UI', sans-serif"
        },
        anchor: 'center',
        align: 'center',
        offset: 0,
        formatter: function(value, context) {
          const total = context.dataset.data.reduce((a, b) => Number(a) + Number(b), 0);
          const percentage = total > 0 ? (Number(value) / total) * 100 : 0;
          if (percentage <= 0) return '';
          if (percentage < 3) return '';
          return `${percentage.toFixed(0)}%`;
        },
        display: function(context) {
          const total = context.dataset.data.reduce((a, b) => Number(a) + Number(b), 0);
          const value = Number(context.dataset.data[context.dataIndex]) || 0;
          const percentage = total > 0 ? (value / total) * 100 : 0;
          return percentage >= 3;
        }
      }
    },
    elements: {
      arc: {
        borderWidth: 2,
        borderColor: '#ffffff'
      }
    },
    onClick: (event, elements) => {
      if (elements.length > 0) {
        const element = elements[0];
        const index = element.index;
        const hodName = filteredRevenueData[index]?.hod_name;
        if (hodName) {
          handleChartClick('revenueByHOD', hodName);
        }
      }
    }
  };

  // Attendance Donut Chart Options with center text and percentage labels
  const attendancePieOptions = {
    responsive: true,
    maintainAspectRatio: false,
    layout: {
      padding: {
        top: 15,
        bottom: 15,
        left: 10,
        right: 10
      }
    },
    plugins: {
      legend: {
        display: true,
        position: 'right',
        align: 'center',
        maxHeight: 180,
        labels: {
          padding: 10,
          usePointStyle: true,
          pointStyle: 'circle',
          boxWidth: 10,
          font: {
            size: 11,
            weight: '500'
          },
          generateLabels: function(chart) {
            const data = chart.data;
            if (data.labels.length && data.datasets.length) {
              const total = data.datasets[0].data.reduce((a, b) => a + b, 0);
              return data.labels.map((label, i) => {
                const value = data.datasets[0].data[i];
                const percentage = total > 0 ? ((value / total) * 100).toFixed(0) : 0;
                return {
                  text: `${label}: ${value} (${percentage}%)`,
                  fillStyle: data.datasets[0].backgroundColor[i],
                  strokeStyle: '#ffffff',
                  lineWidth: 1,
                  hidden: false,
                  index: i
                };
              });
            }
            return [];
          }
        }
      },
      tooltip: {
        backgroundColor: 'rgba(0, 0, 0, 0.85)',
        padding: 12,
        titleFont: { size: 14, weight: 'bold' },
        bodyFont: { size: 13 },
        callbacks: {
          label: function(context) {
            const value = context.parsed || 0;
            const total = context.dataset.data.reduce((a, b) => a + b, 0);
            const percentage = total > 0 ? ((value / total) * 100).toFixed(1) : 0;
            return `Count: ${value} (${percentage}%)`;
          }
        }
      },
      datalabels: {
        color: '#fff',
        font: {
          size: 11,
          weight: 'bold',
          family: "'Segoe UI', sans-serif"
        },
        anchor: 'center',
        align: 'center',
        offset: 0,
        formatter: function(value, context) {
          const total = context.dataset.data.reduce((a, b) => a + b, 0);
          const percentage = total > 0 ? ((value / total) * 100).toFixed(0) : 0;
          return percentage >= 5 ? `${percentage}%` : '';
        },
        display: function(context) {
          const total = context.dataset.data.reduce((a, b) => a + b, 0);
          const value = context.dataset.data[context.dataIndex];
          const percentage = total > 0 ? ((value / total) * 100) : 0;
          return percentage >= 5;
        }
      }
    },
    elements: {
      arc: {
        borderWidth: 3,
        borderColor: '#ffffff'
      }
    },
    onClick: (event, elements) => {
      if (elements.length > 0) {
        const element = elements[0];
        const index = element.index;
        const statusLabels = ['Present', 'Absent', 'Half Day', 'Late', 'Leave'];
        const clickedStatus = statusLabels[index];
        if (clickedStatus) {
          handleChartClick('attendanceByStatus', clickedStatus);
        }
      }
    }
  };

  // Custom plugin to draw connector lines for attendance pie chart
  const connectorLinesPlugin = {
    id: 'connectorLines',
    afterDraw: function(chart) {
      const ctx = chart.ctx;
      const meta = chart.getDatasetMeta(0);
      
      if (!meta || !meta.data) return;
      
      meta.data.forEach((arc, index) => {
        if (chart.data.datasets[0].data[index] <= 0) return;
        
        const centerX = arc.x;
        const centerY = arc.y;
        const outerRadius = arc.outerRadius;
        const startAngle = arc.startAngle;
        const endAngle = arc.endAngle;
        const middleAngle = (startAngle + endAngle) / 2;
        
        // Calculate points for the connector line - start from edge of pie
        const innerPointX = centerX + Math.cos(middleAngle) * outerRadius;
        const innerPointY = centerY + Math.sin(middleAngle) * outerRadius;
        
        // Extend line further out (outerRadius + 30)
        const outerPointX = centerX + Math.cos(middleAngle) * (outerRadius + 30);
        const outerPointY = centerY + Math.sin(middleAngle) * (outerRadius + 30);
        
        // Get color from dataset
        const color = chart.data.datasets[0].backgroundColor[index];
        
        // Draw the connector line
        ctx.save();
        ctx.beginPath();
        ctx.moveTo(innerPointX, innerPointY);
        ctx.lineTo(outerPointX, outerPointY);
        ctx.strokeStyle = color;
        ctx.lineWidth = 2;
        ctx.stroke();
        
        // Draw small arrow/dot at the end
        ctx.beginPath();
        ctx.arc(outerPointX, outerPointY, 4, 0, Math.PI * 2);
        ctx.fillStyle = color;
        ctx.fill();
        ctx.restore();
      });
    }
  };

  const revenueChartOptions = {
    ...pieChartOptions,
    onClick: (event, elements) => {
      if (elements.length > 0) {
        const element = elements[0];
        const chart = event.chart;
        const index = element.index;
        const department = revenueByDepartment[index]?.department;
        if (department) {
          handleChartClick('revenueByDepartment', department);
        }
      }
    }
  };

  const selectedSchemesYear = schemesYearFilter || schemesSummary.year;
  const filteredSchemesList = allSchemes.filter((scheme) => {
    if (!scheme) return false;
    // Filter by year
    const yearMatch = !selectedSchemesYear || selectedSchemesYear === 'All' || scheme.financial_year === selectedSchemesYear;
    // Filter by HOD if selected - match against hod_name field (which comes from scheme's hod field aliased)
    const selectedHODObj = schemesHODFilter ? allHODs.find(h => h.id === parseInt(schemesHODFilter)) : null;
    const selectedHODName = selectedHODObj?.name || '';
    const schemeHODName = scheme.hod_name || scheme.hod || '';
    const hodMatch = !schemesHODFilter || schemeHODName.toLowerCase() === selectedHODName.toLowerCase();
    return yearMatch && hodMatch;
  });

  // Calculate split view counts from filtered schemes list when HOD is selected
  const filteredSplitCounts = (() => {
    if (!schemesHODFilter) {
      // No HOD filter, use API summary data
      return {
        active: { state: schemesSummary.active.state || 0, central: schemesSummary.active.central || 0 },
        inactive: { state: schemesSummary.inactive.state || 0, central: schemesSummary.inactive.central || 0 }
      };
    }
    // Calculate from filtered list
    const activeState = filteredSchemesList.filter(s => 
      (s.status === 'active' || s.status === 'Active' || s.status === 'ACTIVE') && 
      (s.scheme_type === 'state' || s.scheme_type === 'State' || !s.central_scheme_name)
    ).length;
    const activeCentral = filteredSchemesList.filter(s => 
      (s.status === 'active' || s.status === 'Active' || s.status === 'ACTIVE') && 
      (s.scheme_type === 'central' || s.scheme_type === 'Central' || s.central_scheme_name)
    ).length;
    const inactiveState = filteredSchemesList.filter(s => 
      (s.status !== 'active' && s.status !== 'Active' && s.status !== 'ACTIVE') && 
      (s.scheme_type === 'state' || s.scheme_type === 'State' || !s.central_scheme_name)
    ).length;
    const inactiveCentral = filteredSchemesList.filter(s => 
      (s.status !== 'active' && s.status !== 'Active' && s.status !== 'ACTIVE') && 
      (s.scheme_type === 'central' || s.scheme_type === 'Central' || s.central_scheme_name)
    ).length;
    return {
      active: { state: activeState, central: activeCentral },
      inactive: { state: inactiveState, central: inactiveCentral }
    };
  })();

  const totalSchemeCount = filteredSchemesList.length || (schemesHODFilter ? 0 : schemesSummary.total.total) || 0;
  const perSchemePercent = totalSchemeCount > 0 ? 100 / totalSchemeCount : 0;
  const isTotalSchemesView = selectedSchemeType === 'all';
  
  // Adjust bar thickness based on number of schemes
  const dynamicBarThickness = filteredSchemesList.length <= 3 ? 40 : (filteredSchemesList.length <= 6 ? 30 : 24);

  const schemesChartData = isTotalSchemesView
    ? {
        labels: filteredSchemesList.map((scheme) => scheme.scheme_name || scheme.name || 'Scheme'),
        datasets: [
          {
            label: 'Schemes',
            data: filteredSchemesList.map(() => perSchemePercent),
            backgroundColor: '#1976d2',
            borderRadius: 6,
            barThickness: dynamicBarThickness,
            maxBarThickness: 50
          }
        ]
      }
    : {
        labels: ['State', 'Central'],
        datasets: [
          {
            label: 'Active',
            data: [filteredSplitCounts.active.state, filteredSplitCounts.active.central],
            backgroundColor: '#2e7d32',
            stack: 'status',
            borderRadius: 6,
            barThickness: 20
          },
          {
            label: 'Inactive',
            data: [filteredSplitCounts.inactive.state, filteredSplitCounts.inactive.central],
            backgroundColor: '#9e9e9e',
            stack: 'status',
            borderRadius: 6,
            barThickness: 20
          }
        ]
      };

  // Determine if we should show horizontal labels (when few schemes)
  const useHorizontalLabels = filteredSchemesList.length <= 5;
  
  // Dynamic chart height based on number of schemes
  const schemesChartHeight = filteredSchemesList.length > 10 ? '320px' : (filteredSchemesList.length <= 5 ? '220px' : '260px');

  const schemesChartOptions = {
    responsive: true,
    maintainAspectRatio: false,
    indexAxis: isTotalSchemesView ? 'x' : 'y',
    layout: { padding: { top: 10, right: 12, left: 6, bottom: 0 } },
    scales: {
      x: {
        stacked: !isTotalSchemesView,
        beginAtZero: true,
        max: isTotalSchemesView ? undefined : undefined,
        grid: { color: 'rgba(0,0,0,0.05)', display: !isTotalSchemesView },
        ticks: isTotalSchemesView
          ? {
              font: { size: useHorizontalLabels ? 11 : 9, weight: useHorizontalLabels ? '500' : 'normal' },
              maxRotation: useHorizontalLabels ? 0 : 65,
              minRotation: useHorizontalLabels ? 0 : 65,
              autoSkip: false,
              padding: useHorizontalLabels ? 8 : 4
            }
          : {
              font: { size: 10 },
              callback: function(value) {
                return value;
              }
            }
      },
      y: {
        stacked: !isTotalSchemesView,
        beginAtZero: true,
        max: isTotalSchemesView ? 100 : undefined,
        grid: { display: isTotalSchemesView, color: 'rgba(0,0,0,0.05)' },
        ticks: isTotalSchemesView
          ? {
              font: { size: 10, weight: '600' },
              callback: function(value) {
                return `${value}%`;
              }
            }
          : { font: { size: 11, weight: '600' } }
      }
    },
    plugins: {
      legend: {
        display: !isTotalSchemesView,
        position: 'bottom',
        labels: { usePointStyle: true, padding: 12, font: { size: 11, weight: '600' } }
      },
      tooltip: {
        callbacks: {
          label: function(context) {
            const value = context.parsed.x || 0;
            if (isTotalSchemesView) {
              return `${context.label}: ${value.toFixed(1)}%`;
            }
            const totalForBar = context.chart.data.datasets.reduce((sum, ds) => sum + (ds.data[context.dataIndex] || 0), 0);
            const pct = totalForBar > 0 ? ((value / totalForBar) * 100).toFixed(1) : 0;
            return `${context.dataset.label}: ${value} (${pct}%)`;
          }
        }
      },
      datalabels: {
        color: '#0d1c2c',
        anchor: isTotalSchemesView ? 'end' : 'center',
        align: isTotalSchemesView ? 'end' : 'center',
        offset: isTotalSchemesView ? -4 : 0,
        font: { size: 10, weight: '700' },
        formatter: function(value, context) {
          if (!value) return '';
          if (isTotalSchemesView) {
            return `${value.toFixed(1)}%`;
          }
          const totalForBar = context.chart.data.datasets.reduce((sum, ds) => sum + (ds.data[context.dataIndex] || 0), 0);
          return totalForBar > 0 ? `${Math.round((value / totalForBar) * 100)}%` : '';
        }
      }
    }
  };

  // Budget Summary - Vertical Bar (Overall vs Status views)
  const overallBudgetBarData = {
    labels: ['Total', 'State', 'Central', 'Sanctioned', 'Estimated', 'Pending'],
    datasets: [
      {
        label: 'Allocated',
        data: [
          ((budgetSummary.total.total - (budgetSummary.remaining.total || 0)) / 10000000),
          ((budgetSummary.total.state - ((budgetSummary.remaining.state || 0))) / 10000000),
          ((budgetSummary.total.central - ((budgetSummary.remaining.central || 0))) / 10000000),
          ((budgetBreakdown.sanction.total || 0) / 10000000),
          ((budgetBreakdown.estimated.total || 0) / 10000000),
          ((budgetBreakdown.pending.total || 0) / 10000000)
        ],
        backgroundColor: '#1565c0',
        stack: 'overall',
        borderRadius: 6,
        borderSkipped: false,
        categoryPercentage: 0.7,
        barPercentage: 0.85
      },
      {
        label: 'Utilized',
        data: [
          ((budgetSummary.utilized.total || 0) / 10000000),
          ((budgetSummary.utilized.state || 0) / 10000000),
          ((budgetSummary.utilized.central || 0) / 10000000),
          0,
          0,
          0
        ],
        backgroundColor: '#2e7d32',
        stack: 'overall',
        borderRadius: 6,
        borderSkipped: false,
        categoryPercentage: 0.7,
        barPercentage: 0.85
      },
      {
        label: 'Remaining',
        data: [
          ((budgetSummary.remaining.total || 0) / 10000000),
          ((budgetSummary.remaining.state || 0) / 10000000),
          ((budgetSummary.remaining.central || 0) / 10000000),
          0,
          0,
          0
        ],
        backgroundColor: '#9e9e9e',
        stack: 'overall',
        borderRadius: 6,
        borderSkipped: false,
        categoryPercentage: 0.7,
        barPercentage: 0.85
      }
    ]
  };

  const statusBudgetBarData = {
    labels: ['Budget Status'],
    datasets: [
      {
        label: 'Sanctioned',
        data: [(budgetBreakdown.sanction.total || 0) / 10000000],
        backgroundColor: '#2e7d32',
        borderRadius: 6,
        borderSkipped: false,
        categoryPercentage: 0.8,
        barPercentage: 0.8
      },
      {
        label: 'Estimated',
        data: [(budgetBreakdown.estimated.total || 0) / 10000000],
        backgroundColor: '#f57c00',
        borderRadius: 6,
        borderSkipped: false,
        categoryPercentage: 0.8,
        barPercentage: 0.8
      },
      {
        label: 'Pending',
        data: [(budgetBreakdown.pending.total || 0) / 10000000],
        backgroundColor: '#c62828',
        borderRadius: 6,
        borderSkipped: false,
        categoryPercentage: 0.8,
        barPercentage: 0.8
      }
    ]
  };

  const isBudgetOverallView = selectedBudgetView === 'overall';
  const budgetSummaryChartData = isBudgetOverallView ? overallBudgetBarData : statusBudgetBarData;

  const budgetSummaryChartOptions = {
    responsive: true,
    maintainAspectRatio: false,
    indexAxis: 'x',
    plugins: {
      legend: {
        position: 'top',
        labels: {
          usePointStyle: true,
          padding: 12,
          font: { size: 12, weight: '600' },
          color: '#333'
        }
      },
      tooltip: {
        backgroundColor: 'rgba(0,0,0,0.85)',
        padding: 12,
        cornerRadius: 6,
        callbacks: {
          label: function(context) {
            const raw = Number(context.parsed?.y ?? context.parsed) || 0;
            const label = context.dataset.label || context.label || 'Value';
            return label + ': Rs ' + raw.toFixed(2) + ' Cr';
          }
        }
      },
      datalabels: {
        color: '#fff',
        anchor: 'end',
        align: 'end',
        offset: -4,
        font: { size: 10, weight: '700' },
        formatter: function(value) {
          const v = Number(value) || 0;
          return v > 0 ? 'Rs ' + v.toFixed(1) + 'Cr' : '';
        },
        display: function(context) {
          const v = context.dataset.data[context.dataIndex];
          return Number(v) > 0;
        }
      }
    },
    scales: {
      x: {
        stacked: isBudgetOverallView,
        grid: { display: false },
        ticks: {
          font: { size: 11, weight: '600' }
        }
      },
      y: {
        stacked: isBudgetOverallView,
        beginAtZero: true,
        grid: { color: 'rgba(0,0,0,0.05)' },
        ticks: {
          font: { size: 11, weight: '600' },
          callback: function(value) {
            const v = Number(value) || 0;
            return v.toFixed(1);
          }
        },
        title: {
          display: true,
          text: 'Budget (Rs Cr)',
          font: { size: 12, weight: 'bold' }
        }
      }
    }
  };

  if (loading) {
    return (
      <div className="loading">
        <div className="spinner"></div>
      </div>
    );
  }

  return (
    <div className="page-container">
      {/* <Header 
        title="Dashboard" 
        subtitle="Welcome to HOD Management System" 
        onRefresh={handleRefresh}
        onExport={handleExport}
      /> */}

      {/* Filter Bar - Commented out
      <div className="filter-bar">
        <div className="filter-item">
          <label>HOD</label>
          <select 
            value={selectedHOD} 
            onChange={(e) => {
              setSelectedHOD(e.target.value);
              setFilters({ ...filters, hod_id: e.target.value });
            }}
          >
            <option value="">All HODs</option>
            {allHODs.map(hod => (
              <option key={hod.id} value={hod.id}>{hod.name} - {hod.department}</option>
            ))}
          </select>
        </div>
        <div className="filter-item">
          <label>Year</label>
          <select value={filters.year} onChange={(e) => { const nf = {...filters, year: e.target.value}; setFilters(nf); fetchDashboardData(nf); }}>
            <option>All</option>
            <option>2023</option>
            <option>2024</option>
            <option>2025</option>
          </select>
        </div>
        <div className="filter-item">
          <label>Month</label>
          <select value={filters.month} onChange={(e) => { const nf = {...filters, month: e.target.value}; setFilters(nf); }}>
            <option>All</option>
            <option value="1">Jan</option>
            <option value="2">Feb</option>
            <option value="3">Mar</option>
            <option value="4">Apr</option>
            <option value="5">May</option>
            <option value="6">Jun</option>
            <option value="7">Jul</option>
            <option value="8">Aug</option>
            <option value="9">Sep</option>
            <option value="10">Oct</option>
            <option value="11">Nov</option>
            <option value="12">Dec</option>
          </select>
        </div>
        <div className="filter-item">
          <label>Date</label>
          <input type="date" value={filters.date} onChange={(e) => { const nf = {...filters, date: e.target.value}; setFilters(nf); }} />
        </div>
        <div className="filter-actions">
          <button className="btn btn-secondary btn-sm" onClick={() => { 
            setSelectedHOD('');
            setSelectedHODTable({ schemes: '', budget: '', attendance: '' });
            setFilters({ year: 'All', month: 'All', date: '', hod_id: '' }); 
            fetchDashboardData({ year: 'All', month: 'All', date: '', hod_id: '' });
            setSchemesDetails([]);
            setBudgetDetails([]);
            setAttendanceDetails([]);
          }}>Clear</button>
          <button className="btn btn-primary btn-sm" onClick={() => fetchDashboardData()}>Apply</button>
        </div>
      </div>
      */}

      {/* Hero Stats (top big cards like reference) */}
      {/* <div className="hero-stats">
        <div className="hero-card">
          <div className="hero-number purple">{formatCompactNumber(stats.totalHods)}</div>
          <div className="hero-label">HODs</div>
        </div>
        <div className="hero-card">
          <div className="hero-number green">{formatCompactNumber(quickStats.districtsCovered)}</div>
          <div className="hero-label">District</div>
        </div>
        <div className="hero-card">
          <div className="hero-number red">{formatCompactNumber(quickStats.beneficiaries)}</div>
          <div className="hero-label">Total Farmers</div>
        </div>
        <div className="hero-card">
          <div className="hero-number purple">{formatCurrency(stats.totalBudget)}</div>
          <div className="hero-label">Total Budget</div>
        </div>
        <div className="hero-card">
          <div className="hero-number blue">{formatCompactNumber(stats.totalSchemes)}</div>
          <div className="hero-label">Nursery</div>
        </div>
        <div className="hero-card">
          <div className="hero-number teal">{formatCompactNumber(quickStats.nodalOfficers)}</div>
          <div className="hero-label">Nodal Officers</div>
        </div>
      </div> */}

      {/* Stats Cards */}
     <div className="dashboard-top-row">
  <div className="dashboard-top-left">
    <div className="dashboard-mini-tiles">

      <div
        className="dashboard-mini-tile"
        onClick={() => navigate('/hods')}
      >
        <div className="dashboard-tile-content">
          <div className="dashboard-tile-label">Total</div>
          <div className="dashboard-tile-value">
            {(stats.totalHods || 0) + (stats.totalStaff || 0)}
          </div>
          <div className="dashboard-tile-sub">HODs + Staff</div>
        </div>
        <div className="dashboard-tile-icon" aria-hidden="true">
          <FiUsers />
        </div>
      </div>

      <div
        className="dashboard-mini-tile"
        onClick={() => navigate('/attendance')}
      >
        <div className="dashboard-tile-content">
          <div className="dashboard-tile-label">Total Attendance</div>
          <div className="dashboard-tile-value">
            {stats.todayAttendance?.total || 0}
          </div>
          <div className="dashboard-tile-sub">
            {stats.todayAttendance?.present || 0} Present
          </div>
        </div>
        <div className="dashboard-tile-icon" aria-hidden="true">
          <FiCheckCircle />
        </div>
      </div>

      <div
        className="dashboard-mini-tile"
        onClick={() => navigate('/budget')}
      >
        <div className="dashboard-tile-content">
          <div className="dashboard-tile-label">Budget</div>
          <div className="dashboard-tile-value">
            {formatCurrency(stats.totalBudget || 0)}
          </div>
          <div className="dashboard-tile-sub">
            {formatCurrency(stats.utilizedBudget || 0)} Used
          </div>
        </div>
        <div className="dashboard-tile-icon" aria-hidden="true">
          <BiWallet />
        </div>
      </div>

      <div
        className="dashboard-mini-tile"
        onClick={() => navigate('/hods')}
      >
        <div className="dashboard-tile-content">
          <div className="dashboard-tile-label">Total HODs</div>
          <div className="dashboard-tile-value">
            {stats.totalHods || 0}
          </div>
          <div className="dashboard-tile-sub">
            {stats.activeHods || 0} Active
          </div>
        </div>
        <div className="dashboard-tile-icon" aria-hidden="true">
          <FiUsers />
        </div>
      </div>

      <div
        className="dashboard-mini-tile"
        onClick={() => navigate('/flagship-programmes')}
      >
        <div className="dashboard-tile-content">
          <div className="dashboard-tile-label">Flagship Programmes</div>
          <div className="dashboard-tile-value">
            {stats.totalPrograms || 0}
          </div>
          <div className="dashboard-tile-sub">
            {stats.activePrograms || 0} Active
          </div>
        </div>
        <div className="dashboard-tile-icon" aria-hidden="true">
          <FiActivity />
        </div>
      </div>

    </div>
  </div>
</div>

      
      {/* Scrollable Charts Container */}
      <div style={{ flex: 1, overflowY: 'auto', overflowX: 'hidden' }}>
      {/* Top Summary Charts Grid - 2x2 Layout */}
      <div className="charts-grid" style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '14px', marginBottom: '14px' }}>
        
        {/* Schemes Summary - stacked bar with active/inactive and per-scheme list for total view */}
        <div className="chart-card" style={{ gridColumn: '1 / 2', backgroundColor: '#ffffff', border: '1px solid #d0d0d0', boxShadow: '0 1px 3px rgba(0,0,0,0.05)' }}>
          <div className="chart-card-header" style={{ backgroundColor: '#f8f8f8', borderBottom: '1px solid #d0d0d0', display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
            <div style={{ display: 'flex', alignItems: 'center', gap: '10px', flexWrap: 'wrap' }}>
              <h3 style={{ fontSize: '14px', fontWeight: '600', color: '#1a1a1a', margin: 0 }}>
                Schemes Summary (FY {selectedSchemesYear || schemesSummary.year})
                {schemesHODFilter && (
                  <span style={{ fontWeight: '400', color: '#666', fontSize: '12px' }}> - {allHODs.find(h => h.id === parseInt(schemesHODFilter))?.name || 'HOD'}</span>
                )}
              </h3>
              <span style={{ padding: '4px 8px', backgroundColor: '#e8f5e9', color: '#1b5e20', borderRadius: '999px', fontSize: '11px', fontWeight: 700 }}>{totalSchemeCount} {schemesHODFilter ? 'Schemes' : 'Total'}</span>
            </div>
            <div style={{ display: 'flex', gap: '8px', alignItems: 'center' }}>
              <select 
                value={schemesHODFilter}
                onChange={(e) => setSchemesHODFilter(e.target.value)}
                style={{
                  padding: '6px 8px',
                  fontSize: '12px',
                  border: '1px solid #d0d0d0',
                  borderRadius: '4px',
                  backgroundColor: '#fff',
                  color: '#333',
                  cursor: 'pointer',
                  outline: 'none',
                  maxWidth: '150px'
                }}
              >
                <option value="">All HODs</option>
                {allHODs.map((hod) => (
                  <option key={hod.id} value={hod.id}>
                    {hod.name}
                  </option>
                ))}
              </select>
              <select 
                value={selectedSchemeType}
                onChange={(e) => setSelectedSchemeType(e.target.value)}
                style={{
                  padding: '6px 8px',
                  fontSize: '12px',
                  border: '1px solid #d0d0d0',
                  borderRadius: '4px',
                  backgroundColor: '#fff',
                  color: '#333',
                  cursor: 'pointer',
                  outline: 'none'
                }}
              >
                <option value="all">Total Schemes</option>
                <option value="split">State vs Central</option>
              </select>
              <select 
                value={schemesYearFilter || schemesSummary.year} 
                onChange={(e) => {
                  setSchemesYearFilter(e.target.value);
                }}
                style={{
                  padding: '6px 8px',
                  fontSize: '12px',
                  border: '1px solid #d0d0d0',
                  borderRadius: '4px',
                  backgroundColor: '#fff',
                  color: '#333',
                  cursor: 'pointer',
                  outline: 'none'
                }}
              >
                <option value="2024-25">2024-25</option>
                <option value="2025-26">2025-26</option>
                <option value="2026-27">2026-27</option>
                <option value="2027-28">2027-28</option>
              </select>
            </div>
          </div>
          <div className="chart-card-body" style={{ height: schemesChartHeight, padding: '8px 14px 4px 14px' }}>
            <div style={{ height: '100%' }}>
              <Bar data={schemesChartData} options={schemesChartOptions} plugins={[ChartDataLabels]} />
            </div>
            {isTotalSchemesView && filteredSchemesList.length === 0 && (
              <div style={{ marginTop: '12px', fontSize: '12px', color: '#666' }}>No schemes found for this year.</div>
            )}
          </div>
        </div>

        {/* Attendance Summary Pie Chart - Top Right */}
        <div className="chart-card" style={{ backgroundColor: '#ffffff', border: '1px solid #d0d0d0', boxShadow: '0 1px 3px rgba(0,0,0,0.05)' }}>
          <div className="chart-card-header" style={{ backgroundColor: '#f8f8f8', borderBottom: '1px solid #d0d0d0',  display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
            <h3 style={{ fontSize: '14px', fontWeight: '600', color: '#1a1a1a', margin: 0 }}>Attendance (Today)</h3>
            <div style={{ display: 'flex', gap: '8px', alignItems: 'center' }}>
              <select
                value={attendanceDatePeriod}
                onChange={(e) => setAttendanceDatePeriod(e.target.value)}
                style={{
                  padding: '6px 8px',
                  fontSize: '12px',
                  border: '1px solid #d0d0d0',
                  borderRadius: '4px',
                  backgroundColor: '#fff',
                  color: '#333',
                  cursor: 'pointer',
                  outline: 'none'
                }}
              >
                <option value="today">Today</option>
                <option value="weekly">Weekly</option>
                <option value="monthly">Monthly</option>
                <option value="custom">Custom</option>
              </select>
              {attendanceDatePeriod === 'custom' && (
                <>
                  <input
                    type="date"
                    value={customDateRange.start}
                    onChange={(e) => setCustomDateRange({ ...customDateRange, start: e.target.value })}
                    style={{
                      padding: '6px 8px',
                      fontSize: '12px',
                      border: '1px solid #d0d0d0',
                      borderRadius: '4px',
                      backgroundColor: '#fff'
                    }}
                  />
                  <span style={{ fontSize: '12px', color: '#666' }}>to</span>
                  <input
                    type="date"
                    value={customDateRange.end}
                    onChange={(e) => setCustomDateRange({ ...customDateRange, end: e.target.value })}
                    style={{
                      padding: '6px 8px',
                      fontSize: '12px',
                      border: '1px solid #d0d0d0',
                      borderRadius: '4px',
                      backgroundColor: '#fff'
                    }}
                  />
                </>
              )}
            </div>
          </div>
          <div style={{ display: 'flex', height: 'auto', padding: '0' }}>
            {/* Left 64%: Pie Chart */}
            <div style={{ width: '64%', position: 'relative', borderRight: '1px solid #e8e8e8', padding: '12px', minHeight: '220px', height: '220px' }}>
              <Pie 
                data={{
                  labels: ['Present', 'Absent', 'Late', 'Leave'],
                  datasets: [{
                    data: [
                      stats.todayAttendance?.present || 0,
                      stats.todayAttendance?.absent || 0,
                      stats.todayAttendance?.late || 0,
                      stats.todayAttendance?.onLeave || 0
                    ],
                    backgroundColor: [
                      selectedAttendanceStatus === 'present' ? '#2e7d32' : '#4caf50',
                      selectedAttendanceStatus === 'absent' ? '#c62828' : '#ef5350',
                      selectedAttendanceStatus === 'late' ? '#e65100' : '#ff9800',
                      selectedAttendanceStatus === 'leave' ? '#616161' : '#9e9e9e'
                    ],
                    borderWidth: 1,
                    borderColor: '#ffffff',
                    hoverOffset: 4
                  }]
                }}
                options={{
                  responsive: true,
                  maintainAspectRatio: false,
                  plugins: {
                    legend: {
                      position: 'bottom',
                      labels: {
                        padding: 6,
                        usePointStyle: true,
                        font: { size: 11, weight: '500' },
                        color: '#333',
                        generateLabels: function(chart) {
                          const data = chart.data;
                          return data.labels.map((label, i) => {
                            const value = data.datasets[0].data[i] || 0;
                            const total = data.datasets[0].data.reduce((a, b) => (a || 0) + (b || 0), 0);
                            const percentage = total > 0 ? ((value / total) * 100).toFixed(1) : 0;
                            return {
                              text: `${label}: ${percentage}%`,
                              fillStyle: data.datasets[0].backgroundColor[i],
                              hidden: false,
                              index: i
                            };
                          });
                        }
                      }
                    },
                    tooltip: {
                      callbacks: {
                        label: function(context) {
                          const value = context.parsed || 0;
                          const total = context.dataset.data.reduce((a, b) => (a || 0) + (b || 0), 0);
                          const percentage = total > 0 ? ((value / total) * 100).toFixed(1) : 0;
                          return `${context.label}: ${value} (${percentage}%)`;
                        }
                      },
                      backgroundColor: 'rgba(0,0,0,0.8)',
                      padding: 8,
                      cornerRadius: 4
                    },
                    datalabels: {
                      color: '#fff',
                      font: { size: 12, weight: 'bold' },
                      formatter: function(value) {
                        if (value === 0) return '';
                        return value.toString();
                      }
                    }
                  }
                }}
                plugins={[
                  ChartDataLabels,
                  {
                    id: 'attendanceCenterText',
                    beforeDraw: function(chart) {
                      const width = chart.width;
                      const height = chart.height;
                      const ctx = chart.ctx;
                      ctx.restore();
                      const fontSize = (height / 160).toFixed(2);
                      ctx.font = `bold ${fontSize}em sans-serif`;
                      ctx.textBaseline = 'middle';
                      const text = (stats.totalStaff || 0) + (stats.totalHods || 0);
                      const textX = Math.round((width - ctx.measureText(text).width) / 2);
                      const textY = height / 2.5;
                      ctx.fillStyle = '#1a1a1a';
                      ctx.fillText(text, textX, textY);
                      ctx.font = `${fontSize * 0.5}em sans-serif`;
                      const subText = 'Total Employees';
                      const subTextX = Math.round((width - ctx.measureText(subText).width) / 2);
                      const subTextY = height / 2.5 + 20;
                      ctx.fillStyle = '#666';
                      ctx.fillText(subText, subTextX, subTextY);
                      ctx.save();
                    }
                  }
                ]}
              />
            </div>

            {/* Right 36%: Attendance Data */}
            <div style={{ width: '36%', display: 'flex', flexDirection: 'column', padding: '12px 16px', overflowY: 'auto' }}>
              {/* Total Employees Block */}
              <div 
                onClick={() => {
                  setSelectedAttendanceStatus('all');
                }}
                style={{ 
                  marginBottom: '16px', 
                  paddingBottom: '12px', 
                  borderBottom: '1px solid #e0e0e0',
                  cursor: 'pointer',
                  borderLeft: selectedAttendanceStatus === 'all' ? '3px solid #1976d2' : '3px solid transparent',
                  paddingLeft: '8px',
                  marginLeft: '-11px',
                  backgroundColor: selectedAttendanceStatus === 'all' ? '#f5f9ff' : 'transparent',
                  transition: 'all 0.2s ease'
                }}
              >
                <div style={{ fontSize: '12px', color: '#666', marginBottom: '4px' }}>Total Employees</div>
                <div style={{ fontSize: '24px', fontWeight: '600', color: '#1a1a1a' }}>{(stats.totalStaff || 0) + (stats.totalHods || 0)}</div>
              </div>

              {/* Attendance Status Block */}
              <div>
                <div style={{ fontSize: '12px', color: '#666', marginBottom: '8px', fontWeight: '500' }}>Attendance Status</div>
                
                {/* Present */}
                <div 
                  onClick={() => {
                    setSelectedAttendanceStatus(selectedAttendanceStatus === 'present' ? 'all' : 'present');
                    handleChartClick('attendanceByStatus', 'Present');
                  }}
                  style={{
                    display: 'flex',
                    justifyContent: 'space-between',
                    alignItems: 'center',
                    padding: '8px 12px',
                    marginBottom: '0px',
                    cursor: 'pointer',
                    borderLeft: selectedAttendanceStatus === 'present' ? '3px solid #4caf50' : '3px solid transparent',
                    backgroundColor: selectedAttendanceStatus === 'present' ? '#f1f8f4' : 'transparent',
                    transition: 'all 0.2s ease',
                    borderRadius: '2px'
                  }}
                >
                  <span style={{ fontSize: '13px', color: '#333', fontWeight: selectedAttendanceStatus === 'present' ? '600' : '400' }}>Present</span>
                  <span style={{ fontSize: '14px', fontWeight: '600', color: '#4caf50' }}>{stats.todayAttendance?.present || 0}</span>
                </div>

                {/* Absent */}
                <div 
                  onClick={() => {
                    setSelectedAttendanceStatus(selectedAttendanceStatus === 'absent' ? 'all' : 'absent');
                    handleChartClick('attendanceByStatus', 'Absent');
                  }}
                  style={{
                    display: 'flex',
                    justifyContent: 'space-between',
                    alignItems: 'center',
                    padding: '8px 12px',
                    marginBottom: '0px',
                    cursor: 'pointer',
                    borderLeft: selectedAttendanceStatus === 'absent' ? '3px solid #ef5350' : '3px solid transparent',
                    backgroundColor: selectedAttendanceStatus === 'absent' ? '#ffebee' : 'transparent',
                    transition: 'all 0.2s ease',
                    borderRadius: '2px'
                  }}
                >
                  <span style={{ fontSize: '13px', color: '#333', fontWeight: selectedAttendanceStatus === 'absent' ? '600' : '400' }}>Absent</span>
                  <span style={{ fontSize: '14px', fontWeight: '600', color: '#ef5350' }}>{stats.todayAttendance?.absent || 0}</span>
                </div>

                {/* Late */}
                <div 
                  onClick={() => {
                    setSelectedAttendanceStatus(selectedAttendanceStatus === 'late' ? 'all' : 'late');
                    handleChartClick('attendanceByStatus', 'Late');
                  }}
                  style={{
                    display: 'flex',
                    justifyContent: 'space-between',
                    alignItems: 'center',
                    padding: '8px 12px',
                    marginBottom: '0px',
                    cursor: 'pointer',
                    borderLeft: selectedAttendanceStatus === 'late' ? '3px solid #ff9800' : '3px solid transparent',
                    backgroundColor: selectedAttendanceStatus === 'late' ? '#fff8e1' : 'transparent',
                    transition: 'all 0.2s ease',
                    borderRadius: '2px'
                  }}
                >
                  <span style={{ fontSize: '13px', color: '#333', fontWeight: selectedAttendanceStatus === 'late' ? '600' : '400' }}>Late</span>
                  <span style={{ fontSize: '14px', fontWeight: '600', color: '#ff9800' }}>{stats.todayAttendance?.late || 0}</span>
                </div>

                {/* Leave */}
                <div 
                  onClick={() => {
                    setSelectedAttendanceStatus(selectedAttendanceStatus === 'leave' ? 'all' : 'leave');
                    handleChartClick('attendanceByStatus', 'Leave');
                  }}
                  style={{
                    display: 'flex',
                    justifyContent: 'space-between',
                    alignItems: 'center',
                    padding: '8px 12px',
                    cursor: 'pointer',
                    borderLeft: selectedAttendanceStatus === 'leave' ? '3px solid #9e9e9e' : '3px solid transparent',
                    backgroundColor: selectedAttendanceStatus === 'leave' ? '#f5f5f5' : 'transparent',
                    transition: 'all 0.2s ease',
                    borderRadius: '2px'
                  }}
                >
                  <span style={{ fontSize: '13px', color: '#333', fontWeight: selectedAttendanceStatus === 'leave' ? '600' : '400' }}>Leave</span>
                  <span style={{ fontSize: '14px', fontWeight: '600', color: '#9e9e9e' }}>{stats.todayAttendance?.onLeave || 0}</span>
                </div>
              </div>
            </div>
          </div>
        </div>

           <div className="chart-card" style={{ background: '#fff', borderRadius: '8px', boxShadow: '0 2px 8px rgba(0,0,0,0.06)', gridColumn: '1 / -1', border: '1px solid #d0d0d0', overflow: 'hidden' }}>
              <div className="chart-card-header" style={{ backgroundColor: '#f8f8f8', borderBottom: '1px solid #d0d0d0',  display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                <h3 style={{ margin: 0, fontSize: '14px', fontWeight: '600', color: '#1a1a1a' }}>Budget by HOD (₹ Cr)</h3>
                <select
                  value={budgetByHODYearFilter || budgetSummary.year}
                  onChange={(e) => {
                    setBudgetByHODYearFilter(e.target.value);
                  }}
                  style={{
                    padding: '6px 8px',
                    fontSize: '12px',
                    border: '1px solid #d0d0d0',
                    borderRadius: '4px',
                    backgroundColor: '#fff',
                    color: '#333',
                    cursor: 'pointer',
                    outline: 'none'
                  }}
                >
                  <option value="2024-25">2024-25</option>
                  <option value="2025-26">2025-26</option>
                  <option value="2026-27">2026-27</option>
                  <option value="2027-28">2027-28</option>
                </select>
              </div>
              <div style={{ height: 'auto', maxHeight: '340px', overflowY: 'auto', overflowX: 'hidden', padding: '12px 16px' }}>
                <div className="chart-box large" style={{ height: '300px', minHeight: '300px' }}>
                  <Bar data={budgetHODStackedBarData} options={budgetHODStackedBarOptions} plugins={[ChartDataLabels]} />
                </div>
              </div>
            </div>


        {/* Budget Summary - Vertical Bar with View Filter */}
        <div className="chart-card" style={{ backgroundColor: '#ffffff', border: '1px solid #d0d0d0', boxShadow: '0 1px 3px rgba(0,0,0,0.05)' }}>
          <div className="chart-card-header" style={{ backgroundColor: '#f8f8f8', borderBottom: '1px solid #d0d0d0',  display: 'flex', justifyContent: 'space-between', alignItems: 'center', gap: '10px' }}>
            <h3 style={{ fontSize: '14px', fontWeight: '600', color: '#1a1a1a', margin: 0 }}>Budget Summary (FY {budgetSummaryYearFilter || budgetSummary.year})</h3>
            <div style={{ display: 'flex', gap: '8px', marginLeft: 'auto' }}>
              <select
                value={budgetSummaryYearFilter || budgetSummary.year}
                onChange={(e) => {
                  refreshBudgetSummary(e.target.value);
                }}
                style={{
                  padding: '6px 8px',
                  fontSize: '12px',
                  border: '1px solid #d0d0d0',
                  borderRadius: '4px',
                  backgroundColor: '#fff',
                  color: '#333',
                  cursor: 'pointer',
                  outline: 'none'
                }}
              >
                <option value="2024-25">2024-25</option>
                <option value="2025-26">2025-26</option>
                <option value="2026-27">2026-27</option>
                <option value="2027-28">2027-28</option>
              </select>
              <select
                value={selectedBudgetView}
                onChange={(e) => setSelectedBudgetView(e.target.value)}
                style={{
                  padding: '6px 8px',
                  fontSize: '12px',
                  border: '1px solid #d0d0d0',
                  borderRadius: '4px',
                  backgroundColor: '#fff',
                  color: '#333',
                  cursor: 'pointer',
                  outline: 'none'
                }}
              >
                <option value="overall">Overall Budget</option>
                <option value="status">Budget Status</option>
              </select>
            </div>
          </div>
          <div className="chart-card-body" style={{ height: '240px', padding: '12px 14px' }}>
            <Bar data={budgetSummaryChartData} options={budgetSummaryChartOptions} plugins={[ChartDataLabels]} />
          </div>
        </div>

        {/* Budget Breakdown Enhanced Card - Government Style */}
        <div className="chart-card" style={{ gridColumn: '2 / 3', backgroundColor: '#ffffff', border: '1px solid #d0d0d0', boxShadow: '0 1px 3px rgba(0,0,0,0.05)' }}>
          <div className="chart-card-header" style={{ backgroundColor: '#f8f8f8', borderBottom: '1px solid #d0d0d0',  display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
            <h3 style={{ fontSize: '14px', fontWeight: '600', color: '#1a1a1a', margin: 0 }}>Budget Breakdown (FY {budgetBreakdownYearFilter || budgetBreakdown.year})</h3>
            <select 
              value={budgetBreakdownYearFilter || budgetBreakdown.year} 
              onChange={(e) => {
                refreshBudgetBreakdown(e.target.value);
              }}
              style={{
                padding: '4px 8px',
                fontSize: '12px',
                border: '1px solid #d0d0d0',
                borderRadius: '3px',
                backgroundColor: '#fff',
                color: '#333',
                cursor: 'pointer',
                outline: 'none'
              }}
            >
              <option value="2024-25">2024-25</option>
              <option value="2025-26">2025-26</option>
              <option value="2026-27">2026-27</option>
              <option value="2027-28">2027-28</option>
            </select>
          </div>
          <div className="chart-card-body" style={{ display: 'flex', gap: '0', height: '240px', padding: '0' }}>
            {/* Left Side - Pie Chart (64%) */}
            <div style={{ width: '64%', position: 'relative', borderRight: '1px solid #e8e8e8', padding: '12px' }}>
              <div style={{ height: '100%', position: 'relative' }}>
                <Pie 
                  data={{
                    labels: ['Sanctioned', 'Estimated', 'Pending'],
                    datasets: [{
                      data: [
                        budgetBreakdown.sanction.total || 0,
                        budgetBreakdown.estimated.total || 0,
                        budgetBreakdown.pending.total || 0
                      ],
                      backgroundColor: ['#2e7d32', '#f57c00', '#c62828'],
                      borderWidth: 1,
                      borderColor: '#ffffff',
                      hoverOffset: 4
                    }]
                  }}
                  options={{
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                      legend: {
                        position: 'bottom',
                        labels: {
                          padding: 6,
                          usePointStyle: true,
                          font: { size: 11, weight: '500' },
                          color: '#333',
                          generateLabels: function(chart) {
                            const data = chart.data;
                            return data.labels.map((label, i) => {
                              const value = data.datasets[0].data[i] || 0;
                              const percentage = ((value / (data.datasets[0].data.reduce((a, b) => (a || 0) + (b || 0), 0) || 1)) * 100).toFixed(1);
                              return {
                                text: `${label}: ₹${(value / 10000000).toFixed(1)}Cr (${percentage}%)`,
                                fillStyle: data.datasets[0].backgroundColor[i],
                                hidden: false,
                                index: i
                              };
                            });
                          }
                        }
                      },
                      tooltip: {
                        backgroundColor: 'rgba(0,0,0,0.8)',
                        padding: 8,
                        titleFont: { size: 11 },
                        bodyFont: { size: 10 },
                        callbacks: {
                          label: function(context) {
                            const value = context.parsed || 0;
                            const total = context.dataset.data.reduce((a, b) => (a || 0) + (b || 0), 0);
                            const percentage = total > 0 ? ((value / total) * 100).toFixed(1) : 0;
                            return `₹${(value / 10000000).toFixed(1)}Cr (${percentage}%)`;
                          }
                        }
                      },
                      datalabels: {
                        color: '#fff',
                        font: { size: 10, weight: 'bold' },
                        formatter: function(value) {
                          if (value === 0) return '';
                          return (value / 10000000).toFixed(1) + 'Cr';
                        },
                        display: true
                      }
                    }
                  }}
                  plugins={[ChartDataLabels]}
                />
              </div>
            </div>

            {/* Right Side - Budget Status Data (36%) */}
            <div style={{ width: '36%', display: 'flex', flexDirection: 'column', gap: '8px', padding: '10px 12px', overflowY: 'auto' }}>
              {/* Sanctioned Block */}
              <div 
                onClick={() => setSelectedBudgetType('sanction')}
                style={{
                  padding: '8px 10px',
                  borderRadius: '4px',
                  cursor: 'pointer',
                  backgroundColor: selectedBudgetType === 'sanction' ? '#f0f7f0' : '#fafafa',
                  border: selectedBudgetType === 'sanction' ? '1px solid #2e7d32' : '1px solid #d9d9d9',
                  transition: 'all 0.2s ease'
                }}
              >
                <div style={{ fontSize: '13px', fontWeight: '600', color: '#0d3c2c', marginBottom: '5px' }}>Sanctioned</div>
                <div style={{ fontSize: '12px', color: '#666', lineHeight: '1.5' }}>
                  <div><strong>Total:</strong> <span style={{ float: 'right', fontWeight: '600', color: '#2e7d32' }}>₹{(budgetBreakdown.sanction.total / 10000000).toFixed(1)}Cr</span></div>
                  <div style={{ marginTop: '2px' }}><strong>State:</strong> <span style={{ float: 'right', fontWeight: '500', color: '#555' }}>₹{(budgetBreakdown.sanction.state / 10000000).toFixed(1)}Cr</span></div>
                  <div style={{ marginTop: '2px' }}><strong>Central:</strong> <span style={{ float: 'right', fontWeight: '500', color: '#555' }}>₹{(budgetBreakdown.sanction.central / 10000000).toFixed(1)}Cr</span></div>
                </div>
              </div>

              {/* Estimated Block */}
              <div 
                onClick={() => setSelectedBudgetType('estimated')}
                style={{
                  padding: '8px 10px',
                  borderRadius: '4px',
                  cursor: 'pointer',
                  backgroundColor: selectedBudgetType === 'estimated' ? '#fff8e1' : '#fafafa',
                  border: selectedBudgetType === 'estimated' ? '1px solid #f57c00' : '1px solid #d9d9d9',
                  transition: 'all 0.2s ease'
                }}
              >
                <div style={{ fontSize: '13px', fontWeight: '600', color: '#3d2500', marginBottom: '5px' }}>Estimated</div>
                <div style={{ fontSize: '12px', color: '#666', lineHeight: '1.5' }}>
                  <div><strong>Total:</strong> <span style={{ float: 'right', fontWeight: '600', color: '#f57c00' }}>₹{(budgetBreakdown.estimated.total / 10000000).toFixed(1)}Cr</span></div>
                  <div style={{ marginTop: '2px' }}><strong>State:</strong> <span style={{ float: 'right', fontWeight: '500', color: '#555' }}>₹{(budgetBreakdown.estimated.state / 10000000).toFixed(1)}Cr</span></div>
                  <div style={{ marginTop: '2px' }}><strong>Central:</strong> <span style={{ float: 'right', fontWeight: '500', color: '#555' }}>₹{(budgetBreakdown.estimated.central / 10000000).toFixed(1)}Cr</span></div>
                </div>
              </div>

              {/* Pending Block */}
              <div 
                onClick={() => setSelectedBudgetType('pending')}
                style={{
                  padding: '8px 10px',
                  borderRadius: '4px',
                  cursor: 'pointer',
                  backgroundColor: selectedBudgetType === 'pending' ? '#ffebee' : '#fafafa',
                  border: selectedBudgetType === 'pending' ? '1px solid #c62828' : '1px solid #d9d9d9',
                  transition: 'all 0.2s ease'
                }}
              >
                <div style={{ fontSize: '13px', fontWeight: '600', color: '#3a0a09', marginBottom: '5px' }}>Pending</div>
                <div style={{ fontSize: '12px', color: '#666', lineHeight: '1.5' }}>
                  <div><strong>Total:</strong> <span style={{ float: 'right', fontWeight: '600', color: '#c62828' }}>₹{(budgetBreakdown.pending.total / 10000000).toFixed(1)}Cr</span></div>
                  <div style={{ marginTop: '2px' }}><strong>State:</strong> <span style={{ float: 'right', fontWeight: '500', color: '#555' }}>₹{(budgetBreakdown.pending.state / 10000000).toFixed(1)}Cr</span></div>
                  <div style={{ marginTop: '2px' }}><strong>Central:</strong> <span style={{ float: 'right', fontWeight: '500', color: '#555' }}>₹{(budgetBreakdown.pending.central / 10000000).toFixed(1)}Cr</span></div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>

       
{/* <div className="stat-card teal" style={{ cursor: 'pointer' }} onClick={() => navigate('/attendance?period=today')}>
          <div style={{ display: 'flex', alignItems: 'center', gap: '12px' }}>
            <div style={{ backgroundColor: '#e0f2f1', padding: '12px', borderRadius: '12px', display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
              <FiClock style={{ color: '#00897B', fontSize: '24px' }} />
            </div>
            <div>
              <h4 style={{ fontSize: '24px', fontWeight: '700', margin: 0 }}>{stats.todayAttendance?.total || 0}</h4>
              <p style={{ margin: '2px 0 0 0', fontSize: '13px', color: '#666' }}>Today's Attendance</p>
              
               <div className="trend" style={{ fontSize: '11px', display: 'flex', gap: '6px', flexWrap: 'nowrap' }}>
              <span onClick={(e) => { e.stopPropagation(); navigate('/attendance?status=present'); }} style={{ color: '#4CAF50', cursor: 'pointer' }}>{stats.todayAttendance?.present || 0} Present</span>
              <span onClick={(e) => { e.stopPropagation(); navigate('/attendance?status=late'); }} style={{ color: '#FF9800', cursor: 'pointer' }}>{stats.todayAttendance?.late || 0} Late</span>
              <span onClick={(e) => { e.stopPropagation(); navigate('/attendance?status=absent'); }} style={{ color: '#F44336', cursor: 'pointer' }}>{stats.todayAttendance?.absent || 0} Absent</span>
              <span onClick={(e) => { e.stopPropagation(); navigate('/attendance?status=half_day'); }} style={{ color: '#9C27B0', cursor: 'pointer' }}>{stats.todayAttendance?.halfDay || 0} Half</span>
            </div>
            </div>
          </div>
        </div> */}
      {/* Quick Stats - Hidden as cards moved to main grid */}
      {/* <div className="quick-stats" style={{ display: 'none' }}>

        <div className="quick-stat">
          <div style={{ display: 'flex', alignItems: 'center', gap: '10px' }}>
            <div style={{ backgroundColor: '#e8f5e9', padding: '10px', borderRadius: '10px', display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
              <FiTrendingUp style={{ color: '#4CAF50', fontSize: '20px' }} />
            </div>
            <div>
              <h4>{formatCurrency(quickStats.utilizedBudget)}</h4>
              <p>Budget Utilized ({quickStats.budgetUtilization}%)</p>
            </div>
          </div>
        </div>
        <div className="quick-stat">
          <div style={{ display: 'flex', alignItems: 'center', gap: '10px' }}>
            <div style={{ backgroundColor: '#e3f2fd', padding: '10px', borderRadius: '10px', display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
              <BiWallet style={{ color: '#2196F3', fontSize: '20px' }} />
            </div>
            <div>
              <h4>{formatCurrency(quickStats.remainingBudget)}</h4>
              <p>Remaining Budget</p>
            </div>
          </div>
        </div>
        <div className="quick-stat">
          <div style={{ display: 'flex', alignItems: 'center', gap: '10px' }}>
            <div style={{ backgroundColor: '#fff3e0', padding: '10px', borderRadius: '10px', display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
              <FiMapPin style={{ color: '#FF9800', fontSize: '20px' }} />
            </div>
            <div>
              <h4>{quickStats.districtsCovered}</h4>
              <p>Districts Covered</p>
            </div>
          </div>
        </div>
        <div className="quick-stat" onClick={() => window.location.href = '/beneficiaries'} style={{ cursor: 'pointer' }}>
          <div style={{ display: 'flex', alignItems: 'center', gap: '10px' }}>
            <div style={{ backgroundColor: '#fce4ec', padding: '10px', borderRadius: '10px', display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
              <HiOutlineUserGroup style={{ color: '#E91E63', fontSize: '20px' }} />
            </div>
            <div>
              <h4>{formatBeneficiaries(quickStats.beneficiaries)}</h4>
              <p>Beneficiaries</p>
              <p>View & manage</p>
            </div>
          </div>
        </div> */}
        {/* <div className="quick-stat">
          <h4>{quickStats.attendanceRate}%</h4>
          <p>Attendance Rate</p>
        </div> */}
        
      {/* </div> */}
      {/* Charts - 2x2 Grid Layout */}
      <div className="charts-grid" style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '14px', marginBottom: '14px' }}>
        {/* Chart 1: HOD Revenue - Donut Chart with center text */}
        <div className="chart-card">
          <div className="chart-card-header" style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
            <h3><FiPieChart /> HOD Revenue {chartFilters.revenue.hod_id && <span style={{ fontSize: '12px', color: '#666', fontWeight: 'normal' }}>({allHODs.find(h => h.id === parseInt(chartFilters.revenue.hod_id))?.name})</span>}</h3>
            <div className="chart-filter-container" style={{ position: 'relative' }}>
              <FiFilter 
                style={{ cursor: 'pointer', color: chartFilters.revenue.hod_id ? '#2e7d32' : '#666', fontSize: '18px' }} 
                title="Filter" 
                onClick={(e) => { e.stopPropagation(); toggleFilterDropdown('revenue'); }}
              />
              {renderFilterDropdown('revenue')}
            </div>
          </div>
          <div className="chart-card-body">
            <div className="chart-container" style={{ cursor: 'pointer', height: '240px', position: 'relative' }}>
              <Doughnut data={hodRevenueChartData} options={hodRevenuePieOptions} plugins={[ChartDataLabels, revenueCenterTextPlugin]} />
            </div>
          </div>
        </div>

        {/* Chart 2: Schemes (HOD wise) - Bar + Line Combined Chart */}
        <div className="chart-card">
          <div className="chart-card-header" style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
            <div style={{ display: 'flex', alignItems: 'center', gap: '15px' }}>
              <h3><FiBarChart2 /> {isSchemeWiseView ? 'Schemes (Scheme wise)' : 'Schemes (HOD wise)'} {chartFilters.schemes.hod_id && <span style={{ fontSize: '12px', color: '#666', fontWeight: 'normal' }}>({allHODs.find(h => h.id === parseInt(chartFilters.schemes.hod_id))?.name})</span>}</h3>
              {isSchemeWiseView && (
                <div style={{ display: 'flex', gap: '10px', fontSize: '11px' }}>
                  <span style={{ display: 'flex', alignItems: 'center', gap: '4px' }}>
                    <span style={{ width: '12px', height: '12px', borderRadius: '3px', backgroundColor: 'rgba(76, 175, 80, 0.8)' }}></span> Completed
                  </span>
                  <span style={{ display: 'flex', alignItems: 'center', gap: '4px' }}>
                    <span style={{ width: '12px', height: '12px', borderRadius: '3px', backgroundColor: 'rgba(255, 193, 7, 0.8)' }}></span> Planned
                  </span>
                  <span style={{ display: 'flex', alignItems: 'center', gap: '4px' }}>
                    <span style={{ width: '12px', height: '12px', borderRadius: '3px', backgroundColor: 'rgba(33, 150, 243, 0.8)' }}></span> Active
                  </span>
                </div>
              )}
            </div>
            <div className="chart-filter-container" style={{ position: 'relative' }}>
              <FiFilter 
                style={{ cursor: 'pointer', color: chartFilters.schemes.hod_id ? '#2e7d32' : '#666', fontSize: '18px' }} 
                title="Filter" 
                onClick={(e) => { e.stopPropagation(); toggleFilterDropdown('schemes'); }}
              />
              {renderFilterDropdown('schemes')}
            </div>
          </div>
          <div className="chart-card-body">
            <div className="chart-container" style={{ cursor: 'pointer', height: '240px' }}>
              <Bar data={schemesHODBarLineData} options={schemesBarLineOptions} />
            </div>
          </div>
        </div>

        {/* Chart 3: Budget (HOD wise) */}
   
        {/* Chart 4: Attendance (HOD wise) - Bar Chart */}
        <div className="chart-card">
          <div className="chart-card-header" style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
            <h3><FiBarChart2 /> Attendance (HOD wise) {chartFilters.attendance.hod_id && <span style={{ fontSize: '12px', color: '#666', fontWeight: 'normal' }}>({allHODs.find(h => h.id === parseInt(chartFilters.attendance.hod_id))?.name})</span>}</h3>
            <div className="chart-filter-container" style={{ position: 'relative' }}>
              <FiFilter 
                style={{ cursor: 'pointer', color: chartFilters.attendance.hod_id ? '#2e7d32' : '#666', fontSize: '18px' }} 
                title="Filter" 
                onClick={(e) => { e.stopPropagation(); toggleFilterDropdown('attendance'); }}
              />
              {renderFilterDropdown('attendance')}
            </div>
          </div>
          <div className="chart-card-body">
            <div className="chart-container" style={{ height: '240px', position: 'relative' }}>
              <Bar data={attendanceHODBarChartData} options={attendanceBarChartOptions} plugins={[ChartDataLabels]} />
            </div>
          </div>
        </div>
      </div>
      </div>
      {/* End Scrollable Charts Container */}

      {/* Tables */}
      {/* HOD Revenue Table */}
      {/*  */}

      <ListModal
        isOpen={modalOpen}
        onClose={() => setModalOpen(false)}
        title={modalData.title}
        items={modalData.items}
        columns={modalData.columns}
        formatItem={formatModalItem}
      />
    </div>
  );
};

export default Dashboard;
