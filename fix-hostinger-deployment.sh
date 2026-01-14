#!/bin/bash
# Script to fix Hostinger deployment issue
# Run this via SSH on Hostinger

echo "Setting up Git configuration..."
git config pull.rebase false

echo "Fetching latest changes from GitHub..."
git fetch origin

echo "Resetting to match GitHub (this will overwrite local changes)..."
git reset --hard origin/main

echo "Deployment fixed! Your Hostinger is now synced with GitHub."
