# Script de configuración inicial para GoPlus System
Write-Host "Configurando proyecto GoPlus System..." -ForegroundColor Cyan

# Comprobar requisitos previos
Write-Host "Comprobando requisitos previos..." -ForegroundColor Yellow
try {
    flutter --version | Out-Null
    firebase --version | Out-Null
    node --version | Out-Null
    git --version | Out-Null
    Write-Host "? Todos los requisitos previos están instalados" -ForegroundColor Green
} catch {
    Write-Host "? Error: Alguna herramienta requerida no está instalada" -ForegroundColor Red
    exit
}

# Instalar dependencias en paquetes compartidos
Write-Host "Instalando dependencias en paquetes compartidos..." -ForegroundColor Yellow
 = @("goplus_core", "goplus_firebase", "goplus_ui")
foreach ( in ) {
    Write-Host "Configurando ..." -ForegroundColor Yellow
    cd "../../packages/"
    flutter pub get
    cd "../../../tools/scripts/setup"
}

# Instalar dependencias en aplicaciones
Write-Host "Instalando dependencias en aplicaciones..." -ForegroundColor Yellow
 = @("cliente", "repartidor", "negocio", "admin")
foreach ( in ) {
    Write-Host "Configurando ..." -ForegroundColor Yellow
    cd "../../apps/"
    flutter pub get
    cd "../../../tools/scripts/setup"
}

# Configurar Firebase Functions
Write-Host "Configurando Firebase Functions..." -ForegroundColor Yellow
cd "../../firebase/functions"
npm install
cd "../../../tools/scripts/setup"

Write-Host "? Configuración completada con éxito" -ForegroundColor Green
