حل مشكلة فشل البناء في Vercel

## المشكلة

عند محاولة نشر المشروع على Vercel، حدث خطأ في عملية البناء:

```
خطأ البناء:
pnpm install --frozen-lockfile && cd apps/web && pnpm build --outdir ../../webapp
```

الخطأ في السطر الأخير من الأمر: `--outdir ../../webapp` غير مدعوم.

## السبب الحقيقي

1. البناء يستخدم `nx build` الذي يشغل `webpack-cli`
2. `webpack-cli` لا يدعم flag `--outdir`
3. المخرجات محددة بالفعل في `project.json` لتكون في `webapp`
4. محاولة تجاوز المسار بـ `--outdir` تسبب فشل الأمر

## الحل

تم تصحيح `vercel.json` إلى:

```json
{
  "version": 2,
  "buildCommand": "pnpm install --frozen-lockfile && pnpm build",
  "outputDirectory": "apps/web/webapp",
  ...
}
```

### الفروقات الرئيسية:

1. **buildCommand**: من `cd apps/web && pnpm build --outdir ../../webapp` إلى `pnpm build`
   - الآن يشغل الأمر من الجذر مما يسمح لـ nx بإدارة مسارات المشاريع
   - لا يوجد flag غير مدعوم

2. **outputDirectory**: من `webapp` إلى `apps/web/webapp`
   - يشير المسار الصحيح حيث يتم إخراج البناء فعلياً
   - يتطابق مع قيمة `outputs` في `project.json`

## خطوات النشر

```bash
git add vercel.json
git commit -m "fix: correct webpack build command and output path"
git push origin v0/whatsapphamury-4586-a0b5b812
```

## ماذا سيحدث بعد الدفع

1. Vercel ستشغل الأمر الجديد: `pnpm install --frozen-lockfile && pnpm build`
2. `nx build` سيشغل webpack من الموقع الصحيح
3. المخرجات ستذهب إلى `apps/web/webapp`
4. Vercel ستخدم `apps/web/webapp` كـ output directory
5. الموقع سيعمل بنجاح بدون رسالة 404

## ملفات ذات صلة

- `vercel.json` - تكوين النشر
- `apps/web/project.json` - إعدادات بناء webpack
- `nx.json` - إعدادات مربع أدوات النسخ
