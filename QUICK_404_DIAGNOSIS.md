# دليل التشخيص السريع لخطأ 404

## قائمة المراجعة السريعة (5 دقائق)

### 1. هل vercel.json صحيح؟
```bash
# افتح الملف وتحقق من:
- buildCommand: "pnpm install && pnpm build"
- outputDirectory: "apps/web/webapp"
- rewrites موجود وصحيح
```

### 2. هل package.json يحتوي على build script؟
```json
"build": "cd apps/web && pnpm build"
```

### 3. هل config.json موجود؟
```bash
ls -la apps/web/config.json
```

### 4. هل البناء يعمل محلياً؟
```bash
pnpm install
pnpm build
# افحص: هل ظهرت رسائل خطأ؟
```

### 5. تحقق من سجلات Vercel
- اذهب إلى Vercel Dashboard
- ابحث عن Build Logs
- ابحث عن رسائل الخطأ

---

## حل سريع (3 خطوات)

```bash
# 1. تحديث الملفات الضرورية
git add vercel.json package.json apps/web/config.json

# 2. إرسال التحديثات
git commit -m "fix: 404 error configuration"
git push origin your-branch

# 3. اختبار
# زيارة الرابط المؤقت بعد 2-3 دقائق
```

---

## جدول الأعراض والحلول

| الأعراض | السبب الأرجح | الحل |
|-------|---------|-----|
| 404 على / فقط | index.html غير موجود | تحقق من outputDirectory |
| 404 على /login | rewrites غير صحيح | أضف rewrites صحيح |
| Build Failed | خطأ في build command | افحص السجلات |
| Deployment Failed | config.json مفقود | أنشئ الملف |
