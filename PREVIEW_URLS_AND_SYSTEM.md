# الروابط المؤقتة والنظام: شرح شامل

## ما هي الروابط المؤقتة (Preview URLs)?

### التعريف
الروابط المؤقتة هي عناوين URLs مؤقتة توفرها منصات التطوير (مثل Vercel و VS Code) لاختبار التطبيق بسرعة.

### المصادر الشائعة

#### 1. Vercel Preview URL
```
https://secure-chat-project-git-branch-name-m99-9-9.vercel.app/
```
**المميزات:**
- عام (يمكن للجميع الوصول)
- دائم لفترة قصيرة (24-48 ساعة)
- يُعاد إنشاؤه مع كل deployment
- يعكس آخر تغييراتك

#### 2. VS Code Local Preview
```
http://localhost:3000/
```
**المميزات:**
- محلي (أنت فقط)
- مؤقت (أثناء الجلسة)
- سريع للتطوير
- سهل للاختبار

#### 3. GitHub Actions Preview
```
https://github-artifact-preview.vercel.app/...
```

---

## كيفية عمل النظام

### التسلسل الكامل

```
┌─────────────────────────────────────────────────────────┐
│                    1. Git Push                           │
│           أنت تدفع الكود إلى GitHub                     │
└────────────────┬────────────────────────────────────────┘
                 │
                 ▼
┌─────────────────────────────────────────────────────────┐
│                 2. Vercel Webhook                        │
│           Vercel يكتشف التغييرات                         │
└────────────────┬────────────────────────────────────────┘
                 │
                 ▼
┌─────────────────────────────────────────────────────────┐
│                  3. Build Process                        │
│         - قراءة vercel.json                             │
│         - تنفيذ buildCommand                            │
│         - تجميع الملفات النهائية                        │
└────────────────┬────────────────────────────────────────┘
                 │
                 ▼
┌─────────────────────────────────────────────────────────┐
│              4. Output Generation                        │
│         نسخ المخرجات من:                                │
│         apps/web/webapp إلى CDN                         │
└────────────────┬────────────────────────────────────────┘
                 │
                 ▼
┌─────────────────────────────────────────────────────────┐
│                5. URL Creation                           │
│          إنشاء Preview URL (أو فشل)                     │
└────────────────┬────────────────────────────────────────┘
                 │
                 ▼
           ┌─────────────┐
           │ URL Ready ✓ │  أو  │ 404 Error ✗ │
           └─────────────┘       └────────────┘
```

---

## أين تحدث المشاكل؟

### نقطة الفشل 1: قراءة vercel.json
```
❌ vercel.json غير موجود
❌ outputDirectory خاطئ
❌ buildCommand خاطئ
```
**النتيجة**: البناء يفشل → لا يوجد URL

### نقطة الفشل 2: تنفيذ البناء
```
❌ npm run build غير موجود
❌ dependencies غير مثبتة
❌ webpack خطأ
```
**النتيجة**: البناء يفشل → لا يوجد URL

### نقطة الفشل 3: المخرجات
```
❌ webapp/ مجلد فارغ
❌ index.html غير موجود
❌ config.json مفقود
```
**النتيجة**: البناء ينجح لكن 404 عند الوصول

### نقطة الفشل 4: التوجيه
```
❌ rewrites غير صحيح
❌ /login تعيد 404
❌ / يعيد 404
```
**النتيجة**: بعض الصفحات تعيد 404

---

## علاقة الروابط المؤقتة بنظام الملفات

### مثال حقيقي

#### البنية المحلية:
```
project/
├── apps/
│   └── web/
│       ├── src/           ← الكود المصدري
│       ├── config.json    ← الإعدادات
│       ├── package.json   ← المكتبات
│       └── webpack.config ← إعدادات البناء
├── vercel.json            ← إعدادات Vercel
├── package.json           ← Build scripts
└── .git/
```

#### بعد البناء (محلياً):
```
project/
├── apps/
│   └── web/
│       ├── webapp/        ← المخرجات النهائية
│       │   ├── index.html
│       │   ├── js/
│       │   ├── css/
│       │   └── config.json
```

#### على CDN Vercel:
```
vercel.app/
├── index.html       (يُرجع عند /)
├── js/
├── css/
└── config.json      (يُرسل للتطبيق)
```

#### عند طلب /login:
```
1. المتصفح: GET /login
2. Vercel (rewrites): → /index.html
3. index.html يحمّل (React Router يتعامل مع /login)
4. ✓ تعمل بدون 404
```

---

## تأثير المشاكل على الرابط المؤقت

### مثال 1: outputDirectory خاطئ
```
vercel.json:
"outputDirectory": "dist"

الفعل:
- Vercel تبحث عن dist/
- ملفات البناء في webapp/
- CDN فارغ → 404

الحل:
"outputDirectory": "apps/web/webapp"
```

### مثال 2: config.json مفقود
```
البناء:
✓ index.html موجود
✓ js/css جاهزة

الوصول:
- المتصفح يحمّل index.html ✓
- JavaScript يبحث عن config.json ✗
- التطبيق لا يعمل → 404 في الـ API

الحل:
cp apps/web/config.sample.json apps/web/config.json
```

### مثال 3: rewrites خاطئ
```
بدون rewrites:
- GET / → index.html ✓
- GET /login → 404 ✗ (ملف /login.html غير موجود)

مع rewrites صحيح:
- GET / → index.html ✓
- GET /login → index.html (React Router يتعامل) ✓
```

---

## أفضل الممارسات

### 1. فهم تدفق الروابط المؤقتة
```
Git Push → Vercel Build → URL Created → Test
```

### 2. مراجعة الإعدادات قبل كل Push
```bash
# تحقق من:
✓ vercel.json صحيح
✓ package.json build script موجود
✓ config.json موجود
✓ ./apps/web/webapp/ سيُنشأ من البناء
```

### 3. اختبار محلياً أولاً
```bash
pnpm install
pnpm build
# تحقق من: ls apps/web/webapp/
```

### 4. مراقبة سجلات البناء
```
أثناء الانتظار:
1. Vercel Dashboard → Deployments
2. افتح آخر deployment
3. اقرأ Build Logs بعناية
```

### 5. التفريق بين الأخطاء
```
Build Error:     ❌ Deployment Failed
                 → مشكلة في الكود أو config

404 After Build: ✓ Deployment Successful
                 ❌ 404 Not Found
                 → مشكلة في vercel.json أو rewrites
```

---

## الخلاصة

الرابط المؤقت هو انعكاس مباشر لنظام الملفات والإعدادات:
- إذا كان vercel.json خاطئ → لا يوجد URL
- إذا كان البناء خاطئ → URL لكن 404
- إذا كانت الملفات خاطئة → URL لكن 404
- إذا كانت rewrites خاطئة → 404 على المسارات

**النتيجة**: اختبار الروابط المؤقتة دائماً يساعد على اكتشاف مشاكل الإعدادات مبكراً.
