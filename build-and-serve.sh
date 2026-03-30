#!/bin/bash

# Ultimate Build Script for Element Web on Vercel
# This script handles the complete build process

set -e

export NODE_ENV=production
export NODE_OPTIONS="--max-old-space-size=4096"

echo "================================"
echo "Element Web Build Process"
echo "Node Version: $(node --version)"
echo "pnpm Version: $(pnpm --version)"
echo "================================"

# Clean old builds
echo "Cleaning previous builds..."
rm -rf apps/web/webapp dist build 2>/dev/null || true

# Install dependencies
echo "Installing dependencies..."
pnpm install --no-frozen-lockfile

# Run prebuild steps
echo "Running prebuild: module_system..."
cd apps/web
pnpm run prebuild:module_system || pnpm exec node module_system/scripts/install.ts
echo "Running prebuild: rethemendex..."
pnpm run prebuild:rethemendex || echo "Rethemendex skipped (optional)"
cd ../..

# Build using nx
echo "Building with nx..."
npx nx build web --configuration=production || npx nx build web

# Verify the build output
echo "Verifying build output..."
if [ -d "apps/web/webapp" ]; then
    echo "✓ Build directory found at apps/web/webapp"
    
    # For Vercel deployment, copy to root if needed
    if [ ! -z "$VERCEL" ]; then
        echo "Preparing for Vercel deployment..."
        cp -r apps/web/webapp/* . 2>/dev/null || true
        cp -r apps/web/webapp/. . 2>/dev/null || true
    fi
else
    echo "✗ Build failed - webapp directory not found"
    exit 1
fi

echo ""
echo "================================"
echo "✓ Build completed successfully"
echo "================================"
