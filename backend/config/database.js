const mysql = require('mysql2/promise');
require('dotenv').config();

const pool = mysql.createPool({
  host: process.env.DB_HOST || 'localhost',
  user: process.env.DB_USER || 'root',
  password: process.env.DB_PASSWORD || '',
  database: process.env.DB_NAME || 'agri_manager',
  waitForConnections: true,
  connectionLimit: 10,
  queueLimit: 0,
  enableKeepAlive: true
});

// Add error event handler to the pool
pool.on('error', (err) => {
  console.error('Database pool error:', err.message);
  if (err.code === 'PROTOCOL_CONNECTION_LOST') console.error('Database connection was closed.');
  if (err.code === 'PROTOCOL_ENQUEUE_AFTER_FATAL_ERROR') console.error('Cannot enqueue after fatal error.');
  if (err.code === 'PROTOCOL_ENQUEUE_AFTER_SOCKET_CLOSE') console.error('Cannot enqueue after socket close.');
  if (err.code === 'ER_IDENT_CONTAINS_PLUCMSUFFIX') console.error('Misconfig error - check database name!');
  if (err.code === 'ER_ACCESS_DENIED_ERROR') console.error('Database access denied - check credentials!');
  if (err.code === 'ER_BAD_DB_ERROR') console.error('Database not found - check database name!');
  if (err.code === 'ECONNREFUSED') console.error('Database connection refused - is MySQL running?');
});

module.exports = pool;

