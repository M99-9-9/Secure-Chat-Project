#!/bin/bash

# Secure Chat Project - Deployment Script
# This script handles building and pushing changes for Vercel deployment

set -e

echo "================================"
echo "🚀 Secure Chat Project Deploy"
echo "================================"

# Step 1: Check if we're in the right directory
if [ ! -f "package.json" ]; then
  echo "❌ Error: package.json not found. Are you in the project root?"
  exit 1
fi

echo ""
echo "✅ Found project root"

# Step 2: Install dependencies
echo ""
echo "📦 Installing dependencies..."
pnpm install --no-frozen-lockfile

# Step 3: Build the project
echo ""
echo "🔨 Building the project..."
pnpm build

# Step 4: Verify build output
echo ""
echo "✅ Build completed"

# Step 5: Add all changes
echo ""
echo "📝 Staging changes..."
git add -A

# Step 6: Check if there are changes to commit
if git diff --cached --quiet; then
  echo "ℹ️  No changes to commit"
else
  echo "✅ Changes staged for commit"
  
  # Step 7: Create commit
  echo ""
  echo "💾 Creating commit..."
  git commit -m "fix: radical deployment solution - complete vercel setup"
  
  # Step 8: Push changes
  echo ""
  echo "🌐 Pushing to repository..."
  git push origin develop
  
  echo ""
  echo "✅ Successfully pushed to develop branch!"
fi

echo ""
echo "================================"
echo "✨ Deployment preparation complete!"
echo "================================"
echo ""
echo "Next steps:"
echo "1. Go to https://vercel.com/dashboard"
echo "2. Check the build logs for your Secure-Chat-Project"
echo "3. Wait 3-5 minutes for deployment to complete"
echo "4. Your app will be live!"
echo ""
