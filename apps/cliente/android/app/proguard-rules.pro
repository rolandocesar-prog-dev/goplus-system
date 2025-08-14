# ================================
# GoPlus Cliente - ProGuard Rules
# ================================

# =============================
# FLUTTER
# =============================
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.**  { *; }
-keep class io.flutter.plugins.**  { *; }
-dontwarn io.flutter.embedding.**

# =============================
# CORE LIBRARY DESUGARING
# =============================
# ✅ CRÍTICO: Mantener clases de desugaring
-keep class j$.** { *; }
-dontwarn j$.**
-keep class java.time.** { *; }
-dontwarn java.time.**

# =============================
# FIREBASE
# =============================
-keep class com.google.firebase.** { *; }
-keep class com.google.android.gms.** { *; }
-dontwarn com.google.firebase.**
-dontwarn com.google.android.gms.**

# Firebase Messaging
-keep class com.google.firebase.messaging.** { *; }
-keep class com.google.android.gms.maps.** { *; }

# =============================
# GOOGLE MAPS & LOCATION
# =============================
-keep class com.google.android.gms.maps.** { *; }
-keep class com.google.android.gms.location.** { *; }
-dontwarn com.google.android.gms.maps.**
-dontwarn com.google.android.gms.location.**

# =============================
# FLUTTER PLUGINS - CLIENTE
# =============================
# QR Scanner
-keep class net.touchcapture.qr.** { *; }
-dontwarn net.touchcapture.qr.**

# Mobile Scanner (si usas mobile_scanner)
-keep class dev.steenbakker.mobile_scanner.** { *; }
-dontwarn dev.steenbakker.mobile_scanner.**

# Location Plugin
-keep class com.lyokone.location.** { *; }
-dontwarn com.lyokone.location.**

# Flutter Local Notifications (preparado para futuro uso)
-keep class com.dexterous.** { *; }
-dontwarn com.dexterous.**

# =============================
# NETWORKING & HTTP
# =============================
-keep class okhttp3.** { *; }
-keep class retrofit2.** { *; }
-dontwarn okhttp3.**
-dontwarn retrofit2.**

# =============================
# GENERAL
# =============================
# Conservar números de línea para stack traces
-keepattributes SourceFile,LineNumberTable

# Conservar nombres de parámetros
-keepattributes MethodParameters

# Conservar anotaciones
-keepattributes *Annotation*

# Conservar clases que usan reflexión
-keep class kotlin.** { *; }
-keep class kotlinx.** { *; }
-dontwarn kotlin.**
-dontwarn kotlinx.**

# =============================
# GOPLUS MODELS (cuando los definas)
# =============================
# Conservar modelos de datos para serialización JSON
-keep class com.goplus.cliente.models.** { *; }
-keep class com.goplus.core.models.** { *; }