// Frontend Application Configuration
// This centralized config allows easy switching between development and production
// Uses environment variables from .env file

const config = {
  // API Base URL - gets overridden by REACT_APP_API_BASE_URL env var
  apiBaseUrl: process.env.REACT_APP_API_BASE_URL || 'http://localhost:5000/api',
  
  // Frontend Base URL
  frontendUrl: process.env.REACT_APP_FRONTEND_URL || 'http://localhost:3000',
  
  // Environment
  environment: process.env.NODE_ENV || 'development',
  
  // API Timeout (in milliseconds)
  apiTimeout: 30000,
  
  // Pagination
  itemsPerPage: 10
};

export default config;
