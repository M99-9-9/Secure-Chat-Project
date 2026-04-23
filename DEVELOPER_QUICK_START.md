# دليل البدء السريع للمطورين

## معلومات المشروع الأساسية

**اسم المشروع:** Secure Chat Project - منصة اتصالات آمنة مشفرة  
**المطور:** محمد هزاع الحميري  
**النوع:** Graduation Project (Cybersecurity)  
**البروتوكول:** Matrix Protocol  
**الإصدار:** 1.12.12

## التكنولوجيات الرئيسية

- **Frontend:** React 19 + TypeScript + Webpack
- **Backend:** Matrix Synapse
- **التشفير:** Megolm v1 + Olm Protocol
- **إدارة الحالة:** Redux (عبر Matrix SDK)
- **Package Manager:** pnpm 10.32.1
- **Deployment:** Vercel

## بدء التشغيل

```bash
# التثبيت
git clone https://github.com/M99-9-9/Secure-Chat-Project.git
cd Secure-Chat-Project
pnpm install

# التطوير
pnpm dev

# البناء
pnpm build

# النشر
pnpm deploy
```

## الملفات الحرجة

| الملف | الغرض |
|------|-------|
| `vercel.json` | إعدادات النشر على Vercel |
| `apps/web/config.json` | إعدادات اتصال العميل |
| `apps/web/webpack.config.ts` | إعدادات Webpack |
| `apps/web/res/themes/*/` | ملفات الثيم والألوان |
| `apps/web/res/css/views/rooms/_EventBubbleTile.pcss` | تنسيق فقاعات الرسائل |

## اللون الأساسي

**الثيم:** واتساب العنابي  
**اللون الأساسي:** `#8D1C3D`  
**النص في الرسائل المرسلة:** أبيض (#ffffff)  
**الرسائل الواردة:** رمادي فاتح/داكن حسب الثيم

## التطبيقات الرئيسية

1. **مراسلة فورية مشفرة تماماً**
2. **دعم محادثات فردية وجماعية**
3. **إدارة الأعضاء والصلاحيات**
4. **تحقق من الأجهزة والمفاتيح**
5. **دعم 30+ لغة**

## هيكل المشروع

```
apps/web/
├── src/
│   ├── components/        # مكونات React
│   ├── stores/           # إدارة الحالة
│   ├── utils/crypto/     # وظائف التشفير
│   ├── i18n/             # الترجمات
│   └── vector/           # العميل الرئيسي
├── res/
│   ├── css/              # الأنماط (PostCSS/SCSS)
│   ├── themes/           # ملفات الثيم
│   └── images/           # الصور والأيقونات
└── config.json           # إعدادات التكوين
```

## الخطوات الأساسية للتطوير

1. **قراءة** `PROJECT_OVERVIEW.md` للفهم الكامل
2. **استكشاف** بنية المشروع في `apps/web/src/`
3. **فهم** نظام الثيمات في `apps/web/res/themes/`
4. **اختبار** محلياً قبل الدفع
5. **نشر** عبر `git push origin develop`

## المشاكل الشائعة والحلول

**مشكلة:** 404 NOT_FOUND عند المعاينة  
**الحل:** تأكد من أن `vercel.json` و `apps/web/config.json` موجودة

**مشكلة:** webpack build fails  
**الحل:** لا تستخدم `--outdir` مع webpack-cli - المسار محدد في config

**مشكلة:** رسائل غير مشفرة  
**الحل:** تأكد من تفعيل التشفير في إعدادات الغرفة

## موارد مفيدة

- [Matrix Protocol Docs](https://spec.matrix.org/)
- [Element Web GitHub](https://github.com/element-hq/element-web)
- [Vercel Deployment Guide](https://vercel.com/docs)

## التواصل والدعم

**المطور:** محمد هزاع الحميري  
**Repository:** M99-9-9/Secure-Chat-Project  
**Branch:** develop

---

لأي استفسارات تفصيلية، راجع `PROJECT_OVERVIEW.md`
