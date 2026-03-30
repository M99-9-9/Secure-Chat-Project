#!/bin/bash

set -e

echo "======================================"
echo "Element Web - Vercel Build Script"
echo "======================================"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Step 1: Install dependencies
echo -e "${YELLOW}Step 1: Installing dependencies...${NC}"
pnpm install --no-frozen-lockfile || {
    echo -e "${RED}❌ Failed to install dependencies${NC}"
    exit 1
}

# Step 2: Run prebuild tasks
echo -e "${YELLOW}Step 2: Running prebuild tasks...${NC}"
cd apps/web
pnpm run prebuild:module_system || {
    echo -e "${RED}❌ Failed to run prebuild:module_system${NC}"
    exit 1
}
pnpm run prebuild:rethemendex || {
    echo -e "${RED}❌ Failed to run prebuild:rethemendex${NC}"
    exit 1
}
cd ../..

# Step 3: Build the web application
echo -e "${YELLOW}Step 3: Building web application...${NC}"
nx build web || {
    echo -e "${RED}❌ Failed to build web application${NC}"
    exit 1
}

# Step 4: Copy built files to root (for Vercel to find them)
echo -e "${YELLOW}Step 4: Copying built files...${NC}"
if [ -d "apps/web/webapp" ]; then
    echo "Copying webapp contents to root directory..."
    cp -r apps/web/webapp/* . || true
    cp -r apps/web/webapp/. . 2>/dev/null || true
    echo -e "${GREEN}✓ Files copied successfully${NC}"
else
    echo -e "${RED}❌ webapp directory not found at apps/web/webapp${NC}"
    exit 1
fi

# Step 5: Verify build
echo -e "${YELLOW}Step 5: Verifying build...${NC}"
if [ -f "index.html" ]; then
    echo -e "${GREEN}✓ index.html found${NC}"
else
    echo -e "${RED}❌ index.html not found${NC}"
    exit 1
fi

echo -e "${GREEN}======================================"
echo "✓ Build completed successfully!"
echo "======================================${NC}"
exit 0
