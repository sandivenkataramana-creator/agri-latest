import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import ListModal from '../components/ListModal';
import { Pie, Bar, Doughnut, Line } from 'react-chartjs-2';
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
  const [allStaff, setAllStaff] = useState([]);
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
  
  // Scheme wise view toggle for schemes chart
  const [isSchemeWiseView, setIsSchemeWiseView] = useState(false);
  // Budget breakdown view toggle for budget chart
  const [isBudgetBreakdownView, setIsBudgetBreakdownView] = useState(false);
  // HOD Revenue/Budget view toggle
  const [isHodBudgetView, setIsHodBudgetView] = useState(false);
  
  // Scheme Insights Modal
  const [schemeInsightsOpen, setSchemeInsightsOpen] = useState(false);
  const [schemeInsightsFilters, setSchemeInsightsFilters] = useState({
    department: '',
    year: '2025-26',
    schemeStatus: '',
    hodId: '',
    chartView: 'status'
  });
  const [filteredSchemeInsights, setFilteredSchemeInsights] = useState([]);

  // Attendance Insights Modal
  const [attendanceInsightsOpen, setAttendanceInsightsOpen] = useState(false);
  const [attendanceInsightsFilters, setAttendanceInsightsFilters] = useState({
    period: 'today',
    hodId: '',
    status: ''
  });
  const [attendanceInsightData, setAttendanceInsightData] = useState([]);

  // HOD Insights Modal
  const [hodInsightsOpen, setHodInsightsOpen] = useState(false);
  const [hodInsightsChartType, setHodInsightsChartType] = useState('revenue'); // revenue, budget, schemes

  // Budget Insights Modal
  const [budgetInsightsOpen, setBudgetInsightsOpen] = useState(false);
  const [budgetInsightsFilters, setBudgetInsightsFilters] = useState({
    chartType: 'summary', // summary, breakdown, byHod
    year: '2025-26',
    status: ''
  });

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

  // Refetch ONLY attendance data when attendance date period or custom date range changes
  useEffect(() => {
    // Preserve scroll position before fetching
    const scrollY = window.scrollY;
    
    const params = { ...filters };
    
    // Add date range parameters based on selected period
    if (attendanceDatePeriod === 'today') {
      const today = new Date().toISOString().split('T')[0];
      params.date_start = today;
      params.date_end = today;
    } else if (attendanceDatePeriod === 'weekly') {
      const today = new Date();
      const dayOfWeek = today.getDay();
      const startOfWeek = new Date(today);
      startOfWeek.setDate(today.getDate() - dayOfWeek); // Start from Sunday
      const endOfWeek = new Date(startOfWeek);
      endOfWeek.setDate(startOfWeek.getDate() + 6); // End on Saturday
      params.date_start = startOfWeek.toISOString().split('T')[0];
      params.date_end = endOfWeek.toISOString().split('T')[0];
    } else if (attendanceDatePeriod === 'monthly') {
      const today = new Date();
      const startOfMonth = new Date(today.getFullYear(), today.getMonth(), 1);
      const endOfMonth = new Date(today.getFullYear(), today.getMonth() + 1, 0);
      params.date_start = startOfMonth.toISOString().split('T')[0];
      params.date_end = endOfMonth.toISOString().split('T')[0];
    } else if (attendanceDatePeriod === 'custom') {
      if (customDateRange.start && customDateRange.end) {
        params.date_start = customDateRange.start;
        params.date_end = customDateRange.end;
      } else {
        return; // Don't refetch if custom dates are incomplete
      }
    }
    
    // Fetch only attendance-related data to avoid full page refresh
    const fetchAttendanceData = async () => {
      try {
        const [statsRes, attendanceRes] = await Promise.all([
          getDashboardStats(params),
          getAttendanceByHOD(params)
        ]);
        
        // Update only attendance-related state
        setStats(prevStats => ({
          ...prevStats,
          todayAttendance: statsRes.data.todayAttendance || {
            total: 0,
            present: 0,
            absent: 0,
            late: 0,
            halfDay: 0,
            onLeave: 0
          }
        }));
        
        setAttendanceByHOD(attendanceRes.data || []);
      } catch (err) {
        console.error('Error fetching attendance data:', err);
      }
    };
    
    fetchAttendanceData();
    
    // Restore scroll position after rendering completes
    const scrollTimeout = setTimeout(() => {
      window.scrollTo(0, scrollY);
    }, 50);
    
    return () => {
      clearTimeout(scrollTimeout);
    };
  }, [attendanceDatePeriod, customDateRange]);

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
    if (f.date_start) params.date_start = f.date_start;
    if (f.date_end) params.date_end = f.date_end;

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
    if (isNaN(value)) return '$0';
    if (value >= 10000000) {
      return `$${(value / 10000000).toFixed(2)} Cr`;
    } else if (value >= 100000) {
      return `$${(value / 100000).toFixed(2)} L`;
    }
    return `$${value.toLocaleString()}`;
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

let displayValue = '$0';
if (!isNaN(safeTotal)) {
  if (safeTotal >= 10000000) displayValue = `$${(safeTotal / 10000000).toFixed(2)} Cr`;
  else if (safeTotal >= 100000) displayValue = `$${(safeTotal / 100000).toFixed(2)} L`;
  else displayValue = `$${safeTotal.toLocaleString()}`;
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
  
  // When HOD is selected via chart filter and scheme wise view is enabled, show scheme-wise data with status colors
  const showSchemeWiseData = isSchemeWiseView && chartFilters.schemes.hod_id && schemesDetails.length > 0;
  
  const schemesHODBarLineData = showSchemeWiseData ? {
    labels: schemesDetails.map(item => item.name?.split(' ').slice(0, 3).join(' ') || 'Unknown'),
    datasets: [
      {
        type: 'line',
        label: 'Scheme Budget',
        data: schemesDetails.map(item => (item.total_budget || 0) / 100000),
        borderColor: '#1565C0',
        backgroundColor: 'rgba(21, 101, 192, 0.1)',
        borderWidth: 3,
        pointBackgroundColor: '#1565C0',
        pointBorderColor: '#ffffff',
        pointBorderWidth: 2,
        pointRadius: 6,
        pointHoverRadius: 8,
        tension: 0.4,
        fill: true,
        yAxisID: 'y',
        order: 1
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
        yAxisID: 'y',
        order: 2
      }
    ]
  } : {
    labels: filteredSchemesData.map(item => item.hod_name?.split(' ').slice(0, 2).join(' ') || 'Unknown'),
    datasets: [
      {
        type: 'line',
        label: 'Scheme Count',
        data: filteredSchemesData.map(item => item.scheme_count || 0),
        borderColor: '#1565C0',
        backgroundColor: 'rgba(21, 101, 192, 0.1)',
        borderWidth: 3,
        pointBackgroundColor: '#1565C0',
        pointBorderColor: '#ffffff',
        pointBorderWidth: 2,
        pointRadius: 6,
        pointHoverRadius: 8,
        tension: 0.4,
        fill: true,
        yAxisID: 'y',
        order: 1
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
        yAxisID: 'y',
        order: 2
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
            return '$' + value + 'Cr';
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
            return `Revenue: $${formatRevenueShort(value)} (${percentage}%)`;
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

 const totalHodCount = allHODs.length || 0;
 const totalStaffCount = stats.totalStaff || 0;
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
  const schemesChartHeight = filteredSchemesList.length > 10 ? '260px' : (filteredSchemesList.length <= 5 ? '220px' : '240px');

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
    <div style={{
      display: 'grid',
      gridTemplateColumns: 'repeat(5, 1fr)',
      gap: '12px',
      marginBottom: '20px'
    }}>

      <div
        style={{
          backgroundColor: '#fff',
          padding: '12px 16px',
          borderRadius: '6px',
          boxShadow: '0 1px 3px rgba(0,0,0,0.08)',
          cursor: 'pointer',
          display: 'flex',
          alignItems: 'center',
          gap: '12px',
          transition: 'all 0.2s',
          border: '1px solid #f0f0f0'
        }}
        onClick={() => navigate('/hods')}
        onMouseOver={(e) => {
          e.currentTarget.style.boxShadow = '0 2px 6px rgba(0,0,0,0.12)';
          e.currentTarget.style.borderColor = '#e0e0e0';
        }}
        onMouseOut={(e) => {
          e.currentTarget.style.boxShadow = '0 1px 3px rgba(0,0,0,0.08)';
          e.currentTarget.style.borderColor = '#f0f0f0';
        }}
      >
        <div style={{ minWidth: '60px', fontWeight: 'bold' }}>
          <div style={{ fontSize: '12px', color: '#666' }}>TOTAL</div>
          <div style={{ fontSize: '20px', fontWeight: '800', color: '#1565c0' }}>
            {(stats.totalHods || 0) + (stats.totalStaff || 0)}
          </div>
        </div>
        <div style={{ fontSize: '11px', color: '#999', fontWeight: '600', marginLeft: '8px' }}>
          HODs: {totalHodCount} Staff: {totalStaffCount}
        </div>
        <div style={{ marginLeft: 'auto', fontSize: '18px', color: '#9c27b0' }}>
          <FiUsers />
        </div>
      </div>

      <div
        style={{
          backgroundColor: '#fff',
          padding: '12px 16px',
          borderRadius: '6px',
          boxShadow: '0 1px 3px rgba(0,0,0,0.08)',
          cursor: 'pointer',
          display: 'flex',
          alignItems: 'center',
          gap: '12px',
          transition: 'all 0.2s',
          border: '1px solid #f0f0f0'
        }}
        onClick={() => navigate('/attendance')}
        onMouseOver={(e) => {
          e.currentTarget.style.boxShadow = '0 2px 6px rgba(0,0,0,0.12)';
          e.currentTarget.style.borderColor = '#e0e0e0';
        }}
        onMouseOut={(e) => {
          e.currentTarget.style.boxShadow = '0 1px 3px rgba(0,0,0,0.08)';
          e.currentTarget.style.borderColor = '#f0f0f0';
        }}
      >
        <div style={{ minWidth: '60px', fontWeight: 'bold' }}>
          <div style={{ fontSize: '12px', color: '#666' }}>TOTAL ATTENDANCE</div>
          <div style={{ fontSize: '20px', fontWeight: '800', color: '#2e7d32' }}>
            {stats.todayAttendance?.total || 0}
          </div>
        </div>
        <div style={{ fontSize: '11px', color: '#999', fontWeight: '600', marginLeft: '8px' }}>
          {stats.todayAttendance?.present || 0} Present
        </div>
        <div style={{ marginLeft: 'auto', fontSize: '18px', color: '#2e7d32' }}>
          <FiCheckCircle />
        </div>
      </div>

      <div
        style={{
          backgroundColor: '#fff',
          padding: '12px 16px',
          borderRadius: '6px',
          boxShadow: '0 1px 3px rgba(0,0,0,0.08)',
          cursor: 'pointer',
          display: 'flex',
          alignItems: 'center',
          gap: '12px',
          transition: 'all 0.2s',
          border: '1px solid #f0f0f0'
        }}
        onClick={() => navigate('/budget')}
        onMouseOver={(e) => {
          e.currentTarget.style.boxShadow = '0 2px 6px rgba(0,0,0,0.12)';
          e.currentTarget.style.borderColor = '#e0e0e0';
        }}
        onMouseOut={(e) => {
          e.currentTarget.style.boxShadow = '0 1px 3px rgba(0,0,0,0.08)';
          e.currentTarget.style.borderColor = '#f0f0f0';
        }}
      >
        <div style={{ minWidth: '60px', fontWeight: 'bold' }}>
          <div style={{ fontSize: '12px', color: '#666' }}>BUDGET</div>
          <div style={{ fontSize: '20px', fontWeight: '800', color: '#1565c0' }}>
            {formatCurrency(stats.totalBudget || 0)}
          </div>
        </div>
        <div style={{ fontSize: '11px', color: '#999', fontWeight: '600', marginLeft: '8px' }}>
          {formatCurrency(stats.utilizedBudget || 0)} Used
        </div>
        <div style={{ marginLeft: 'auto', fontSize: '18px', color: '#ff6f00' }}>
          <BiWallet />
        </div>
      </div>

      <div
        style={{
          backgroundColor: '#fff',
          padding: '12px 16px',
          borderRadius: '6px',
          boxShadow: '0 1px 3px rgba(0,0,0,0.08)',
          cursor: 'pointer',
          display: 'flex',
          alignItems: 'center',
          gap: '12px',
          transition: 'all 0.2s',
          border: '1px solid #f0f0f0'
        }}
        onClick={() => navigate('/hods')}
        onMouseOver={(e) => {
          e.currentTarget.style.boxShadow = '0 2px 6px rgba(0,0,0,0.12)';
          e.currentTarget.style.borderColor = '#e0e0e0';
        }}
        onMouseOut={(e) => {
          e.currentTarget.style.boxShadow = '0 1px 3px rgba(0,0,0,0.08)';
          e.currentTarget.style.borderColor = '#f0f0f0';
        }}
      >
        <div style={{ minWidth: '60px', fontWeight: 'bold' }}>
          <div style={{ fontSize: '12px', color: '#666' }}>TOTAL HODS</div>
          <div style={{ fontSize: '20px', fontWeight: '800', color: '#1565c0' }}>
            {stats.totalHods || 0}
          </div>
        </div>
        <div style={{ fontSize: '11px', color: '#999', fontWeight: '600', marginLeft: '8px' }}>
          {stats.activeHods || 0} Active
        </div>
        <div style={{ marginLeft: 'auto', fontSize: '18px', color: '#1976d2' }}>
          <FiUsers />
        </div>
      </div>

      <div
        style={{
          backgroundColor: '#fff',
          padding: '12px 16px',
          borderRadius: '6px',
          boxShadow: '0 1px 3px rgba(0,0,0,0.08)',
          cursor: 'pointer',
          display: 'flex',
          alignItems: 'center',
          gap: '12px',
          transition: 'all 0.2s',
          border: '1px solid #f0f0f0'
        }}
        onClick={() => navigate('/flagship-programmes')}
        onMouseOver={(e) => {
          e.currentTarget.style.boxShadow = '0 2px 6px rgba(0,0,0,0.12)';
          e.currentTarget.style.borderColor = '#e0e0e0';
        }}
        onMouseOut={(e) => {
          e.currentTarget.style.boxShadow = '0 1px 3px rgba(0,0,0,0.08)';
          e.currentTarget.style.borderColor = '#f0f0f0';
        }}
      >
        <div style={{ minWidth: '60px', fontWeight: 'bold' }}>
          <div style={{ fontSize: '12px', color: '#666' }}>FLAGSHIP PROGRAMMES</div>
          <div style={{ fontSize: '20px', fontWeight: '800', color: '#1565c0' }}>
            {stats.totalPrograms || 0}
          </div>
        </div>
        <div style={{ fontSize: '11px', color: '#999', fontWeight: '600', marginLeft: '8px' }}>
          {stats.activePrograms || 0} Active
        </div>
        <div style={{ marginLeft: 'auto', fontSize: '18px', color: '#7b1fa2' }}>
          <FiActivity />
        </div>
      </div>

    </div>

    {/* Additional Cards Row */}
    <div style={{ 
      display: 'flex', 
      gap: '10px', 
      marginTop: '14px', 
      justifyContent: 'center',
      maxWidth: '600px',
      margin: '14px auto 0'
    }}>
      
      <div
        style={{
          backgroundColor: '#e8f5e9',
          padding: '8px 12px',
          borderRadius: '6px',
          boxShadow: '0 1px 3px rgba(0,0,0,0.08)',
          cursor: 'pointer',
          display: 'flex',
          alignItems: 'center',
          gap: '6px',
          fontSize: '12px',
          fontWeight: '600',
          color: '#333',
          transition: 'all 0.2s'
        }}
        onClick={() => {
          setSchemeInsightsOpen(false);
          setHodInsightsOpen(false);
          setBudgetInsightsOpen(false);
          setAttendanceInsightsOpen(true);
        }}
        onMouseOver={(e) => e.currentTarget.style.boxShadow = '0 2px 6px rgba(0,0,0,0.15)'}
        onMouseOut={(e) => e.currentTarget.style.boxShadow = '0 1px 3px rgba(0,0,0,0.08)'}
      >
        <FiCheckCircle size={16} style={{ color: '#4CAF50' }} />
        <span>ATTENDANCE</span>
      </div>

      <div
        style={{
          backgroundColor: '#e8f5e9',
          padding: '8px 12px',
          borderRadius: '6px',
          boxShadow: '0 1px 3px rgba(0,0,0,0.08)',
          cursor: 'pointer',
          display: 'flex',
          alignItems: 'center',
          gap: '6px',
          fontSize: '12px',
          fontWeight: '600',
          color: '#333',
          transition: 'all 0.2s'
        }}
        onClick={() => {
          setSchemeInsightsOpen(false);
          setAttendanceInsightsOpen(false);
          setBudgetInsightsOpen(false);
          setHodInsightsOpen(true);
        }}
        onMouseOver={(e) => e.currentTarget.style.boxShadow = '0 2px 6px rgba(0,0,0,0.15)'}
        onMouseOut={(e) => e.currentTarget.style.boxShadow = '0 1px 3px rgba(0,0,0,0.08)'}
      >
        <FiUsers size={16} style={{ color: '#2196F3' }} />
        <span>HOD'S</span>
      </div>

      <div
        style={{
          backgroundColor: '#e8f5e9',
          padding: '8px 12px',
          borderRadius: '6px',
          boxShadow: '0 1px 3px rgba(0,0,0,0.08)',
          cursor: 'pointer',
          display: 'flex',
          alignItems: 'center',
          gap: '6px',
          fontSize: '12px',
          fontWeight: '600',
          color: '#333',
          transition: 'all 0.2s'
        }}
        onClick={() => {
          setAttendanceInsightsOpen(false);
          setHodInsightsOpen(false);
          setBudgetInsightsOpen(false);
          setSchemeInsightsOpen(true);
        }}
        onMouseOver={(e) => e.currentTarget.style.boxShadow = '0 2px 6px rgba(0,0,0,0.15)'}
        onMouseOut={(e) => e.currentTarget.style.boxShadow = '0 1px 3px rgba(0,0,0,0.08)'}
      >
        <FiPieChart size={16} style={{ color: '#FF9800' }} />
        <span>SCHEMES</span>
      </div>

      <div
        style={{
          backgroundColor: '#e8f5e9',
          padding: '8px 12px',
          borderRadius: '6px',
          boxShadow: '0 1px 3px rgba(0,0,0,0.08)',
          cursor: 'pointer',
          display: 'flex',
          alignItems: 'center',
          gap: '6px',
          fontSize: '12px',
          fontWeight: '600',
          color: '#333',
          transition: 'all 0.2s'
        }}
        onClick={() => {
          setSchemeInsightsOpen(false);
          setAttendanceInsightsOpen(false);
          setHodInsightsOpen(false);
          setBudgetInsightsOpen(true);
        }}
        onMouseOver={(e) => e.currentTarget.style.boxShadow = '0 2px 6px rgba(0,0,0,0.15)'}
        onMouseOut={(e) => e.currentTarget.style.boxShadow = '0 1px 3px rgba(0,0,0,0.08)'}
      >
        <BiWallet size={16} style={{ color: '#9C27B0' }} />
        <span>BUDGET</span>
      </div>

    </div>

  </div>
</div>

      
      {/* Scrollable Charts Container */}
      {!schemeInsightsOpen && !attendanceInsightsOpen && !hodInsightsOpen && !budgetInsightsOpen && (
      <div style={{ flex: 1, overflowY: 'auto', overflowX: 'hidden' }}>
      {/* Top Summary Charts Grid - 2x2 Layout */}
      <div className="charts-grid" style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '12px', marginBottom: '1px' }}>
        
        {/* Schemes Summary - stacked bar with active/inactive and per-scheme list for total view */}
        <div className="chart-card" style={{ gridColumn: '1 / 2', backgroundColor: '#ffffff', border: '1px solid #d0d0d0', boxShadow: '0 1px 3px rgba(0,0,0,0.05)', height: '288px', display: 'flex', flexDirection: 'column' }}>
          <div className="chart-card-header" style={{ backgroundColor: '#f8f8f8', borderBottom: '1px solid #d0d0d0', display: 'flex', justifyContent: 'space-between', alignItems: 'center', padding: '8px 12px' }}>
            <div style={{ display: 'flex', alignItems: 'center', gap: '8px', flexWrap: 'wrap' }}>
              <h3 style={{ fontSize: '13px', fontWeight: '600', color: '#1a1a1a', margin: 0 }}>
                Schemes {isSchemeWiseView ? '(HOD wise)' : '(FY ' + (selectedSchemesYear || schemesSummary.year) + ')'}
              </h3>
              {isSchemeWiseView && chartFilters.schemes.hod_id && (
                <span style={{ fontSize: '12px', color: '#666', fontWeight: 'normal' }}>
                  - {allHODs.find(h => h.id === parseInt(chartFilters.schemes.hod_id))?.name}
                </span>
              )}
            </div>
            <div style={{ display: 'flex', gap: '6px', alignItems: 'center' }}>
              <select 
                value={isSchemeWiseView ? 'hodwise' : 'summary'}
                onChange={(e) => setIsSchemeWiseView(e.target.value === 'hodwise')}
                style={{
                  padding: '5px 6px',
                  fontSize: '11px',
                  border: '1px solid #d0d0d0',
                  borderRadius: '3px',
                  backgroundColor: '#fff',
                  color: '#333',
                  cursor: 'pointer',
                  outline: 'none',
                  maxWidth: '120px'
                }}
              >
                <option value="summary">Summary</option>
                <option value="hodwise">HOD wise</option>
              </select>
              {!isSchemeWiseView && (
                <>
                  <select 
                    value={schemesHODFilter}
                    onChange={(e) => setSchemesHODFilter(e.target.value)}
                    style={{
                      padding: '5px 6px',
                      fontSize: '11px',
                      border: '1px solid #d0d0d0',
                      borderRadius: '3px',
                      backgroundColor: '#fff',
                      color: '#333',
                      cursor: 'pointer',
                      outline: 'none',
                      maxWidth: '130px'
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
                      padding: '5px 6px',
                      fontSize: '11px',
                      border: '1px solid #d0d0d0',
                      borderRadius: '3px',
                      backgroundColor: '#fff',
                      color: '#333',
                      cursor: 'pointer',
                      outline: 'none'
                    }}
                  >
                    <option value="all">Total</option>
                    <option value="split">State vs Central</option>
                  </select>
                </>
              )}
              {isSchemeWiseView && (
                <div style={{ position: 'relative' }}>
                  <FiFilter 
                    style={{ cursor: 'pointer', color: chartFilters.schemes.hod_id ? '#2e7d32' : '#666', fontSize: '18px' }} 
                    title="Filter" 
                    onClick={(e) => { e.stopPropagation(); toggleFilterDropdown('schemes'); }}
                  />
                  {renderFilterDropdown('schemes')}
                </div>
              )}
              <select 
                value={schemesYearFilter || schemesSummary.year} 
                onChange={(e) => {
                  setSchemesYearFilter(e.target.value);
                }}
                style={{
                  padding: '5px 6px',
                  fontSize: '11px',
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
          </div>
          <div className="chart-card-body" style={{ height: schemesChartHeight, padding: '8px 12px 4px 12px' }}>
            <div style={{ height: '100%' }}>
              {isSchemeWiseView ? (
                <Line data={schemesHODBarLineData} options={schemesBarLineOptions} />
              ) : (
                <Bar data={schemesChartData} options={schemesChartOptions} plugins={[ChartDataLabels]} />
              )}
            </div>
            {isTotalSchemesView && filteredSchemesList.length === 0 && !isSchemeWiseView && (
              <div style={{ marginTop: '12px', fontSize: '12px', color: '#666' }}>No schemes found for this year.</div>
            )}
          </div>
        </div>
        {/* Chart 1: HOD Revenue / Budget by HOD */}
        <div className="chart-card" style={{ height: '288px', display: 'flex', flexDirection: 'column' }}>
          <div className="chart-card-header" style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
            <h3>
              {isHodBudgetView ? (
                'Budget by HOD (₹ Cr)'
              ) : (
                <>
                  <FiPieChart /> HOD Revenue {chartFilters.revenue.hod_id && <span style={{ fontSize: '12px', color: '#666', fontWeight: 'normal' }}>({allHODs.find(h => h.id === parseInt(chartFilters.revenue.hod_id))?.name})</span>}
                </>
              )}
            </h3>
            <div style={{ display: 'flex', gap: '8px', alignItems: 'center' }}>
              <select
                value={isHodBudgetView ? 'budget' : 'revenue'}
                onChange={(e) => setIsHodBudgetView(e.target.value === 'budget')}
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
                <option value="revenue">Revenue</option>
                <option value="budget">Budget by HOD</option>
              </select>
              {isHodBudgetView ? (
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
              ) : (
                <div className="chart-filter-container" style={{ position: 'relative' }}>
                  <FiFilter 
                    style={{ cursor: 'pointer', color: chartFilters.revenue.hod_id ? '#2e7d32' : '#666', fontSize: '18px' }} 
                    title="Filter" 
                    onClick={(e) => { e.stopPropagation(); toggleFilterDropdown('revenue'); }}
                  />
                  {renderFilterDropdown('revenue')}
                </div>
              )}
            </div>
          </div>
          <div className="chart-card-body">
            {isHodBudgetView ? (
              <div style={{ height: 'auto', padding: '10px 12px' }}>
                <div className="chart-box large" style={{ height: '216px', minHeight: '216px' }}>
                  <Bar data={budgetHODStackedBarData} options={budgetHODStackedBarOptions} plugins={[ChartDataLabels]} />
                </div>
              </div>
            ) : (
              <div className="chart-container" style={{ cursor: 'pointer', height: '216px', position: 'relative' }}>
                <Doughnut data={hodRevenueChartData} options={hodRevenuePieOptions} plugins={[ChartDataLabels, revenueCenterTextPlugin]} />
              </div>
            )}
          </div>
        </div>

       
        {/* Budget Summary/Breakdown - Vertical Bar with View Filter */}
        <div className="chart-card" style={{ backgroundColor: '#ffffff', border: '1px solid #d0d0d0', boxShadow: '0 1px 3px rgba(0,0,0,0.05)', height: '288px', display: 'flex', flexDirection: 'column' }}>
          <div className="chart-card-header" style={{ backgroundColor: '#f8f8f8', borderBottom: '1px solid #d0d0d0',  display: 'flex', justifyContent: 'space-between', alignItems: 'center', gap: '10px' }}>
            <h3 style={{ fontSize: '14px', fontWeight: '600', color: '#1a1a1a', margin: 0 }}>Budget {isBudgetBreakdownView ? '(Breakdown)' : '(Summary)'} (FY {isBudgetBreakdownView ? budgetBreakdownYearFilter || budgetBreakdown.year : budgetSummaryYearFilter || budgetSummary.year})</h3>
            <div style={{ display: 'flex', gap: '8px', marginLeft: 'auto' }}>
              <select 
                value={isBudgetBreakdownView ? 'breakdown' : 'summary'}
                onChange={(e) => setIsBudgetBreakdownView(e.target.value === 'breakdown')}
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
                <option value="summary">Summary</option>
                <option value="breakdown">Breakdown</option>
              </select>
              <select
                value={isBudgetBreakdownView ? budgetBreakdownYearFilter || budgetBreakdown.year : budgetSummaryYearFilter || budgetSummary.year}
                onChange={(e) => {
                  if (isBudgetBreakdownView) {
                    refreshBudgetBreakdown(e.target.value);
                  } else {
                    refreshBudgetSummary(e.target.value);
                  }
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
              {!isBudgetBreakdownView && (
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
              )}
            </div>
          </div>
          <div className="chart-card-body" style={{ height: '234px', padding: isBudgetBreakdownView ? '0' : '10px 12px', display: 'flex', gap: '0' }}>
            {isBudgetBreakdownView ? (
              <>
                {/* Left Side - Pie Chart (64%) */}
                <div style={{ width: '64%', position: 'relative', borderRight: '1px solid #e8e8e8', padding: '10px' }}>
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
                              padding: 8,
                              font: { size: 12 },
                              usePointStyle: true,
                              boxWidth: 8
                            }
                          },
                          tooltip: {
                            backgroundColor: 'rgba(0,0,0,0.8)',
                            padding: 8,
                            titleFont: { size: 12 },
                            bodyFont: { size: 11 },
                            callbacks: {
                              label: function(context) {
                                const value = context.raw;
                                return '₹' + (value / 10000000).toFixed(1) + 'Cr';
                              }
                            }
                          }
                        }
                      }}
                    />
                  </div>
                </div>

                {/* Right Side - Budget Status Data (36%) */}
                <div style={{ width: '36%', display: 'flex', flexDirection: 'column', gap: '6px', padding: '10px 12px' }}>
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
              </>
            ) : (
              <Bar data={budgetSummaryChartData} options={budgetSummaryChartOptions} plugins={[ChartDataLabels]} />
            )}
          </div>
        </div>

        {/* Attendance Summary Pie Chart - Top Right */}
        <div className="chart-card" style={{ backgroundColor: '#ffffff', border: '1px solid #d0d0d0', boxShadow: '0 1px 3px rgba(0,0,0,0.05)', height: '288px', display: 'flex', flexDirection: 'column' }}>
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
          <div style={{ display: 'flex', height: '234px', padding: '0' }}>
            {/* Left 64%: Pie Chart */}
            <div style={{ width: '64%', position: 'relative', borderRight: '1px solid #e8e8e8', padding: '10px', minHeight: '207px', height: '207px' }}>
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
            <div style={{ width: '36%', display: 'flex', flexDirection: 'column', padding: '10px 12px' }}>
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
        {/* <div className="chart-card">
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
        </div> */}
      </div>
      )}
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

      {/* Scheme Insights Inline */}
      {schemeInsightsOpen && (
        <div style={{
          marginTop: '0px',
          backgroundColor: '#f5f5f5',
          borderRadius: '12px',
          overflow: 'hidden',
          boxShadow: '0 2px 8px rgba(0,0,0,0.08)'
        }}>
          {/* Header */}
          <div style={{
            padding: '5px 10px',
            borderBottom: '2px solid #e0e0e0',
            display: 'flex',
            justifyContent: 'space-between',
            alignItems: 'center',
            backgroundColor: '#fff'
          }}>
            <h2 style={{ margin: 0, fontSize: '22px', fontWeight: '600', color: '#1a1a1a' }}>
              Page 3: Scheme Insights
            </h2>
            <button
              onClick={() => setSchemeInsightsOpen(false)}
              style={{
                background: 'none',
                border: 'none',
                fontSize: '28px',
                cursor: 'pointer',
                color: '#666',
                padding: '0 10px',
                lineHeight: '1'
              }}
            >
              ×
            </button>
          </div>

          {/* Content */}
          <div style={{
            display: 'flex',
            minHeight: '600px'
          }}>
            {/* Left Sidebar - Filters */}
            <div style={{
              width: '200px',
              backgroundColor: '#fff',
              borderRight: '1px solid #e0e0e0',
              padding: '12px'
            }}>
                <h3 style={{ 
                  fontSize: '13px', 
                  fontWeight: '600', 
                  marginBottom: '12px',
                  color: '#333',
                  display: 'flex',
                  alignItems: 'center',
                  gap: '6px'
                }}>
                  <FiFilter /> Filters
                </h3>

                {/* Department Filter */}
                <div style={{ marginBottom: '12px' }}>
                  <label style={{
                    display: 'block',
                    fontSize: '11px',
                    fontWeight: '600',
                    marginBottom: '4px',
                    color: '#555'
                  }}>
                    Department
                  </label>
                  <select
                    value={schemeInsightsFilters.department}
                    onChange={(e) => setSchemeInsightsFilters({
                      ...schemeInsightsFilters,
                      department: e.target.value
                    })}
                    style={{
                      width: '100%',
                      padding: '6px 8px',
                      fontSize: '12px',
                      border: '1px solid #d0d0d0',
                      borderRadius: '4px',
                      backgroundColor: '#fff',
                      cursor: 'pointer',
                      outline: 'none'
                    }}
                  >
                    <option value="">All Departments</option>
                    {Array.from(new Set(allSchemes.map(s => s.category || s.department).filter(Boolean))).map(dept => (
                      <option key={dept} value={dept}>{dept}</option>
                    ))}
                  </select>
                </div>

                {/* Year Filter */}
                <div style={{ marginBottom: '12px' }}>
                  <label style={{
                    display: 'block',
                    fontSize: '11px',
                    fontWeight: '600',
                    marginBottom: '4px',
                    color: '#555'
                  }}>
                    Year
                  </label>
                  <select
                    value={schemeInsightsFilters.year}
                    onChange={(e) => setSchemeInsightsFilters({
                      ...schemeInsightsFilters,
                      year: e.target.value
                    })}
                    style={{
                      width: '100%',
                      padding: '6px 8px',
                      fontSize: '12px',
                      border: '1px solid #d0d0d0',
                      borderRadius: '4px',
                      backgroundColor: '#fff',
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

                {/* Scheme Status Filter */}
                <div style={{ marginBottom: '12px' }}>
                  <label style={{
                    display: 'block',
                    fontSize: '11px',
                    fontWeight: '600',
                    marginBottom: '4px',
                    color: '#555'
                  }}>
                    Scheme Status
                  </label>
                  <select
                    value={schemeInsightsFilters.schemeStatus}
                    onChange={(e) => setSchemeInsightsFilters({
                      ...schemeInsightsFilters,
                      schemeStatus: e.target.value
                    })}
                    style={{
                      width: '100%',
                      padding: '6px 8px',
                      fontSize: '12px',
                      border: '1px solid #d0d0d0',
                      borderRadius: '4px',
                      backgroundColor: '#fff',
                      cursor: 'pointer',
                      outline: 'none'
                    }}
                  >
                    <option value="">All Status</option>
                    <option value="active">Active</option>
                    <option value="inactive">Inactive</option>
                    <option value="planned">Planned</option>
                    <option value="completed">Completed</option>
                  </select>
                </div>

                {/* HOD Filter */}
                <div style={{ marginBottom: '12px' }}>
                  <label style={{
                    display: 'block',
                    fontSize: '11px',
                    fontWeight: '600',
                    marginBottom: '4px',
                    color: '#555'
                  }}>
                    HOD
                  </label>
                  <select
                    value={schemeInsightsFilters.hodId}
                    onChange={(e) => setSchemeInsightsFilters({
                      ...schemeInsightsFilters,
                      hodId: e.target.value
                    })}
                    style={{
                      width: '100%',
                      padding: '6px 8px',
                      fontSize: '12px',
                      border: '1px solid #d0d0d0',
                      borderRadius: '4px',
                      backgroundColor: '#fff',
                      cursor: 'pointer',
                      outline: 'none'
                    }}
                  >
                    <option value="">All HODs</option>
                    {allHODs.map(hod => (
                      <option key={hod.id} value={hod.id}>{hod.name}</option>
                    ))}
                  </select>
                </div>

                {/* Chart View Filter */}
                <div style={{ marginBottom: '12px' }}>
                  <label style={{
                    display: 'block',
                    fontSize: '11px',
                    fontWeight: '600',
                    marginBottom: '4px',
                    color: '#555'
                  }}>
                    Chart View
                  </label>
                  <select
                    value={schemeInsightsFilters.chartView}
                    onChange={(e) => setSchemeInsightsFilters({
                      ...schemeInsightsFilters,
                      chartView: e.target.value
                    })}
                    style={{
                      width: '100%',
                      padding: '6px 8px',
                      fontSize: '12px',
                      border: '1px solid #d0d0d0',
                      borderRadius: '4px',
                      backgroundColor: '#fff',
                      cursor: 'pointer',
                      outline: 'none'
                    }}
                  >
                    <option value="status">By Status</option>
                    <option value="allSchemes">All Schemes</option>
                    <option value="stateSchemes">State Schemes</option>
                    <option value="centralSchemes">Central Schemes</option>
                  </select>
                </div>

                {/* Reset Button */}
                <button
                  onClick={() => {
                    setSchemeInsightsFilters({
                      department: '',
                      year: '2025-26',
                      schemeStatus: '',
                      hodId: '',
                      chartView: 'status'
                    });
                  }}
                  style={{
                    width: '100%',
                    padding: '6px 8px',
                    fontSize: '11px',
                    fontWeight: '600',
                    backgroundColor: '#f5f5f5',
                    color: '#333',
                    border: '1px solid #d0d0d0',
                    borderRadius: '4px',
                    cursor: 'pointer',
                    transition: 'all 0.2s'
                  }}
                  onMouseOver={(e) => e.target.style.backgroundColor = '#e0e0e0'}
                  onMouseOut={(e) => e.target.style.backgroundColor = '#f5f5f5'}
                >
                  Reset
                </button>
              </div>

            {/* Right Content Area */}
            <div style={{
              flex: 1,
              padding: '5px',
              backgroundColor: '#f5f5f5'
            }}>
              <SchemeInsightsContent 
                filters={schemeInsightsFilters}
                allSchemes={allSchemes}
                allHODs={allHODs}
              />
            </div>
          </div>
        </div>
      )}

      {/* Attendance Insights Inline */}
      {attendanceInsightsOpen && (
        <div style={{
          marginTop: '0px',
          backgroundColor: '#f5f5f5',
          borderRadius: '12px',
          overflow: 'hidden',
          boxShadow: '0 2px 8px rgba(0,0,0,0.08)'
        }}>
          {/* Header */}
          <div style={{
            padding: '5px 15px',
            borderBottom: '2px solid #e0e0e0',
            display: 'flex',
            justifyContent: 'space-between',
            alignItems: 'center',
            backgroundColor: '#fff'
          }}>
            <h2 style={{ margin: 0, fontSize: '22px', fontWeight: '600', color: '#1a1a1a' }}>
              ATTEDENCE OVERVIEW
            </h2>
            <button
              onClick={() => setAttendanceInsightsOpen(false)}
              style={{
                background: 'none',
                border: 'none',
                fontSize: '28px',
                cursor: 'pointer',
                color: '#666',
                padding: '0 10px',
                lineHeight: '1'
              }}
            >
              ×
            </button>
          </div>

          {/* Content */}
          <div style={{
            display: 'flex',
            minHeight: '600px'
          }}>
            {/* Left Sidebar - Filters */}
            <div style={{
              width: '200px',
              backgroundColor: '#fff',
              borderRight: '1px solid #e0e0e0',
              padding: '12px'
            }}>
              <h3 style={{ 
                fontSize: '13px', 
                fontWeight: '600', 
                marginBottom: '12px',
                color: '#333',
                display: 'flex',
                alignItems: 'center',
                gap: '6px'
              }}>
                <FiFilter /> Filters
              </h3>

              {/* Period Filter */}
              <div style={{ marginBottom: '12px' }}>
                <label style={{
                  display: 'block',
                  fontSize: '11px',
                  fontWeight: '600',
                  marginBottom: '4px',
                  color: '#555'
                }}>
                  Period
                </label>
                <select
                  value={attendanceInsightsFilters.period}
                  onChange={(e) => setAttendanceInsightsFilters({
                    ...attendanceInsightsFilters,
                    period: e.target.value
                  })}
                  style={{
                    width: '100%',
                    padding: '6px 8px',
                    fontSize: '12px',
                    border: '1px solid #d0d0d0',
                    borderRadius: '4px',
                    backgroundColor: '#fff',
                    cursor: 'pointer',
                    outline: 'none'
                  }}
                >
                  <option value="today">Today</option>
                  <option value="weekly">Weekly</option>
                  <option value="yearly">Yearly</option>
                  <option value="custom">Custom</option>
                </select>
              </div>

              {/* HOD Filter */}
              <div style={{ marginBottom: '12px' }}>
                <label style={{
                  display: 'block',
                  fontSize: '11px',
                  fontWeight: '600',
                  marginBottom: '4px',
                  color: '#555'
                }}>
                  HOD
                </label>
                <select
                  value={attendanceInsightsFilters.hodId}
                  onChange={(e) => setAttendanceInsightsFilters({
                    ...attendanceInsightsFilters,
                    hodId: e.target.value
                  })}
                  style={{
                    width: '100%',
                    padding: '6px 8px',
                    fontSize: '12px',
                    border: '1px solid #d0d0d0',
                    borderRadius: '4px',
                    backgroundColor: '#fff',
                    cursor: 'pointer',
                    outline: 'none'
                  }}
                >
                  <option value="">All HODs</option>
                  {allHODs.map(hod => (
                    <option key={hod.id} value={hod.id}>{hod.name}</option>
                  ))}
                </select>
              </div>

              {/* Status Filter */}
              <div style={{ marginBottom: '12px' }}>
                <label style={{
                  display: 'block',
                  fontSize: '11px',
                  fontWeight: '600',
                  marginBottom: '4px',
                  color: '#555'
                }}>
                  Attendance Status
                </label>
                <select
                  value={attendanceInsightsFilters.status}
                  onChange={(e) => setAttendanceInsightsFilters({
                    ...attendanceInsightsFilters,
                    status: e.target.value
                  })}
                  style={{
                    width: '100%',
                    padding: '6px 8px',
                    fontSize: '12px',
                    border: '1px solid #d0d0d0',
                    borderRadius: '4px',
                    backgroundColor: '#fff',
                    cursor: 'pointer',
                    outline: 'none'
                  }}
                >
                  <option value="">All Status</option>
                  <option value="present">Present</option>
                  <option value="absent">Absent</option>
                  <option value="late">Late</option>
                  <option value="leave">Leave</option>
                </select>
              </div>

              {/* Reset Button */}
              <button
                onClick={() => {
                  setAttendanceInsightsFilters({
                    period: 'today',
                    hodId: '',
                    status: ''
                  });
                }}
                style={{
                  width: '100%',
                  padding: '6px 8px',
                  fontSize: '11px',
                  fontWeight: '600',
                  backgroundColor: '#f5f5f5',
                  color: '#333',
                  border: '1px solid #d0d0d0',
                  borderRadius: '4px',
                  cursor: 'pointer',
                  transition: 'all 0.2s'
                }}
                onMouseOver={(e) => e.target.style.backgroundColor = '#e0e0e0'}
                onMouseOut={(e) => e.target.style.backgroundColor = '#f5f5f5'}
              >
                Reset
              </button>
            </div>

            {/* Right Content Area */}
            <div style={{
              flex: 1,
              padding: '5px',
              backgroundColor: '#f5f5f5'
            }}>
              <AttendanceInsightsContent 
                filters={attendanceInsightsFilters}
                allAttendance={attendanceByHOD}
                allHODs={allHODs}
                stats={stats}
              />
            </div>
          </div>
        </div>
      )}

      {/* HOD Insights Inline */}
      {hodInsightsOpen && (
        <div style={{
          marginTop: '0px',
          backgroundColor: '#f5f5f5',
          borderRadius: '12px',
          overflow: 'hidden',
          boxShadow: '0 2px 8px rgba(0,0,0,0.08)'
        }}>
          {/* Header */}
          <div style={{
            padding: '5px 10px',
            borderBottom: '2px solid #e0e0e0',
            display: 'flex',
            justifyContent: 'space-between',
            alignItems: 'center',
            backgroundColor: '#fff'
          }}>
            <h2 style={{ margin: 0, fontSize: '22px', fontWeight: '600', color: '#1a1a1a' }}>
              HOD MANAGEMENT
            </h2>
            <button
              onClick={() => setHodInsightsOpen(false)}
              style={{
                background: 'none',
                border: 'none',
                fontSize: '28px',
                cursor: 'pointer',
                color: '#666',
                padding: '0 10px',
                lineHeight: '1'
              }}
            >
              ×
            </button>
          </div>

          {/* Content */}
          <div style={{
            display: 'flex',
            minHeight: '600px'
          }}>
            {/* Left Sidebar - Filters */}
            <div style={{
              width: '200px',
              backgroundColor: '#fff',
              borderRight: '1px solid #e0e0e0',
              padding: '12px'
            }}>
              <h3 style={{ 
                fontSize: '13px', 
                fontWeight: '600', 
                marginBottom: '12px',
                color: '#333',
                display: 'flex',
                alignItems: 'center',
                gap: '6px'
              }}>
                <FiFilter /> Chart Type
              </h3>

              {/* Chart Type Selection */}
              <div style={{ marginBottom: '12px' }}>
                <label style={{
                  display: 'block',
                  fontSize: '11px',
                  fontWeight: '600',
                  marginBottom: '4px',
                  color: '#555'
                }}>
                  Select Chart
                </label>
                <select
                  value={hodInsightsChartType}
                  onChange={(e) => setHodInsightsChartType(e.target.value)}
                  style={{
                    width: '100%',
                    padding: '6px 8px',
                    fontSize: '12px',
                    border: '1px solid #d0d0d0',
                    borderRadius: '4px',
                    backgroundColor: '#fff',
                    cursor: 'pointer',
                    outline: 'none'
                  }}
                >
                  <option value="revenue">HOD Revenue</option>
                  <option value="budget">Budget by HOD</option>
                  <option value="schemes">Schemes by HOD</option>
                </select>
              </div>

              {/* Info Box */}
              <div style={{
                padding: '8px',
                backgroundColor: '#e3f2fd',
                borderRadius: '4px',
                borderLeft: '3px solid #1976d2',
                marginTop: '12px'
              }}>
                <div style={{ fontSize: '11px', color: '#1565c0', fontWeight: '600' }}>
                  {hodInsightsChartType === 'revenue' && 'HOD Revenue Distribution'}
                  {hodInsightsChartType === 'budget' && 'Budget Allocation by HOD'}
                  {hodInsightsChartType === 'schemes' && 'Schemes Count by HOD'}
                </div>
                <div style={{ fontSize: '10px', color: '#0d47a1', marginTop: '3px' }}>
                  {hodInsightsChartType === 'revenue' && 'View revenue generated by each HOD'}
                  {hodInsightsChartType === 'budget' && 'View budget allocation across HODs'}
                  {hodInsightsChartType === 'schemes' && 'View scheme distribution across HODs'}
                </div>
              </div>
            </div>

            {/* Right Content Area */}
            <div style={{
              flex: 1,
              padding: '5px',
              backgroundColor: '#f5f5f5'
            }}>
              <HodInsightsContent 
                chartType={hodInsightsChartType}
                revenueByHOD={revenueByHOD}
                budgetByHOD={budgetByHOD}
                schemesByHOD={schemesByHOD}
                allHODs={allHODs}
              />
            </div>
          </div>
        </div>
      )}

      {/* Budget Insights Inline */}
      {budgetInsightsOpen && (
        <div style={{
          marginTop: '0px',
          backgroundColor: '#f5f5f5',
          borderRadius: '12px',
          overflow: 'hidden',
          boxShadow: '0 2px 8px rgba(0,0,0,0.08)'
        }}>
          {/* Header */}
          <div style={{
            padding: '5px 10px',
            borderBottom: '2px solid #e0e0e0',
            display: 'flex',
            justifyContent: 'space-between',
            alignItems: 'center',
            backgroundColor: '#fff'
          }}>
            <h2 style={{ margin: 0, fontSize: '22px', fontWeight: '600', color: '#1a1a1a' }}>
              Budget Management
            </h2>
            <button
              onClick={() => setBudgetInsightsOpen(false)}
              style={{
                background: 'none',
                border: 'none',
                fontSize: '28px',
                cursor: 'pointer',
                color: '#666',
                padding: '0 10px',
                lineHeight: '1'
              }}
            >
              ×
            </button>
          </div>

          {/* Content */}
          <div style={{
            display: 'flex',
            minHeight: '600px'
          }}>
            {/* Left Sidebar - Filters */}
            <div style={{
              width: '200px',
              backgroundColor: '#fff',
              borderRight: '1px solid #e0e0e0',
              padding: '12px'
            }}>
              <h3 style={{ 
                fontSize: '13px', 
                fontWeight: '600', 
                marginBottom: '12px',
                color: '#333',
                display: 'flex',
                alignItems: 'center',
                gap: '6px'
              }}>
                <FiFilter /> Filters
              </h3>

              {/* Chart Type Selection */}
              <div style={{ marginBottom: '12px' }}>
                <label style={{
                  display: 'block',
                  fontSize: '11px',
                  fontWeight: '600',
                  marginBottom: '4px',
                  color: '#555'
                }}>
                  Budget View
                </label>
                <select
                  value={budgetInsightsFilters.chartType}
                  onChange={(e) => setBudgetInsightsFilters({
                    ...budgetInsightsFilters,
                    chartType: e.target.value
                  })}
                  style={{
                    width: '100%',
                    padding: '6px 8px',
                    fontSize: '12px',
                    border: '1px solid #d0d0d0',
                    borderRadius: '4px',
                    backgroundColor: '#fff',
                    cursor: 'pointer',
                    outline: 'none'
                  }}
                >
                  <option value="summary">Budget Summary</option>
                  <option value="breakdown">Budget Breakdown</option>
                  <option value="byHod">Budget by HOD</option>
                </select>
              </div>

              {/* Year Filter */}
              <div style={{ marginBottom: '12px' }}>
                <label style={{
                  display: 'block',
                  fontSize: '11px',
                  fontWeight: '600',
                  marginBottom: '4px',
                  color: '#555'
                }}>
                  Year
                </label>
                <select
                  value={budgetInsightsFilters.year}
                  onChange={(e) => setBudgetInsightsFilters({
                    ...budgetInsightsFilters,
                    year: e.target.value
                  })}
                  style={{
                    width: '100%',
                    padding: '6px 8px',
                    fontSize: '12px',
                    border: '1px solid #d0d0d0',
                    borderRadius: '4px',
                    backgroundColor: '#fff',
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

              {/* Budget Status Filter */}
              <div style={{ marginBottom: '12px' }}>
                <label style={{
                  display: 'block',
                  fontSize: '11px',
                  fontWeight: '600',
                  marginBottom: '4px',
                  color: '#555'
                }}>
                  Budget Status
                </label>
                <select
                  value={budgetInsightsFilters.status}
                  onChange={(e) => setBudgetInsightsFilters({
                    ...budgetInsightsFilters,
                    status: e.target.value
                  })}
                  style={{
                    width: '100%',
                    padding: '6px 8px',
                    fontSize: '12px',
                    border: '1px solid #d0d0d0',
                    borderRadius: '4px',
                    backgroundColor: '#fff',
                    cursor: 'pointer',
                    outline: 'none'
                  }}
                >
                  <option value="">All Status</option>
                  <option value="allocated">Allocated</option>
                  <option value="utilized">Utilized</option>
                  <option value="remaining">Remaining</option>
                </select>
              </div>

              {/* Info Box */}
              <div style={{
                padding: '8px',
                backgroundColor: '#e3f2fd',
                borderRadius: '4px',
                borderLeft: '3px solid #1976d2',
                marginTop: '12px'
              }}>
                <div style={{ fontSize: '11px', color: '#1565c0', fontWeight: '600' }}>
                  {budgetInsightsFilters.chartType === 'summary' && 'Budget Summary'}
                  {budgetInsightsFilters.chartType === 'breakdown' && 'Budget Breakdown'}
                  {budgetInsightsFilters.chartType === 'byHod' && 'Budget by HOD'}
                </div>
                <div style={{ fontSize: '10px', color: '#0d47a1', marginTop: '3px' }}>
                  {budgetInsightsFilters.chartType === 'summary' && 'View overall budget allocation'}
                  {budgetInsightsFilters.chartType === 'breakdown' && 'View budget breakdown details'}
                  {budgetInsightsFilters.chartType === 'byHod' && 'View budget by HOD distribution'}
                </div>
              </div>

              {/* Reset Button */}
              <button
                onClick={() => {
                  setBudgetInsightsFilters({
                    chartType: 'summary',
                    year: '2025-26',
                    status: ''
                  });
                }}
                style={{
                  width: '100%',
                  padding: '10px',
                  fontSize: '13px',
                  fontWeight: '600',
                  backgroundColor: '#f5f5f5',
                  color: '#333',
                  border: '1px solid #d0d0d0',
                  borderRadius: '6px',
                  cursor: 'pointer',
                  marginTop: '20px',
                  transition: 'all 0.2s'
                }}
                onMouseOver={(e) => e.target.style.backgroundColor = '#e0e0e0'}
                onMouseOut={(e) => e.target.style.backgroundColor = '#f5f5f5'}
              >
                Reset Filters
              </button>
            </div>

            {/* Right Content Area */}
            <div style={{
              flex: 1,
              padding: '5px',
              backgroundColor: '#f5f5f5'
            }}>
              <BudgetInsightsContent 
                filters={budgetInsightsFilters}
                budgetSummary={budgetSummary}
                budgetBreakdown={budgetBreakdown}
                budgetByHOD={budgetByHOD}
              />
            </div>
          </div>
        </div>
      )}
    </div>
  );
};

// Budget Insights Content Component
const BudgetInsightsContent = ({ filters, budgetSummary, budgetBreakdown, budgetByHOD }) => {
  const formatCurrency = (amount) => {
    const num = parseFloat(amount) || 0;
    if (num >= 10000000) {
      return `₹${(num / 10000000).toFixed(2)} Cr`;
    } else if (num >= 100000) {
      return `₹${(num / 100000).toFixed(2)} L`;
    }
    return `₹${num.toFixed(2)}`;
  };

  let chartData, summaryCards, tableData;

  if (filters.chartType === 'summary') {
    // Budget Summary (Total, Central, State)
    const total = budgetSummary.total || { total: 0, central: 0, state: 0 };
    
    chartData = {
      labels: ['Central', 'State'],
      datasets: [{
        data: [total.central || 0, total.state || 0],
        backgroundColor: ['#1565c0', '#2e7d32'],
        borderWidth: 2,
        borderColor: '#fff'
      }]
    };

    summaryCards = [
      { label: 'Total Budget', value: formatCurrency(total.total || 0), color: '#1565c0' },
      { label: 'Central Share', value: formatCurrency(total.central || 0), color: '#2e7d32' },
      { label: 'State Share', value: formatCurrency(total.state || 0), color: '#ef6c00' }
    ];

    tableData = [
      { type: 'Total', central: total.central || 0, state: total.state || 0, total: total.total || 0 }
    ];
  } else if (filters.chartType === 'breakdown') {
    // Budget Breakdown (Estimated, Sanction, Pending)
    const breakdown = budgetBreakdown;
    
    chartData = {
      labels: ['Estimated', 'Sanction', 'Pending'],
      datasets: [{
        data: [breakdown.estimated?.total || 0, breakdown.sanction?.total || 0, breakdown.pending?.total || 0],
        backgroundColor: ['#1565c0', '#2e7d32', '#FF9800'],
        borderWidth: 2,
        borderColor: '#fff'
      }]
    };

    summaryCards = [
      { label: 'Estimated', value: formatCurrency(breakdown.estimated?.total || 0), color: '#1565c0' },
      { label: 'Sanction', value: formatCurrency(breakdown.sanction?.total || 0), color: '#2e7d32' },
      { label: 'Pending', value: formatCurrency(breakdown.pending?.total || 0), color: '#FF9800' }
    ];

    tableData = [
      { 
        type: 'Estimated', 
        central: breakdown.estimated?.central || 0, 
        state: breakdown.estimated?.state || 0, 
        total: breakdown.estimated?.total || 0 
      },
      { 
        type: 'Sanction', 
        central: breakdown.sanction?.central || 0, 
        state: breakdown.sanction?.state || 0, 
        total: breakdown.sanction?.total || 0 
      },
      { 
        type: 'Pending', 
        central: breakdown.pending?.central || 0, 
        state: breakdown.pending?.state || 0, 
        total: breakdown.pending?.total || 0 
      }
    ];
  } else if (filters.chartType === 'byHod') {
    // Budget by HOD
    const allocatedByHOD = budgetByHOD.map(item => item.allocated || 0);
    const hodNames = budgetByHOD.map(item => item.department || item.hod_name || 'Unknown');

    const totalAllocated = allocatedByHOD.reduce((a, b) => a + b, 0);

    chartData = {
      labels: hodNames,
      datasets: [{
        data: allocatedByHOD,
        backgroundColor: [
          '#1565c0', '#2e7d32', '#ef6c00', '#7b1fa2', '#c62828',
          '#00838f', '#FFD700', '#E91E63', '#795548', '#607D8B'
        ],
        borderWidth: 2,
        borderColor: '#fff'
      }]
    };

    summaryCards = [
      { label: 'Total Allocated', value: formatCurrency(totalAllocated), color: '#1565c0' },
      { label: 'HOD Count', value: budgetByHOD.length, color: '#2e7d32' },
      { label: 'Avg per HOD', value: formatCurrency(totalAllocated / (budgetByHOD.length || 1)), color: '#ef6c00' }
    ];

    tableData = budgetByHOD;
  }

  const pieOptions = {
    responsive: true,
    maintainAspectRatio: false,
    plugins: {
      legend: {
        position: 'right',
        align: 'center',
        maxHeight: 250,
        labels: {
          padding: 15,
          usePointStyle: true,
          font: { size: 11 },
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
        callbacks: {
          label: function(context) {
            const total = context.dataset.data.reduce((a, b) => a + b, 0);
            const percentage = ((context.parsed / total) * 100).toFixed(1);
            return `${formatCurrency(context.parsed)} (${percentage}%)`;
          }
        }
      },
      datalabels: {
        color: '#fff',
        font: { size: 12, weight: 'bold' },
        formatter: (value, context) => {
          const total = context.dataset.data.reduce((a, b) => a + b, 0);
          const percentage = ((value / total) * 100).toFixed(0);
          return percentage >= 3 ? `${percentage}%` : '';
        }
      }
    }
  };

  return (
    <div>
      {/* Summary Cards */}
      <div style={{
        display: 'grid',
        gridTemplateColumns: 'repeat(3, 1fr)',
        gap: '8px',
        marginBottom: '12px'
      }}>
        {summaryCards.map((card, index) => (
          <div key={index} style={{
            backgroundColor: '#fff',
            padding: '8px 10px',
            borderRadius: '4px',
            boxShadow: '0 1px 2px rgba(0,0,0,0.04)',
            display: 'flex',
            justifyContent: 'space-between',
            alignItems: 'center'
          }}>
            <div style={{ fontSize: '13px', color: '#666', fontWeight: '700' }}>
              {card.label}
            </div>
            <div style={{ fontSize: '24px', fontWeight: '800', color: card.color }}>
              {card.value}
            </div>
          </div>
        ))}
      </div>

      {/* Chart */}
      <div style={{
        backgroundColor: '#fff',
        padding: '12px',
        borderRadius: '4px',
        boxShadow: '0 1px 2px rgba(0,0,0,0.04)',
        marginBottom: '12px'
      }}>
        <h3 style={{ fontSize: '15px', fontWeight: '700', marginBottom: '12px', color: '#333' }}>
          {filters.chartType === 'summary' && 'Budget Summary Distribution'}
          {filters.chartType === 'breakdown' && 'Budget Breakdown'}
          {filters.chartType === 'byHod' && 'Budget Distribution by HOD'}
        </h3>
        <div style={{ height: '320px' }}>
          <Pie data={chartData} options={pieOptions} plugins={[ChartDataLabels]} />
        </div>
      </div>

      {/* Data Table */}
      <div style={{
        backgroundColor: '#fff',
        borderRadius: '8px',
        boxShadow: '0 2px 8px rgba(0,0,0,0.08)',
        overflow: 'hidden'
      }}>
        <div style={{
          padding: '15px 20px',
          backgroundColor: '#f8f9fa',
          borderBottom: '1px solid #e0e0e0'
        }}>
          <h3 style={{ fontSize: '15px', fontWeight: '600', margin: 0, color: '#333' }}>
            {filters.chartType === 'summary' && 'Budget Summary Details'}
            {filters.chartType === 'breakdown' && 'Budget Breakdown Details'}
            {filters.chartType === 'byHod' && 'Budget Details by HOD'}
          </h3>
        </div>
        <div style={{ overflowX: 'auto' }}>
          <table style={{ width: '100%', borderCollapse: 'collapse', fontSize: '13px' }}>
            <thead>
              <tr style={{ backgroundColor: '#f8f9fa', borderBottom: '2px solid #e0e0e0' }}>
                {filters.chartType === 'byHod' ? (
                  <>
                    <th style={{ padding: '12px 15px', textAlign: 'left', fontWeight: '600', color: '#555' }}>Department</th>
                    <th style={{ padding: '12px 15px', textAlign: 'right', fontWeight: '600', color: '#555' }}>Allocated</th>
                    <th style={{ padding: '12px 15px', textAlign: 'right', fontWeight: '600', color: '#555' }}>Utilized</th>
                    <th style={{ padding: '12px 15px', textAlign: 'center', fontWeight: '600', color: '#555' }}>Utilization %</th>
                  </>
                ) : (
                  <>
                    <th style={{ padding: '12px 15px', textAlign: 'left', fontWeight: '600', color: '#555' }}>{filters.chartType === 'summary' ? 'Budget Type' : 'Breakdown Type'}</th>
                    <th style={{ padding: '12px 15px', textAlign: 'right', fontWeight: '600', color: '#555' }}>Central</th>
                    <th style={{ padding: '12px 15px', textAlign: 'right', fontWeight: '600', color: '#555' }}>State</th>
                    <th style={{ padding: '12px 15px', textAlign: 'right', fontWeight: '600', color: '#555' }}>Total</th>
                  </>
                )}
              </tr>
            </thead>
            <tbody>
              {filters.chartType === 'byHod' ? (
                budgetByHOD.map((item, index) => {
                  const allocated = parseFloat(item.allocated) || 0;
                  const utilized = parseFloat(item.utilized) || 0;
                  const utilization = allocated > 0 ? ((utilized / allocated) * 100).toFixed(1) : 0;
                  return (
                    <tr key={index} style={{ borderBottom: '1px solid #f0f0f0' }}
                      onMouseOver={(e) => e.currentTarget.style.backgroundColor = '#f8f9fa'}
                      onMouseOut={(e) => e.currentTarget.style.backgroundColor = 'transparent'}
                    >
                      <td style={{ padding: '12px 15px', fontWeight: '600', color: '#333' }}>{item.department || item.hod_name}</td>
                      <td style={{ padding: '12px 15px', textAlign: 'right', fontWeight: '600', color: '#1565c0' }}>{formatCurrency(allocated)}</td>
                      <td style={{ padding: '12px 15px', textAlign: 'right', fontWeight: '600', color: '#2e7d32' }}>{formatCurrency(utilized)}</td>
                      <td style={{ padding: '12px 15px', textAlign: 'center' }}>
                        <span style={{
                          padding: '4px 10px',
                          backgroundColor: utilization >= 75 ? '#e8f5e9' : utilization >= 50 ? '#fff3e0' : '#ffebee',
                          color: utilization >= 75 ? '#2e7d32' : utilization >= 50 ? '#ef6c00' : '#c62828',
                          borderRadius: '12px',
                          fontSize: '12px',
                          fontWeight: '600'
                        }}>
                          {utilization}%
                        </span>
                      </td>
                    </tr>
                  );
                })
              ) : (
                tableData.map((item, index) => (
                  <tr key={index} style={{ borderBottom: '1px solid #f0f0f0' }}
                    onMouseOver={(e) => e.currentTarget.style.backgroundColor = '#f8f9fa'}
                    onMouseOut={(e) => e.currentTarget.style.backgroundColor = 'transparent'}
                  >
                    <td style={{ padding: '12px 15px', fontWeight: '600', color: '#333' }}>{item.type}</td>
                    <td style={{ padding: '12px 15px', textAlign: 'right', fontWeight: '600', color: '#1565c0' }}>{formatCurrency(item.central)}</td>
                    <td style={{ padding: '12px 15px', textAlign: 'right', fontWeight: '600', color: '#2e7d32' }}>{formatCurrency(item.state)}</td>
                    <td style={{ padding: '12px 15px', textAlign: 'right', fontWeight: '700', color: '#333' }}>{formatCurrency(item.total)}</td>
                  </tr>
                ))
              )}
            </tbody>
          </table>
        </div>
      </div>
    </div>
  );
};

// HOD Insights Content Component
const HodInsightsContent = ({ chartType, revenueByHOD, budgetByHOD, schemesByHOD, allHODs }) => {
  // Prepare data based on chart type
  let chartData, chartOptions, summaryCards;

  const formatCurrency = (amount) => {
    if (amount >= 10000000) {
      return `₹${(amount / 10000000).toFixed(2)} Cr`;
    } else if (amount >= 100000) {
      return `₹${(amount / 100000).toFixed(2)} L`;
    }
    return `₹${amount.toFixed(2)}`;
  };

  if (chartType === 'revenue') {
    const totalRevenue = revenueByHOD.reduce((sum, item) => sum + (parseFloat(item.revenue) || 0), 0);
    
    chartData = {
      labels: revenueByHOD.map(item => item.hod_name || 'Unknown'),
      datasets: [{
        data: revenueByHOD.map(item => parseFloat(item.revenue) || 0),
        backgroundColor: [
          '#1565c0', '#2e7d32', '#ef6c00', '#7b1fa2', '#c62828',
          '#00838f', '#FFD700', '#E91E63', '#795548', '#607D8B'
        ],
        borderWidth: 2,
        borderColor: '#fff'
      }]
    };

    summaryCards = [
      { label: 'Total Revenue', value: formatCurrency(totalRevenue), color: '#1565c0' },
      { label: 'HODs Count', value: revenueByHOD.length, color: '#2e7d32' },
      { label: 'Avg Revenue', value: formatCurrency(totalRevenue / (revenueByHOD.length || 1)), color: '#ef6c00' }
    ];
  } else if (chartType === 'budget') {
    const totalAllocated = budgetByHOD.reduce((sum, item) => sum + (parseFloat(item.allocated) || 0), 0);
    const totalUtilized = budgetByHOD.reduce((sum, item) => sum + (parseFloat(item.utilized) || 0), 0);

    chartData = {
      labels: budgetByHOD.map(item => item.department || item.hod_name || 'Unknown'),
      datasets: [
        {
          label: 'Allocated',
          data: budgetByHOD.map(item => (parseFloat(item.allocated) || 0) / 10000000),
          backgroundColor: '#1565c0',
          borderRadius: 4
        },
        {
          label: 'Utilized',
          data: budgetByHOD.map(item => (parseFloat(item.utilized) || 0) / 10000000),
          backgroundColor: '#2e7d32',
          borderRadius: 4
        }
      ]
    };

    summaryCards = [
      { label: 'Total Allocated', value: formatCurrency(totalAllocated), color: '#1565c0' },
      { label: 'Total Utilized', value: formatCurrency(totalUtilized), color: '#2e7d32' },
      { label: 'Utilization %', value: `${totalAllocated > 0 ? ((totalUtilized / totalAllocated) * 100).toFixed(1) : 0}%`, color: '#ef6c00' }
    ];
  } else if (chartType === 'schemes') {
    const totalSchemes = schemesByHOD.reduce((sum, item) => sum + (parseInt(item.scheme_count) || 0), 0);

    chartData = {
      labels: schemesByHOD.map(item => item.hod_name || 'Unknown'),
      datasets: [{
        data: schemesByHOD.map(item => parseInt(item.scheme_count) || 0),
        backgroundColor: [
          '#1565c0', '#2e7d32', '#ef6c00', '#7b1fa2', '#c62828',
          '#00838f', '#FFD700', '#E91E63', '#795548', '#607D8B'
        ],
        borderWidth: 2,
        borderColor: '#fff'
      }]
    };

    summaryCards = [
      { label: 'Total Schemes', value: totalSchemes, color: '#1565c0' },
      { label: 'HODs Count', value: schemesByHOD.length, color: '#2e7d32' },
      { label: 'Avg per HOD', value: (totalSchemes / (schemesByHOD.length || 1)).toFixed(1), color: '#ef6c00' }
    ];
  }

  const pieOptions = {
    responsive: true,
    maintainAspectRatio: false,
    plugins: {
      legend: {
        position: 'right',
        align: 'center',
        maxHeight: 250,
        labels: {
          padding: 15,
          usePointStyle: true,
          font: { size: 11 },
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
        callbacks: {
          label: function(context) {
            const total = context.dataset.data.reduce((a, b) => a + b, 0);
            const percentage = ((context.parsed / total) * 100).toFixed(1);
            if (chartType === 'revenue' || chartType === 'budget') {
              return `Revenue: ${formatCurrency(context.parsed)} (${percentage}%)`;
            }
            return `Schemes: ${context.parsed} (${percentage}%)`;
          }
        }
      },
      datalabels: {
        color: '#fff',
        font: { size: 12, weight: 'bold' },
        formatter: (value, context) => {
          const total = context.dataset.data.reduce((a, b) => a + b, 0);
          const percentage = ((value / total) * 100).toFixed(0);
          return percentage >= 3 ? `${percentage}%` : '';
        }
      }
    }
  };

  const barOptions = {
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
            return `${context.dataset.label}: ${formatCurrency(context.parsed.y * 10000000)}`;
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
        }
      }
    },
    scales: {
      x: {
        grid: { display: false },
        ticks: {
          font: { size: 10, weight: '600' },
          maxRotation: 45,
          minRotation: 0
        }
      },
      y: {
        beginAtZero: true,
        ticks: {
          callback: function(value) {
            return formatCurrency(value * 10000000);
          }
        }
      }
    }
  };

  return (
    <div>
      {/* Summary Cards */}
      <div style={{
        display: 'grid',
        gridTemplateColumns: 'repeat(3, 1fr)',
        gap: '8px',
        marginBottom: '12px'
      }}>
        {summaryCards.map((card, index) => (
          <div key={index} style={{
            backgroundColor: '#fff',
            padding: '8px 10px',
            borderRadius: '4px',
            boxShadow: '0 1px 2px rgba(0,0,0,0.04)',
            display: 'flex',
            justifyContent: 'space-between',
            alignItems: 'center'
          }}>
            <div style={{ fontSize: '13px', color: '#666', fontWeight: '700' }}>
              {card.label}
            </div>
            <div style={{ fontSize: '24px', fontWeight: '800', color: card.color }}>
              {card.value}
            </div>
          </div>
        ))}
      </div>

      {/* Chart */}
      <div style={{
        backgroundColor: '#fff',
        padding: '12px',
        borderRadius: '4px',
        boxShadow: '0 1px 2px rgba(0,0,0,0.04)',
        marginBottom: '12px'
      }}>
        <h3 style={{ fontSize: '15px', fontWeight: '700', marginBottom: '12px', color: '#333' }}>
          {chartType === 'revenue' && 'HOD Revenue Distribution'}
          {chartType === 'budget' && 'Budget Allocation by HOD'}
          {chartType === 'schemes' && 'Schemes Distribution by HOD'}
        </h3>
        <div style={{ height: '320px' }}>
          {chartType === 'budget' ? (
            <Bar data={chartData} options={barOptions} plugins={[ChartDataLabels]} />
          ) : (
            <Pie data={chartData} options={pieOptions} plugins={[ChartDataLabels]} />
          )}
        </div>
      </div>

      {/* Data Table */}
      <div style={{
        backgroundColor: '#fff',
        borderRadius: '8px',
        boxShadow: '0 2px 8px rgba(0,0,0,0.08)',
        overflow: 'hidden'
      }}>
        <div style={{
          padding: '15px 20px',
          backgroundColor: '#f8f9fa',
          borderBottom: '1px solid #e0e0e0'
        }}>
          <h3 style={{ fontSize: '15px', fontWeight: '600', margin: 0, color: '#333' }}>
            {chartType === 'revenue' && 'HOD Revenue Details'}
            {chartType === 'budget' && 'Budget Details by HOD'}
            {chartType === 'schemes' && 'Schemes Details by HOD'}
          </h3>
        </div>
        <div style={{ overflowX: 'auto' }}>
          <table style={{ width: '100%', borderCollapse: 'collapse', fontSize: '13px' }}>
            <thead>
              <tr style={{ backgroundColor: '#f8f9fa', borderBottom: '2px solid #e0e0e0' }}>
                {chartType === 'revenue' && (
                  <>
                    <th style={{ padding: '12px 15px', textAlign: 'left', fontWeight: '600', color: '#555' }}>HOD Name</th>
                    <th style={{ padding: '12px 15px', textAlign: 'right', fontWeight: '600', color: '#555' }}>Revenue</th>
                    <th style={{ padding: '12px 15px', textAlign: 'center', fontWeight: '600', color: '#555' }}>Percentage</th>
                  </>
                )}
                {chartType === 'budget' && (
                  <>
                    <th style={{ padding: '12px 15px', textAlign: 'left', fontWeight: '600', color: '#555' }}>Department</th>
                    <th style={{ padding: '12px 15px', textAlign: 'right', fontWeight: '600', color: '#555' }}>Allocated</th>
                    <th style={{ padding: '12px 15px', textAlign: 'right', fontWeight: '600', color: '#555' }}>Utilized</th>
                    <th style={{ padding: '12px 15px', textAlign: 'center', fontWeight: '600', color: '#555' }}>Utilization %</th>
                  </>
                )}
                {chartType === 'schemes' && (
                  <>
                    <th style={{ padding: '12px 15px', textAlign: 'left', fontWeight: '600', color: '#555' }}>HOD Name</th>
                    <th style={{ padding: '12px 15px', textAlign: 'center', fontWeight: '600', color: '#555' }}>Schemes Count</th>
                    <th style={{ padding: '12px 15px', textAlign: 'center', fontWeight: '600', color: '#555' }}>Percentage</th>
                  </>
                )}
              </tr>
            </thead>
            <tbody>
              {chartType === 'revenue' && revenueByHOD.map((item, index) => {
                const total = revenueByHOD.reduce((sum, r) => sum + (parseFloat(r.revenue) || 0), 0);
                const percentage = total > 0 ? ((parseFloat(item.revenue) || 0) / total * 100).toFixed(1) : 0;
                return (
                  <tr key={index} style={{ borderBottom: '1px solid #f0f0f0' }}
                    onMouseOver={(e) => e.currentTarget.style.backgroundColor = '#f8f9fa'}
                    onMouseOut={(e) => e.currentTarget.style.backgroundColor = 'transparent'}
                  >
                    <td style={{ padding: '12px 15px', fontWeight: '600', color: '#333' }}>{item.hod_name}</td>
                    <td style={{ padding: '12px 15px', textAlign: 'right', fontWeight: '600', color: '#1565c0' }}>{formatCurrency(parseFloat(item.revenue) || 0)}</td>
                    <td style={{ padding: '12px 15px', textAlign: 'center' }}>
                      <span style={{
                        padding: '4px 10px',
                        backgroundColor: '#e8f5e9',
                        color: '#2e7d32',
                        borderRadius: '12px',
                        fontSize: '12px',
                        fontWeight: '600'
                      }}>
                        {percentage}%
                      </span>
                    </td>
                  </tr>
                );
              })}
              {chartType === 'budget' && budgetByHOD.map((item, index) => {
                const allocated = parseFloat(item.allocated) || 0;
                const utilized = parseFloat(item.utilized) || 0;
                const utilization = allocated > 0 ? ((utilized / allocated) * 100).toFixed(1) : 0;
                return (
                  <tr key={index} style={{ borderBottom: '1px solid #f0f0f0' }}
                    onMouseOver={(e) => e.currentTarget.style.backgroundColor = '#f8f9fa'}
                    onMouseOut={(e) => e.currentTarget.style.backgroundColor = 'transparent'}
                  >
                    <td style={{ padding: '12px 15px', fontWeight: '600', color: '#333' }}>{item.department || item.hod_name}</td>
                    <td style={{ padding: '12px 15px', textAlign: 'right', fontWeight: '600', color: '#1565c0' }}>{formatCurrency(allocated)}</td>
                    <td style={{ padding: '12px 15px', textAlign: 'right', fontWeight: '600', color: '#2e7d32' }}>{formatCurrency(utilized)}</td>
                    <td style={{ padding: '12px 15px', textAlign: 'center' }}>
                      <span style={{
                        padding: '4px 10px',
                        backgroundColor: utilization >= 75 ? '#e8f5e9' : utilization >= 50 ? '#fff3e0' : '#ffebee',
                        color: utilization >= 75 ? '#2e7d32' : utilization >= 50 ? '#ef6c00' : '#c62828',
                        borderRadius: '12px',
                        fontSize: '12px',
                        fontWeight: '600'
                      }}>
                        {utilization}%
                      </span>
                    </td>
                  </tr>
                );
              })}
              {chartType === 'schemes' && schemesByHOD.map((item, index) => {
                const total = schemesByHOD.reduce((sum, s) => sum + (parseInt(s.scheme_count) || 0), 0);
                const percentage = total > 0 ? ((parseInt(item.scheme_count) || 0) / total * 100).toFixed(1) : 0;
                return (
                  <tr key={index} style={{ borderBottom: '1px solid #f0f0f0' }}
                    onMouseOver={(e) => e.currentTarget.style.backgroundColor = '#f8f9fa'}
                    onMouseOut={(e) => e.currentTarget.style.backgroundColor = 'transparent'}
                  >
                    <td style={{ padding: '12px 15px', fontWeight: '600', color: '#333' }}>{item.hod_name}</td>
                    <td style={{ padding: '12px 15px', textAlign: 'center', fontWeight: '600', color: '#1565c0' }}>{item.scheme_count || 0}</td>
                    <td style={{ padding: '12px 15px', textAlign: 'center' }}>
                      <span style={{
                        padding: '4px 10px',
                        backgroundColor: '#e8f5e9',
                        color: '#2e7d32',
                        borderRadius: '12px',
                        fontSize: '12px',
                        fontWeight: '600'
                      }}>
                        {percentage}%
                      </span>
                    </td>
                  </tr>
                );
              })}
            </tbody>
          </table>
        </div>
      </div>
    </div>
  );
};

// Scheme Insights Content Component
const SchemeInsightsContent = ({ filters, allSchemes, allHODs }) => {
  // Filter schemes based on filters
  const filteredSchemes = allSchemes.filter(scheme => {
    const matchDept = !filters.department || 
      (scheme.category || scheme.department || '').toLowerCase().includes(filters.department.toLowerCase());
    const matchYear = !filters.year || (scheme.year || scheme.financial_year) === filters.year;
    const matchStatus = !filters.schemeStatus || 
      (scheme.status || '').toLowerCase() === filters.schemeStatus.toLowerCase();
    const matchHOD = !filters.hodId || 
      scheme.hod_id === parseInt(filters.hodId) || 
      (scheme.hod_name || '').toLowerCase() === allHODs.find(h => h.id === parseInt(filters.hodId))?.name?.toLowerCase();
    
    return matchDept && matchYear && matchStatus && matchHOD;
  });

  // Calculate summary statistics
  const totalBudget = filteredSchemes.reduce((sum, s) => sum + (parseFloat(s.budget) || 0), 0);
  const totalUtilized = filteredSchemes.reduce((sum, s) => sum + (parseFloat(s.utilized) || parseFloat(s.amount_spent) || 0), 0);
  const totalPending = totalBudget - totalUtilized;
  const totalBeneficiaries = filteredSchemes.reduce((sum, s) => sum + (parseInt(s.beneficiaries) || 0), 0);

  // Group schemes by status for pie chart
  const schemesByStatus = {};
  filteredSchemes.forEach(scheme => {
    const status = (scheme.status || 'active').toLowerCase();
    if (!schemesByStatus[status]) {
      schemesByStatus[status] = [];
    }
    schemesByStatus[status].push(scheme);
  });

  // Format currency helper function
  const formatCurrency = (amount) => {
    if (amount >= 10000000) {
      return `₹${(amount / 10000000).toFixed(2)} Cr`;
    } else if (amount >= 100000) {
      return `₹${(amount / 100000).toFixed(2)} L`;
    }
    return `₹${amount.toFixed(2)}`;
  };

  // Prepare chart data based on chartView
  let schemesToDisplay = filteredSchemes;
  
  // Filter by state or central schemes
  if (filters.chartView === 'stateSchemes') {
    schemesToDisplay = filteredSchemes.filter(s => 
      (s.scheme_type || s.type || '').toLowerCase().includes('state') ||
      (s.category || s.department || '').toLowerCase().includes('state')
    );
  } else if (filters.chartView === 'centralSchemes') {
    schemesToDisplay = filteredSchemes.filter(s => 
      (s.scheme_type || s.type || '').toLowerCase().includes('central') ||
      (s.category || s.department || '').toLowerCase().includes('central')
    );
  }
  
  const barChartData = filters.chartView === 'allSchemes' || filters.chartView === 'stateSchemes' || filters.chartView === 'centralSchemes'
    ? {
        labels: schemesToDisplay.map(s => s.name || s.scheme_name || 'Unnamed'),
        datasets: [{
          label: 'Budget Amount',
          data: schemesToDisplay.map(s => parseFloat(s.budget) || 0),
          backgroundColor: schemesToDisplay.map((_, index) => {
            const colors = ['#4CAF50', '#2196F3', '#FFC107', '#FF9800', '#9C27B0', '#00BCD4', '#E91E63'];
            return colors[index % colors.length];
          }),
          borderWidth: 1,
          borderColor: '#fff'
        }]
      }
    : {
        labels: Object.keys(schemesByStatus).map(s => s.charAt(0).toUpperCase() + s.slice(1)),
        datasets: [{
          label: 'Number of Schemes',
          data: Object.values(schemesByStatus).map(schemes => schemes.length),
          backgroundColor: [
            '#4CAF50', // Active - Green
            '#2196F3', // Inactive - Blue
            '#FFC107', // Planned - Yellow
            '#FF9800', // Completed - Orange
            '#9C27B0'  // Other - Purple
          ],
          borderWidth: 1,
          borderColor: '#fff'
        }]
      };

  const barOptions = {
    responsive: true,
    maintainAspectRatio: false,
    indexAxis: (filters.chartView === 'allSchemes' || filters.chartView === 'stateSchemes' || filters.chartView === 'centralSchemes') && schemesToDisplay.length > 5 ? 'y' : 'x',
    plugins: {
      legend: {
        display: false
      },
      tooltip: {
        callbacks: {
          label: function(context) {
            if (filters.chartView === 'allSchemes' || filters.chartView === 'stateSchemes' || filters.chartView === 'centralSchemes') {
              const amount = context.parsed.x || context.parsed.y;
              return `Budget: ${formatCurrency(amount)}`;
            } else {
              const total = context.dataset.data.reduce((a, b) => a + b, 0);
              const percentage = ((context.parsed.y / total) * 100).toFixed(1);
              return `Count: ${context.parsed.y} (${percentage}%)`;
            }
          }
        }
      },
      datalabels: {
        color: '#333',
        font: { size: 10, weight: 'bold' },
        anchor: 'end',
        align: (filters.chartView === 'allSchemes' || filters.chartView === 'stateSchemes' || filters.chartView === 'centralSchemes') && schemesToDisplay.length > 5 ? 'end' : 'top',
        formatter: (value) => {
          if (filters.chartView === 'allSchemes' || filters.chartView === 'stateSchemes' || filters.chartView === 'centralSchemes') {
            if (value >= 10000000) return `${(value / 10000000).toFixed(1)}Cr`;
            if (value >= 100000) return `${(value / 100000).toFixed(1)}L`;
            return value;
          }
          return value;
        }
      }
    },
    scales: {
      y: {
        beginAtZero: true,
        ticks: {
          stepSize: (filters.chartView === 'allSchemes' || filters.chartView === 'stateSchemes' || filters.chartView === 'centralSchemes') ? undefined : 1,
          font: { size: (filters.chartView === 'allSchemes' || filters.chartView === 'stateSchemes' || filters.chartView === 'centralSchemes') && schemesToDisplay.length > 5 ? 9 : 11 },
          callback: function(value) {
            if ((filters.chartView === 'allSchemes' || filters.chartView === 'stateSchemes' || filters.chartView === 'centralSchemes') && schemesToDisplay.length > 5) {
              return this.getLabelForValue(value);
            }
            return value;
          }
        },
        grid: {
          color: '#f0f0f0'
        }
      },
      x: {
        ticks: {
          font: { size: 11 },
          maxRotation: (filters.chartView === 'allSchemes' || filters.chartView === 'stateSchemes' || filters.chartView === 'centralSchemes') ? 45 : 0,
          minRotation: (filters.chartView === 'allSchemes' || filters.chartView === 'stateSchemes' || filters.chartView === 'centralSchemes') ? 45 : 0
        },
        grid: {
          display: false
        }
      }
    }
  };

  return (
    <div>
      {/* Summary Cards */}
      <div style={{
        display: 'grid',
        gridTemplateColumns: 'repeat(4, 1fr)',
        gap: '8px',
        marginBottom: '12px'
      }}>
        <div style={{
          backgroundColor: '#fff',
          padding: '8px 10px',
          borderRadius: '4px',
          boxShadow: '0 1px 2px rgba(0,0,0,0.04)',
          display: 'flex',
          justifyContent: 'space-between',
          alignItems: 'center'
        }}>
          <div style={{ display: 'flex', alignItems: 'center', gap: '6px' }}>
            <div style={{ fontSize: '16px', color: '#1565c0' }}><FiPieChart size={16} /></div>
            <div>
              <div style={{ fontSize: '13px', color: '#666', fontWeight: '700' }}>Budget</div>
              <div style={{ fontSize: '11px', color: '#999', fontWeight: '600' }}>Schemes: {filteredSchemes.length}</div>
            </div>
          </div>
          <div style={{ fontSize: '24px', fontWeight: '800', color: '#1565c0' }}>
            {formatCurrency(totalBudget)}
          </div>
        </div>

        <div style={{
          backgroundColor: '#fff',
          padding: '8px 10px',
          borderRadius: '4px',
          boxShadow: '0 1px 2px rgba(0,0,0,0.04)',
          display: 'flex',
          justifyContent: 'space-between',
          alignItems: 'center'
        }}>
          <div style={{ display: 'flex', alignItems: 'center', gap: '6px' }}>
            <div style={{ fontSize: '16px', color: '#2e7d32' }}><FiCheckCircle size={16} /></div>
            <div>
              <div style={{ fontSize: '13px', color: '#666', fontWeight: '700' }}>Utilized</div>
              <div style={{ fontSize: '11px', color: '#999', fontWeight: '600' }}>
                {totalBudget > 0 ? `${((totalUtilized / totalBudget) * 100).toFixed(1)}%` : '0%'} Amount Spent
              </div>
            </div>
          </div>
          <div style={{ fontSize: '24px', fontWeight: '800', color: '#2e7d32' }}>
            {formatCurrency(totalUtilized)}
          </div>
        </div>

        <div style={{
          backgroundColor: '#fff',
          padding: '8px 10px',
          borderRadius: '4px',
          boxShadow: '0 1px 2px rgba(0,0,0,0.04)',
          display: 'flex',
          justifyContent: 'space-between',
          alignItems: 'center'
        }}>
          <div style={{ display: 'flex', alignItems: 'center', gap: '6px' }}>
            <div style={{ fontSize: '16px', color: '#ef6c00' }}><BiWallet size={16} /></div>
            <div>
              <div style={{ fontSize: '13px', color: '#666', fontWeight: '700' }}>Pending</div>
              <div style={{ fontSize: '11px', color: '#999', fontWeight: '600' }}>Scheme Sanction</div>
            </div>
          </div>
          <div style={{ fontSize: '24px', fontWeight: '800', color: '#ef6c00' }}>
            {formatCurrency(totalPending)}
          </div>
        </div>

        <div style={{
          backgroundColor: '#fff',
          padding: '8px 10px',
          borderRadius: '4px',
          boxShadow: '0 1px 2px rgba(0,0,0,0.04)',
          display: 'flex',
          justifyContent: 'space-between',
          alignItems: 'center'
        }}>
          <div style={{ display: 'flex', alignItems: 'center', gap: '6px' }}>
            <div style={{ fontSize: '16px', color: '#7b1fa2' }}><FiUsers size={16} /></div>
            <div>
              <div style={{ fontSize: '13px', color: '#666', fontWeight: '700' }}>Beneficiaries</div>
              <div style={{ fontSize: '11px', color: '#999', fontWeight: '600' }}>Default: 5,043</div>
            </div>
          </div>
          <div style={{ fontSize: '24px', fontWeight: '800', color: '#7b1fa2' }}>
            {totalBeneficiaries.toLocaleString()}
          </div>
        </div>
      </div>

      {/* Charts and Table Grid */}
      <div style={{
        display: 'grid',
        gridTemplateColumns: '1fr 280px',
        gap: '12px',
        marginBottom: '12px'
      }}>
        {/* Bar Chart */}
        <div style={{
          backgroundColor: '#fff',
          padding: '12px',
          borderRadius: '4px',
          boxShadow: '0 1px 2px rgba(0,0,0,0.04)'
        }}>
          <h3 style={{ fontSize: '15px', fontWeight: '700', marginBottom: '12px', color: '#333' }}>
            {filters.chartView === 'allSchemes' ? 'All Schemes Budget' : 
             filters.chartView === 'stateSchemes' ? 'State Schemes Budget' :
             filters.chartView === 'centralSchemes' ? 'Central Schemes Budget' :
             'Schemes Overview'}
          </h3>
          <div style={{ height: (filters.chartView === 'allSchemes' || filters.chartView === 'stateSchemes' || filters.chartView === 'centralSchemes') && schemesToDisplay.length > 5 ? '400px' : '320px' }}>
            <Bar data={barChartData} options={barOptions} plugins={[ChartDataLabels]} />
          </div>
        </div>

        {/* Top Performers */}
        <div style={{
          backgroundColor: '#fff',
          padding: '12px',
          borderRadius: '4px',
          boxShadow: '0 1px 2px rgba(0,0,0,0.04)'
        }}>
          <h3 style={{ fontSize: '15px', fontWeight: '700', marginBottom: '12px', color: '#333' }}>
            Top Performers
          </h3>
          <div style={{ fontSize: '13px' }}>
            {filteredSchemes
              .sort((a, b) => (parseFloat(b.budget) || 0) - (parseFloat(a.budget) || 0))
              .slice(0, 5)
              .map((scheme, index) => (
                <div key={index} style={{
                  padding: '6px 8px',
                  marginBottom: '6px',
                  backgroundColor: '#f8f9fa',
                  borderRadius: '4px',
                  display: 'flex',
                  justifyContent: 'space-between',
                  alignItems: 'center'
                }}>
                  <div>
                    <div style={{ fontWeight: '700', color: '#333', marginBottom: '2px', fontSize: '12px' }}>
                      {scheme.name || scheme.scheme_name || 'Unnamed Scheme'}
                    </div>
                    <div style={{ fontSize: '10px', color: '#666', fontWeight: '500' }}>
                      {scheme.category || scheme.department || 'General'}
                    </div>
                  </div>
                  <div style={{ textAlign: 'right' }}>
                    <div style={{ fontWeight: '800', color: '#1565c0', fontSize: '12px' }}>
                      {formatCurrency(parseFloat(scheme.budget) || 0)}
                    </div>
                    <div style={{ fontSize: '10px', color: '#2e7d32', fontWeight: '600' }}>
                      {scheme.utilization || '0'}% utilized
                    </div>
                  </div>
                </div>
              ))}
          </div>
        </div>
      </div>

      {/* Schemes Table */}
      <div style={{
        backgroundColor: '#fff',
        borderRadius: '8px',
        boxShadow: '0 2px 8px rgba(0,0,0,0.08)',
        overflow: 'hidden'
      }}>
        <div style={{
          padding: '15px 20px',
          backgroundColor: '#f8f9fa',
          borderBottom: '1px solid #e0e0e0'
        }}>
          <h3 style={{ fontSize: '15px', fontWeight: '600', margin: 0, color: '#333' }}>
            Schemes Overview
          </h3>
        </div>
        <div style={{ overflowX: 'auto' }}>
          <table style={{ width: '100%', borderCollapse: 'collapse', fontSize: '13px' }}>
            <thead>
              <tr style={{ backgroundColor: '#f8f9fa', borderBottom: '2px solid #e0e0e0' }}>
                <th style={{ padding: '12px 15px', textAlign: 'left', fontWeight: '600', color: '#555' }}>Scheme</th>
                <th style={{ padding: '12px 15px', textAlign: 'center', fontWeight: '600', color: '#555' }}>Active</th>
                <th style={{ padding: '12px 15px', textAlign: 'right', fontWeight: '600', color: '#555' }}>Budget</th>
                <th style={{ padding: '12px 15px', textAlign: 'right', fontWeight: '600', color: '#555' }}>Utilized</th>
                <th style={{ padding: '12px 15px', textAlign: 'center', fontWeight: '600', color: '#555' }}>Utilization</th>
                <th style={{ padding: '12px 15px', textAlign: 'center', fontWeight: '600', color: '#555' }}>Status</th>
              </tr>
            </thead>
            <tbody>
              {filteredSchemes.length === 0 ? (
                <tr>
                  <td colSpan="6" style={{ padding: '40px', textAlign: 'center', color: '#999' }}>
                    No schemes found matching the selected filters
                  </td>
                </tr>
              ) : (
                filteredSchemes.map((scheme, index) => {
                  const budget = parseFloat(scheme.budget) || 0;
                  const utilized = parseFloat(scheme.utilized) || parseFloat(scheme.amount_spent) || 0;
                  const utilization = budget > 0 ? ((utilized / budget) * 100).toFixed(0) : 0;
                  const status = (scheme.status || 'active').toLowerCase();
                  
                  return (
                    <tr key={index} style={{
                      borderBottom: '1px solid #f0f0f0',
                      transition: 'background-color 0.2s'
                    }}
                    onMouseOver={(e) => e.currentTarget.style.backgroundColor = '#f8f9fa'}
                    onMouseOut={(e) => e.currentTarget.style.backgroundColor = 'transparent'}
                    >
                      <td style={{ padding: '12px 15px' }}>
                        <div style={{ fontWeight: '600', color: '#333', marginBottom: '2px' }}>
                          {scheme.name || scheme.scheme_name || 'Unnamed'}
                        </div>
                        <div style={{ fontSize: '11px', color: '#666' }}>
                          {scheme.category || scheme.department || 'General'}
                        </div>
                      </td>
                      <td style={{ padding: '12px 15px', textAlign: 'center' }}>
                        {scheme.scheme_id || scheme.id || '-'}
                      </td>
                      <td style={{ padding: '12px 15px', textAlign: 'right', fontWeight: '600', color: '#1565c0' }}>
                        {formatCurrency(budget)}
                      </td>
                      <td style={{ padding: '12px 15px', textAlign: 'right', fontWeight: '600', color: '#2e7d32' }}>
                        {formatCurrency(utilized)}
                      </td>
                      <td style={{ padding: '12px 15px', textAlign: 'center' }}>
                        <div style={{
                          display: 'inline-flex',
                          alignItems: 'center',
                          gap: '8px',
                          padding: '4px 10px',
                          backgroundColor: utilization >= 75 ? '#e8f5e9' : utilization >= 50 ? '#fff3e0' : '#ffebee',
                          color: utilization >= 75 ? '#2e7d32' : utilization >= 50 ? '#ef6c00' : '#c62828',
                          borderRadius: '12px',
                          fontSize: '12px',
                          fontWeight: '600'
                        }}>
                          {utilization}%
                        </div>
                      </td>
                      <td style={{ padding: '12px 15px', textAlign: 'center' }}>
                        <span style={{
                          padding: '4px 10px',
                          borderRadius: '12px',
                          fontSize: '11px',
                          fontWeight: '600',
                          backgroundColor: 
                            status === 'active' ? '#e8f5e9' :
                            status === 'completed' ? '#e3f2fd' :
                            status === 'planned' ? '#fff3e0' : '#f5f5f5',
                          color:
                            status === 'active' ? '#2e7d32' :
                            status === 'completed' ? '#1565c0' :
                            status === 'planned' ? '#ef6c00' : '#666'
                        }}>
                          {status === 'active' ? '✓ On Track' :
                           status === 'completed' ? '✓ Completed' :
                           status === 'planned' ? 'Planned' : status}
                        </span>
                      </td>
                    </tr>
                  );
                })
              )}
            </tbody>
          </table>
        </div>
      </div>
    </div>
  );
};

// Attendance Insights Content Component
const AttendanceInsightsContent = ({ filters, allAttendance, allHODs, stats }) => {
  // Filter attendance based on filters
  const filteredAttendance = allAttendance.filter(record => {
    const matchHOD = !filters.hodId || record.hod_id === parseInt(filters.hodId) || 
      (record.hod_name || '').toLowerCase() === allHODs.find(h => h.id === parseInt(filters.hodId))?.name?.toLowerCase();
    
    return matchHOD;
  });

  // Calculate attendance statistics
  const totalPresent = filteredAttendance.reduce((sum, r) => sum + (parseInt(r.present) || 0), 0);
  const totalAbsent = filteredAttendance.reduce((sum, r) => sum + (parseInt(r.absent) || 0), 0);
  const totalLate = filteredAttendance.reduce((sum, r) => sum + (parseInt(r.late) || 0), 0);
  const totalLeave = filteredAttendance.reduce((sum, r) => sum + (parseInt(r.on_leave) || 0), 0);
  const totalStaff = totalPresent + totalAbsent + totalLate + totalLeave;

  // Prepare pie chart data for attendance status
  const attendancePieChartData = {
    labels: ['Present', 'Absent', 'Late', 'Leave'],
    datasets: [{
      data: [totalPresent, totalAbsent, totalLate, totalLeave],
      backgroundColor: [
        '#4CAF50', // Present - Green
        '#F44336', // Absent - Red
        '#FF9800', // Late - Orange
        '#2196F3'  // Leave - Blue
      ],
      borderWidth: 2,
      borderColor: '#fff'
    }]
  };

  const pieOptions = {
    responsive: true,
    maintainAspectRatio: false,
    plugins: {
      legend: {
        position: 'bottom',
        labels: {
          padding: 15,
          usePointStyle: true,
          font: { size: 12 }
        }
      },
      tooltip: {
        callbacks: {
          label: function(context) {
            const total = context.dataset.data.reduce((a, b) => a + b, 0);
            const percentage = ((context.parsed / total) * 100).toFixed(1);
            return `${context.label}: ${context.parsed} (${percentage}%)`;
          }
        }
      },
      datalabels: {
        color: '#fff',
        font: { size: 14, weight: 'bold' },
        formatter: (value, context) => {
          const total = context.dataset.data.reduce((a, b) => a + b, 0);
          const percentage = ((value / total) * 100).toFixed(0);
          return percentage > 5 ? `${percentage}%` : '';
        }
      }
    }
  };

  return (
    <div>
      {/* Summary Cards */}
      <div style={{
        display: 'grid',
        gridTemplateColumns: 'repeat(auto-fit, minmax(160px, 1fr))',
        gap: '8px',
        marginBottom: '12px'
      }}>
        <div style={{
          backgroundColor: '#fff',
          padding: '8px 10px',
          borderRadius: '4px',
          boxShadow: '0 1px 2px rgba(0,0,0,0.04)',
          display: 'flex',
          alignItems: 'center',
          justifyContent: 'space-between'
        }}>
          <div style={{ display: 'flex', alignItems: 'center', gap: '6px' }}>
            <div style={{ 
              width: '32px', 
              height: '32px', 
              borderRadius: '50%', 
              border: '1px solid #4CAF50',
              display: 'flex',
              alignItems: 'center',
              justifyContent: 'center',
              color: '#4CAF50'
            }}>
              <FiCheckCircle size={16} />
            </div>
            <span style={{ fontSize: '13px', color: '#333', fontWeight: '700' }}>Present</span>
          </div>
          <div style={{ textAlign: 'right' }}>
            <div style={{ fontSize: '24px', fontWeight: '800', color: '#4CAF50', lineHeight: '1' }}>
              {totalPresent}
            </div>
            <div style={{ fontSize: '11px', color: '#999', marginTop: '2px', fontWeight: '600' }}>Staff</div>
          </div>
        </div>

        <div style={{
          backgroundColor: '#fff',
          padding: '8px 10px',
          borderRadius: '4px',
          boxShadow: '0 1px 2px rgba(0,0,0,0.04)',
          display: 'flex',
          alignItems: 'center',
          justifyContent: 'space-between'
        }}>
          <div style={{ display: 'flex', alignItems: 'center', gap: '6px' }}>
            <div style={{ 
              width: '32px', 
              height: '32px', 
              borderRadius: '50%', 
              border: '1px solid #F44336',
              display: 'flex',
              alignItems: 'center',
              justifyContent: 'center',
              color: '#F44336'
            }}>
              <FiUsers size={16} />
            </div>
            <span style={{ fontSize: '13px', color: '#333', fontWeight: '700' }}>Absent</span>
          </div>
          <div style={{ textAlign: 'right' }}>
            <div style={{ fontSize: '24px', fontWeight: '800', color: '#F44336', lineHeight: '1' }}>
              {totalAbsent}
            </div>
            <div style={{ fontSize: '11px', color: '#999', marginTop: '2px', fontWeight: '600' }}>Staff</div>
          </div>
        </div>

        <div style={{
          backgroundColor: '#fff',
          padding: '8px 10px',
          borderRadius: '4px',
          boxShadow: '0 1px 2px rgba(0,0,0,0.04)',
          display: 'flex',
          alignItems: 'center',
          justifyContent: 'space-between'
        }}>
          <div style={{ display: 'flex', alignItems: 'center', gap: '6px' }}>
            <div style={{ 
              width: '32px', 
              height: '32px', 
              borderRadius: '50%', 
              border: '1px solid #FF9800',
              display: 'flex',
              alignItems: 'center',
              justifyContent: 'center',
              color: '#FF9800'
            }}>
              <FiActivity size={16} />
            </div>
            <span style={{ fontSize: '13px', color: '#333', fontWeight: '700' }}>Late</span>
          </div>
          <div style={{ textAlign: 'right' }}>
            <div style={{ fontSize: '24px', fontWeight: '800', color: '#FF9800', lineHeight: '1' }}>
              {totalLate}
            </div>
            <div style={{ fontSize: '11px', color: '#999', marginTop: '2px', fontWeight: '600' }}>Staff</div>
          </div>
        </div>

        <div style={{
          backgroundColor: '#fff',
          padding: '8px 10px',
          borderRadius: '4px',
          boxShadow: '0 1px 2px rgba(0,0,0,0.04)',
          display: 'flex',
          alignItems: 'center',
          justifyContent: 'space-between'
        }}>
          <div style={{ display: 'flex', alignItems: 'center', gap: '6px' }}>
            <div style={{ 
              width: '32px', 
              height: '32px', 
              borderRadius: '50%', 
              border: '1px solid #2196F3',
              display: 'flex',
              alignItems: 'center',
              justifyContent: 'center',
              color: '#2196F3'
            }}>
              <BiWallet size={16} />
            </div>
            <span style={{ fontSize: '13px', color: '#333', fontWeight: '700' }}>Leave</span>
          </div>
          <div style={{ textAlign: 'right' }}>
            <div style={{ fontSize: '24px', fontWeight: '800', color: '#2196F3', lineHeight: '1' }}>
              {totalLeave}
            </div>
            <div style={{ fontSize: '11px', color: '#999', marginTop: '2px', fontWeight: '600' }}>Staff</div>
          </div>
        </div>
      </div>

      {/* Charts and Table Grid */}
      <div style={{
        display: 'grid',
        gridTemplateColumns: '1fr 300px',
        gap: '12px',
        marginBottom: '12px'
      }}>
        {/* Pie Chart */}
        <div style={{
          backgroundColor: '#fff',
          padding: '12px',
          borderRadius: '4px',
          boxShadow: '0 1px 2px rgba(0,0,0,0.04)'
        }}>
          <h3 style={{ fontSize: '15px', fontWeight: '700', marginBottom: '12px', color: '#333' }}>
            Attendance Overview
          </h3>
          <div style={{ height: '320px' }}>
            <Pie data={attendancePieChartData} options={pieOptions} plugins={[ChartDataLabels]} />
          </div>
        </div>

        {/* Top Performers */}
        <div style={{
          backgroundColor: '#fff',
          padding: '12px',
          borderRadius: '4px',
          boxShadow: '0 1px 2px rgba(0,0,0,0.04)'
        }}>
          <h3 style={{ fontSize: '15px', fontWeight: '700', marginBottom: '12px', color: '#333' }}>
            Attendance Rate
          </h3>
          <div style={{ fontSize: '13px' }}>
            <div style={{
              padding: '6px 8px',
              marginBottom: '6px',
              backgroundColor: '#e8f5e9',
              borderRadius: '4px',
              display: 'flex',
              justifyContent: 'space-between',
              alignItems: 'center'
            }}>
              <div>
                <div style={{ fontWeight: '700', color: '#333', marginBottom: '2px', fontSize: '12px' }}>
                  Present
                </div>
                <div style={{ fontSize: '10px', color: '#666', fontWeight: '500' }}>
                  Staff present
                </div>
              </div>
              <div style={{ textAlign: 'right' }}>
                <div style={{ fontWeight: '800', color: '#4CAF50', fontSize: '17px' }}>
                  {totalStaff > 0 ? ((totalPresent / totalStaff) * 100).toFixed(1) : 0}%
                </div>
              </div>
            </div>

            <div style={{
              padding: '6px 8px',
              marginBottom: '6px',
              backgroundColor: '#ffebee',
              borderRadius: '4px',
              display: 'flex',
              justifyContent: 'space-between',
              alignItems: 'center'
            }}>
              <div>
                <div style={{ fontWeight: '700', color: '#333', marginBottom: '2px', fontSize: '12px' }}>
                  Absent
                </div>
                <div style={{ fontSize: '10px', color: '#666', fontWeight: '500' }}>
                  Staff absent
                </div>
              </div>
              <div style={{ textAlign: 'right' }}>
                <div style={{ fontWeight: '800', color: '#F44336', fontSize: '17px' }}>
                  {totalStaff > 0 ? ((totalAbsent / totalStaff) * 100).toFixed(1) : 0}%
                </div>
              </div>
            </div>

            <div style={{
              padding: '6px 8px',
              marginBottom: '6px',
              backgroundColor: '#fff3e0',
              borderRadius: '4px',
              display: 'flex',
              justifyContent: 'space-between',
              alignItems: 'center'
            }}>
              <div>
                <div style={{ fontWeight: '700', color: '#333', marginBottom: '2px', fontSize: '12px' }}>
                  Late
                </div>
                <div style={{ fontSize: '10px', color: '#666', fontWeight: '500' }}>
                  Coming late
                </div>
              </div>
              <div style={{ textAlign: 'right' }}>
                <div style={{ fontWeight: '800', color: '#FF9800', fontSize: '17px' }}>
                  {totalStaff > 0 ? ((totalLate / totalStaff) * 100).toFixed(1) : 0}%
                </div>
              </div>
            </div>

            <div style={{
              padding: '6px 8px',
              backgroundColor: '#e3f2fd',
              borderRadius: '4px',
              display: 'flex',
              justifyContent: 'space-between',
              alignItems: 'center'
            }}>
              <div>
                <div style={{ fontWeight: '700', color: '#333', marginBottom: '2px', fontSize: '12px' }}>
                  Leave
                </div>
                <div style={{ fontSize: '10px', color: '#666', fontWeight: '500' }}>
                  Staff on leave
                </div>
              </div>
              <div style={{ textAlign: 'right' }}>
                <div style={{ fontWeight: '800', color: '#2196F3', fontSize: '17px' }}>
                  {totalStaff > 0 ? ((totalLeave / totalStaff) * 100).toFixed(1) : 0}%
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>

      {/* HOD-wise Attendance Table */}
      <div style={{
        backgroundColor: '#fff',
        borderRadius: '8px',
        boxShadow: '0 2px 8px rgba(0,0,0,0.08)',
        overflow: 'hidden'
      }}>
        <div style={{
          padding: '15px 20px',
          backgroundColor: '#f8f9fa',
          borderBottom: '1px solid #e0e0e0'
        }}>
          <h3 style={{ fontSize: '15px', fontWeight: '600', margin: 0, color: '#333' }}>
            HOD-wise Attendance
          </h3>
        </div>
        <div style={{ overflowX: 'auto' }}>
          <table style={{ width: '100%', borderCollapse: 'collapse', fontSize: '13px' }}>
            <thead>
              <tr style={{ backgroundColor: '#f8f9fa', borderBottom: '2px solid #e0e0e0' }}>
                <th style={{ padding: '12px 15px', textAlign: 'left', fontWeight: '600', color: '#555' }}>HOD/Department</th>
                <th style={{ padding: '12px 15px', textAlign: 'center', fontWeight: '600', color: '#555' }}>Present</th>
                <th style={{ padding: '12px 15px', textAlign: 'center', fontWeight: '600', color: '#555' }}>Absent</th>
                <th style={{ padding: '12px 15px', textAlign: 'center', fontWeight: '600', color: '#555' }}>Late</th>
                <th style={{ padding: '12px 15px', textAlign: 'center', fontWeight: '600', color: '#555' }}>Leave</th>
                <th style={{ padding: '12px 15px', textAlign: 'center', fontWeight: '600', color: '#555' }}>Attendance %</th>
              </tr>
            </thead>
            <tbody>
              {filteredAttendance.length === 0 ? (
                <tr>
                  <td colSpan="6" style={{ padding: '40px', textAlign: 'center', color: '#999' }}>
                    No attendance records found
                  </td>
                </tr>
              ) : (
                filteredAttendance.map((record, index) => {
                  const total = (parseInt(record.present) || 0) + (parseInt(record.absent) || 0) + 
                               (parseInt(record.late) || 0) + (parseInt(record.on_leave) || 0);
                  const attendancePercent = total > 0 ? (((parseInt(record.present) || 0) / total) * 100).toFixed(1) : 0;
                  
                  return (
                    <tr key={index} style={{
                      borderBottom: '1px solid #f0f0f0',
                      transition: 'background-color 0.2s'
                    }}
                    onMouseOver={(e) => e.currentTarget.style.backgroundColor = '#f8f9fa'}
                    onMouseOut={(e) => e.currentTarget.style.backgroundColor = 'transparent'}
                    >
                      <td style={{ padding: '12px 15px' }}>
                        <div style={{ fontWeight: '600', color: '#333' }}>
                          {record.hod_name || record.department || 'General'}
                        </div>
                      </td>
                      <td style={{ padding: '12px 15px', textAlign: 'center', fontWeight: '600', color: '#4CAF50' }}>
                        {record.present || 0}
                      </td>
                      <td style={{ padding: '12px 15px', textAlign: 'center', fontWeight: '600', color: '#F44336' }}>
                        {record.absent || 0}
                      </td>
                      <td style={{ padding: '12px 15px', textAlign: 'center', fontWeight: '600', color: '#FF9800' }}>
                        {record.late || 0}
                      </td>
                      <td style={{ padding: '12px 15px', textAlign: 'center', fontWeight: '600', color: '#2196F3' }}>
                        {record.on_leave || 0}
                      </td>
                      <td style={{ padding: '12px 15px', textAlign: 'center' }}>
                        <div style={{
                          display: 'inline-flex',
                          alignItems: 'center',
                          gap: '8px',
                          padding: '4px 10px',
                          backgroundColor: attendancePercent >= 75 ? '#e8f5e9' : attendancePercent >= 50 ? '#fff3e0' : '#ffebee',
                          color: attendancePercent >= 75 ? '#2e7d32' : attendancePercent >= 50 ? '#ef6c00' : '#c62828',
                          borderRadius: '12px',
                          fontSize: '12px',
                          fontWeight: '600'
                        }}>
                          {attendancePercent}%
                        </div>
                      </td>
                    </tr>
                  );
                })
              )}
            </tbody>
          </table>
        </div>
      </div>
    </div>
  );
};

export default Dashboard;
