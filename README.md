# GoPlus System

Sistema integrado de delivery con cuatro aplicaciones:
- App Cliente (Android/iOS)
- App Repartidor (Android)
- App Negocio (Web)
- Panel Administrador (Web)

## Estructura del proyecto

El proyecto sigue Clean Architecture con MVVM y está organizado en:

- **apps/**: Aplicaciones individuales
  - cliente/
  - repartidor/
  - negocio/
  - admin/
- **packages/**: Paquetes compartidos
  - goplus_core/
  - goplus_firebase/
  - goplus_ui/
- **firebase/**: Código de backend Cloud Functions
- **tools/**: Scripts y herramientas de desarrollo

## Configuración de desarrollo

Sigue las instrucciones en [DEVELOPMENT.md](DEVELOPMENT.md) para configurar el entorno.
