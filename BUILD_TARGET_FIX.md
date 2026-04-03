## حل مشكلة خطأ nx build target

### المشكلة
الأمر في vercel.json كان:
```
pnpm install && nx build web && (cp -r apps/web/webapp/* . || true)
```

الخطأ: `nx build web` لا يوجد. اسم الـ target الصحيح في nx.json هو `element-web` وليس `web`.

### الحل المطبق
تم تصحيح `vercel.json` إلى:
```json
"buildCommand": "pnpm install && nx build element-web && (cp -r apps/web/webapp/* . || true)",
```

### التفاصيل
- اسم الـ project في nx هو `element-web` (يمكن التحقق من `apps/web/project.json`)
- الأمر الآن سيعمل بشكل صحيح:
  1. `pnpm install` - تثبيت الـ dependencies
  2. `nx build element-web` - بناء المشروع
  3. `cp -r apps/web/webapp/* .` - نسخ المخرجات إلى جذر الـ output

### الخطوات التالية
```bash
git add vercel.json
git commit -m "fix: correct nx build target name from web to element-web"
git push origin develop
```

بعد الدفع، Vercel سيعيد البناء بنجاح.
