# Script para ejecutar todos los tests
Write-Host "Ejecutando tests para GoPlus System..." -ForegroundColor Cyan

 = 0

# Ejecutar tests en paquetes compartidos
Write-Host "Ejecutando tests en paquetes compartidos..." -ForegroundColor Yellow
 = @("goplus_core", "goplus_firebase", "goplus_ui")
foreach ( in ) {
    Write-Host "Testing ..." -ForegroundColor Yellow
    cd "../../packages/"
    flutter test
    if ( -ne 0) {
         = 
        Write-Host "? Tests fallidos en " -ForegroundColor Red
    }
    cd "../../../tools/scripts/ci"
}

# Ejecutar tests en aplicaciones
Write-Host "Ejecutando tests en aplicaciones..." -ForegroundColor Yellow
 = @("cliente", "repartidor", "negocio", "admin")
foreach ( in ) {
    Write-Host "Testing ..." -ForegroundColor Yellow
    cd "../../apps/"
    flutter test
    if ( -ne 0) {
         = 
        Write-Host "? Tests fallidos en " -ForegroundColor Red
    }
    cd "../../../tools/scripts/ci"
}

if ( -eq 0) {
    Write-Host "? Todos los tests pasaron correctamente" -ForegroundColor Green
} else {
    Write-Host "? Algunos tests fallaron. Revisa los errores anteriores." -ForegroundColor Red
}

exit 
