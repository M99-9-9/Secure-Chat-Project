# أوامر جاهزة للنشر الفوري

## الخيار 1: الأمر الواحد الفوري (الأسرع)

```bash
git add vercel.json && git commit -m "fix: remove framework property from vercel.json for Vercel compliance" && git push origin develop
```

**المدة:** 30 ثانية
**النتيجة:** النشر يبدأ فوراً على Vercel

---

## الخيار 2: أوامر منفصلة (للتحقق)

```bash
# الخطوة 1: التحقق من الحالة الحالية
echo "=== Checking vercel.json ==="
cat vercel.json | jq '.' && echo "✅ JSON is valid"

# الخطوة 2: التحقق من عدم وجود framework
echo "=== Checking for framework property ==="
grep '"framework"' vercel.json && echo "❌ Found framework (needs removal)" || echo "✅ No framework property"

# الخطوة 3: عرض الملف الحالي
echo "=== Current vercel.json ==="
head -15 vercel.json

# الخطوة 4: دفع التغييرات
echo "=== Pushing changes ==="
git add vercel.json
git commit -m "fix: remove invalid framework property from vercel.json"
git push origin develop

echo "=== Done! ==="
echo "✅ Changes pushed successfully"
echo "⏱️ Build will start on Vercel (5 minutes)"
```

---

## الخيار 3: مع المراقبة التفصيلية

```bash
#!/bin/bash

echo "🚀 Vault Deployment Script"
echo "=========================="

# الخطوة 1: التحقق من المتطلبات
echo "📋 Step 1: Checking prerequisites..."
if ! command -v git &> /dev/null; then
    echo "❌ Git is not installed"
    exit 1
fi
echo "✅ Git found"

# الخطوة 2: التحقق من الحالة الحالية
echo "📋 Step 2: Checking current status..."
if [ ! -f "vercel.json" ]; then
    echo "❌ vercel.json not found"
    exit 1
fi
echo "✅ vercel.json found"

# الخطوة 3: التحقق من JSON صيغة
echo "📋 Step 3: Validating JSON syntax..."
if ! jq '.' vercel.json > /dev/null 2>&1; then
    echo "❌ Invalid JSON syntax"
    exit 1
fi
echo "✅ JSON syntax is valid"

# الخطوة 4: التحقق من عدم وجود framework
echo "📋 Step 4: Checking for framework property..."
if grep -q '"framework"' vercel.json; then
    echo "⚠️ WARNING: framework property found (this should be removed)"
    echo "Current value:"
    grep '"framework"' vercel.json
else
    echo "✅ No framework property (correct)"
fi

# الخطوة 5: عرض آخر 20 سطر من الملف
echo "📋 Step 5: Displaying vercel.json content..."
echo "Last 20 lines of vercel.json:"
tail -20 vercel.json

# الخطوة 6: عرض حالة Git
echo "📋 Step 6: Checking Git status..."
git status --short vercel.json || echo "✅ No changes detected"

# الخطوة 7: الدفع
echo "📋 Step 7: Committing and pushing changes..."
git add vercel.json
git commit -m "fix: remove invalid framework property from vercel.json

- Removed 'framework: \"other\"' property which is not supported by Vercel
- Vercel will auto-detect framework type from build configuration
- Complies with current Vercel JSON schema validation
- This change resolves deployment failures"

if [ $? -eq 0 ]; then
    echo "✅ Commit created successfully"
else
    echo "ℹ️ No changes to commit (already up to date)"
fi

# الخطوة 8: الدفع إلى المستودع
echo "📋 Step 8: Pushing to repository..."
git push origin develop

if [ $? -eq 0 ]; then
    echo "✅ Changes pushed successfully"
    echo ""
    echo "🎉 Deployment started!"
    echo "📍 Monitor at: https://vercel.com/dashboard"
    echo "⏱️ Build time: ~5 minutes"
else
    echo "❌ Failed to push changes"
    exit 1
fi

echo ""
echo "✅ Script completed successfully!"
```

---

## الخيار 4: مع تنبيهات Slack (إذا كان متاحاً)

```bash
#!/bin/bash

SLACK_WEBHOOK="https://hooks.slack.com/services/YOUR/WEBHOOK/URL"

# أرسل تنبيه البدء
curl -X POST -H 'Content-type: application/json' \
    --data '{"text":"🚀 Starting Vault deployment to Vercel..."}' \
    $SLACK_WEBHOOK

# تنفيذ النشر
git add vercel.json && \
git commit -m "fix: remove framework property" && \
git push origin develop

# أرسل تنبيه النجاح
if [ $? -eq 0 ]; then
    curl -X POST -H 'Content-type: application/json' \
        --data '{"text":"✅ Vault deployment started! Check Vercel dashboard for build status."}' \
        $SLACK_WEBHOOK
else
    curl -X POST -H 'Content-type: application/json' \
        --data '{"text":"❌ Vault deployment failed. Please check logs."}' \
        $SLACK_WEBHOOK
fi
```

---

## الخيار 5: للمستخدمين بدون Git (استخدام Vercel CLI)

```bash
# تثبيت Vercel CLI (إذا لم يكن مثبتاً)
npm i -g vercel

# تسجيل الدخول
vercel login

# ربط المشروع
vercel link

# النشر المباشر
vercel deploy --prod

# أو النشر مع preview
vercel deploy
```

---

## سيناريوهات مختلفة

### إذا كنت في الجذر

```bash
git add vercel.json && git commit -m "fix: remove framework property" && git push
```

### إذا كنت في مجلد مختلف

```bash
cd /path/to/project
git add vercel.json && git commit -m "fix: remove framework property" && git push origin develop
```

### إذا أردت التحقق قبل الدفع

```bash
# فقط أضف التغييرات
git add vercel.json

# اعرض الفروقات
git diff --cached vercel.json

# إذا بدت جيدة، اعمل commit
git commit -m "fix: remove framework property"

# إذا لم تبد جيدة، أعد التغييرات
git reset HEAD vercel.json
```

---

## خطوات ما بعد الدفع

### 1. راقب البناء

```bash
# في Terminal
echo "⏳ Waiting for build to complete..."
while ! curl -s https://vercel.com/dashboard | grep -q "Deployed"; do
  sleep 10
done
echo "✅ Build complete!"
```

### أو افتح Dashboard يدويا

https://vercel.com/dashboard

### 2. اختبر الموقع

```bash
# انتظر 5-10 دقائق ثم افتح الموقع
# https://vault-xxxx.vercel.app

# أو اختبر من Terminal
curl -I https://vault-xxxx.vercel.app
```

### 3. تحقق من عدم وجود أخطاء

```bash
# انظر في Vercel logs
# ابحث عن:
# ✅ "Build successful"
# ✅ "Deployment successful"
# ❌ لا توجد أخطاء framework
```

---

## أوامر مفيدة

### التحقق من التكوين الحالي

```bash
# عرض جميع الخصائص
cat vercel.json | jq '.'

# عرض خاصية واحدة فقط
cat vercel.json | jq '.buildCommand'

# البحث عن framework
grep framework vercel.json
```

### التراجع إذا حدث خطأ

```bash
# التراجع عن الـ commit الأخير
git reset --soft HEAD~1

# أو
git revert HEAD
```

### معرفة الفرع الحالي

```bash
git branch
# يجب أن ترى * develop أو * main
```

---

## نصائح مهمة

1. **تأكد من الفرع الصحيح**
   ```bash
   git branch  # يجب أن تكون على develop
   ```

2. **تأكد من عدم وجود تغييرات معلقة**
   ```bash
   git status  # يجب أن تكون النتيجة "working tree clean"
   ```

3. **استخدم رسالة commit واضحة**
   ```bash
   # ✅ جيد
   git commit -m "fix: remove framework property from vercel.json"
   
   # ❌ سيء
   git commit -m "fix"
   ```

4. **تحقق من الدفع**
   ```bash
   git log --oneline -5  # يجب أن ترى الـ commit الأخير
   ```

---

## الوقت المتوقع

| الخطوة | المدة |
|------|------|
| تشغيل الأمر | < 1 دقيقة |
| دفع التغييرات | < 2 دقيقة |
| بدء البناء على Vercel | < 1 دقيقة |
| اكتمال البناء | 3-7 دقائق |
| **المجموع** | **5-10 دقائق** |

---

## الخلاصة

```
الأمر الأساسي (أنسخ والصق مباشرة):

git add vercel.json && git commit -m "fix: remove framework property" && git push origin develop
```

**بعد 5 دقائق: موقعك سيكون حياً!** 🚀
