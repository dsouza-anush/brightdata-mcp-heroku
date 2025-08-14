#!/bin/bash
# Script to update from upstream repository while preserving Heroku-specific changes

set -e

echo "Updating from upstream repository..."

# Fetch the latest changes from the upstream repository
git fetch upstream

# Create a temporary branch for updates
git checkout -b temp-update

# Merge upstream changes
git merge upstream/main -m "Merge upstream changes"

# List of files we want to preserve (Heroku-specific files)
PRESERVED_FILES=(
  "app.json"
  "Procfile"
  "verify_heroku_config.js"
  "update_from_upstream.sh"
)

# Check if README.md was modified upstream
if git diff --name-only HEAD@{1} | grep -q "README.md"; then
  echo "README.md was modified upstream, preserving our Heroku button section"
  # Get our version of the Heroku deploy section
  HEROKU_SECTION=$(git show HEAD@{1}:README.md | grep -A10 "## ☁️ Deploy to Heroku" | head -n10)
  
  # Update README.md to include our Heroku section
  if [ -n "$HEROKU_SECTION" ]; then
    # Check if the file exists
    if grep -q "## ☁️ Deploy to Heroku" README.md; then
      echo "Heroku section already exists in README.md"
    else
      # Find Table of Content section and update it
      sed -i '' -e '/## Table of Content/,/^$/ s/- \[.* Playgrounds\]/- [☁️ Deploy to Heroku](#️-deploy-to-heroku)\n- [🎮 Try Bright Data MCP Playgrounds]/' README.md
      
      # Find the Try Bright Data MCP Playgrounds section and add our Heroku section before it
      sed -i '' -e '/## 🎮 Try Bright Data MCP Playgrounds/i\
## ☁️ Deploy to Heroku\
\
You can deploy this MCP server to Heroku with one click using the button below:\
\
[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy?template=https://github.com/brightdata/brightdata-mcp)\
\
After deployment, make sure to set the required environment variables in your Heroku app settings.\
\
' README.md
    fi
  fi
fi

# Make sure our preserved files are not overwritten
for file in "${PRESERVED_FILES[@]}"; do
  if [ -f "$file" ]; then
    git checkout HEAD@{1} -- "$file"
    git add "$file"
  fi
done

# Commit the preserved changes
git commit -m "Preserve Heroku-specific changes" || echo "No changes needed"

# Checkout back to main branch
git checkout main

# Merge the temporary branch
git merge temp-update

# Delete the temporary branch
git branch -D temp-update

echo "Update complete. Heroku-specific changes have been preserved."