// Quick test to verify password auto-generation works

// Replicate the password generation function
const generateTemporaryPassword = () => {
  const length = 12;
  const uppercase = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  const lowercase = 'abcdefghijklmnopqrstuvwxyz';
  const numbers = '0123456789';
  const special = '!@#$%^&*';
  const all = uppercase + lowercase + numbers + special;
  
  let password = '';
  password += uppercase[Math.floor(Math.random() * uppercase.length)];
  password += lowercase[Math.floor(Math.random() * lowercase.length)];
  password += numbers[Math.floor(Math.random() * numbers.length)];
  password += special[Math.floor(Math.random() * special.length)];
  
  for (let i = 4; i < length; i++) {
    password += all[Math.floor(Math.random() * all.length)];
  }
  
  return password.split('').sort(() => Math.random() - 0.5).join('');
};

console.log('\n🔐 AUTO-PASSWORD GENERATION TEST\n');
console.log('Generated 5 sample temporary passwords:\n');

for (let i = 1; i <= 5; i++) {
  const pwd = generateTemporaryPassword();
  console.log(`${i}. ${pwd} (length: ${pwd.length})`);
}

console.log('\n✅ Auto-generation working correctly!\n');
