# 📱 GoPlus - App Cliente

App móvil para usuarios finales que realizan pedidos de comida y productos a través de la plataforma GoPlus.

## 🎯 Características Principales

### 🔐 Autenticación y Perfil

- ✅ Registro con Google/Apple ID
- ✅ Verificación por SMS
- ✅ Recuperación de cuenta
- ✅ Gestión de perfil personal
- ✅ Múltiples direcciones de entrega
- ✅ Métodos de pago (QR, efectivo)

### 🔍 Navegación y Búsqueda

- ✅ Búsqueda de negocios por nombre/categoría
- ✅ Exploración de menús con imágenes
- ✅ Filtros por precio, rating, tiempo de entrega
- ✅ Vista de mapa de negocios cercanos

### 🛒 Gestión de Pedidos

- ✅ Carrito de compras intuitivo
- ✅ Cálculo automático de costos
- ✅ Selección de dirección y pago
- ✅ Seguimiento en tiempo real
- ✅ Notificaciones de estado

### 📊 Historial y Valoraciones

- ✅ Historial completo de pedidos
- ✅ Reordenar pedidos favoritos
- ✅ Calificar negocios y repartidores
- ✅ Sistema de comentarios

## 🚀 Ejecución

### Desarrollo

```bash
# Navegar a la carpeta
cd apps/cliente

# Instalar dependencias
flutter pub get

# Ejecutar en desarrollo
flutter run

# Ejecutar en dispositivo específico
flutter run -d [device-id]
```

### VS Code

- Usar la configuración `Cliente Debug` en el debugger
- O ejecutar task: `Flutter: Run Cliente App`

### Build

```bash
# Android APK
flutter build apk --release

# Android App Bundle
flutter build appbundle --release

# iOS (requiere macOS y Xcode)
flutter build ios --release
```

## 📱 Screenshots

```
[Aquí irían screenshots de la app]
- Pantalla de login
- Home con negocios
- Detalle de menú
- Carrito de compras
- Seguimiento de pedido
- Perfil de usuario
```

## ⚙️ Configuración

### Variables de Entorno

La app usa configuración desde Firebase y packages compartidos:

```dart
// Configuración automática desde goplus_core
import 'package:goplus_core/goplus_core.dart';
import 'package:goplus_firebase/goplus_firebase.dart';
```

### Permisos Necesarios

#### Android (`android/app/src/main/AndroidManifest.xml`)

```xml
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
<uses-permission android:name="android.permission.CAMERA" />
```

#### iOS (`ios/Runner/Info.plist`)

```xml
<key>NSLocationWhenInUseUsageDescription</key>
<string>Para encontrar negocios cercanos</string>
<key>NSCameraUsageDescription</key>
<string>Para escanear códigos QR de pago</string>
```

## 🏗️ Arquitectura

### Estructura de Carpetas

```
lib/
├── main.dart                 # Entry point
├── app/                      # App configuration
├── features/                 # Features por módulo
│   ├── auth/                 # Autenticación
│   ├── home/                 # Pantalla principal
│   ├── search/               # Búsqueda de negocios
│   ├── menu/                 # Menús y productos
│   ├── cart/                 # Carrito de compras
│   ├── orders/               # Gestión de pedidos
│   ├── profile/              # Perfil de usuario
│   └── notifications/        # Notificaciones
├── shared/                   # Widgets y utils compartidos
└── core/                     # Configuración base
```

### Patrón de Arquitectura

- **Clean Architecture** con separation of concerns
- **BLoC Pattern** para state management
- **Repository Pattern** para acceso a datos
- **Dependency Injection** con get_it

### Dependencias Principales

```yaml
dependencies:
  # GoPlus packages
  goplus_core: { path: ../../packages/goplus_core }
  goplus_firebase: { path: ../../packages/goplus_firebase }
  goplus_ui: { path: ../../packages/goplus_ui }

  # State Management
  flutter_bloc: ^8.1.3

  # Navigation
  go_router: ^12.1.3

  # Maps & Location
  google_maps_flutter: ^2.5.0
  geolocator: ^10.1.0

  # QR Scanner
  qr_code_scanner: ^1.0.1
```

## 🧪 Testing

```bash
# Ejecutar tests
flutter test

# Tests con coverage
flutter test --coverage

# Integration tests
flutter drive --target=test_driver/app.dart
```

### Tests Incluidos

- ✅ Unit tests para business logic
- ✅ Widget tests para UI components
- ✅ Integration tests para flujos críticos
- ✅ Golden tests para verificar UI

## 🔧 Troubleshooting

### Problemas Comunes

**Error de compilación Android**

```bash
cd android
./gradlew clean
cd ..
flutter clean && flutter pub get
```

**Problemas con mapas**

- Verificar API key de Google Maps
- Confirmar permisos de ubicación
- Revisar configuración en Firebase

**Issues con autenticación**

- Verificar configuración de Firebase Auth
- Confirmar fingerprints SHA en Firebase Console
- Revisar configuración de Google/Apple Sign In

## 📈 Performance

### Optimizaciones Implementadas

- ✅ Lazy loading de imágenes
- ✅ Paginación en listados
- ✅ Cache de datos frecuentes
- ✅ Optimización de builds
- ✅ Tree shaking automático

### Métricas Target

- 📊 Tiempo de carga inicial: < 3s
- 📊 Tiempo de navegación: < 500ms
- 📊 Memoria RAM: < 150MB
- 📊 Tamaño APK: < 50MB

## 🚀 Deployment

### Play Store (Android)

1. Configurar signing keys
2. Incrementar version en `pubspec.yaml`
3. Build release: `flutter build appbundle`
4. Upload a Play Console

### App Store (iOS)

1. Configurar certificates en Xcode
2. Build: `flutter build ios --release`
3. Archive y upload desde Xcode

---

## 📞 Support

Para issues específicos de la app cliente:

- Revisar [issues conocidos](../docs/known-issues.md)
- Crear issue en el repositorio
- Contactar al equipo de desarrollo
