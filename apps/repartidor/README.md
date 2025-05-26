# 🏍️ GoPlus - App Repartidor

Aplicación móvil para repartidores que gestionan las entregas de pedidos en la plataforma GoPlus.

## 🎯 Características Principales

### 🔐 Autenticación

- ✅ Login con usuario y contraseña
- ✅ Recuperación de cuenta
- ✅ Verificación de repartidor activo

### ⚡ Gestión de Disponibilidad

- ✅ Toggle ON/OFF para recibir pedidos
- ✅ Estado en tiempo real visible para el sistema
- ✅ Configuración de horarios de trabajo
- ✅ Pausa automática por inactividad

### 📦 Gestión de Pedidos

- ✅ Notificaciones de nuevos pedidos
- ✅ Aceptar/rechazar pedidos asignados
- ✅ Vista detallada del pedido y ubicaciones
- ✅ Confirmar recojo en el negocio
- ✅ Confirmar entrega al cliente
- ✅ Sistema de códigos de verificación

### 🗺️ Navegación Inteligente

- ✅ Integración con Google Maps
- ✅ Rutas optimizadas automáticas
- ✅ GPS en tiempo real
- ✅ Actualizaciones de ubicación al sistema
- ✅ Modo offline básico

### 💰 Control de Ganancias

- ✅ Dashboard de ganancias diarias/semanales
- ✅ Historial detallado de entregas
- ✅ Estadísticas de rendimiento
- ✅ Cálculo automático de comisiones

## 🚀 Ejecución

### Desarrollo

```bash
# Navegar a la carpeta
cd apps/repartidor

# Instalar dependencias
flutter pub get

# Ejecutar en desarrollo
flutter run

# Solo Android (esta app es solo para Android)
flutter run -d android
```

### VS Code

- Usar la configuración `Repartidor Debug` en el debugger
- O ejecutar task: `Flutter: Run Repartidor App`

### Build

```bash
# Android APK
flutter build apk --release

# Android App Bundle
flutter build appbundle --release
```

## 📱 Flujo de Trabajo del Repartidor

### 1. **Activación**

```
Login → Activar Disponibilidad → Esperar Pedidos
```

### 2. **Recepción de Pedido**

```
Notificación → Ver Detalles → Aceptar/Rechazar
```

### 3. **Proceso de Entrega**

```
Ir al Negocio → Confirmar Recojo → Ir al Cliente → Confirmar Entrega
```

### 4. **Estados del Pedido**

- 🟡 **Asignado**: Pedido recién asignado
- 🔵 **Aceptado**: Repartidor confirmó
- 🟠 **En Camino**: Dirigiéndose al negocio
- 🟢 **Recogido**: Producto en posesión
- 🟣 **En Entrega**: Camino al cliente
- ✅ **Entregado**: Completado exitosamente

## ⚙️ Configuración

### Permisos Críticos

#### Android (`android/app/src/main/AndroidManifest.xml`)

```xml
<!-- Permisos esenciales -->
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_BACKGROUND_LOCATION" />

<!-- Para mantener GPS activo -->
<uses-permission android:name="android.permission.WAKE_LOCK" />
<uses-permission android:name="android.permission.FOREGROUND_SERVICE" />

<!-- Para llamadas al cliente -->
<uses-permission android:name="android.permission.CALL_PHONE" />
```

### Variables de Configuración

```dart
// Configuración específica del repartidor
class DeliveryConfig {
  static const double maxDeliveryRadius = 15.0; // km
  static const int locationUpdateInterval = 10; // segundos
  static const int maxOrdersPerDay = 50;
  static const double baseCommission = 0.15; // 15%
}
```

## 🏗️ Arquitectura

### Estructura de Carpetas

```
lib/
├── main.dart                    # Entry point
├── app/                         # App configuration
├── features/                    # Features del repartidor
│   ├── auth/                    # Autenticación
│   ├── dashboard/               # Dashboard principal
│   ├── availability/            # Control de disponibilidad
│   ├── orders/                  # Gestión de pedidos
│   │   ├── assignment/          # Asignación de pedidos
│   │   ├── pickup/              # Recojo en negocio
│   │   └── delivery/            # Entrega al cliente
│   ├── navigation/              # Integración con mapas
│   ├── earnings/                # Control de ganancias
│   └── profile/                 # Perfil del repartidor
├── services/                    # Servicios específicos
│   ├── location_service.dart    # GPS y tracking
│   ├── delivery_service.dart    # Lógica de entregas
│   └── earnings_service.dart    # Cálculo de ganancias
└── widgets/                     # Widgets específicos
```

### Servicios Clave

#### 📍 LocationService

```dart
class LocationService {
  // Tracking continuo del repartidor
  Stream<Position> trackLocation();

  // Actualizar ubicación en tiempo real
  Future<void> updateLocationToServer(Position position);

  // Calcular distancia y tiempo estimado
  Future<RouteInfo> calculateRoute(LatLng from, LatLng to);
}
```

#### 🚚 DeliveryService

```dart
class DeliveryService {
  // Gestionar estado de disponibilidad
  Future<void> setAvailability(bool available);

  // Aceptar/rechazar pedidos
  Future<void> acceptOrder(String orderId);
  Future<void> rejectOrder(String orderId, String reason);

  // Confirmar recojo y entrega
  Future<void> confirmPickup(String orderId, String code);
  Future<void> confirmDelivery(String orderId, String code);
}
```

### Dependencias Principales

```yaml
dependencies:
  # GoPlus packages
  goplus_core: { path: ../../packages/goplus_core }
  goplus_firebase: { path: ../../packages/goplus_firebase }
  goplus_ui: { path: ../../packages/goplus_ui }

  # Maps & Location
  google_maps_flutter: ^2.5.0
  geolocator: ^10.1.0
  location: ^5.0.3

  # Background services
  workmanager: ^0.5.1

  # Phone calls
  url_launcher: ^6.2.1

  # Audio notifications
  just_audio: ^0.9.36

  # State Management
  flutter_bloc: ^8.1.3

  # Local notifications
  flutter_local_notifications: ^16.3.0
```

## 🔔 Sistema de Notificaciones

### Tipos de Notificaciones

- 🔥 **Pedido Nuevo**: Vibración + sonido + notificación push
- 📍 **Cambio de Ruta**: Notificación silenciosa
- 💰 **Ganancia Actualizada**: Notificación informativa
- ⚠️ **Alerta del Sistema**: Notificación crítica

### Configuración de Sonidos

```dart
// Sonidos personalizados para repartidores
class DeliveryNotifications {
  static const String newOrderSound = 'new_order_alert.mp3';
  static const String completionSound = 'delivery_complete.mp3';
  static const Duration vibrationPattern = Duration(milliseconds: 1000);
}
```

## 📊 Métricas y Analytics

### KPIs del Repartidor

- 📦 **Entregas por día/semana/mes**
- ⏱️ **Tiempo promedio por entrega**
- 📍 **Distancia total recorrida**
- ⭐ **Rating promedio del cliente**
- 💰 **Ganancias totales**
- 🚫 **Tasa de rechazos**

### Dashboard Analytics

```dart
class DeliveryMetrics {
  final int totalDeliveries;
  final double averageDeliveryTime; // minutos
  final double totalEarnings;
  final double averageRating;
  final int completionRate; // porcentaje
  final double totalDistance; // km
}
```

## 🧪 Testing

### Tests Específicos

```bash
# Tests de lógica de entrega
flutter test test/features/orders/

# Tests de servicios de ubicación
flutter test test/services/location_service_test.dart

# Tests de cálculo de ganancias
flutter test test/services/earnings_service_test.dart
```

### Tests de Integración

- ✅ Flujo completo de entrega
- ✅ Actualización de ubicación en tiempo real
- ✅ Cálculo correcto de ganancias
- ✅ Manejo de estados offline

## 🔧 Troubleshooting

### Problemas Comunes

**GPS no funciona correctamente**

```bash
# Verificar permisos
- Ubicación precisa habilitada
- Permisos de ubicación en segundo plano
- GPS del dispositivo activado
```

**No recibe pedidos**

```bash
# Verificar estado
- Repartidor marcado como disponible
- Conexión a internet estable
- Notificaciones habilitadas
- Dentro del radio de cobertura
```

**Problemas con Google Maps**

```bash
# Verificar configuración
- API key válida en Firebase
- Servicios de Google Play actualizados
- Permisos de ubicación otorgados
```

## ⚡ Optimizaciones de Batería

### Configuraciones Críticas

```dart
// Optimizar uso de batería
class BatteryOptimizer {
  // Reducir frecuencia de GPS cuando está parado
  static const int stationaryUpdateInterval = 30; // segundos
  static const int movingUpdateInterval = 5;      // segundos

  // Pausar tracking cuando no hay pedidos
  static bool shouldTrackLocation(DeliveryState state) {
    return state.isAvailable && state.hasActivePedidos;
  }
}
```

### Recomendaciones al Repartidor

- 📱 Mantener app en primer plano durante entregas
- 🔋 Usar cargador de vehículo
- 📶 Verificar señal antes de aceptar pedidos
- 🗺️ Descargar mapas offline del área de trabajo

## 🚀 Deployment

### Play Store

```bash
# Build optimizado para repartidores
flutter build appbundle --release \
  --target-platform android-arm,android-arm64,android-x64 \
  --obfuscate --split-debug-info=build/debug-info/
```

### Configuración Específica

- 🎯 **Target SDK**: Android 13+ (API 33+)
- 📱 **Dispositivos**: Smartphones con GPS
- 🔋 **Optimización**: Background processing habilitado
- 📍 **Ubicación**: Precisión alta requerida

---

## 📞 Support

Para issues específicos de repartidores:

- Verificar conectividad GPS
- Confirmar permisos de ubicación
- Revisar estado de disponibilidad en el sistema
- Contactar soporte técnico con logs del dispositivo
