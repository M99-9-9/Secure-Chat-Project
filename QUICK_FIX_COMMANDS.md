# أوامر سريعة لنشر الإصلاح

## الأمر الموحد (نسخ والصق)
```bash
git add vercel.json && git commit -m "fix: remove invalid framework property" && git push origin develop
```

## أوامر منفصلة
```bash
# 1. إضافة الملف
git add vercel.json

# 2. إنشاء التزام
git commit -m "fix: remove invalid framework property"

# 3. دفع التغييرات
git push origin develop
```

## التحقق من التغييرات
```bash
# عرض الفرق
git diff vercel.json

# أو عرض آخر commit
git show HEAD:vercel.json
```

---

## ماذا سيحدث بعد الدفع؟

1. **Vercel سيكتشف التغييرات** (خلال ثوان)
2. **سيبدأ البناء الجديد** (3-5 دقائق)
3. **سيتم النشر** (1 دقيقة)
4. **الموقع سيكون حياً** ✅

---

## مراقبة البناء
زر: https://vercel.com/dashboard

---

**استغرق 30 ثانية فقط لتشغيل الأمر وكل شيء سيكون جاهزاً!** 🚀
