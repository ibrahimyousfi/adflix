#!/bin/bash
# Deployment hook script for Hostinger
# This script will be executed when webhook is triggered

echo "Starting deployment..."
cd "$(dirname "$0")"

# Configure Git
git config pull.rebase false
git config core.autocrlf false

# Fetch and reset to match GitHub
git fetch origin
git reset --hard origin/main

# Clean any untracked files (optional)
# git clean -fd

echo "Deployment completed successfully!"
