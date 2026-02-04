// Application Configuration
// This centralized config allows easy switching between development and production

const config = {
  // API Server Configuration
  port: process.env.PORT || 5000,
  
  // Base URLs
  baseUrl: process.env.BASE_URL || 'http://localhost:5000',
  apiBaseUrl: process.env.API_BASE_URL || 'http://localhost:5000/api',
  
  // Frontend URL (for CORS, redirects, email links, etc.)
  frontendUrl: process.env.FRONTEND_URL || 'http://localhost:3000',
  
  // Environment
  environment: process.env.NODE_ENV || 'development',
  
  // Database
  database: {
    host: process.env.DB_HOST || 'localhost',
    user: process.env.DB_USER || 'root',
    password: process.env.DB_PASSWORD || '',
    database: process.env.DB_NAME || 'agri_mani'
  },
  
  // Email Service
  email: {
    service: process.env.EMAIL_SERVICE || 'gmail',
    user: process.env.EMAIL_USER || '',
    password: process.env.EMAIL_PASSWORD || '',
    from: process.env.EMAIL_FROM || 'noreply@agrimani.gov.in'
  }
};

module.exports = config;
