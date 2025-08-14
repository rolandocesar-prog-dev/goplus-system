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

// ✅ LEER: API key para Google Maps
val googleMapsApiKey = localProperties.getProperty("GOOGLE_MAPS_API_KEY") 
    ?: throw GradleException("GOOGLE_MAPS_API_KEY not found in local.properties")

plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
    id("com.google.gms.google-services")
}

android {
    namespace = "com.goplus.repartidor.goplus_repartidor"
    compileSdk = 35
    
    // ✅ CRÍTICO: Habilitar Core Library Desugaring
    compileOptions {
        isCoreLibraryDesugaringEnabled = true
        sourceCompatibility = JavaVersion.VERSION_1_8
        targetCompatibility = JavaVersion.VERSION_1_8
    }
    
    kotlinOptions {
        jvmTarget = "1.8"
    }

    buildFeatures {
        buildConfig = true
    }
    
    defaultConfig {
        applicationId = "com.goplus.repartidor.goplus_repartidor"
        minSdk = 23  // Android 6.0 - Para repartidores (dispositivos modernos)
        targetSdk = 35
        versionCode = flutterVersionCode.toInt()
        versionName = flutterVersionName
        
        multiDexEnabled = true
        
        // ✅ CONFIGURAR: Placeholders para manifest
        manifestPlaceholders["GOOGLE_MAPS_API_KEY"] = googleMapsApiKey
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
    // ✅ CRÍTICO: Core Library Desugaring para compatibilidad
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.0.4")
    
    // ✅ KOTLIN: Versión estable
    implementation("org.jetbrains.kotlin:kotlin-stdlib-jdk8:1.8.22")
    
    // ✅ FIREBASE: BoM para gestión de versiones
    implementation(platform("com.google.firebase:firebase-bom:32.7.0"))
    implementation("com.google.firebase:firebase-analytics")
    implementation("com.google.firebase:firebase-messaging")
    
    // ✅ GOOGLE PLAY SERVICES: Maps y Location
    implementation("com.google.android.gms:play-services-maps:18.2.0")
    implementation("com.google.android.gms:play-services-location:21.1.0")
    
    // ❌ REMOVIDO: WorkManager (causaba problemas de compatibilidad)
    // implementation("androidx.work:work-runtime-ktx:2.9.1")
    
    // ✅ MULTIDEX: Soporte para Firebase
    implementation("androidx.multidex:multidex:2.0.1")
    
    // ✅ LIFECYCLE: Para servicios de ubicación
    implementation("androidx.lifecycle:lifecycle-service:2.7.0")
}