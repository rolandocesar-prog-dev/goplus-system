# GoPlus Tools & Scripts

Herramientas y scripts para el desarrollo, despliegue y pruebas de GoPlus System.

## Scripts disponibles

### Setup
- **setup_project.ps1**: Configura el proyecto completo (dependencias, paquetes)

### CI
- **run_tests.ps1**: Ejecuta todas las pruebas unitarias e integradas

### Deploy
- Scripts para automatizar el despliegue en diferentes entornos

## Uso

Los scripts deben ejecutarse desde PowerShell:

`powershell
# Desde la raíz del proyecto
./tools/scripts/setup/setup_project.ps1

# O desde el directorio del script
cd tools/scripts/setup
./setup_project.ps1
