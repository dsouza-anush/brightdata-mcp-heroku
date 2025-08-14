#!/usr/bin/env node
'use strict';

import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const currentDir = process.cwd();

console.log('Verifying Heroku deployment configuration...');

// Check for required files
const requiredFiles = [
  'app.json',
  'Procfile',
  'package.json',
  'server.js'
];

let allFilesExist = true;
for (const file of requiredFiles) {
  const filePath = path.join(currentDir, file);
  if (fs.existsSync(filePath)) {
    console.log(`✅ ${file} exists`);
  } else {
    console.error(`❌ ${file} is missing`);
    allFilesExist = false;
  }
}

if (!allFilesExist) {
  console.error('Some required files are missing. Please ensure all required files exist.');
  process.exit(1);
}

// Check app.json structure
try {
  const appJson = JSON.parse(fs.readFileSync(path.join(currentDir, 'app.json'), 'utf8'));
  
  // Check required fields
  const requiredFields = ['name', 'description', 'repository', 'env'];
  let missingFields = [];
  
  for (const field of requiredFields) {
    if (!appJson[field]) {
      missingFields.push(field);
    }
  }
  
  if (missingFields.length > 0) {
    console.error(`❌ app.json is missing required fields: ${missingFields.join(', ')}`);
    process.exit(1);
  }
  
  // Check API_TOKEN in env
  if (!appJson.env.API_TOKEN) {
    console.error('❌ app.json is missing API_TOKEN in env');
    process.exit(1);
  }
  
  console.log('✅ app.json structure is valid');
} catch (error) {
  console.error(`❌ Error parsing app.json: ${error.message}`);
  process.exit(1);
}

// Check Procfile structure
try {
  const procfile = fs.readFileSync(path.join(currentDir, 'Procfile'), 'utf8');
  
  // Check for web and mcp process types
  if (!procfile.includes('web:')) {
    console.error('❌ Procfile is missing web process type');
    process.exit(1);
  }
  
  if (!procfile.includes('mcp:')) {
    console.error('❌ Procfile is missing mcp process type');
    process.exit(1);
  }
  
  console.log('✅ Procfile structure is valid');
} catch (error) {
  console.error(`❌ Error reading Procfile: ${error.message}`);
  process.exit(1);
}

console.log('\n✅ All checks passed! The repository is ready for Heroku Button deployment.');