# دليل نشر Secure-Chat-Project على Vercel

## الملفات المضافة

تم إضافة الملفات التالية لضمان نشر صحيح على Vercel:

1. **vercel.json** - إعدادات البناء والنشر
2. **apps/web/config.json** - ملف الإعدادات الأساسي للتطبيق
3. **.vercelignore** - ملفات تجاهلها عند البناء

---

## خطوات النشر على Vercel

### 1. الربط الأولي (First Time Setup)

إذا لم تكن قد ربطت المشروع بـ Vercel بعد:

```bash
# قم بتسجيل الدخول إلى Vercel
vercel login

# انشر المشروع
vercel --prod
```

### 2. إعدادات Dashboard (Vercel Console)

عند نشر المشروع لأول مرة أو عند تحديث الإعدادات:

1. **اذهب إلى**: https://vercel.com/dashboard
2. **حدد المشروع**: Secure-Chat-Project
3. **انقر على**: Settings
4. **انتقل إلى**: Build & Development Settings

#### أ) Build Settings

```
Framework Preset:        Other
Build Command:           (ترك فارغ - يستخدم من vercel.json)
Output Directory:        (ترك فارغ - يستخدم من vercel.json)
Install Command:         pnpm install --frozen-lockfile
```

#### ب) Environment Variables

لا توجد متغيرات بيئة مطلوبة حالياً، لكن إذا أضفت خوادم مصادقة مخصصة:

```
VITE_SYNAPSE_SERVER_URL=https://your-synapse-server.com
```

#### ج) Git Settings

```
Production Branch:       main (أو develop حسب احتياجك)
Preview Deployments:     Enabled
```

### 3. الإعدادات المطبقة في vercel.json

```json
{
  "buildCommand": "cd apps/web && pnpm install && pnpm build",
  "outputDirectory": "apps/web/webapp",
  "framework": "other",
  "rewrites": [
    {
      "source": "/:path*",
      "destination": "/index.html"
    }
  ]
}
```

**التفسير:**
- **buildCommand**: يدخل إلى مجلد apps/web ويقوم بتثبيت الحزم والبناء
- **outputDirectory**: يخبر Vercel أن الملفات النهائية في `apps/web/webapp`
- **rewrites**: يعيد التوجيه لـ index.html (ضروري للـ SPA)

### 4. التحقق من النشر

بعد الضغط على Deploy:

1. **انتظر اكتمال البناء** (قد يستغرق 5-10 دقائق أول مرة)
2. **تحقق من السجل**:
   - انقر على Deployments
   - ابحث عن الخطأ في Build Logs إن وجد
3. **زيارة الموقع**:
   - سيكون الرابط في صيغة: `https://secure-chat-project-xxxxx.vercel.app`

### 5. حل المشاكل الشائعة

#### خطأ: "404 - Not Found"

**السبب**: الملفات الثابتة لم تُبنَ بشكل صحيح

**الحل**:
1. تأكد أن `outputDirectory` في vercel.json هو `apps/web/webapp`
2. تأكد من وجود ملف `config.json` في `apps/web/`
3. أعد بناء المشروع محلياً:
   ```bash
   cd apps/web
   pnpm install
   pnpm build
   ```

#### خطأ: "Failed to install dependencies"

**السبب**: مشكلة في تثبيت pnpm

**الحل**:
1. تأكد من وجود `.npmrc` في جذر المشروع
2. أضف إلى `.npmrc`:
   ```
   shamefully-hoist=true
   strict-peer-dependencies=false
   ```

#### التطبيق يفتح لكن يظهر شاشة بيضاء

**السبب**: المتغيرات البيئية أو الإعدادات مفقودة

**الحل**:
1. افتح الكونسول (F12)
2. تحقق من الأخطاء
3. تأكد من أن `config.json` يحتوي على إعدادات صحيحة

---

## ملاحظات تم إضافتها

### ملف vercel.json

يحتوي على:
- أوامر بناء صحيحة
- مجلد المخرجات الصحيح
- إعادة توجيه SPA
- رؤوس الأمان (Security Headers)
- قوائم إعادة الكتابة (Rewrites)

### ملف config.json

- نسخة من `config.sample.json`
- معدلة باسم تطبيق مخصص
- تحتوي على إعدادات الخادم الافتراضي

### ملف .vercelignore

- يتجاهل الملفات غير الضرورية
- يسرع البناء
- يقلل حجم الـ deployment

---

## أوامر مفيدة

```bash
# بناء محلي للاختبار
cd apps/web
pnpm build
pnpm preview

# نشر مباشر إلى Vercel
vercel --prod

# نشر كـ Preview
vercel

# عرض سجل النشر
vercel logs
```

---

## إعدادات إضافية اختيارية

### إضافة Domain مخصص

1. في Vercel Dashboard
2. انتقل إلى Settings → Domains
3. أضف النطاق الخاص بك
4. اتبع خطوات التحقق

### إضافة متغيرات بيئية

في Vercel Dashboard:
1. Settings → Environment Variables
2. أضف المتغيرات:
   ```
   VITE_API_BASE_URL=your-api-url
   ```

### تفعيل Analytics

في Vercel Dashboard:
1. Settings → Analytics
2. انقر على Enable

---

## الحالة النهائية

✅ تم إعداد جميع الملفات اللازمة  
✅ الإعدادات متوافقة مع Element Web  
✅ جاهز للنشر على Vercel  

**التالي**: الضغط على Deploy وسيظهر الواجهة العنابية 🎉
