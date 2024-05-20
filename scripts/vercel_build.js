const {execSync} = require('child_process');

const branch = execSync('git rev-parse --abbrev-ref HEAD', {encoding: 'utf8'}).trim();
console.log(`Branch: ${branch}`);

if (branch === "main" || branch === "beta") {
  // Proceed with the build
  console.log("✅ - Build can proceed");
  process.exit(1);
} else {
  // Don't build
  console.log("🛑 - Build cancelled");
  process.exit(0);
}