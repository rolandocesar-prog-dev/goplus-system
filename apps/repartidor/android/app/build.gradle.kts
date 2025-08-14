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

// ✅ AÑADIR: Leer la API key
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
    
    // ✅ CRÍTICO: Habilitar Core Library Desugaring para flutter_local_notifications
    compileOptions {
        // ✅ NUEVO: Habilitar desugaring para APIs de Java 8+
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
        minSdk = 23
        targetSdk = 35
        versionCode = flutterVersionCode.toInt()
        versionName = flutterVersionName
        
        multiDexEnabled = true
        
        // ✅ AÑADIR: Configurar placeholders
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
    // ✅ CRÍTICO: Core Library Desugaring - NUEVA DEPENDENCIA REQUERIDA
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.0.4")
    
    implementation("org.jetbrains.kotlin:kotlin-stdlib-jdk7:1.8.22")
    
    // Firebase BoM
    implementation(platform("com.google.firebase:firebase-bom:32.7.0"))
    implementation("com.google.firebase:firebase-analytics")
    implementation("com.google.firebase:firebase-messaging")
    
    // Google Play Services
    implementation("com.google.android.gms:play-services-maps:18.2.0")
    implementation("com.google.android.gms:play-services-location:21.0.1")
    
    // ✅ ACTUALIZAR: WorkManager con versiones más estables
    implementation("androidx.work:work-runtime-ktx:2.9.0")
    
    // MultiDex support
    implementation("androidx.multidex:multidex:2.0.1")
    
    // Lifecycle components
    implementation("androidx.lifecycle:lifecycle-service:2.7.0")
}