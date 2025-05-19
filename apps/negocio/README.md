# GoPlus Negocio

Aplicación web para negocios (restaurantes, tiendas) de la plataforma GoPlus, desarrollada con Flutter Web.

## Características

- Inicio de sesión
- Configuración de menú y productos
- Gestión de pedidos
- Reportes

## Estructura del proyecto

La aplicación sigue Clean Architecture:

- **lib/core/**: Utilidades, constantes, configuraciones
- **lib/data/**: Capa de datos (datasources, models, repositories)
- **lib/domain/**: Capa de dominio (entities, repositories, usecases)
- **lib/presentation/**: Capa de presentación (pages, providers, widgets)
