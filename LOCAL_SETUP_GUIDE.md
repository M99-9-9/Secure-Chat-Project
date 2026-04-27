# دليل تشغيل Vault على جهازك محليا

## المتطلبات الأساسية

### 1. Node.js و npm/pnpm
- **Node.js** الإصدار 22.18 أو أحدث
- **pnpm** كمدير الحزم (الموصى به)
- **Git** لاستنساخ المستودع

### 2. التحقق من التثبيت

```bash
node --version      # يجب أن يكون v22.18+
pnpm --version      # يجب أن يكون مثبت
git --version       # للتحقق من Git
```

إذا لم يكن pnpm مثبتا، قم بتثبيته:

```bash
npm install -g pnpm
```

---

## خطوات التشغيل

### الخطوة 1: استنساخ المستودع

```bash
# استنساخ المشروع
git clone https://github.com/M99-9-9/Secure-Chat-Project.git

# الدخول للمجلد
cd Secure-Chat-Project

# التأكد من الفرع الصحيح
git checkout develop
```

### الخطوة 2: تثبيت الاعتماديات

```bash
# تثبيت جميع الحزم
pnpm install

# أو باستخدام npm
npm install
```

**ملاحظة:** هذا قد يستغرق بعض الوقت في المرة الأولى (3-5 دقائق)

### الخطوة 3: تشغيل الخادم المحلي

#### الطريقة الأولى: تشغيل من الجذر

```bash
# تشغيل مباشر من المجلد الرئيسي
pnpm start

# أو
npm start
```

#### الطريقة الثانية: تشغيل من مجلد web

```bash
# الدخول لمجلد Element Web
cd apps/web

# تشغيل الخادم
pnpm start

# أو
npm start
```

### الخطوة 4: فتح الموقع

بعد التشغيل، سترى رسالة مثل:

```
> element-web@1.12.12 start /vercel/share/v0-project/apps/web
> nx serve element-web

Starting application server at http://localhost:5173
```

افتح المتصفح على:
```
http://localhost:5173
```

---

## الأوامر الرئيسية

### البناء والتشغيل

```bash
# بناء المشروع
pnpm build

# أو من مجلد apps/web
cd apps/web && pnpm build

# التشغيل المباشر (dev mode)
pnpm start

# أو
npm start

# التشغيل مع Hot Reload
pnpm dev

# البناء للإنتاج
pnpm build:prod
```

### الاختبار والفحص

```bash
# تشغيل الاختبارات
pnpm test

# فحص النوع (TypeScript)
pnpm type-check

# فحص الأسلوب (Linting)
pnpm lint

# إصلاح مشاكل الأسلوب تلقائيا
pnpm lint:fix
```

### عمليات أخرى

```bash
# تنظيف المشروع
pnpm clean

# تنظيف node_modules
rm -rf node_modules && pnpm install

# تحديث الاعتماديات
pnpm update
```

---

## إعدادات قاعدة البيانات والخادم

### تكوين الخادم المحلي

إذا كنت تريد الاتصال بخادم Matrix خاص:

1. انتقل إلى `apps/web/config.json`
2. عدّل `default_home_server`:

```json
{
    "default_home_server": "http://localhost:8008",
    "server_name": "localhost"
}
```

### استخدام الخادم الافتراضي

المشروع يأتي معه بإعدادات افتراضية للاتصال بـ:
- **الخادم:** `https://matrix.org` (أو الخادم المجهز مسبقا)
- **تسجيل الدخول:** عبر روابط الدعوة أو بيانات المستخدم

---

## استكشاف الأخطاء الشائعة

### المشكلة: رسالة الخطأ "Port already in use"

```bash
# الحل: استخدم منفذ مختلف
PORT=5174 pnpm start

# أو قتل العملية التي تستخدم المنفذ 5173
# في Windows
netstat -ano | findstr :5173
taskkill /PID <PID> /F

# في Linux/Mac
lsof -i :5173
kill -9 <PID>
```

### المشكلة: أخطاء في التثبيت

```bash
# حل شامل
rm -rf node_modules pnpm-lock.yaml
pnpm install --force
pnpm start
```

### المشكلة: Node version mismatch

```bash
# تحقق من إصدار Node.js
node --version

# إذا كان أقل من v22.18، حدثه من:
# https://nodejs.org/

# أو استخدم nvm (Node Version Manager)
nvm install 22.18
nvm use 22.18
```

### المشكلة: لا تظهر التغييرات عند التعديل

```bash
# أعد تشغيل الخادم
# أوقف الخادم (Ctrl + C)
# ثم أعد التشغيل
pnpm start
```

---

## هيكل المجلدات المهم

```
Secure-Chat-Project/
├── apps/
│   ├── web/              # التطبيق الرئيسي (Element Web)
│   │   ├── src/
│   │   ├── public/
│   │   ├── package.json
│   │   └── config.json   # إعدادات التطبيق
│   └── ...
├── packages/             # الحزم المشتركة
├── package.json          # إعدادات المشروع الرئيسية
├── pnpm-lock.yaml        # ملف القفل
└── ...
```

---

## الإعدادات المتقدمة

### تفعيل وضع التطوير المتقدم

```bash
# مع معلومات التصحيح
DEBUG=* pnpm start

# مع console logs
NODE_ENV=development pnpm start
```

### الاتصال ببيئة مختلفة

```bash
# اتصال بخادم اختبار
REACT_APP_SERVER=https://test.server pnpm start

# اتصال بخادم محلي
REACT_APP_SERVER=http://localhost:8008 pnpm start
```

### تغيير المنفذ

```bash
# تشغيل على منفذ مختلف
PORT=3000 pnpm start

# أو في ملف .env
# PORT=3000
```

---

## المتطلبات الإضافية (اختياري)

### Synapse Server (خادم Matrix محلي)

إذا أردت تشغيل خادم Matrix محلي:

```bash
# باستخدام Docker
docker run -it --rm \
  -v synapse_data:/data \
  -e SYNAPSE_SERVER_NAME=localhost \
  -p 8008:8008 \
  matrixdotorg/synapse:latest

# ثم عدّل config.json للاتصال بـ localhost:8008
```

---

## التطوير والمساهمة

### مراقبة التغييرات

```bash
# المسح التلقائي للملفات
pnpm watch

# أو في مجلد web
cd apps/web
pnpm watch
```

### فتح developer tools

```bash
# في المتصفح: F12 أو Ctrl+Shift+I
# أو قائمة: Right-click → Inspect Element
```

---

## موارد مفيدة

- **مستندات Element Web:** `docs/` folder
- **دليل المطورين:** `developer_guide.md`
- **Matrix Protocol:** https://matrix.org/
- **Element Web GitHub:** https://github.com/element-hq/element-web

---

## دعم وتجنب المشاكل

إذا واجهت مشاكل:

1. تأكد من تثبيت جميع المتطلبات
2. جرّب حذف `node_modules` والتثبيت من جديد
3. تحقق من إصدارات Node و pnpm
4. اطلع على `README.md` و `developer_guide.md`
5. ابحث عن الخطأ على GitHub Issues

---

**تم التحديث:** مارس 2026  
**تطوير:** محمد هزاع الحميري
