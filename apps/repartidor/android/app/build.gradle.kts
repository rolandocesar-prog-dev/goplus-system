def localProperties = new Properties()
def localPropertiesFile = rootProject.file('local.properties')
if (localPropertiesFile.exists()) {
    localPropertiesFile.withReader('UTF-8') { reader ->
        localProperties.load(reader)
    }
}

def flutterRoot = localProperties.getProperty('flutter.sdk')
if (flutterRoot == null) {
    throw new GradleException("Flutter SDK not found.")
}

def flutterVersionCode = localProperties.getProperty('flutter.versionCode')
if (flutterVersionCode == null) {
    flutterVersionCode = '1'
}

def flutterVersionName = localProperties.getProperty('flutter.versionName')
if (flutterVersionName == null) {
    flutterVersionName = '1.0'
}

apply plugin: 'com.android.application'
apply plugin: 'kotlin-android'
apply from: "$flutterRoot/packages/flutter_tools/gradle/flutter.gradle"

// ⚠️ CRÍTICO: Plugin de Google Services
apply plugin: 'com.google.gms.google-services'

android {
    namespace "com.goplus.repartidor"
    compileSdkVersion 34
    ndkVersion flutter.ndkVersion

    compileOptions {
        sourceCompatibility JavaVersion.VERSION_1_8
        targetCompatibility JavaVersion.VERSION_1_8
    }

    kotlinOptions {
        jvmTarget = '1.8'
    }

    defaultConfig {
        applicationId "com.goplus.repartidor"
        minSdkVersion 23    // Android 6.0 - Para permisos de ubicación en background
        targetSdkVersion 34
        versionCode flutterVersionCode.toInteger()
        versionName flutterVersionName
        
        multiDexEnabled true
        
        // Configuración específica para repartidor
        manifestPlaceholders = [
            'appAuthRedirectScheme': 'com.goplus.repartidor'
        ]
    }

    buildTypes {
        release {
            signingConfig signingConfigs.debug
            minifyEnabled true
            shrinkResources true
            proguardFiles getDefaultProguardFile('proguard-android-optimize.txt'), 'proguard-rules.pro'
            
            // Optimizaciones para background location
            buildConfigField "boolean", "ENABLE_LOCATION_TRACKING", "true"
        }
        
        debug {
            signingConfig signingConfigs.debug
            debuggable true
            buildConfigField "boolean", "ENABLE_LOCATION_TRACKING", "true"
        }
    }
}

flutter {
    source '../..'
}

dependencies {
    implementation "org.jetbrains.kotlin:kotlin-stdlib-jdk7:$kotlin_version"
    
    // Firebase BoM
    implementation platform('com.google.firebase:firebase-bom:32.7.0')
    implementation 'com.google.firebase:firebase-analytics'
    implementation 'com.google.firebase:firebase-messaging'
    
    // Google Play Services - Versiones específicas para repartidor
    implementation 'com.google.android.gms:play-services-maps:18.2.0'
    implementation 'com.google.android.gms:play-services-location:21.0.1'
    
    // ⚠️ CRÍTICO: Background location tracking
    implementation 'androidx.work:work-runtime:2.9.0'
    implementation 'androidx.work:work-runtime-ktx:2.9.0'
    
    // MultiDex support
    implementation 'androidx.multidex:multidex:2.0.1'
    
    // Lifecycle components para servicios
    implementation 'androidx.lifecycle:lifecycle-service:2.7.0'
}