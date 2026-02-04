-- API Keys table for third-party systems
CREATE TABLE IF NOT EXISTS third_party_api_keys (
  id INT PRIMARY KEY AUTO_INCREMENT,
  system_name VARCHAR(255) NOT NULL UNIQUE,
  api_key_hash VARCHAR(255) NOT NULL UNIQUE,
  description TEXT,
  is_active BOOLEAN DEFAULT 1,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  last_used_at TIMESTAMP NULL,
  INDEX idx_api_key_hash (api_key_hash),
  INDEX idx_system_name (system_name),
  INDEX idx_is_active (is_active)
);

-- Import logs table to track all imports
CREATE TABLE IF NOT EXISTS attendance_import_logs (
  id INT PRIMARY KEY AUTO_INCREMENT,
  api_key_id INT NOT NULL,
  employee_id VARCHAR(50),
  attendance_date DATE,
  check_in TIME,
  check_out TIME,
  status VARCHAR(50),
  device_id VARCHAR(100),
  import_status ENUM('success', 'failed') DEFAULT 'success',
  error_message TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (api_key_id) REFERENCES third_party_api_keys(id) ON DELETE CASCADE,
  INDEX idx_api_key_id (api_key_id),
  INDEX idx_employee_id (employee_id),
  INDEX idx_attendance_date (attendance_date),
  INDEX idx_created_at (created_at),
  INDEX idx_import_status (import_status)
);

-- Modify existing attendance table to track source
ALTER TABLE attendance ADD COLUMN IF NOT EXISTS source VARCHAR(50) DEFAULT 'manual';
ALTER TABLE attendance ADD COLUMN IF NOT EXISTS device_id VARCHAR(100);
ALTER TABLE attendance ADD INDEX IF NOT EXISTS idx_source (source);

-- Example: Test data insertion
-- INSERT INTO third_party_api_keys (system_name, api_key_hash, description)
-- VALUES ('BioMetric System', SHA2('your-secret-key-here', 256), 'Main biometric system');
