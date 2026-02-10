# حفظ كلاسات Chromium Cronet الخاصة بـ ivs_broadcaster
-keep class org.chromium.net.** { *; }
-dontwarn org.chromium.net.**

# حفظ كلاسات Flutter الأساسية
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.** { *; }
-dontwarn io.flutter.embedding.**



# حفظ أي كائنات تستخدم reflection (حسب الحاجة)
-keepattributes *Annotation*
-keepattributes InnerClasses
 