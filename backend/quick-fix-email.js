const { execSync } = require('child_process');
const config = require('./config/database');

console.log('🔧 Fixing email constraint...\n');

try {
  // Drop UNIQUE constraint if it exists
  const dropSQL = `mysql -h${config.host} -u${config.user} -p${config.password} ${config.database} -e "ALTER TABLE hods DROP INDEX IF EXISTS email; SELECT 'Constraint dropped' as status;"`;
  
  console.log('Executing: ALTER TABLE hods DROP INDEX IF EXISTS email\n');
  const result = execSync(dropSQL, { encoding: 'utf-8' });
  console.log(result);
  
  console.log('✅ Email constraint fix completed!');
} catch (error) {
  console.error('❌ Error:', error.message);
}
