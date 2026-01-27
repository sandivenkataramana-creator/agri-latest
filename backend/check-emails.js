/**
 * Diagnostic tool to check all emails in HODs table
 */
const db = require('./config/database');

console.log('\n🔍 CHECKING ALL EMAILS IN HODS TABLE\n');

async function checkEmails() {
  try {
    // Get all HODs with non-null emails
    const [hodsWithEmail] = await db.query(
      'SELECT id, name, email FROM hods WHERE email IS NOT NULL ORDER BY email'
    );
    
    console.log(`Found ${hodsWithEmail.length} HODs with emails:\n`);
    
    if (hodsWithEmail.length === 0) {
      console.log('✅ No emails in database - all are NULL\n');
    } else {
      console.table(hodsWithEmail);
      console.log('\n📧 Emails in use:');
      hodsWithEmail.forEach(hod => {
        console.log(`  - ${hod.email}`);
      });
    }

    // Get HODs with null emails
    const [hodsWithoutEmail] = await db.query(
      'SELECT id, name FROM hods WHERE email IS NULL ORDER BY name'
    );
    
    console.log(`\n\nFound ${hodsWithoutEmail.length} HODs with NULL emails:\n`);
    if (hodsWithoutEmail.length > 0) {
      console.table(hodsWithoutEmail);
    }

    console.log('\n✅ Diagnostic complete\n');
    process.exit(0);

  } catch (error) {
    console.error('❌ Error:', error.message);
    process.exit(1);
  }
}

checkEmails();
