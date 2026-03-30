# أوامر سريعة للنشر

## انسخ والصق مباشرة 👇

### الخيار 1️⃣ - الأسرع

```bash
bash deploy-now.sh
```

**مدة التنفيذ:** 3-5 دقائق  
**النتيجة:** موقع حياً على Vercel

---

### الخيار 2️⃣ - متوسط السرعة

```bash
# الكل دفعة واحدة
pnpm install --no-frozen-lockfile && pnpm build && git add -A && git commit -m "fix: radical deployment solution" && git push origin develop
```

**مدة التنفيذ:** 5-7 دقائق

---

### الخيار 3️⃣ - خطوة بخطوة

```bash
# 1️⃣ تثبيت
pnpm install --no-frozen-lockfile

# 2️⃣ بناء
pnpm build

# 3️⃣ دفع
git add -A
git commit -m "fix: radical deployment solution"
git push origin develop
```

**مدة التنفيذ:** 5-7 دقائق

---

### الخيار 4️⃣ - اختبار محلي أولاً

```bash
# 1️⃣ تثبيت
pnpm install --no-frozen-lockfile

# 2️⃣ بناء
pnpm build

# 3️⃣ خدمة محلية (اختياري)
cd apps/web
pnpm serve

# 4️⃣ دفع
cd ../..
git add -A
git commit -m "fix: radical deployment solution"
git push origin develop
```

---

## إذا حدثت مشكلة

### تنظيف كامل

```bash
# حذف وإعادة تثبيت
rm -rf node_modules pnpm-lock.yaml
pnpm install
pnpm build
```

### فحص المشروع

```bash
# تحقق من البنية
ls -la apps/web/

# تحقق من node_modules
ls -la node_modules/ | head -20

# تحقق من الإصدارات
pnpm --version
node --version
```

### تصحيح Git

```bash
# تحقق من الفرع الحالي
git branch

# تحقق من الحالة
git status

# إعادة تعيين (إذا حدث خطأ)
git reset --hard origin/develop
```

---

## مراقبة البناء

### شاهد البناء على Vercel

```
https://vercel.com/dashboard
→ اختر Secure-Chat-Project
→ شاهد Deployments
```

---

## بعد النشر الناجح

### اختبار الموقع

```bash
# افتح الموقع (استبدل URL)
open https://<your-project>.vercel.app

# أو
curl https://<your-project>.vercel.app
```

### تحقق من الرؤوس الأمنية

```bash
# افحص رؤوس الأمان
curl -I https://<your-project>.vercel.app

# يجب أن تظهر:
# - X-Content-Type-Options: nosniff
# - X-Frame-Options: SAMEORIGIN
# - Cache-Control: public, max-age=3600
```

---

## أوامر إضافية مفيدة

### البناء فقط (بدون دفع)

```bash
pnpm install --no-frozen-lockfile
pnpm build
```

### الدفع فقط (بدون بناء)

```bash
git add -A
git commit -m "your message"
git push origin develop
```

### فحص الفرع

```bash
git branch -a
git log --oneline -10
```

### إرجاع التغييرات

```bash
# إلغاء التغييرات المحلية
git checkout .

# أو إعادة تعيين كامل
git reset --hard HEAD
```

---

## ملخص

**ما عليك سوى تشغيل أمر واحد:**

```bash
bash deploy-now.sh
```

**وخلال 5 دقائق سيكون موقعك حياً!**

---

## هل تحتاج مساعدة؟

| المشكلة | الملف |
|--------|-------|
| شرح المشاكل | ROOT_CAUSE_FIX.md |
| خطوات مفصلة | START_DEPLOYMENT_NOW.md |
| حل المشاكل | TROUBLESHOOTING_DEPLOYMENT.md |
| فهرس كامل | DEPLOYMENT_INDEX.md |
