# دليل النشر الكامل على Vercel لمنصة الاتصالات الآمنة

## مقدمة
هذا الدليل سيأخذك خطوة بخطوة لنشر منصة الاتصالات الآمنة على Vercel بنجاح.

---

## المرحلة الأولى: الإعداد الأولي

### 1. التحقق من الملفات الأساسية

تأكد من وجود جميع الملفات التالية:

```bash
# الملفات المطلوبة
✓ vercel.json
✓ apps/web/config.json
✓ apps/web/package.json
✓ apps/web/webpack.config.ts
✓ apps/web/.gitignore (يحتوي على !/config.json)
✓ pnpm-lock.yaml
```

### 2. التحقق من محتويات الملفات الحرجة

#### vercel.json
```json
{
  "version": 2,
  "buildCommand": "pnpm install --frozen-lockfile && pnpm build",
  "outputDirectory": "apps/web/webapp",
  "cleanUrls": true,
  "rewrites": [
    {
      "source": "/(.*)",
      "destination": "/index.html"
    }
  ],
  "headers": [...]
}
```

#### apps/web/config.json
```json
{
  "brand": "Secure Chat",
  "defaultHomeserverUrl": "https://matrix.org",
  "defaultIdentityServerUrl": "https://vector.im",
  "showLabsSettings": true,
  "element_call": {
    "e2eeEnabled": true
  }
}
```

#### apps/web/.gitignore
يجب أن يحتوي على:
```
/webapp
/config.local.json
/config.local*.json
!/config.json              # ← هذا مهم جداً
!/config.sample.json
```

---

## المرحلة الثانية: الدفع إلى GitHub

### الخطوة 1: التحقق من الحالة
```bash
git status
```

**يجب أن تشاهد:**
```
On branch develop
Changes not staged for commit:
  modified:   vercel.json
  modified:   apps/web/.gitignore
  new file:   apps/web/config.json
```

### الخطوة 2: إضافة التغييرات
```bash
git add .
```

### الخطوة 3: إنشاء Commit
```bash
git commit -m "fix: prepare Secure Chat Platform for Vercel deployment

- Fixed SPA routing with proper rewrites
- Added security headers and cache control
- Configured output directory for webapp build
- Optimized build command with frozen-lockfile
- Updated .gitignore to include config.json
- All deployment configurations verified and tested"
```

### الخطوة 4: الدفع إلى GitHub
```bash
# للفرع الحالي (إذا كنت على فرع تطوير)
git push origin $(git rev-parse --abbrev-ref HEAD)

# أو تحديد الفرع مباشرة
git push origin develop

# أو إذا كان لديك فرع feature
git push origin your-feature-branch
```

**تتبع العملية:**
```bash
# تحقق من آخر commit
git log --oneline -1

# تحقق من أن الدفع نجح
git status
# يجب أن تشاهد: "Your branch is up to date"
```

---

## المرحلة الثالثة: الإعدادات في Vercel

### الخطوة 1: الدخول إلى Vercel Dashboard
```
https://vercel.com/dashboard
```

### الخطوة 2: اختيار المشروع
```
Secure-Chat-Project
```

### الخطوة 3: التحقق من الإعدادات

#### Project Settings
```
Navigate to: Settings → General
- Project Name: Secure-Chat-Project
- Framework: Custom (Webpack)
- Node.js Version: 22.x (يجب أن تختار الإصدار الأحدث المتاح)
```

#### Build & Development Settings
```
Navigate to: Settings → Build & Development

Build Command: pnpm install --frozen-lockfile && pnpm build
Output Directory: apps/web/webapp
Install Command: pnpm install --frozen-lockfile

✓ (اترك الباقي كما هو)
```

#### Environment Variables
```
Navigate to: Settings → Environment Variables

تأكد من أن المتغيرات التالية موجودة (إن كانت مطلوبة):
- NODE_ENV: production
- أي متغيرات أخرى خاصة بـ Matrix homeserver

انقر على "Add"، أضف المتغيرات إذا لزم الحال
```

#### Root Directory (إذا طُلب)
```
Leave as: / (default)
(يجب أن يكون فارغاً)
```

### الخطوة 4: حفظ الإعدادات
```
انقر على "Save"
```

---

## المرحلة الرابعة: بدء الـ Deployment

### الخيار أ: النشر الآلي (من GitHub)
```
1. اذهب إلى: Deployments tab
2. سيظهر آخر push من GitHub تلقائياً
3. Vercel سيبدأ البناء تلقائياً
4. انتظر 3-5 دقائق لاكتمال البناء
```

### الخيار ب: النشر اليدوي (من CLI)
```bash
# تثبيت Vercel CLI
npm install -g vercel

# الدخول إلى حسابك
vercel login

# النشر من مجلد المشروع
cd Secure-Chat-Project
vercel --prod

# سيسأل عن التأكيد
# أجب بـ "Yes" لجميع الأسئلة
```

---

## المرحلة الخامسة: مراقبة البناء

### الخطوة 1: فتح صفحة الـ Deployment
```
Vercel Dashboard → Deployments → أحدث deployment
```

### الخطوة 2: مراقبة حالة البناء

**الحالات الممكنة:**

```
QUEUED (قائمة الانتظار)
  ↓
BUILDING (جاري البناء)
  ↓
ANALYZING (جاري التحليل)
  ↓
READY (جاهز)
```

### الخطوة 3: قراءة السجلات (Build Logs)
```
إذا واجهت مشكلة:

1. انقر على "View Function Logs"
2. ابحث عن كلمة "error"
3. اقرأ الرسالة الكاملة
4. راجع قسم "استكشاف الأخطاء" أدناه
```

### الخطوة 4: انتظار اكتمال البناء
```
الوقت المتوقع: 3-5 دقائق

خلال الانتظار:
- لا تغلق الصفحة
- لا تدفع تغييرات جديدة
- يمكنك فتح نافذة جديدة للعمل
```

---

## المرحلة السادسة: الاختبار بعد النشر

### الخطوة 1: فتح الموقع

```
انقر على "Visit" أو نسخ الرابط من:
https://[your-project-name].vercel.app
```

### الخطوة 2: الاختبارات الأساسية

- [ ] يفتح الموقع بسرعة
- [ ] لا توجد أخطاء 404
- [ ] الشعار والألوان صحيحة
- [ ] جميع الصفحات تحمّل

### الخطوة 3: الاختبارات المتقدمة

```bash
# فتح DevTools
F12 أو Cmd+Option+I

# فحص Console (يجب أن تكون فارغة)
- لا أخطاء (باللون الأحمر)
- لا تحذيرات مهمة

# فحص Network (يجب أن تكون الملفات سريعة)
- جميع الملفات تحمّل بـ status 200
- بدون 404 أو 500

# فحص Performance (يجب أن تكون سريعة)
- FCP < 3 ثانية
- LCP < 5 ثواني
- CLS < 0.1
```

### الخطوة 4: اختبار الملاحة
```
- اختبر جميع الروابط الرئيسية
- جرّب زر "Back" و "Forward"
- أعد تحميل الصفحة من صفحات مختلفة
- تأكد من عدم وجود 404
```

---

## استكشاف الأخطاء

### خطأ: "Build failed"

**الحل:**
1. افتح Build Logs
2. ابحث عن أول سطر يحتوي على "error"
3. اقرأ الرسالة الكاملة

**الأخطاء الشائعة:**

#### خطأ 1: "Cannot find module"
```
السبب: تبعية ناقصة
الحل:
- تأكد من pnpm-lock.yaml موجود
- تأكد من pnpm install يعمل محلياً
- جرب: rm pnpm-lock.yaml && pnpm install
```

#### خطأ 2: "Output directory not found"
```
السبب: outputDirectory غير صحيح في vercel.json
الحل:
- تأكد من: "outputDirectory": "apps/web/webapp"
- تأكد من أن webpack ينتج ملفات هناك
- جرب محلياً: pnpm build
```

#### خطأ 3: "config.json not found"
```
السبب: .gitignore يستثني الملف
الحل:
- تأكد من: !/config.json في .gitignore
- تأكد من الملف موجود في المستودع
- جرب: git status | grep config
```

#### خطأ 4: "Node.js version mismatch"
```
السبب: إصدار Node.js مختلف
الحل:
- اذهب إلى Settings
- غيّر Node.js Version إلى 22.x
- أعد البناء
```

#### خطأ 5: "Build timeout"
```
السبب: البناء يأخذ وقت طويل جداً
الحل:
- قلل حجم المشروع
- فعّل التخزين المؤقت
- تحسين الأداء (انظر PERFORMANCE_OPTIMIZATION.md)
- أضف exclusions إلى webpack
```

### خطأ: "404 errors after deploy"

**الحل:**
1. تأكد من vercel.json يحتوي على rewrites
2. تأكد من SPA routing مفعّل:
```json
{
  "rewrites": [
    {
      "source": "/(.*)",
      "destination": "/index.html"
    }
  ]
}
```
3. أعد البناء من Dashboard

### خطأ: "Blank page after deploy"

**الحل:**
1. افتح DevTools Console
2. ابحث عن الأخطاء
3. تحقق من أن index.html يُرجع الملف الصحيح
4. تحقق من مسارات الملفات الثابتة

---

## الإعدادات الموصى بها بعد النشر

### 1. تفعيل Auto-Deployments
```
Settings → Git → Automatic Deployments
✓ Deploy on push to main branch
✓ Deploy on pull requests (preview)
```

### 2. إضافة Domain مخصص (اختياري)
```
Settings → Domains
- أضف اسم النطاق الخاص بك
- حدّث DNS records حسب الإرشادات
```

### 3. تفعيل Analytics (اختياري)
```
Analytics tab
- اعرض إحصائيات الزيارات
- راقب الأداء
- اكتشف المشاكل
```

### 4. إضافة Monitoring (اختياري)
```
Settings → Monitoring
- فعّل Error Tracking
- فعّل Performance Monitoring
```

---

## قائمة التحقق النهائية

- [ ] جميع الملفات موجودة
- [ ] vercel.json صحيح
- [ ] config.json موجود وصحيح
- [ ] .gitignore يستثني الملف بشكل صحيح
- [ ] تم الدفع إلى GitHub بنجاح
- [ ] البناء على Vercel نجح
- [ ] الموقع يفتح بدون أخطاء
- [ ] لا توجد أخطاء 404
- [ ] الأداء مرضي
- [ ] جميع الميزات تعمل
- [ ] DevTools Console نظيفة

---

## الخطوات التالية

### بعد النشر الناجح

```
1. مشاركة الرابط مع الفريق:
   https://[your-project-name].vercel.app

2. المراقبة المستمرة:
   - تحقق من Analytics يومياً
   - راقب Error Tracking
   - اقرأ Performance Metrics

3. التطوير المستمر:
   - أضف ميزات جديدة
   - أصلح الأخطاء
   - حسّن الأداء

4. النشرات الجديدة:
   - كل تغيير يُدفع إلى GitHub
   - Vercel ينشر تلقائياً
   - سيتم إنشاء preview link جديد
```

---

## الدعم والمساعدة

### مصادر مفيدة
- [Vercel Documentation](https://vercel.com/docs)
- [Vercel Status](https://www.vercelstatus.com/)
- [Vercel Support](https://vercel.com/help)
- [Matrix Protocol](https://matrix.org/)
- [Element Web Repository](https://github.com/element-hq/element-web)

### اتصل بالدعم
```
إذا واجهت مشكلة لا تستطيع حلها:

1. تحقق من Build Logs في Vercel
2. اقرأ قسم "استكشاف الأخطاء" أعلاه
3. ابحث في Vercel Docs
4. افتح ticket دعم من Vercel Dashboard
```

---

## ملاحظات مهمة

1. **config.json الآن مرئي:** يتم نشره مع المستودع
2. **لا تستخدم secrets فيه:** استخدم Environment Variables بدلاً منها
3. **config.local.json يبقى مخفي:** للإعدادات المحلية فقط
4. **Vercel ستعيد بناء:** تلقائياً عند كل push

---

## الملخص السريع

```bash
# 1. تحضير المشروع
git add .
git commit -m "fix: prepare for Vercel deployment"

# 2. الدفع إلى GitHub
git push origin develop

# 3. الانتظار (3-5 دقائق)
# افتح Vercel Dashboard وراقب البناء

# 4. الاختبار
# افتح الرابط المؤقت واختبر الميزات

# 5. النجاح!
# الموقع جاهز للاستخدام
```

---

**آخر تحديث:** 2026-03-29
**الحالة:** جاهز للنشر الفوري
**الدعم:** مرحب به! راجع الأقسام أعلاه للمساعدة
