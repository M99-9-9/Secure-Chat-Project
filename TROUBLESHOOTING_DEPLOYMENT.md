# دليل استكشاف الأخطاء الشامل

## 🔍 الخطوة 1: اختبر البناء محليا أولاً

### اختبر البناء العادي:
```bash
cd /vercel/share/v0-project

# تنظيف كامل
rm -rf apps/web/webapp node_modules pnpm-lock.yaml

# تثبيت جديد
pnpm install

# بناء
pnpm build

# تحقق من النتيجة
ls -la apps/web/webapp/
# يجب أن ترى: index.html, bundles/, ...
```

إذا نجح هنا، المشروع سليم.
إذا فشل، المشكلة محلية.

---

## 🔍 الخطوة 2: اختبر Build Script الخاص بـ Vercel

```bash
# اجعله قابل للتنفيذ
chmod +x scripts/vercel-build.sh
chmod +x build-and-serve.sh

# اختبره
bash scripts/vercel-build.sh

# أو
bash build-and-serve.sh
```

---

## 🔍 الخطوة 3: اختبر Docker (إن استخدمته)

```bash
# بناء صورة Docker
docker build -f Dockerfile.vercel -t element-web:test .

# الأخطاء الشائعة في Docker:
# - "node_modules not found" → أضف COPY أكثر
# - "pnpm not found" → أضف npm install -g pnpm
# - "out of memory" → أضف --memory=4g في build

# اختبر الصورة
docker run -p 8080:8080 element-web:test
# افتح: http://localhost:8080
```

---

## ⚠️ الأخطاء الشائعة وحلولها:

### 1️⃣ "Cannot find module 'webpack'"

**السبب:** webpack لم يتثبت

**الحل:**
```bash
pnpm install
# أو
npm install -g webpack webpack-cli
```

**في Vercel:**
```json
// vercel.json
{
  "buildCommand": "pnpm install && pnpm build"
}
```

---

### 2️⃣ "404 Not Found"

**السبب:** rewrites غير صحيحة

**الحل:**
```json
// vercel.json
{
  "rewrites": [
    {
      "source": "/(.*)",
      "destination": "/index.html"
    }
  ]
}
```

**تحقق:**
```bash
curl -I https://your-app.vercel.app/
# يجب أن ترى: 200 OK

curl -I https://your-app.vercel.app/nonexistent
# يجب أن ترى: 200 OK (ستحمل index.html)
```

---

### 3️⃣ "pnpm: command not found"

**السبب:** pnpm لم يثبت على Vercel

**الحل 1: في vercel.json**
```json
{
  "installCommand": "npm install -g pnpm && pnpm install --no-frozen-lockfile"
}
```

**الحل 2: في Settings على Vercel**
1. Settings → Build & Development
2. Install Command: `npm install -g pnpm && pnpm install`

---

### 4️⃣ "Out of memory"

**السبب:** المشروع كبير جداً

**الحل:**
```json
{
  "buildEnvironment": {
    "NODE_OPTIONS": "--max-old-space-size=4096"
  }
}
```

أو استخدم Docker مع memory أكثر.

---

### 5️⃣ "Build timeout"

**السبب:** البناء يأخذ وقتاً طويلاً

**الحل 1: استخدم Docker (أسرع)**
```bash
docker build --cache=type=local -f Dockerfile.vercel .
```

**الحل 2: حسّن البناء**
```json
{
  "buildCommand": "pnpm install --prod && pnpm build"
}
```

---

### 6️⃣ "Cannot read property 'outputDirectory'"

**السبب:** مسار output خاطئ

**الحل:**
```json
{
  "outputDirectory": "apps/web/webapp"
  // أو
  "outputDirectory": "."
}
```

تحقق أن هذا المسار موجود بعد البناء!

---

## 🧪 اختبارات التشخيص:

### اختبار 1: تحقق من ملفات البناء
```bash
# يجب أن توجد هذه الملفات:
test -f apps/web/webapp/index.html && echo "✓ index.html found"
test -d apps/web/webapp/bundles && echo "✓ bundles found"
test -f apps/web/webapp/config.json && echo "✓ config.json found" || echo "✗ config.json missing"
```

### اختبر 2: تحقق من الـ package.json
```bash
# يجب أن يحتوي على build script
grep "\"build\"" apps/web/package.json
```

### اختبار 3: تحقق من vercel.json
```bash
# يجب أن يكون JSON صحيح
jq . vercel.json > /dev/null && echo "✓ vercel.json is valid JSON"
```

---

## 🔍 قراءة سجلات Vercel:

### الخطوات:
1. افتح Vercel Dashboard
2. اختر المشروع
3. Deployments (الزر العلوي)
4. اختر آخر deployment
5. Build Logs

### ماذا تبحث عنه:
```
❌ FAIL: "error:" - الخطأ الأساسي
⚠️  WARNING: - تحذيرات قد تسبب مشاكل
✓ PASS: - علامات النجاح
```

### نسخ سجل البناء:
```bash
# انسخ السجل كاملاً
# اضغط Ctrl+A ثم Ctrl+C
# الصقه في ملف لدراستها
```

---

## 🛠️ حل شامل إذا فشل كل شيء:

### الخطوة 1: أعد تعيين المشروع
```bash
cd /vercel/share/v0-project
rm -rf node_modules apps/web/webapp pnpm-lock.yaml

pnpm install --no-frozen-lockfile
pnpm build

# تحقق
ls -la apps/web/webapp/index.html
```

### الخطوة 2: استخدم Docker
```bash
docker build -f Dockerfile.vercel -t element-web .
docker run -p 8080:8080 element-web
# افتح: http://localhost:8080
```

### الخطوة 3: دفع التغييرات
```bash
git add .
git commit -m "fix: comprehensive deployment solution"
git push origin develop
```

### الخطوة 4: على Vercel
- اذهب للـ Settings
- اختر Docker deployment
- Deploy!

---

## 📊 جدول الأخطاء والحلول السريعة:

| الخطأ | السبب | الحل السريع |
|-------|--------|-----------|
| 404 Not Found | rewrites خاطئة | انسخ vercel.json الجديد |
| Out of memory | حجم كبير | أضف NODE_OPTIONS |
| Build timeout | بطء | استخدم Docker |
| pnpm not found | لم يثبت | أضف installCommand |
| webpack not found | لم يثبت | أضف pnpm install |
| config.json missing | لم ينسخ | تحقق من build script |
| bundles not found | build فشل | اختبر محليا أولاً |

---

## ✅ قائمة التحقق النهائية:

قبل كل push:

- [ ] `pnpm install` نجح محليا
- [ ] `pnpm build` نجح محليا
- [ ] `ls apps/web/webapp/index.html` موجود
- [ ] vercel.json صحيح (جرب `jq . vercel.json`)
- [ ] scripts/vercel-build.sh قابل للتنفيذ
- [ ] Dockerfile.vercel موجود
- [ ] git status نظيف

---

## 🎯 الخط النهائي:

إذا اتبعت هذه الخطوات بالترتيب، ستحل جميع المشاكل المحتملة 99% من الوقت.

**الآن أنت جاهز للنشر!** 🚀
