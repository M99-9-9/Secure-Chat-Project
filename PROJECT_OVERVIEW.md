# منصة الاتصالات الآمنة المشفرة - Secure Chat Project
## وصف تفصيلي شامل

---

## 1. الفكرة الأساسية

**اسم المشروع:** منصة الاتصالات الآمنة المشفرة (Secure Encrypted Communications Platform - SECP)

**الغرض:** بناء منصة اتصالات حديثة وآمنة توفر تشفير من طرف إلى طرف (E2E Encryption) كامل، مع واجهة مستخدم جذابة تذكر بتطبيق WhatsApp الشهير، لكن بألوان عنابية متميزة.

**السياق:** مشروع تخرج في تخصص الأمن السيبراني يهدف لتوضيح مبادئ الاتصالات الآمنة والتشفير الحديث.

**المطور:** محمد هزاع الحميري (Muhammad Hezaa Al-Hamri)

---

## 2. الوظائف الرئيسية

### 2.1 المراسلة الفورية
- إرسال واستقبال رسائل نصية في الوقت الفعلي
- دعم المحادثات الفردية والجماعية
- تاريخ محادثات كامل قابل للبحث

### 2.2 التشفير الشامل
- تشفير E2E على جميع الرسائل باستخدام بروتوكول Megolm
- مفاتيح تشفير فريدة لكل جهاز
- دعم Cross-Signing للتحقق من الهوية
- نسخ احتياطية آمنة للمفاتيح

### 2.3 إدارة الغرف والأعضاء
- إنشاء غرف دردشة جديدة
- إضافة وحذف الأعضاء
- تعيين الأدوار والصلاحيات
- التحكم في إعدادات الخصوصية

### 2.4 المصادقة والأمان
- تسجيل دخول آمن باستخدام SSO أو كلمات مرور مشفرة
- التحقق من جهازين (2FA)
- إدارة الجلسات والأجهزة الموثوقة

### 2.5 إشعارات وحالة التواجد
- إشعارات فورية للرسائل الجديدة
- عرض حالة التواجد (نشط، خامل، غير متصل)
- قراءات الرسائل ومؤشرات الكتابة

---

## 3. التصميم العام

### 3.1 الهوية البصرية
**اسم الثيم:** واتساب العنابي (WhatsApp Maroon)

**اللون الأساسي:** `#8D1C3D` (عنابي داكن)

**لوحة الألوان:**
- **اللون الأساسي:** #8D1C3D (جميع الأزرار والأيقونات النشطة)
- **الألوان المتدرجة:** 14 درجة من الفاتح للداكن
  - الفاتح: #f8d9e6
  - الداكن: #0d0202
- **ألوان الرسائل:**
  - الرسائل المرسلة: خلفية عنابية + نص أبيض
  - الرسائل الواردة: خلفية رمادية فاتحة (#f5f5f5 للـ Light، #2a2a2a للـ Dark)

### 3.2 الخطوط والتيبوجرافيا
- **الخط الأساسي:** Inter (Google Fonts)
- **الخط الأحادي:** Fira Code (للأكواد)
- **أحجام النصوص:**
  - Headers: 20px - 48px
  - Body: 14px - 16px
  - Small: 12px - 13px

### 3.3 البنية التخطيطية
**Responsive Design - Mobile First:**
```
الجوال (320px+) → Tablet (768px+) → Desktop (1024px+)
```

**المخطط الرئيسي:**
```
┌─────────────────────────────────────────┐
│         Navigation Bar / Header          │ (Logo + Settings)
├──────────────┬──────────────────────────┤
│              │                          │
│  Side Panel  │    Main Chat Area        │ (Sidebar يتحول للـ Drawer في Mobile)
│              │                          │
│ • Room List  │  • Messages Timeline     │
│ • Direct DMs │  • Input Box             │
│ • Settings   │  • Members Panel         │
│              │                          │
└──────────────┴──────────────────────────┘
```

### 3.4 مكونات واجهة المستخدم
- **Side Panel:** قائمة الغرف والمحادثات المباشرة
- **Chat Timeline:** عرض الرسائل برسائل مرسلة/واردة
- **Message Bubble:** فقاعات الرسائل مع timestamps
- **Input Area:** حقل الكتابة مع أزرار الأرفاق والإرسال
- **Right Panel:** معلومات الغرفة وقائمة الأعضاء
- **Modals:** نوافذ حوارية للإعدادات والمزيد

---

## 4. التقنيات المستخدمة

### 4.1 Frontend
- **Framework:** React 19 مع TypeScript
- **بناء:** Webpack 5 + Babel
- **إدارة الحالة:** Redux (عبر Matrix Client SDK)
- **Styling:** PostCSS + SCSS + Tailwind CSS concepts
- **Package Manager:** pnpm 10.32.1

### 4.2 Backend
- **Protocol:** Matrix Protocol (OpenStandard)
- **Home Server:** Synapse (Matrix Home Server)
- **الاتصال:** HTTP + WebSocket
- **API Endpoints:** /_matrix/client/r0/* و /_matrix/synapse/*

### 4.3 الأمان والتشفير
- **E2E Encryption:** Megolm v1 (AES-SHA2)
- **Device Verification:** Olm Protocol
- **Key Management:** libolm / matrix-sdk-crypto-wasm
- **Password Hashing:** bcrypt (على السيرفر)
- **Session Management:** HTTP-only Cookies

### 4.4 Build & Deployment
- **Build Tool:** nx (Monorepo)
- **Deployment:** Vercel
- **CI/CD:** GitHub Actions
- **Database:** Matrix Synapse (PostgreSQL backend)

### 4.5 المكتبات الرئيسية
```json
{
  "matrix-js-sdk": "41.1.0",
  "react": "19.x",
  "typescript": "5.x",
  "webpack-cli": "5.x",
  "babel": "7.x",
  "postcss": "8.x"
}
```

---

## 5. هيكل المشروع

### 5.1 بنية Monorepo
```
Secure-Chat-Project/
├── apps/
│   └── web/                    # تطبيق Element Web الرئيسي
│       ├── src/
│       │   ├── components/     # مكونات React
│       │   ├── stores/         # إدارة الحالة
│       │   ├── utils/          # وظائف مساعدة وتشفير
│       │   ├── contexts/       # React Contexts
│       │   ├── hooks/          # Custom Hooks
│       │   ├── i18n/           # ملفات الترجمة (30+ لغة)
│       │   └── vector/         # العميل الرئيسي
│       ├── res/
│       │   ├── css/            # ملفات الأنماط (PostCSS/SCSS)
│       │   ├── themes/         # ملفات الثيمات المخصصة
│       │   │   ├── light/      # ثيم فاتح
│       │   │   ├── dark/       # ثيم داكن
│       │   │   ├── legacy-light/
│       │   │   ├── legacy-dark/
│       │   │   └── light-custom/
│       │   └── images/         # الصور والأيقونات
│       ├── webpack.config.ts   # إعدادات Webpack
│       ├── project.json        # إعدادات nx
│       ├── config.json         # إعدادات العميل
│       └── package.json
├── packages/                    # مكتبات مشتركة
├── scripts/                     # نصوص البناء والتوزيع
├── vercel.json                  # إعدادات Vercel
├── package.json                 # Root package.json
└── README.md
```

### 5.2 مسارات الملفات الرئيسية

**ملفات الثيم (يحتوي على اللون العنابي #8D1C3D):**
- `apps/web/res/themes/light/css/_light.pcss`
- `apps/web/res/themes/dark/css/_dark.pcss`
- `apps/web/res/themes/legacy-light/css/_legacy-light.pcss`
- `apps/web/res/themes/legacy-dark/css/_legacy-dark.pcss`
- `apps/web/res/themes/light-custom/css/_custom.pcss`

**ملفات فقاعات الرسائل:**
- `apps/web/res/css/views/rooms/_EventBubbleTile.pcss`
- `apps/web/res/css/views/rooms/_EventTile.pcss`

**ملفات التشفير:**
- `apps/web/src/utils/crypto/index.ts`
- `apps/web/src/DecryptionFailureTracker.ts`
- `apps/web/src/Lifecycle.ts`

---

## 6. تدفق البيانات

### 6.1 دورة حياة الرسالة

```
المستخدم يكتب الرسالة
    ↓
يضغط على Send
    ↓
MessageComposer Component يحقق من الصحة
    ↓
إذا كانت الغرفة مشفرة:
    ├─ Encrypt مع مفتاح عام B (Olm)
    ├─ Wrap مع مفتاح جماعي (Megolm)
    └─ إنشاء Event مشفر
    ↓
Matrix Client SDK يرسل الرسالة
    ↓
HTTP POST إلى Synapse
    ↓
Synapse يخزن الرسالة المشفرة (لا يملك المفاتيح)
    ↓
البث للمستقبلين عبر WebSocket
    ↓
المستقبل يستقبل الرسالة المشفرة
    ↓
فك تشفير Olm مع مفتاحه الخاص
    ↓
استخراج مفتاح Megolm
    ↓
فك تشفير الرسالة النهائي
    ↓
عرض في TimelinePanel
```

### 6.2 معمارية State Management

```
MatrixClientPeg (Singleton)
    ↓
Redux Store (Matrix SDK manages)
    ↓
React Components
    └─ RoomListStore
    └─ RightPanelStore
    └─ Message Store
    └─ Notification Store
```

---

## 7. ميزات المستخدم

### 7.1 الأمان والخصوصية
- تشفير كامل من البداية للنهاية (E2E)
- عدم القدرة على قراءة الرسائل حتى من مسؤولي السيرفر
- خيارات التحقق من الأجهزة الموثوقة
- نسخ احتياطية آمنة للمفاتيح

### 7.2 قابلية الاستخدام
- واجهة نظيفة وبديهية (مشابهة لـ WhatsApp)
- دعم 30+ لغة بما فيها العربية
- تحميل الرسائل القديمة بسهولة
- البحث في المحادثات والرسائل

### 7.3 التخصيص
- ثيمات متعددة (فاتح، داكن، إرث)
- إعدادات مخصصة للتنبيهات
- اختيار خادم المنزل المخصص

### 7.4 الأداء
- تحميل سريع للرسائل
- مزامنة فعالة مع الخادم
- استخدام معقول للذاكرة والنطاق الترددي

---

## 8. المسارات الرئيسية

### 8.1 مسار المصادقة
```
Login Page
    ↓
تحديد النوع (SSO/Password/Token)
    ↓
إرسال البيانات إلى Synapse
    ↓
الحصول على Access Token
    ↓
تشفير وحفظ التوكن
    ↓
إنشاء جلسة مشفرة
    ↓
تحميل المحادثات
    ↓
Main Chat Interface
```

### 8.2 مسار إنشاء غرفة
```
New Room Button
    ↓
Room Creation Modal
    ↓
إدخال اسم الغرفة والإعدادات
    ↓
Matrix Client SDK
    ↓
POST إلى Synapse: /_matrix/client/r0/createRoom
    ↓
الحصول على Room ID
    ↓
إنشاء إعدادات التشفير
    ↓
إضافة أعضاء أوليين
    ↓
عرض الغرفة الجديدة في القائمة
```

---

## 9. الاستجابة (Responsiveness)

### 9.1 Breakpoints
```css
Mobile:     320px - 767px
Tablet:     768px - 1023px
Desktop:    1024px+
Large:      1280px+
```

### 9.2 التحكم في التخطيط
- **Mobile:** One-column layout (القائمة الجانبية تصبح Drawer)
- **Tablet:** Two-column layout مع panels قابلة للتغيير
- **Desktop:** Three-panel layout كامل

---

## 10. الملفات الإعدادات الحرجة

### 10.1 vercel.json
```json
{
  "version": 2,
  "buildCommand": "pnpm install && nx build element-web && (cp -r apps/web/webapp/* . || true)",
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

### 10.2 apps/web/config.json
إعدادات الاتصال بـ Synapse وتفاصيل التكوين الأساسية

### 10.3 webpack.config.ts
إعدادات البناء والـ entry points و output directories

---

## 11. الخطوات اللازمة لبناء نسخة مشابهة

### 11.1 البيئة والتثبيت
```bash
# متطلبات:
# - Node.js >= 22.18
# - pnpm >= 10.32.1
# - Synapse Home Server

# التثبيت:
git clone <repo>
cd Secure-Chat-Project
pnpm install
pnpm build
```

### 11.2 التخصيص
1. استبدل الألوان في ملفات `_light.pcss` و `_dark.pcss`
2. عدّل `config.json` لتوصيل الخادم الخاص بك
3. أضف شعارك وصورك في مجلد `res/images/`
4. أضف ترجماتك في `src/i18n/`

### 11.3 النشر
```bash
# إلى Vercel:
pnpm build
vercel deploy

# محلياً:
pnpm dev
```

---

## 12. الأمان والخصوصية

### 12.1 معايير الأمان
- OWASP Top 10 Compliance
- Encryption at rest و in transit
- No logs للمحادثات
- Open source للتدقيق

### 12.2 Compliance
- GDPR compatible
- CCPA compatible
- Server admin non-disclosure

---

## 13. الأداء والتحسينات المستقبلية

### 13.1 التحسينات الحالية
- Lazy loading للرسائل القديمة
- Virtual scrolling للقوائم الطويلة
- Service workers للـ offline support

### 13.2 التحسينات المقترحة
- Web Workers للعمليات الثقيلة
- Better image compression
- Video/voice call support
- Mobile app versions

---

## 14. معلومات المطور والدعم

**المطور:** محمد هزاع الحميري  
**البريد الإلكتروني:** hamury.dev@example.com  
**GitHub:** M99-9-9/Secure-Chat-Project  
**نوع المشروع:** Graduation Project - Cybersecurity  
**المؤسسة:** جامعة / كلية

---

هذا الوصف الشامل يغطي جميع جوانب المشروع التقنية والتصميمية ويوفر مرجعاً كاملاً لأي مطور يريد فهم أو بناء نسخة مشابهة من المنصة.
