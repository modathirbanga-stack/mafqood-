# مفقود — Mafqood App 🔍

منصة المفقودات الذكية — Lost & Found Platform

## الميزات
- 📋 فيد المفقودات مع بحث وفلاتر
- 📷 تصوير الأشياء المفقودة ورفعها
- 🗺️ خريطة تفاعلية بمواقع المفقودات
- 💬 محادثة مباشرة بين العاثر وصاحب الشيء
- 🔔 إشعارات فورية

---

## كيفية بناء وتثبيت التطبيق

### الطريقة الأسهل: GitHub Actions (بدون لاب توب)

1. **ارفع الكود على GitHub:**
   - اذهب إلى github.com → "New repository"
   - اسمه: `mafqood`
   - اجعله **Public**
   - لا تضف README

2. **ارفع الملفات:**
   ```bash
   cd mafqood
   git init
   git add .
   git commit -m "Initial commit - Mafqood App"
   git branch -M main
   git remote add origin https://github.com/YOUR_USERNAME/mafqood.git
   git push -u origin main
   ```

3. **انتظر البناء:**
   - اذهب إلى repo → تبويب **Actions**
   - ستشوف workflow اسمه "Build Mafqood APK" يشتغل
   - انتظر ~5 دقائق

4. **حمّل الـ APK:**
   - بعد انتهاء الـ workflow، اضغط عليه
   - في الأسفل: **Artifacts** → اضغط `mafqood-debug-apk`
   - يتحمل zip، افتحه وخذ الـ APK

5. **ثبّت على هاتفك:**
   - انقل الـ APK للهاتف
   - الإعدادات → الأمان → "تثبيت تطبيقات من مصادر غير معروفة" ✓
   - افتح الـ APK → ثبّت

---

### الطريقة البديلة: Flutter مباشرة

```bash
# 1. ثبّت Flutter: flutter.dev/docs/get-started/install
# 2. ثبّت dependencies
flutter pub get

# 3. ضع ملفات خطوط Tajawal في assets/fonts/
# من: fonts.google.com/specimen/Tajawal

# 4. ابن الـ APK
flutter build apk --debug

# 5. الـ APK في:
# build/app/outputs/flutter-apk/app-debug.apk
```

---

## هيكل المشروع

```
lib/
├── main.dart              # Entry point + Splash Screen
├── theme.dart             # الألوان والثيم
├── models/
│   └── models.dart        # Data models + Sample data
├── widgets/
│   └── widgets.dart       # Shared UI components
└── screens/
    ├── feed_screen.dart   # الشاشة الرئيسية + إشعارات + ملف شخصي
    ├── detail_screen.dart # تفاصيل المفقود
    ├── chat_screen.dart   # المحادثة
    ├── map_screen.dart    # الخريطة
    └── upload_screen.dart # رفع مفقود جديد
```

## التقنيات المستخدمة
- Flutter 3.x (Dart)
- flutter_map + OpenStreetMap (خريطة مجانية)
- image_picker (كاميرا + معرض)
- shared_preferences (تخزين محلي)
- permission_handler (صلاحيات)
