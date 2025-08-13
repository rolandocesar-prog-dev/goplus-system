import java.util.Properties
import java.io.FileInputStream

val localProperties = Properties()
val localPropertiesFile = rootProject.file("local.properties")
if (localPropertiesFile.exists()) {
    localProperties.load(FileInputStream(localPropertiesFile))
}

val flutterRoot = localProperties.getProperty("flutter.sdk")
    ?: throw GradleException("Flutter SDK not found. Define location with flutter.sdk in the local.properties file.")

val flutterVersionCode = localProperties.getProperty("flutter.versionCode") ?: "1"
val flutterVersionName = localProperties.getProperty("flutter.versionName") ?: "1.0.0"

plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
    id("com.google.gms.google-services")
}

android {
    namespace = "com.goplus.cliente.goplus_cliente"
    compileSdk = 35  // ✅ ACTUALIZADO: Android SDK 35
    
    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_1_8
        targetCompatibility = JavaVersion.VERSION_1_8
    }
    
    kotlinOptions {
        jvmTarget = "1.8"
    }
    
    defaultConfig {
        // ✅ CORREGIDO: Debe coincidir con google-services.json
        applicationId = "com.goplus.cliente.goplus_cliente"
        minSdk = 21
        targetSdk = 35  // ✅ ACTUALIZADO: Android SDK 35
        versionCode = flutterVersionCode.toInt()
        versionName = flutterVersionName
        
        // MultiDex para Firebase
        multiDexEnabled = true
        
        // Configuración para Google Maps
        manifestPlaceholders["appAuthRedirectScheme"] = "com.goplus.cliente.goplus_cliente"
    }
    
    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
            
            // Optimizaciones de release
            isMinifyEnabled = true
            isShrinkResources = true
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
        }
        
        debug {
            signingConfig = signingConfigs.getByName("debug")
            isDebuggable = true
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    // ✅ CORREGIDO: Usar versión específica
    implementation("org.jetbrains.kotlin:kotlin-stdlib-jdk7:1.8.22")
    
    // Firebase BoM para gestión de versiones
    implementation(platform("com.google.firebase:firebase-bom:32.7.0"))
    implementation("com.google.firebase:firebase-analytics")
    implementation("com.google.firebase:firebase-messaging")
    
    // Google Play Services para Maps
    implementation("com.google.android.gms:play-services-maps:18.2.0")
    implementation("com.google.android.gms:play-services-location:21.0.1")
    
    // MultiDex support
    implementation("androidx.multidex:multidex:2.0.1")
}