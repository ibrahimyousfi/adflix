#!/bin/bash
# Run this script ONCE on Hostinger via SSH to fix deployment
# This will configure Git to prevent divergent branches error

echo "Configuring Git for Hostinger deployment..."
cd "$(dirname "$0")" || exit 1

# Set Git configuration
git config pull.rebase false
git config pull.ff only
git config core.autocrlf false

# Verify configuration
echo ""
echo "Git configuration:"
git config --list | grep -E "(pull|core.autocrlf)"

echo ""
echo "Configuration complete!"
echo "Now try deploying again from Hostinger panel."
