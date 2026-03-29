#!/bin/bash

# Secure Chat Platform - Pre-Deployment Checklist Script
# المنصة الآمنة للدردشة - سكريبت فحص ما قبل النشر

echo "=================================="
echo "منصة الاتصالات الآمنة المشفرة"
echo "قائمة الفحص قبل النشر"
echo "Secure Chat Platform - Pre-Deployment Checklist"
echo "=================================="
echo ""

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Counter
CHECKS_PASSED=0
CHECKS_FAILED=0

# Function to check and print
check() {
  if [ $? -eq 0 ]; then
    echo -e "${GREEN}✓${NC} $1"
    ((CHECKS_PASSED++))
  else
    echo -e "${RED}✗${NC} $1"
    ((CHECKS_FAILED++))
  fi
}

echo "1️⃣ فحص النظام - System Checks"
echo "=================================="

# Check Node.js version
echo "التحقق من إصدار Node.js..."
NODE_VERSION=$(node -v)
NODE_MAJOR=$(echo $NODE_VERSION | cut -d'.' -f1 | sed 's/v//')
if [ "$NODE_MAJOR" -ge 22 ]; then
  echo -e "${GREEN}✓${NC} Node.js version: $NODE_VERSION (Required: >= 22)"
  ((CHECKS_PASSED++))
else
  echo -e "${RED}✗${NC} Node.js version: $NODE_VERSION (Required: >= 22)"
  ((CHECKS_FAILED++))
fi

# Check pnpm
echo "التحقق من pnpm..."
if command -v pnpm &> /dev/null; then
  PNPM_VERSION=$(pnpm -v)
  echo -e "${GREEN}✓${NC} pnpm is installed: $PNPM_VERSION"
  ((CHECKS_PASSED++))
else
  echo -e "${RED}✗${NC} pnpm is not installed"
  ((CHECKS_FAILED++))
fi

# Check git
echo "التحقق من git..."
if command -v git &> /dev/null; then
  GIT_VERSION=$(git --version)
  echo -e "${GREEN}✓${NC} $GIT_VERSION"
  ((CHECKS_PASSED++))
else
  echo -e "${RED}✗${NC} git is not installed"
  ((CHECKS_FAILED++))
fi

echo ""
echo "2️⃣ فحص الملفات الأساسية - Essential Files Check"
echo "=================================="

# Check vercel.json
if [ -f "vercel.json" ]; then
  echo -e "${GREEN}✓${NC} vercel.json exists"
  ((CHECKS_PASSED++))
else
  echo -e "${RED}✗${NC} vercel.json is missing"
  ((CHECKS_FAILED++))
fi

# Check apps/web/config.json
if [ -f "apps/web/config.json" ]; then
  echo -e "${GREEN}✓${NC} apps/web/config.json exists"
  ((CHECKS_PASSED++))
else
  echo -e "${RED}✗${NC} apps/web/config.json is missing"
  ((CHECKS_FAILED++))
fi

# Check apps/web/package.json
if [ -f "apps/web/package.json" ]; then
  echo -e "${GREEN}✓${NC} apps/web/package.json exists"
  ((CHECKS_PASSED++))
else
  echo -e "${RED}✗${NC} apps/web/package.json is missing"
  ((CHECKS_FAILED++))
fi

# Check apps/web/webpack.config.ts
if [ -f "apps/web/webpack.config.ts" ]; then
  echo -e "${GREEN}✓${NC} apps/web/webpack.config.ts exists"
  ((CHECKS_PASSED++))
else
  echo -e "${RED}✗${NC} apps/web/webpack.config.ts is missing"
  ((CHECKS_FAILED++))
fi

echo ""
echo "3️⃣ فحص Git - Git Status Check"
echo "=================================="

# Check git status
echo "حالة المستودع الحالية..."
git status --short

BRANCH=$(git rev-parse --abbrev-ref HEAD)
echo -e "${GREEN}✓${NC} Current branch: $BRANCH"
((CHECKS_PASSED++))

# Check if there are changes
if [ -n "$(git status --porcelain)" ]; then
  echo -e "${YELLOW}!${NC} There are uncommitted changes"
  echo "  Run: git add . && git commit -m 'message'"
else
  echo -e "${GREEN}✓${NC} Working tree is clean"
  ((CHECKS_PASSED++))
fi

echo ""
echo "4️⃣ فحص التبعيات - Dependencies Check"
echo "=================================="

# Check node_modules
if [ -d "node_modules" ]; then
  echo -e "${GREEN}✓${NC} node_modules directory exists"
  ((CHECKS_PASSED++))
else
  echo -e "${YELLOW}!${NC} node_modules directory not found"
  echo "  Run: pnpm install"
fi

# Check pnpm-lock.yaml
if [ -f "pnpm-lock.yaml" ]; then
  echo -e "${GREEN}✓${NC} pnpm-lock.yaml exists"
  ((CHECKS_PASSED++))
else
  echo -e "${RED}✗${NC} pnpm-lock.yaml is missing"
  ((CHECKS_FAILED++))
fi

echo ""
echo "5️⃣ فحص البناء - Build Check"
echo "=================================="

# Try to build
echo "اختبار بناء المشروع..."
if pnpm build &> /dev/null; then
  echo -e "${GREEN}✓${NC} Build succeeded"
  ((CHECKS_PASSED++))
else
  echo -e "${RED}✗${NC} Build failed"
  echo "  Run: pnpm build (to see detailed errors)"
  ((CHECKS_FAILED++))
fi

# Check if webapp directory exists after build
if [ -d "apps/web/webapp" ]; then
  WEBAPP_SIZE=$(du -sh apps/web/webapp 2>/dev/null | cut -f1)
  echo -e "${GREEN}✓${NC} apps/web/webapp created: $WEBAPP_SIZE"
  ((CHECKS_PASSED++))
else
  echo -e "${YELLOW}!${NC} apps/web/webapp not found (normal if just built)"
fi

echo ""
echo "6️⃣ فحص التكوين - Configuration Check"
echo "=================================="

# Check vercel.json syntax
if grep -q '"buildCommand"' vercel.json; then
  echo -e "${GREEN}✓${NC} vercel.json contains buildCommand"
  ((CHECKS_PASSED++))
else
  echo -e "${RED}✗${NC} vercel.json is missing buildCommand"
  ((CHECKS_FAILED++))
fi

# Check vercel.json output directory
if grep -q '"outputDirectory"' vercel.json; then
  echo -e "${GREEN}✓${NC} vercel.json contains outputDirectory"
  ((CHECKS_PASSED++))
else
  echo -e "${RED}✗${NC} vercel.json is missing outputDirectory"
  ((CHECKS_FAILED++))
fi

# Check vercel.json rewrites
if grep -q '"rewrites"' vercel.json; then
  echo -e "${GREEN}✓${NC} vercel.json contains rewrites (SPA routing)"
  ((CHECKS_PASSED++))
else
  echo -e "${YELLOW}!${NC} vercel.json may be missing rewrites"
fi

# Check config.json format
if grep -q '"brand"' apps/web/config.json && grep -q '"defaultHomeserverUrl"' apps/web/config.json; then
  echo -e "${GREEN}✓${NC} apps/web/config.json is properly formatted"
  ((CHECKS_PASSED++))
else
  echo -e "${RED}✗${NC} apps/web/config.json may be malformed"
  ((CHECKS_FAILED++))
fi

echo ""
echo "7️⃣ فحص الأمان - Security Check"
echo "=================================="

# Check for sensitive files in git
if git ls-files | grep -q "\.env\|\.key\|private"; then
  echo -e "${RED}✗${NC} Sensitive files may be tracked in git"
  ((CHECKS_FAILED++))
else
  echo -e "${GREEN}✓${NC} No obvious sensitive files in git"
  ((CHECKS_PASSED++))
fi

# Check .gitignore
if [ -f ".gitignore" ] && [ -f "apps/web/.gitignore" ]; then
  echo -e "${GREEN}✓${NC} .gitignore files exist"
  ((CHECKS_PASSED++))
else
  echo -e "${YELLOW}!${NC} .gitignore files may be missing"
fi

echo ""
echo "8️⃣ فحص الوثائق - Documentation Check"
echo "=================================="

# Check for documentation files
DOCS=("README.md" "CONTRIBUTING.md")
for doc in "${DOCS[@]}"; do
  if [ -f "$doc" ]; then
    echo -e "${GREEN}✓${NC} $doc exists"
    ((CHECKS_PASSED++))
  else
    echo -e "${YELLOW}!${NC} $doc not found"
  fi
done

echo ""
echo "=================================="
echo "📊 الملخص - Summary"
echo "=================================="
echo -e "الفحوصات الناجحة: ${GREEN}$CHECKS_PASSED${NC}"
echo -e "الفحوصات الفاشلة: ${RED}$CHECKS_FAILED${NC}"

if [ $CHECKS_FAILED -eq 0 ]; then
  echo -e "${GREEN}✓ جميع الفحوصات نجحت - All checks passed!${NC}"
  echo ""
  echo "الخطوات التالية:"
  echo "1. git add ."
  echo "2. git commit -m 'fix: deployment ready'"
  echo "3. git push origin $(git rev-parse --abbrev-ref HEAD)"
  exit 0
else
  echo -e "${RED}✗ بعض الفحوصات فشلت - Some checks failed${NC}"
  echo ""
  echo "يرجى إصلاح المشاكل المذكورة أعلاه"
  exit 1
fi
