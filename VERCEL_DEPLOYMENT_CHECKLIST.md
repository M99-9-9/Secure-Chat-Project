# قائمة التحقق الشاملة لنشر Vault على Vercel

## قبل النشر (Pre-Deployment)

### 1. التحقق من vercel.json
- [ ] الملف موجود في الجذر
- [ ] صيغة JSON صحيحة (لا توجد أخطاء في الفاصلة)
- [ ] لا توجد خاصية `framework` (❌ تم حذفها)
- [ ] لا توجد خاصية `nodeVersion` (❌ تم حذفها)
- [ ] لا توجد خاصية `buildEnvironment` في الجذر (❌ تم نقلها إلى `env`)

```bash
# أمر التحقق
cat vercel.json | jq . && echo "✅ JSON syntax is valid"
```

### 2. التحقق من buildCommand
- [ ] الأمر واضح ومحدد
- [ ] يتضمن `pnpm install && nx build web`
- [ ] يتضمن نسخ الملفات إلى الجذر

```bash
# يجب أن تكون كالآتي:
"buildCommand": "pnpm install && nx build web && (cp -r apps/web/webapp/* . || true)"
```

### 3. التحقق من outputDirectory
- [ ] محدد بشكل صحيح (يجب أن يكون `.` أو مسار صحيح)
- [ ] يشير إلى مسار ملفات البناء الفعلي

```bash
"outputDirectory": "."
```

### 4. التحقق من SPA Routing
- [ ] وجود `rewrites` في vercel.json
- [ ] تم إعادة توجيه جميع المسارات إلى `/index.html`

```json
"rewrites": [
  {
    "source": "/(.*)",
    "destination": "/index.html"
  }
]
```

### 5. التحقق من الأمان (Headers)
- [ ] وجود `Cache-Control` headers
- [ ] وجود `X-Content-Type-Options`
- [ ] وجود `X-Frame-Options`
- [ ] وجود `Referrer-Policy`
- [ ] وجود `Permissions-Policy`

### 6. التحقق من متغيرات البيئة
- [ ] `NODE_ENV` = production
- [ ] `NODE_OPTIONS` = --max-old-space-size=4096

```json
"env": {
  "NODE_ENV": "production",
  "NODE_OPTIONS": "--max-old-space-size=4096"
}
```

### 7. البناء المحلي
- [ ] تشغيل `pnpm install` بنجاح
- [ ] تشغيل `pnpm build` بنجاح
- [ ] وجود ملفات البناء في `apps/web/webapp`

```bash
pnpm install && pnpm build
ls -la apps/web/webapp
```

## أثناء النشر (During Deployment)

### 8. دفع التغييرات
- [ ] تم إضافة الملفات المعدلة بـ `git add`
- [ ] تم إنشاء commit مناسب
- [ ] تم دفع التغييرات إلى `develop` أو `main`

```bash
git add vercel.json
git commit -m "fix: remove invalid framework property from vercel.json"
git push origin develop
```

### 9. مراقبة البناء
- [ ] الدخول إلى Vercel Dashboard
- [ ] اختيار مشروع Vault
- [ ] ملاحظة بدء البناء
- [ ] عدم وجود أخطاء في سجل البناء

### 10. مشاهدة السجلات (Logs)
- [ ] لا توجد أخطاء JSON Schema
- [ ] لا توجد رسائل خطأ `framework`
- [ ] تم اكتمال `buildCommand` بنجاح
- [ ] تم نسخ الملفات بنجاح

## بعد النشر (Post-Deployment)

### 11. التحقق من النشر
- [ ] رسالة "Deployment successful" من Vercel
- [ ] الموقع متاح على الرابط المخصص
- [ ] الصفحة الرئيسية تحمل بدون أخطاء

### 12. الاختبار الأساسي
- [ ] فتح الموقع في المتصفح
- [ ] تحميل جميع الأصول (JS, CSS, Images)
- [ ] عدم وجود أخطاء في Console
- [ ] عمل جميع الروابط بشكل صحيح

### 13. الاختبار المتقدم
- [ ] اختبار الميزات الأساسية
- [ ] اختبار المصادقة (إن وجدت)
- [ ] اختبار الاتصال بـ Matrix Server
- [ ] اختبار التشفير والاتصالات

### 14. مراقبة الأداء
- [ ] فتح Vercel Analytics
- [ ] التحقق من وقت البناء (يجب أن يكون أقل من 10 دقائق)
- [ ] التحقق من حجم الحزمة (يجب أن يكون معقولاً)

### 15. التحقق من الأمان
- [ ] اختبار Security Headers
- [ ] التحقق من HTTPS
- [ ] اختبار CORS (إن كان مطبقاً)

```bash
# اختبر Headers
curl -I https://your-vault-site.vercel.app
```

## المتطلبات الإضافية (Optional)

### .vercelignore
- [ ] وجود ملف `.vercelignore` في الجذر
- [ ] استثناء الملفات غير الضرورية

```
.git
.gitignore
.env.local
node_modules
coverage
```

### config.json
- [ ] محدث مع بيانات Matrix Server الصحيحة
- [ ] متضمن في إعدادات التطبيق

## استكشاف الأخطاء

### إذا فشل البناء

```bash
# 1. تحقق من الـ logs
# افتح Vercel Dashboard → Deployments → أحدث deployment

# 2. تحقق من vercel.json محلياً
node -e "console.log(JSON.stringify(require('./vercel.json'), null, 2))"

# 3. اختبر البناء محلياً
pnpm install && pnpm build

# 4. إذا استمر الفشل، انظر إلى:
# - رسائل الخطأ في Vercel Logs
# - حجم الذاكرة (ربما تحتاج NODE_OPTIONS)
# - التبعيات المفقودة
```

### إذا فشل الموقع بعد النشر

```bash
# 1. تحقق من outputDirectory
# يجب أن يكون صحيحاً ويحتوي على index.html

# 2. تحقق من rewrites
# يجب أن تعيد توجيه جميع المسارات إلى index.html

# 3. اختبر المتصفح
# افتح Developer Tools → Network
# تأكد من تحميل جميع الملفات
```

## نقاط التفتيش الحرجة

| نقطة | الحالة | الإجراء |
|------|--------|--------|
| ✅ vercel.json | يجب أن يكون بدون `framework` | تحقق من الملف |
| ✅ buildCommand | يجب أن يكون محدد بوضوح | اختبر محلياً |
| ✅ outputDirectory | يجب أن يشير للملفات الصحيحة | تحقق من البناء |
| ✅ SPA Routing | يجب أن يكون مفعل | تحقق من rewrites |
| ✅ Logs | يجب أن تكون خالية من الأخطاء | راقب Vercel |
| ✅ الموقع | يجب أن يكون حياً | اختبر الرابط |

## الوقت المتوقع

- قراءة هذه القائمة: 10 دقائق
- إجراء الفحوصات: 15 دقيقة
- النشر والاختبار: 10 دقائق
- **المجموع: 35 دقيقة تقريباً**

## الخطوة التالية مباشرة

```bash
# 1. تحقق من vercel.json
cat vercel.json | jq . || echo "❌ Invalid JSON"

# 2. تأكد من عدم وجود framework
grep '"framework"' vercel.json && echo "❌ Found framework" || echo "✅ No framework"

# 3. انسخ ودفع
git add vercel.json && git commit -m "fix: remove framework" && git push

# 4. راقب https://vercel.com/dashboard
```

**ملاحظة:** هذه القائمة شاملة وتغطي جميع جوانب النشر. في الواقع، قد تحتاج فقط إلى الخطوات 8-11 للنشر الفوري.
