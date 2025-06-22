# Script para configurar Firebase en GoPlus System
Write-Host "🔥 Configurando Firebase para GoPlus System..." -ForegroundColor Cyan

# Verificar que Firebase CLI esté instalado
try {
    firebase --version | Out-Null
    Write-Host "✅ Firebase CLI encontrado" -ForegroundColor Green
} catch {
    Write-Host "❌ Firebase CLI no encontrado. Instalando..." -ForegroundColor Red
    npm install -g firebase-tools
}

# Verificar que FlutterFire CLI esté instalado
try {
    flutterfire --version | Out-Null
    Write-Host "✅ FlutterFire CLI encontrado" -ForegroundColor Green
} catch {
    Write-Host "❌ FlutterFire CLI no encontrado. Instalando..." -ForegroundColor Red
    dart pub global activate flutterfire_cli
}

# Solicitar ID del proyecto Firebase
$projectId = Read-Host "Ingresa el ID de tu proyecto Firebase (ej: goplus-delivery)"

if ([string]::IsNullOrWhiteSpace($projectId)) {
    Write-Host "❌ ID de proyecto requerido" -ForegroundColor Red
    exit 1
}

Write-Host "🔧 Configurando proyecto: $projectId" -ForegroundColor Yellow

# Inicializar Firebase en el proyecto
Write-Host "📦 Inicializando Firebase..." -ForegroundColor Yellow
firebase use $projectId

# Instalar dependencias de Functions
Write-Host "📦 Instalando dependencias de Functions..." -ForegroundColor Yellow
cd firebase/functions
npm install
cd ../..

# Configurar cada aplicación Flutter usando la opción Flutter moderna
$apps = @("cliente", "repartidor", "negocio", "admin")

Write-Host "🎯 Usando Firebase Flutter Platform Option..." -ForegroundColor Cyan

# Guardar la ruta actual (raíz del proyecto)
$rootPath = Get-Location

foreach ($app in $apps) {
    Write-Host "🔧 Configurando $app con FlutterFire CLI..." -ForegroundColor Yellow
    
    # Navegar al directorio de la app
    $appPath = Join-Path $rootPath "apps\$app"
    Set-Location $appPath
    
    Write-Host "📁 Directorio actual: $appPath" -ForegroundColor Gray
    
    # Verificar que existe pubspec.yaml
    if (Test-Path "pubspec.yaml") {
        Write-Host "✅ pubspec.yaml encontrado" -ForegroundColor Green
        
        # Usar FlutterFire CLI con opción Flutter moderna
        flutterfire configure --project=$projectId --out=lib/firebase_options.dart
        
        if ($LASTEXITCODE -eq 0) {
            Write-Host "✅ $app configurado con Firebase Flutter Option" -ForegroundColor Green
            
            # Verificar que se generó el archivo correcto
            if (Test-Path "lib/firebase_options.dart") {
                Write-Host "  📄 firebase_options.dart generado correctamente" -ForegroundColor Green
            }
        } else {
            Write-Host "❌ Error configurando $app" -ForegroundColor Red
        }
    } else {
        Write-Host "❌ No se encontró pubspec.yaml en $appPath" -ForegroundColor Red
    }
    
    # Regresar a la raíz para la siguiente iteración
    Set-Location $rootPath
}

# Obtener dependencias para todos los paquetes
Write-Host "📦 Obteniendo dependencias..." -ForegroundColor Yellow
$packages = @("goplus_core", "goplus_firebase", "goplus_ui")

foreach ($package in $packages) {
    Write-Host "📦 $package..." -ForegroundColor Yellow
    cd "packages/$package"
    flutter pub get
    cd "../.."
}

# Obtener dependencias para todas las apps
foreach ($app in $apps) {
    Write-Host "📦 $app..." -ForegroundColor Yellow
    cd "apps/$app"
    flutter pub get
    cd "../.."
}

# Deploy de reglas de Firestore y Storage
Write-Host "🚀 Desplegando reglas de seguridad..." -ForegroundColor Yellow
firebase deploy --only firestore:rules,storage:rules

# Deploy de Functions
Write-Host "🚀 Desplegando Functions..." -ForegroundColor Yellow
firebase deploy --only functions

Write-Host "🎉 ¡Firebase configurado correctamente!" -ForegroundColor Green
Write-Host "📋 Próximos pasos:" -ForegroundColor Cyan
Write-Host "  1. Verifica que los archivos google-services.json estén en apps/*/android/app/" -ForegroundColor White
Write-Host "  2. Verifica que los archivos GoogleService-Info.plist estén en apps/*/ios/Runner/" -ForegroundColor White
Write-Host "  3. Configura los métodos de autenticación en Firebase Console" -ForegroundColor White
Write-Host "  4. Ejecuta 'firebase emulators:start' para desarrollo local" -ForegroundColor White