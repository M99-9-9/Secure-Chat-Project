# إصلاح خطأ Regex Pattern في Vercel

## المشكلة

تم تلقي خطأ من Vercel:
```
Header at index 2 has invalid `source` regular expression "/bundles/**/*"
```

## السبب

نمط regex `/bundles/**/*` غير صحيح لأن:
- `**` (double asterisk) ليس جزءاً من regex القياسي
- `**` هو glob pattern يُستخدم في bash وليس في regex
- Vercel يتطلب regex pattern صحيح لخاصية `source` في headers

## الحل

تم تغيير النمط من:
```json
"source": "/bundles/**/*"
```

إلى:
```json
"source": "/bundles/(.*)"
```

## الشرح

- `(.*)` هو regex صحيح يطابق أي شيء بعد `/bundles/`
- يعادل الوظيفة المقصودة من `/bundles/**/*`
- يتوافق مع معايير Vercel

## الملفات المعدلة

- ✅ `vercel.json` - تم تصحيح السطر 62

## الخطوة التالية

انشر التغييرات:

```bash
git add vercel.json
git commit -m "fix: correct regex pattern in headers configuration"
git push origin develop
```

## النتيجة المتوقعة

- ✅ اختفاء خطأ regex
- ✅ النشر ينجح بدون أخطاء
- ✅ Cache-Control headers تُطبق بشكل صحيح على ملفات الـ bundles
