# 🚀 GoPlus - Sistema de Delivery Completo

GoPlus es un sistema completo de delivery que conecta clientes, repartidores y negocios en una plataforma integrada, construida con Flutter y Firebase.

## 📱 Aplicaciones del Sistema

| App            | Plataforma  | Descripción                               |
| -------------- | ----------- | ----------------------------------------- |
| **Cliente**    | Android/iOS | App para usuarios que realizan pedidos    |
| **Repartidor** | Android     | App para deliverys que gestionan entregas |
| **Negocio**    | Web         | Dashboard para restaurantes y comercios   |
| **Admin**      | Web         | Panel de administración del sistema       |

## 🏗️ Arquiractura del Proyecto

### Monorepo Structure

```
goplus_system/
├── apps/                    # Aplicaciones principales
│   ├── cliente/            # App móvil para clientes
│   ├── repartidor/         # App móvil para repartidores
│   ├── negocio/            # App web para negocios
│   └── admin/              # Panel web de administración
├── packages/               # Packages compartidos
│   ├── goplus_core/        # Modelos, servicios y widgets básicos
│   ├── goplus_firebase/    # Abstracciones de Firebase
│   └── goplus_ui/          # Componentes UI avanzados
├── firebase/               # Backend y Cloud Functions
│   └── functions/          # Cloud Functions
└── tools/                  # Scripts y herramientas
    └── scripts/            # Scripts de automatización
```

### Stack Tecnológico

- **Frontend**: Flutter 3.10+ (Dart 3.0+)
- **Backend**: Firebase (Functions, Firestore, Auth, Storage)
- **Autenticación**: Firebase Auth + Google/Apple ID
- **Base de Datos**: Cloud Firestore
- **Notificaciones**: Firebase Cloud Messaging
- **Mapas**: Google Maps API
- **CI/CD**: Scripts PowerShell automatizados

## 🚀 Inicio Rápido

### Prerrequisitos

- Flutter SDK 3.10+
- Dart SDK 3.0+
- Firebase CLI
- Android Studio / VS Code
- Git

### Instalación

1. **Clonar el repositorio**

```bash
git clone https://github.com/tu-usuario/goplus_system.git
cd goplus_system
```

2. **Configurar dependencias**

```bash
# Usando VS Code task
Ctrl+Shift+P -> "Tasks: Run Task" -> "Flutter: Get All Dependencies"

# O manualmente
./tools/scripts/setup/setup_project.ps1
```

3. **Configurar Firebase**

```bash
cd firebase/functions
npm install
firebase use --add tu-proyecto-firebase
```

4. **Ejecutar aplicaciones**

```bash
# Cliente (Android/iOS)
cd apps/cliente && flutter run

# Repartidor (Android)
cd apps/repartidor && flutter run

# Negocio (Web)
cd apps/negocio && flutter run -d chrome

# Admin (Web)
cd apps/admin && flutter run -d chrome
```

## ⚙️ Comandos Disponibles

### Flutter Tasks (VS Code)

- `Flutter: Run Cliente App`
- `Flutter: Run Repartidor App`
- `Flutter: Run Negocio App (Web)`
- `Flutter: Run Admin App (Web)`
- `Flutter: Get All Dependencies`
- `Flutter: Run All Tests`

### Scripts Manuales

```bash
# Setup completo del proyecto
./tools/scripts/setup/setup_project.ps1

# Ejecutar todos los tests
./tools/scripts/ci/run_tests.ps1

# Deploy Firebase Functions
cd firebase/functions && npm run deploy
```

## 🧪 Testing

```bash
# Ejecutar todos los tests
./tools/scripts/ci/run_tests.ps1

# Tests por package/app individual
cd packages/goplus_core && flutter test
cd apps/cliente && flutter test
```

## 📚 Documentación Adicional

- [App Cliente](./apps/cliente/README.md) - Funcionalidades para usuarios finales
- [App Repartidor](./apps/repartidor/README.md) - Herramientas para deliverys
- [App Negocio](./apps/negocio/README.md) - Dashboard para comercios
- [Panel Admin](./apps/admin/README.md) - Administración del sistema
- [GoPlus Core](./packages/goplus_core/README.md) - Biblioteca compartida base
- [GoPlus Firebase](./packages/goplus_firebase/README.md) - Servicios Firebase
- [GoPlus UI](./packages/goplus_ui/README.md) - Componentes UI avanzados

## 🤝 Contribución

1. Fork el proyecto
2. Crea una branch para tu feature (`git checkout -b feature/AmazingFeature`)
3. Commit tus cambios (`git commit -m 'Add some AmazingFeature'`)
4. Push a la branch (`git push origin feature/AmazingFeature`)
5. Abre un Pull Request

### Estándares de Código

- Seguir las reglas de `analysis_options.yaml`
- Usar `flutter format` antes de commit
- Escribir tests para nuevas funcionalidades
- Documentar APIs públicas

## 📄 Licencia

Este proyecto está bajo la Licencia MIT - ver el archivo [LICENSE](LICENSE) para detalles.

## 📞 Contacto

- **Desarrollador**: [Rolando Vasquez]
- **Email**: [rolando.sha256@gmail.com]
- **Proyecto**: [https://github.com/rolandocesar-prog-dev/goplus-system]

---

## 🎯 Roadmap

- [ ] Implementación de pagos con tarjeta
- [ ] Chat en tiempo real cliente-repartidor
- [ ] Sistema de cupones y promociones
- [ ] Analytics avanzados
- [ ] API REST complementaria
- [ ] App para smartwatch (repartidores)
