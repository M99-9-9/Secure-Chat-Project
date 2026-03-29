# دليل الاختبار المحلي لمنصة الاتصالات الآمنة

## مقدمة
هذا الدليل يساعدك على اختبار التطبيق محليّاً قبل النشر على Vercel.

---

## 1. المتطلبات

### النظام المطلوبة
- Node.js >= 22.18
- pnpm >= 10.32.1
- Git (مثبت)
- 4GB+ RAM
- 5GB+ مساحة حرة على الجهاز

### أدوات اختياري
- Visual Studio Code
- Browser DevTools
- Postman (لاختبار API)

---

## 2. الإعداد المحلي

### الخطوة 1: استنساخ المستودع
```bash
git clone https://github.com/M99-9-9/Secure-Chat-Project.git
cd Secure-Chat-Project
```

### الخطوة 2: تبديل للفرع الصحيح
```bash
# عرض جميع الفروع
git branch -a

# الانتقال للفرع المطلوب
git checkout develop

# أو للفرع الحالي إذا كنت في الفرع بالفعل
git checkout -b your-feature-branch
```

### الخطوة 3: تثبيت الاعتماديات
```bash
# تثبيت جميع الاعتماديات
pnpm install

# أو إعادة تثبيت (إذا حدثت مشاكل)
pnpm install --frozen-lockfile

# التحقق من التثبيت
pnpm -v
node -v
```

### الخطوة 4: إعداد متغيرات البيئة
```bash
# في مجلد المشروع الجذر، أنشئ ملف:
cd apps/web
cp config.sample.json config.local.json

# عدّل config.local.json إذا لزم الحال
# أو استخدم القيم الافتراضية كما هي
```

---

## 3. تشغيل التطبيق محليّاً

### الخيار أ: تشغيل في وضع التطوير (Development)
```bash
# من مجلد المشروع الجذر
pnpm start

# أو من مجلد apps/web مباشرة
cd apps/web
pnpm start
```

**النتيجة:**
- سيفتح الملقم على `http://localhost:8080`
- Hot Module Replacement مفعّل
- التغييرات تظهر فوراً بدون إعادة تحميل

**استخدم:**
```bash
# فتح المتصفح تلقائياً
pnpm start

# أو افتح يدوياً
# http://localhost:8080
```

### الخيار ب: بناء الإنتاج والاختبار (Production Build)
```bash
# من مجلد المشروع الجذر
pnpm build

# التحقق من البناء
ls -la apps/web/webapp

# تشغيل خادم محلي (يتطلب بايثون 3)
cd apps/web/webapp
python3 -m http.server 8000

# أو استخدم Node.js
npm install -g http-server
http-server

# افتح في المتصفح
# http://localhost:8000
```

---

## 4. قائمة الاختبار الشاملة

### أ) الاختبارات الأساسية
- [ ] يفتح التطبيق بدون أخطاء
- [ ] يظهر شاشة تسجيل الدخول
- [ ] لا توجد أخطاء في DevTools Console
- [ ] الواجهة تظهر بشكل صحيح

### ب) اختبارات المصادقة
- [ ] إمكانية تسجيل حساب جديد
- [ ] إمكانية تسجيل الدخول
- [ ] إمكانية تسجيل الخروج
- [ ] الجلسات تُحفظ بشكل صحيح
- [ ] إعادة التحميل تحافظ على الجلسة

### ج) اختبارات الدردشة
- [ ] إنشاء غرفة جديدة
- [ ] الانضمام إلى غرفة موجودة
- [ ] إرسال رسالة نصية
- [ ] استقبال الرسائل
- [ ] حذف الرسائل

### د) اختبارات التشفير
- [ ] الرسائل مشفرة end-to-end
- [ ] فك التشفير يعمل بشكل صحيح
- [ ] الملفات المشفرة تُفك بشكل صحيح

### هـ) اختبارات الملفات
- [ ] رفع الملفات
- [ ] تحميل الملفات
- [ ] عرض المعاينات
- [ ] مشاركة الملفات

### و) اختبارات الملاحة
- [ ] الروابط الداخلية تعمل
- [ ] عدم وجود أخطاء 404
- [ ] التصفح بالأمام والخلف يعمل
- [ ] الإشارات المرجعية تعمل

### ز) اختبارات الأداء
- [ ] الصفحة تحمّل بسرعة (< 3 ثانية)
- [ ] عدم وجود تأخير في الاستجابة
- [ ] الرسوم البيانية سلسة
- [ ] لا توجد أخطاء في الذاكرة

### ح) اختبارات المتصفحات المختلفة
- [ ] Chrome
- [ ] Firefox
- [ ] Safari
- [ ] Edge

### ط) اختبارات الأجهزة المختلفة
- [ ] سطح المكتب
- [ ] تابلت
- [ ] الهاتف الذكي

---

## 5. استخدام DevTools

### فتح DevTools
```
Windows/Linux: F12 أو Ctrl+Shift+I
Mac: Cmd+Option+I
```

### فحوصات مهمة

#### Network Tab
```bash
# تحقق من:
- حجم الملفات المحملة
- سرعة التحميل
- عدم وجود أخطاء HTTP 404 أو 500
- استخدام HTTP/2 أو أحدث
```

#### Console Tab
```bash
# ابحث عن:
- أخطاء JavaScript
- تحذيرات الأمان
- رسائل تصحيح

# لا يجب أن تشاهد:
- أخطاء غير معالجة
- تحذيرات مهمة
```

#### Performance Tab
```bash
# اختبر السرعة:
- ابدأ التسجيل (F12 → Performance → Record)
- افعل عملية في التطبيق
- توقف التسجيل
- حلل النتائج
```

#### Application Tab
```bash
# تحقق من:
- LocalStorage والبيانات المخزنة
- Cookies والجلسات
- Service Workers (إن وجدت)
- Cache Storage
```

---

## 6. تشغيل الاختبارات الآلية

### اختبارات الوحدة
```bash
# من مجلد المشروع الجذر
pnpm test

# مع تغطية الكود (Coverage)
pnpm coverage

# مراقبة الاختبارات (تعيد التشغيل تلقائياً)
pnpm test --watch
```

### اختبارات Playwright
```bash
# تشغيل جميع الاختبارات
pnpm test:playwright

# تشغيل بواجهة رسومية
pnpm test:playwright:open

# تشغيل اختبار واحد
pnpm test:playwright -- --grep "specific-test-name"

# تحديث لقطات الشاشات
pnpm test:playwright:screenshots
```

---

## 7. تصحيح الأخطاء (Debugging)

### طريقة 1: استخدام console.log
```javascript
console.log("[v0] User data:", userData)
console.log("[v0] API response:", response)
console.error("[v0] Error occurred:", error)
```

### طريقة 2: استخدام DevTools Debugger
```javascript
// في الكود
debugger; // سيتوقف هنا عند فتح DevTools

// أو انقر على رقم السطر في DevTools
// لإضافة breakpoint
```

### طريقة 3: استخدام VS Code Debugger
```json
// في .vscode/launch.json
{
  "version": "0.2.0",
  "configurations": [
    {
      "type": "chrome",
      "request": "launch",
      "name": "Launch Chrome against localhost",
      "url": "http://localhost:8080",
      "webRoot": "${workspaceFolder}/apps/web/src"
    }
  ]
}
```

---

## 8. اختبار نمط الإنتاج محلياً

### محاكاة بيئة Vercel محلياً
```bash
# تثبيت Vercel CLI
npm install -g vercel

# اختبار محلي قبل الدفع
vercel dev

# أو بدون تثبيت Vercel:
cd apps/web/webapp
python3 -m http.server 3000
```

### اختبار الأداء
```bash
# باستخدام Lighthouse CLI
npm install -g lighthouse

lighthouse http://localhost:3000 --view

# أو من DevTools
# F12 → Lighthouse → Analyze page load
```

---

## 9. الأوامر المهمة

```bash
# البناء والاختبار
pnpm build          # بناء المشروع
pnpm start          # تشغيل في وضع التطوير
pnpm test           # تشغيل الاختبارات
pnpm test:playwright  # اختبارات Playwright
pnpm lint           # التحقق من جودة الكود
pnpm lint:js-fix    # إصلاح تلقائي

# الأدوات المساعدة
pnpm i18n           # تحديث الترجمات
pnpm coverage       # تقرير التغطية
pnpm analyse:webpack-bundles  # تحليل الحزم

# التنظيف
pnpm clean          # حذف مجلدات البناء
rm -rf node_modules pnpm-lock.yaml  # حذف شامل
```

---

## 10. حل المشاكل الشائعة

### مشكلة: "command not found: pnpm"
```bash
# الحل: تثبيت pnpm
npm install -g pnpm@10.32.1
```

### مشكلة: "Port 8080 already in use"
```bash
# الحل: استخدام منفذ مختلف
pnpm start -- --port 3000
```

### مشكلة: "Module not found"
```bash
# الحل: إعادة تثبيت الاعتماديات
rm -rf node_modules pnpm-lock.yaml
pnpm install
```

### مشكلة: "Build fails"
```bash
# الحل: فحص الأخطاء بالتفصيل
pnpm build 2>&1 | tee build.log
# اقرأ الملف build.log وابحث عن الخطأ
```

### مشكلة: "Memory limit exceeded"
```bash
# الحل: زيادة حد الذاكرة للـ Node.js
NODE_OPTIONS=--max_old_space_size=4096 pnpm build
```

---

## 11. قائمة التحقق قبل الدفع

- [ ] قمت بتشغيل التطبيق محلياً بنجاح
- [ ] جميع الاختبارات تمر بدون أخطاء
- [ ] لا توجد تحذيرات في DevTools Console
- [ ] الأداء مرضي (LCP < 3s)
- [ ] اختبرت في متصفحات مختلفة
- [ ] اختبرت على أجهزة مختلفة
- [ ] الميزات الأساسية تعمل
- [ ] لا توجد أخطاء تشفير
- [ ] السجلات نظيفة (no console errors)

---

## 12. الخطوة التالية

بعد اجتياز جميع الاختبارات المحلية:

```bash
# 1. أضف التغييرات
git add .

# 2. قم بـ commit
git commit -m "test: local testing completed and all checks passed"

# 3. ادفع إلى GitHub
git push origin your-branch-name

# 4. انتظر بناء Vercel
# افتح https://vercel.com/dashboard وراقب البناء
```

---

## الموارد الإضافية

- [Webpack Documentation](https://webpack.js.org/)
- [React Testing Library](https://testing-library.com/docs/react-testing-library/intro/)
- [Playwright Documentation](https://playwright.dev/)
- [DevTools Guide](https://developer.chrome.com/docs/devtools/)

---

**آخر تحديث:** 2026-03-29
