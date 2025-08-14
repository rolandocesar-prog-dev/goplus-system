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
    namespace = "com.goplus.repartidor.goplus_repartidor"
    compileSdk = 35  // ✅ ACTUALIZADO: Android SDK 35
    
    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_1_8
        targetCompatibility = JavaVersion.VERSION_1_8
    }
    
    kotlinOptions {
        jvmTarget = "1.8"
    }

     // ✅ CRÍTICO: Habilitar buildConfig para campos personalizados
    buildFeatures {
        buildConfig = true
    }
    
    defaultConfig {
        // ✅ CORREGIDO: Debe coincidir con google-services.json
        applicationId = "com.goplus.repartidor.goplus_repartidor"
        minSdk = 23  // Android 6.0 - Para permisos de ubicación en background
        targetSdk = 35  // ✅ ACTUALIZADO: Android SDK 35
        versionCode = flutterVersionCode.toInt()
        versionName = flutterVersionName
        
        multiDexEnabled = true
        
        // Configuración específica para repartidor
        manifestPlaceholders["appAuthRedirectScheme"] = "com.goplus.repartidor.goplus_repartidor"
    }
    
    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
            isMinifyEnabled = true
            isShrinkResources = true
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
            
            // Optimizaciones para background location
            buildConfigField("boolean", "ENABLE_LOCATION_TRACKING", "true")
        }
        
        debug {
            signingConfig = signingConfigs.getByName("debug")
            isDebuggable = true
            buildConfigField("boolean", "ENABLE_LOCATION_TRACKING", "true")
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    // ✅ CORREGIDO: Usar versión específica
    implementation("org.jetbrains.kotlin:kotlin-stdlib-jdk7:1.8.22")
    
    // Firebase BoM
    implementation(platform("com.google.firebase:firebase-bom:32.7.0"))
    implementation("com.google.firebase:firebase-analytics")
    implementation("com.google.firebase:firebase-messaging")
    
    // Google Play Services - Versiones específicas para repartidor
    implementation("com.google.android.gms:play-services-maps:18.2.0")
    implementation("com.google.android.gms:play-services-location:21.0.1")
    
    // Background location tracking
    implementation("androidx.work:work-runtime:2.9.0")
    implementation("androidx.work:work-runtime-ktx:2.9.0")
    
    // MultiDex support
    implementation("androidx.multidex:multidex:2.0.1")
    
    // Lifecycle components para servicios
    implementation("androidx.lifecycle:lifecycle-service:2.7.0")
}