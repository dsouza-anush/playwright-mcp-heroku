#!/bin/bash

# This script prepares the repository for Heroku deployment and MCP compatibility

echo "🔧 Initializing Heroku MCP server setup..."

# Copy the Heroku-specific package.json to ensure TypeScript is installed as a dependency
if [ -f heroku.package.json ]; then
  echo "📦 Setting up Heroku-specific package.json"
  cp heroku.package.json package.json
else
  echo "❌ Error: heroku.package.json not found"
  exit 1
fi

# Install TypeScript if not already installed
if ! command -v tsc &> /dev/null; then
  echo "📥 Installing TypeScript..."
  npm install typescript
fi

# Build the project
if [ ! -d "lib" ] || [ ! -f "lib/program.js" ]; then
  echo "🏗️ Building the project..."
  npm run build
fi

# Verify the build was successful
if [ ! -d "lib" ] || [ ! -f "lib/program.js" ]; then
  echo "❌ Build failed: lib directory or program.js not found"
  exit 1
fi

# Set up Heroku MCP specific environment
echo "🔄 Configuring for Heroku MCP..."
export PLAYWRIGHT_MCP_HEADLESS=true
export PLAYWRIGHT_MCP_NO_SANDBOX=true

# Ensure the script completes successfully
echo "✅ Heroku MCP setup completed successfully"