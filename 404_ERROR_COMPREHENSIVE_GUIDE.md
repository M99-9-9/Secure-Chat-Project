# دليل شامل: مشكلة خطأ 404 والروابط المؤقتة في Visual Studio Code

## 📋 نظرة عامة على المشكلة

عند محاولة فتح تطبيق Element Web عبر الرابط المؤقت (Preview URL) المُوفّر من Visual Studio Code أو بيئة Vercel، قد يواجه المستخدم **رسالة خطأ 404 - Not Found**. هذا الخطأ يشير إلى أن السيرفر لم يتمكن من العثور على المورد المطلوب.

---

## 🔴 تحليل تفصيلي لرسالة الخطأ 404

### ما هي رسالة 404؟

رسالة الخطأ **404 Not Found** هي استجابة HTTP تشير إلى:
- المورد (الملف أو الصفحة) المطلوب غير موجود على الخادم
- المسار أو الـ URL غير صحيح أو تم تعديله
- الخادم لم يستقبل طلب البحث بشكل صحيح

### محتوى رسالة الخطأ النموذجية:

```
404 Not Found

The requested URL /index.html was not found on this server.
```

أو في بعض الحالات:

```
Cannot GET /
```

أو مع تفاصيل أكثر:

```
404 | Not Found
The page you are looking for could not be found.

Request URL: http://localhost:3000/
```

---

## 🔍 الأسباب المحتملة للخطأ

### 1. **خطأ في إعدادات المخرجات (Output Directory)**
- **المشكلة**: Vercel لا تعرف أين توجد ملفات البناء النهائية
- **السبب**: لم يتم تحديد `outputDirectory` في `vercel.json` بشكل صحيح
- **الحل**: تأكد من أن المسار يشير إلى `apps/web/webapp`

### 2. **عدم وجود ملف index.html**
- **المشكلة**: المجلد المحدد كـ output directory فارغ أو لا يحتوي على index.html
- **السبب**: 
  - البناء لم يتم بنجاح
  - المخرجات في مسار مختلف
  - ملفات البناء لم تُنسخ إلى المكان الصحيح
- **الحل**: تحقق من أن أوامر البناء صحيحة

### 3. **عدم وجود ملف config.json**
- **المشكلة**: تطبيق Element Web يحتاج إلى ملف إعدادات
- **السبب**: ملف config.json غير موجود أو في مسار خاطئ
- **الحل**: تأكد من وجود الملف في `apps/web/config.json`

### 4. **عدم تصحيح الروابط (Rewrites)**
- **المشكلة**: الطلبات على المسارات الفرعية لا يتم توجيهها إلى index.html
- **السبب**: إعدادات rewrites في vercel.json غير صحيحة
- **الحل**: تأكد من وجود rewrites للـ SPA routing

### 5. **مشكلة في أوامر البناء**
- **المشكلة**: أوامر البناء في package.json تخرج بأخطاء
- **السبب**:
  - Dependencies غير مثبتة
  - نسخة pnpm غير متوافقة
  - خطأ في webpack أو build tool
- **الحل**: تحقق من سجلات البناء على Vercel

---

## 🌐 السياق والاستخدام المقصود

### متى تظهر المشكلة؟

#### **1. عند فتح الرابط المؤقت الأول مرة:**
```
الرابط: https://secure-chat-project-wjkd1234.vercel.app/
النتيجة: 404 Not Found
```

#### **2. عند ملء البيانات والانتقال بين الصفحات:**
```
الرابط: https://secure-chat-project-wjkd1234.vercel.app/login
النتيجة: 404 Not Found
```

#### **3. عند تحديث الصفحة (F5):**
```
الرابط: https://secure-chat-project-wjkd1234.vercel.app/settings
النتيجة: 404 Not Found
```

### السيناريوهات الشائعة:

| السيناريو | المظهر | السبب |
|---------|-------|------|
| **البناء الأول** | 404 عند فتح الرابط | البناء لم يكتمل بعد |
| **بعد التغييرات** | 404 بعد git push | أوامر البناء خاطئة |
| **أثناء التطوير** | 404 على جميع المسارات | مشكلة في rewrites |
| **بعد تحديث الملفات** | 404 عشوائي | مشكلة في caching |

---

## 🔧 كيفية التعامل مع المشكلة

### الخطوة 1: فهم مصدر الرابط المؤقت

**ما هو الرابط المؤقت (Preview URL)?**
- رابط مؤقت يُنشئه Vercel أو Visual Studio Code
- يستمر لفترة محدودة (عادة 24-48 ساعة)
- يُستخدم للاختبار السريع قبل الإطلاق النهائي
- يمكن أن يتغير مع كل deployment

**مثال على الروابط:**
```
من Vercel:
https://secure-chat-project-git-branch-name-m99-9-9.vercel.app/

من Visual Studio Code Preview:
http://localhost:3000/  (محلي)
```

### الخطوة 2: التحقق من الإعدادات

#### **تحقق من vercel.json:**

```json
{
  "version": 2,
  "buildCommand": "pnpm install && pnpm build",
  "outputDirectory": "apps/web/webapp",
  "public": true,
  "cleanUrls": true,
  "rewrites": [
    {
      "source": "/(.*)",
      "destination": "/index.html"
    }
  ]
}
```

**النقاط الحرجة:**
- ✅ `buildCommand` يجب أن ينتقل إلى المجلد الصحيح
- ✅ `outputDirectory` يجب أن يشير إلى مخرجات البناء
- ✅ `rewrites` يجب أن يوجه جميع الطلبات إلى index.html

#### **تحقق من package.json:**

```json
{
  "scripts": {
    "build": "cd apps/web && pnpm build",
    "start": "cd apps/web && pnpm start"
  }
}
```

### الخطوة 3: فحص السجلات (Logs)

#### **على لوحة تحكم Vercel:**
1. اذهب إلى Deployments
2. انقر على آخر deployment
3. ابحث عن Build Logs
4. ابحث عن رسائل الخطأ مثل:
   - `Command "npm run build" exited with 1`
   - `ENOENT: no such file or directory`
   - `Module not found`

#### **في VS Code Terminal:**
```bash
# تشغيل البناء محلياً لاختبار
pnpm install
pnpm build

# التحقق من وجود المخرجات
ls -la apps/web/webapp/
```

### الخطوة 4: إعادة البناء واختبار

#### **الخيار 1: إعادة البناء عبر Vercel Dashboard**
```
1. اذهب إلى Deployments
2. انقر على ... (ثلاث نقاط)
3. اختر "Redeploy"
4. انتظر انتهاء البناء
```

#### **الخيار 2: الدفع مع تغيير طفيف**
```bash
git commit --allow-empty -m "chore: trigger rebuild"
git push origin your-branch
```

---

## ⚙️ مراجعة إعدادات الروابط والنظام

### إعدادات Vercel الحرجة

**في Vercel Dashboard:**

1. **Framework Preset**: `Other`
2. **Build Command**: `pnpm install && pnpm build`
3. **Output Directory**: `apps/web/webapp`
4. **Install Command**: `pnpm install`
5. **Node Version**: `18` أو أعلى

### إعدادات ملف vercel.json المهمة

```json
{
  "version": 2,                    // أحدث إصدار
  "buildCommand": "...",          // أوامر البناء
  "outputDirectory": "...",       // مجلد المخرجات
  "cleanUrls": true,              // تنظيف الـ URLs
  "rewrites": [                   // إعادة التوجيه
    {
      "source": "/(.*)",
      "destination": "/index.html"
    }
  ]
}
```

### إعدادات package.json الضرورية

```json
{
  "scripts": {
    "build": "cd apps/web && pnpm build",
    "start": "cd apps/web && pnpm start",
    "dev": "cd apps/web && pnpm dev"
  }
}
```

---

## 🛡️ تجنب المشاكل المتكررة

### قائمة المراجعة قبل الدفع

- [ ] التحقق من عدم وجود أخطاء في `npm run build` محلياً
- [ ] التأكد من وجود `config.json` في `apps/web/`
- [ ] فحص ملف `vercel.json` للتأكد من الإعدادات الصحيحة
- [ ] التحقق من أن `outputDirectory` يشير إلى المكان الصحيح
- [ ] اختبار الـ SPA routing (الانتقال بين المسارات)
- [ ] فحص سجلات البناء على Vercel Dashboard
- [ ] اختبار الرابط المؤقت بعد اكتمال البناء

### نصائح للحفاظ على الاستقرار

1. **استخدم نفس أدوات البناء محلياً وعلى Vercel:**
   ```bash
   # تثبيت pnpm إن لم تكن مثبتة
   npm install -g pnpm@10
   ```

2. **تجنب تعديل المسارات بدون التحديث في vercel.json:**
   - إذا نقلت مخرجات البناء، حدّث `outputDirectory`

3. **استخدم نفس النسخ من المكتبات:**
   - حافظ على `pnpm-lock.yaml` محدثة
   - تجنب `npm install` مع `pnpm`

4. **راقب سجلات البناء دائماً:**
   - كل deployment جديد قد يحتوي على تحذيرات
   - اعالج التحذيرات قبل أن تصبح أخطاء

---

## 📊 المقارنة: الحالة قبل وبعد الحل

### قبل الحل:
```
Deployment Status: FAILED
Build Error: Command "npm run build" exited with 1
Preview URL: ❌ 404 Not Found
```

### بعد الحل:
```
Deployment Status: READY
Build Success: ✓ Completed
Preview URL: ✅ https://...vercel.app/ (Working)
```

---

## 🔄 الخطوات التفصيلية للحل النهائي

### 1. تحديث vercel.json
```json
{
  "version": 2,
  "buildCommand": "pnpm install && pnpm build",
  "outputDirectory": "apps/web/webapp",
  "public": true,
  "cleanUrls": true,
  "rewrites": [
    {
      "source": "/(.*)",
      "destination": "/index.html"
    }
  ]
}
```

### 2. تحديث package.json الرئيسي
```json
{
  "scripts": {
    "build": "cd apps/web && pnpm build",
    "start": "cd apps/web && pnpm start"
  }
}
```

### 3. إضافة config.json
```bash
# نسخ config.sample.json إلى config.json
cp apps/web/config.sample.json apps/web/config.json
```

### 4. الدفع والانتظار
```bash
git add .
git commit -m "fix: resolve 404 error by fixing build configuration"
git push origin your-branch
```

### 5. المراقبة
- اذهب إلى Vercel Dashboard
- انتظر حتى `READY` ✓
- اختبر الرابط المؤقت

---

## ✅ الخلاصة

**الرسالة الأساسية**: مشكلة 404 عند فتح الروابط المؤقتة تُشير غالباً إلى **مشكلة في إعدادات البناء أو التوجيه**.

**الحل الأساسي**:
1. تأكد من صحة `vercel.json`
2. تأكد من صحة `package.json` scripts
3. تأكد من وجود `config.json`
4. راقب سجلات البناء
5. اختبر بعد انتهاء الـ Deployment

**النتيجة المتوقعة**: رابط مؤقت عامل وموقع يستجيب لجميع المسارات بدون 404.
