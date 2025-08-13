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

// ⚠️ CRÍTICO: Plugin de Google Services DEBE ir después de android plugin
apply plugin: 'com.google.gms.google-services'

android {
    namespace "com.goplus.cliente"
    compileSdkVersion 34 // Android 14
    ndkVersion flutter.ndkVersion

    compileOptions {
        sourceCompatibility JavaVersion.VERSION_1_8
        targetCompatibility JavaVersion.VERSION_1_8
    }

    kotlinOptions {
        jvmTarget = '1.8'
    }

    defaultConfig {
        applicationId "com.goplus.cliente"
        minSdkVersion 21    // Android 5.0 - Mínimo para Firebase
        targetSdkVersion 34 // Android 14 - Target actual
        versionCode flutterVersionCode.toInteger()
        versionName flutterVersionName
        
        // ⚠️ CRÍTICO: MultiDex para Firebase
        multiDexEnabled true
        
        // Configuración para Google Maps
        manifestPlaceholders = [
            'appAuthRedirectScheme': 'com.goplus.cliente'
        ]
    }

    buildTypes {
        release {
            signingConfig signingConfigs.debug
            
            // Optimizaciones de release
            minifyEnabled true
            shrinkResources true
            proguardFiles getDefaultProguardFile('proguard-android-optimize.txt'), 'proguard-rules.pro'
        }
        
        debug {
            signingConfig signingConfigs.debug
            debuggable true
        }
    }
}

flutter {
    source '../..'
}

dependencies {
    implementation "org.jetbrains.kotlin:kotlin-stdlib-jdk7:$kotlin_version"
    
    // ⚠️ CRÍTICO: Firebase BoM para gestión de versiones
    implementation platform('com.google.firebase:firebase-bom:32.7.0')
    implementation 'com.google.firebase:firebase-analytics'
    implementation 'com.google.firebase:firebase-messaging'
    
    // Google Play Services para Maps
    implementation 'com.google.android.gms:play-services-maps:18.2.0'
    implementation 'com.google.android.gms:play-services-location:21.0.1'
    
    // ⚠️ CRÍTICO: MultiDex support
    implementation 'androidx.multidex:multidex:2.0.1'
}