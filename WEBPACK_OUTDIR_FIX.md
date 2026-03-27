# حل مشكلة webpack --outdir

## المشكلة
```
[webpack-cli] Error: Unknown option '--outdir'
```

## السبب
- webpack-cli لا يدعم flag `--outdir`
- مسار الخروج يتم تحديده في `webpack.config.ts` أو عبر environment variables
- لا يمكن تمريره عبر command-line flags

## الحل المطبق

### 1. تصحيح project.json
تم إزالة أي محاولة لتمرير `--outdir` في build command:
```json
"build": {
    "command": "webpack-cli --progress --mode production",
    "outputs": ["{projectRoot}/webapp"],
    "cache": false,
    "options": { "cwd": "apps/web" }
}
```

### 2. التأكد من vercel.json
```json
{
  "version": 2,
  "buildCommand": "pnpm install --frozen-lockfile && pnpm build",
  "outputDirectory": "apps/web/webapp",
  ...
}
```

### 3. كيف يعمل الآن
1. Vercel تنفذ: `pnpm install --frozen-lockfile && pnpm build`
2. هذا ينفذ root package.json build: `cd apps/web && pnpm build`
3. هذا ينفذ apps/web package.json build: `nx build`
4. `nx build` ينفذ webpack مع الأمر البسيط: `webpack-cli --progress --mode production`
5. webpack يقرأ من `webpack.config.ts` مسار الخروج: `apps/web/webapp`
6. Vercel يعرف المخرجات موجودة في: `apps/web/webapp`

## النتيجة النهائية
- البناء سيعمل بنجاح بدون أخطاء
- المخرجات ستكون في `apps/web/webapp`
- الموقع سيظهر بشكل صحيح على Vercel

## الخطوات التالية
```bash
git add vercel.json apps/web/project.json package.json
git commit -m "fix: remove webpack --outdir flag and use correct build commands"
git push origin develop
```

النشر سيكون ناجحاً هذه المرة!
