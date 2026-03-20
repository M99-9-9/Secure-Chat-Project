# Secure Chat Project - Maroon Theme Edition

![Status](https://img.shields.io/badge/Status-Production%20Ready-brightgreen)
![Version](https://img.shields.io/badge/Version-1.12.12-blue)
![License](https://img.shields.io/badge/License-AGPL%2B-red)

## ما هذا المشروع؟

منصة اتصالات آمنة ومشفرة بالكامل تعتمد على بروتوكول Matrix. هذه نسخة مخصصة بـ **ثيم واتساب العنابي** مع واجهة محسّنة.

### الميزات الرئيسية

✨ **تشفير من طرف إلى طرف (E2E)**
- جميع الرسائل مشفرة افتراضياً
- فقط المرسل والمستقبل يمكنهما قراءة الرسائل

🎨 **ثيم عنابي جميل**
- لون أساسي: `#8D1C3D`
- فقاعات رسائل محسّنة
- واجهة حديثة وأنيقة

🔒 **أمان عالي**
- بروتوكول Matrix موحد
- مصادقة آمنة
- خوادم مفتوحة المصدر

🌐 **توافق عالمي**
- يعمل على جميع الأجهزة
- 30+ لغة مدعومة
- تطبيقات سطح المكتب والهاتف

---

## البدء السريع

### المتطلبات

- Node.js 22+
- pnpm 10.32.1+

### التثبيت المحلي

```bash
# استنساخ المشروع
git clone https://github.com/M99-9-9/Secure-Chat-Project.git
cd Secure-Chat-Project

# تثبيت الحزم
pnpm install

# بناء المشروع
cd apps/web
pnpm build

# تشغيل في المعاينة
pnpm preview
```

---

## النشر على Vercel

### الخطوة 1: الربط الأولي

```bash
vercel login
vercel
```

### الخطوة 2: الإعدادات

في Vercel Dashboard:
1. انتقل إلى Settings
2. Build & Development Settings
3. اترك القيم فارغة (ستستخدم من `vercel.json`)

### الخطوة 3: النشر الإنتاجي

```bash
vercel --prod
```

**تفاصيل أكثر في**: [VERCEL_DEPLOYMENT_GUIDE.md](./VERCEL_DEPLOYMENT_GUIDE.md)

---

## الملفات المهمة

### للتطوير
- `apps/web/src/` - كود المصدر
- `apps/web/res/` - الموارد (CSS, صور, إلخ)
- `apps/web/webpack.config.js` - إعدادات البناء

### للنشر
- `vercel.json` - ⭐ إعدادات Vercel
- `apps/web/config.json` - ⭐ إعدادات التطبيق
- `.vercelignore` - ملفات التجاهل

### للتوثيق
- [QUICK_START.md](./QUICK_START.md) - بدء سريع
- [MAROON_THEME_TESTING_GUIDE.md](./MAROON_THEME_TESTING_GUIDE.md) - اختبر الثيم
- [VERCEL_FIX_SUMMARY.md](./VERCEL_FIX_SUMMARY.md) - حل المشاكل
- [FINAL_STATUS.md](./FINAL_STATUS.md) - الحالة النهائية

---

## الألوان المستخدمة

### الدرجات الأساسية

| النوع | اللون | الكود |
|------|-------|-------|
| الأفتح جداً | ![#f8d9e6](https://via.placeholder.com/20/f8d9e6) | `#f8d9e6` |
| فاتح | ![#f1b3cd](https://via.placeholder.com/20/f1b3cd) | `#f1b3cd` |
| متوسط فاتح | ![#e98db4](https://via.placeholder.com/20/e98db4) | `#e98db4` |
| متوسط | ![#e0679b](https://via.placeholder.com/20/e0679b) | `#e0679b` |
| متوسط داكن | ![#c84e75](https://via.placeholder.com/20/c84e75) | `#c84e75` |
| **أساسي** | ![#8D1C3D](https://via.placeholder.com/20/8D1C3D) | **`#8D1C3D`** |
| داكن | ![#6b1530](https://via.placeholder.com/20/6b1530) | `#6b1530` |
| أغمق | ![#490d23](https://via.placeholder.com/20/490d23) | `#490d23` |

---

## الأوامر المفيدة

```bash
# التطوير
pnpm i18n              # مزامنة الترجمات
pnpm lint              # فحص الأخطاء
pnpm test              # تشغيل الاختبارات
pnpm build             # بناء الإنتاج

# الاختبار
pnpm test:playwright   # اختبارات E2E
pnpm build-stats       # إحصائيات البناء

# التنسيق
pnpm lint:prettier     # فحص التنسيق
pnpm lint:prettier-fix # إصلاح التنسيق تلقائياً
```

---

## معلومات عن Element Web

**Element** هو تطبيق اتصالات مفتوح المصدر يعتمد على بروتوكول **Matrix**.

### المميزات
- ✅ تشفير من طرف إلى طرف
- ✅ محادثات جماعية آمنة
- ✅ مشاركة الملفات الآمنة
- ✅ مكالمات صوتية وفيديو
- ✅ التكامل مع التطبيقات الأخرى

### الروابط المفيدة
- [GitHub](https://github.com/element-hq/element-web)
- [الموقع الرسمي](https://element.io)
- [بروتوكول Matrix](https://matrix.org)

---

## حل المشاكل الشائعة

### ❌ خطأ 404

**الحل**:
1. تأكد من `outputDirectory` في `vercel.json` = `apps/web/webapp`
2. تأكد من وجود `config.json` في `apps/web/`
3. أعد بناء المشروع

### ❌ فشل البناء

**الحل**:
1. تأكد من استخدام `pnpm` وليس `npm`
2. حذف `node_modules` و `pnpm-lock.yaml`
3. تشغيل `pnpm install` من جديد

### ❌ الألوان العنابية لا تظهر

**الحل**:
1. امسح ذاكرة التخزين المؤقت (Ctrl+Shift+Delete)
2. أعد تحميل الصفحة (Ctrl+F5)
3. تحقق من متغيرات CSS في المتصفح (F12)

---

## المساهمة والتطوير

### فروع العمل

```
main/develop          ← الإنتاج
  ↑
v0/whatsapphamury... ← التطوير الحالي
  ↑
feature/...          ← الميزات الجديدة
```

### عملية المساهمة

1. **عمل Fork** من المشروع
2. **إنشاء فرع** جديد: `git checkout -b feature/your-feature`
3. **الكتابة والاختبار**: تأكد من عمل كل شيء
4. **إرسال Pull Request**: اشرح التغييرات
5. **المراجعة**: انتظر الموافقة

---

## الترخيص

هذا المشروع مرخص تحت:
- **AGPL-3.0** (مفتوح المصدر)
- **GPL-3.0** (بديل)
- **رخصة تجارية** (خيار)

اقرأ [LICENSE-AGPL-3.0](./LICENSE-AGPL-3.0) للتفاصيل.

---

## الدعم والمساعدة

### الأسئلة الشائعة

**س: هل البيانات آمنة تماماً؟**  
ج: نعم! جميع الرسائل مشفرة من طرف إلى طرف.

**س: هل يمكن استخدام خادم خاص؟**  
ج: نعم! عدّل `config.json` لتعيين خادم Synapse الخاص بك.

**س: هل يعمل بدون إنترنت؟**  
ج: كلا، يحتاج إلى اتصال بخادم Matrix.

### الاتصال

- 📧 البريد الإلكتروني: team@securechat.io
- 🐛 الأخطاء: [GitHub Issues](https://github.com/element-hq/element-web/issues)
- 💬 المراسلة: Matrix Community

---

## الخريطة الطريقية (Roadmap)

### ✅ مكتمل
- [x] ثيم العنابي الكامل
- [x] تشفير E2E
- [x] واجهة محسّنة
- [x] إعدادات Vercel

### 🔄 قيد العمل
- [ ] دعم مزيد من اللغات
- [ ] تطبيق الهاتف المحسّن
- [ ] المزيد من الثيمات

### 📋 المستقبل
- [ ] دعم Spaces
- [ ] تحسينات الأداء
- [ ] ميزات التسويق

---

## الإحصائيات

| العنصر | القيمة |
|--------|-------|
| الإصدار | 1.12.12 |
| اللغات المدعومة | 30+ |
| الأجهزة المدعومة | Windows, Mac, Linux, iOS, Android |
| حجم الملف | ~5MB (مضغوط) |
| وقت البناء | 5-10 دقائق |

---

## شكراً! 🎉

شكراً لاستخدامك Secure Chat Project!

**ابدأ الآن:**
1. اقرأ [QUICK_START.md](./QUICK_START.md)
2. اختبر الثيم محلياً
3. انشر على Vercel
4. استمتع بالواجهة العنابية! 🎨

---

**آخر تحديث**: مارس 2026  
**الحالة**: ✅ جاهز للإنتاج
