# حل خطأ Build في Vercel

## المشكلة
```
npm error Missing script: "build"
npm error
npm error To see a list of scripts, run:
npm error   npm run
Error: Command "npm run build" exited with 1
```

## السبب
Vercel يحاول تنفيذ `npm run build` من الـ root package.json، لكن الـ root package.json لم يكن يحتوي على build script.

## الحل المطبق

### 1. إضافة build script إلى package.json الرئيسي
```json
{
  "scripts": {
    "build": "cd apps/web && pnpm build",
    "start": "cd apps/web && pnpm start",
    ...
  }
}
```

### 2. تحديث vercel.json
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

## التفاصيل

- **buildCommand**: يحدد الأمر الذي سيستخدمه Vercel للبناء
- **outputDirectory**: يحدد مجلد المخرجات (webapp)
- **cleanUrls**: يزيل امتدادات الملفات من الروابط
- **rewrites**: يوجه جميع الطلبات إلى index.html لدعم SPA routing

## النتيجة
الآن عندما يتم الدفع (Push) إلى GitHub:
1. Vercel سيكتشف الريبوزيتوري
2. سيقوم بتثبيت المتطلبات باستخدام pnpm
3. سيقوم بتنفيذ `pnpm build` من root
4. سيبني Element Web باستخدام nx
5. سيأخذ المخرجات من `apps/web/webapp`
6. سيعرض الواجهة العنابية الجميلة بدون مشاكل 404

## ملخص التغييرات
- `package.json`: إضافة build و start scripts
- `vercel.json`: إضافة buildCommand و outputDirectory

كل التغييرات تم حفظها وجاهزة للدفع!
