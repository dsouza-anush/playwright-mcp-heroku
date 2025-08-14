#!/bin/bash

# This script prepares the repository for Heroku deployment

# Copy the Heroku-specific package.json to ensure TypeScript is installed as a dependency
if [ -f heroku.package.json ]; then
  echo "Setting up Heroku-specific package.json"
  cp heroku.package.json package.json
else
  echo "Error: heroku.package.json not found"
  exit 1
fi

# Ensure the script completes successfully
echo "Heroku setup completed successfully"
exit 0