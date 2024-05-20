const {execSync} = require('child_process');
const fs = require('fs');

try {
    // Get the current branch name
    const branch = execSync('git rev-parse --abbrev-ref HEAD', {encoding: 'utf8'}).trim();
    // Get the latest version tag for the current branch
    // also remove 'v', to follow pubspec rules
    const version = execSync(`git describe --tags --abbrev=0`, {encoding: 'utf8'}).trim().replace('v', '');
    console.log(`Current branch: ${branch} with tag ${version}\n`)

    if (version) {
        // Read the YAML file
        const filePath = 'pubspec.yaml';
        const fileContents = fs.readFileSync(filePath, 'utf8');
        // Replace the version line or add a new one
        // we don't use a yml parser because it removes spaces and comments which we want to preserve
        const updatedContents = fileContents.replace(
            /^version:.*$/m, `version: ${version}`) || `${fileContents.trim()}\nversion: ${version}`;

        // Write the updated YAML data back to the file
        fs.writeFileSync(filePath, updatedContents);

        console.log(`Version ${version} added to ${filePath}`);
    } else {
        console.log(`No version tag found for the current branch (${branch})`);
    }
} catch (e) {
    console.log(`Command failed, make sure ${branch} has tags`);
    console.log(e)
}
