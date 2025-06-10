# tools/scripts/setup/setup_apps.ps1
Write-Host "Creando aplicaciones GoPlus..." -ForegroundColor Cyan

# Navegar al directorio de apps
cd ../../../apps

# Crear App Cliente (Android + iOS)
Write-Host "Creando app Cliente (Android + iOS)..." -ForegroundColor Yellow
flutter create cliente --platforms=android,ios --org com.goplus.cliente --project-name goplus_cliente

# Crear App Repartidor (Solo Android)
Write-Host "Creando app Repartidor (Android)..." -ForegroundColor Yellow
flutter create repartidor --platforms=android --org com.goplus.repartidor --project-name goplus_repartidor

# Crear App Negocio (Solo Web)
Write-Host "Creando app Negocio (Web)..." -ForegroundColor Yellow
flutter create negocio --platforms=web --org com.goplus.negocio --project-name goplus_negocio

# Crear App Admin (Solo Web)
Write-Host "Creando app Admin (Web)..." -ForegroundColor Yellow
flutter create admin --platforms=web --org com.goplus.admin --project-name goplus_admin

Write-Host "✅ Aplicaciones creadas exitosamente" -ForegroundColor Green

# Volver al directorio original
cd ../tools/scripts/setup