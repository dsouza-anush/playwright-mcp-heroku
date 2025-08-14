#!/bin/bash

# Script to update the Heroku-Playwright-MCP repository from the upstream Microsoft repository
# while preserving Heroku-specific files

set -e

echo "Updating from upstream Microsoft Playwright MCP repository..."

# Backup Heroku-specific files
echo "Backing up Heroku-specific files..."
mkdir -p .heroku-backup

# Read the list of Heroku-specific files
if [ -f .heroku-files ]; then
  while IFS= read -r file; do
    # Skip empty lines and comments
    [[ -z "$file" || "$file" =~ ^#.*$ ]] && continue
    # Backup the file if it exists
    if [ -f "$file" ]; then
      echo "  Backing up $file"
      cp -f "$file" .heroku-backup/ 2>/dev/null || true
    fi
  done < .heroku-files
else
  echo "Warning: .heroku-files list not found. Falling back to hardcoded list."
  cp -f Procfile .heroku-backup/ 2>/dev/null || true
  cp -f app.json .heroku-backup/ 2>/dev/null || true
  cp -f README-HEROKU.md .heroku-backup/ 2>/dev/null || true
  cp -f update-from-upstream.sh .heroku-backup/ 2>/dev/null || true
  cp -f .heroku-files .heroku-backup/ 2>/dev/null || true
fi

# Fetch latest changes from upstream
echo "Fetching latest changes from upstream..."
git fetch upstream

# Merge upstream changes
echo "Merging upstream changes..."
git merge upstream/main --no-edit

# Restore Heroku-specific files
echo "Restoring Heroku-specific files..."
if [ -d .heroku-backup ]; then
  for file in .heroku-backup/*; do
    base_file=$(basename "$file")
    echo "  Restoring $base_file"
    cp -f "$file" ./ 2>/dev/null || true
  done
fi

# Clean up
rm -rf .heroku-backup

echo "Update completed successfully!"
echo "You can now commit and push these changes to your repository."
echo "Run 'git push heroku main' to deploy to Heroku if needed."