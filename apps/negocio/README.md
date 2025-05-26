# 🏪 GoPlus - App Negocio

Dashboard web para restaurantes y comercios que gestionan sus menús, pedidos y ventas en la plataforma GoPlus.

## 🎯 Características Principales

### 🔐 Autenticación y Perfil

- ✅ Login con usuario y contraseña
- ✅ Recuperación de cuenta
- ✅ Perfil completo del negocio
- ✅ Verificación de documentos (RUC, licencias)
- ✅ Configuración de datos bancarios

### ⚙️ Configuración del Negocio

- ✅ **Información básica**: Nombre, descripción, categoría
- ✅ **Horarios de atención** personalizables
- ✅ **Tiempo de preparación** por tipo de producto
- ✅ **Radio de entrega** y zonas de cobertura
- ✅ **Comisiones y tarifas** negociadas
- ✅ **Configuración de notificaciones**

### 📝 Gestión de Menú

- ✅ **Crear y editar productos** con imágenes HD
- ✅ **Categorización** y organización del menú
- ✅ **Precios dinámicos** y ofertas especiales
- ✅ **Disponibilidad** en tiempo real
- ✅ **Ingredientes y alérgenos**
- ✅ **Variaciones** de productos (tamaños, extras)

### 📦 Gestión de Pedidos

- ✅ **Dashboard en tiempo real** de pedidos
- ✅ **Notificaciones instantáneas** de nuevos pedidos
- ✅ **Aceptar/rechazar** pedidos según capacidad
- ✅ **Actualizar estado** (preparando, listo, entregado)
- ✅ **Tiempo estimado** de preparación dinámico
- ✅ **Comunicación directa** con repartidores

### 📊 Reportes y Analytics

- ✅ **Dashboard de ventas** diario/semanal/mensual
- ✅ **Productos más vendidos** y análisis de rendimiento
- ✅ **Horarios pico** de mayor demanda
- ✅ **Calificaciones y comentarios** de clientes
- ✅ **Análisis de ganancias** y comisiones
- ✅ **Exportación de datos** a Excel/PDF

## 🚀 Ejecución

### Desarrollo

```bash
# Navegar a la carpeta
cd apps/negocio

# Instalar dependencias
flutter pub get

# Ejecutar en desarrollo (Web)
flutter run -d chrome

# Ejecutar en modo debug
flutter run -d chrome --debug

# Ejecutar en modo release
flutter run -d chrome --release
```

### VS Code

- Usar la configuración `Negocio Debug (Web)` en el debugger
- O ejecutar task: `Flutter: Run Negocio App (Web)`

### Build para Producción

```bash
# Build optimizado para web
flutter build web --release

# Build con optimizaciones específicas
flutter build web --release --web-renderer canvaskit --base-href /negocio/
```

## 🌐 Deployment Web

### Hosting Options

```bash
# Firebase Hosting
firebase deploy --only hosting:negocio

# Servidor propio
# Copiar carpeta build/web/ a tu servidor HTTP
```

### Configuración de Dominio

```
# Subdominios sugeridos:
negocio.goplus.com
dashboard.goplus.com
business.goplus.com
```

## 🏗️ Arquitectura

### Estructura de Carpetas

```
lib/
├── main.dart                    # Entry point
├── app/                         # App configuration
├── features/                    # Features del negocio
│   ├── auth/                    # Autenticación
│   ├── dashboard/               # Dashboard principal
│   │   ├── widgets/             # Widgets del dashboard
│   │   └── analytics/           # Analytics y métricas
│   ├── menu/                    # Gestión de menú
│   │   ├── products/            # CRUD de productos
│   │   ├── categories/          # Gestión de categorías
│   │   └── pricing/             # Gestión de precios
│   ├── orders/                  # Gestión de pedidos
│   │   ├── incoming/            # Pedidos entrantes
│   │   ├── active/              # Pedidos activos
│   │   ├── history/             # Historial
│   │   └── status/              # Control de estados
│   ├── reports/                 # Reportes y estadísticas
│   │   ├── sales/               # Reportes de ventas
│   │   ├── products/            # Análisis de productos
│   │   └── export/              # Exportación de datos
│   ├── settings/                # Configuración
│   │   ├── business_info/       # Info del negocio
│   │   ├── hours/               # Horarios
│   │   └── notifications/       # Preferencias
│   └── profile/                 # Perfil del negocio
├── shared/                      # Widgets compartidos
│   ├── layouts/                 # Layouts del dashboard
│   ├── forms/                   # Formularios comunes
│   └── charts/                  # Gráficos y visualizaciones
└── core/                        # Configuración base
```

### Responsive Design

```dart
// Layout adaptativo para diferentes pantallas
class ResponsiveLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 1200) {
          return DesktopLayout();      // > 1200px
        } else if (constraints.maxWidth > 800) {
          return TabletLayout();       // 800-1200px
        } else {
          return MobileLayout();       // < 800px
        }
      },
    );
  }
}
```

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

  # Forms & Validation
  reactive_forms: ^14.1.0

  # Charts & Visualizations
  fl_chart: ^0.66.0
  syncfusion_flutter_charts: ^23.2.7

  # File handling
  file_picker: ^6.1.1
  excel: ^2.1.0
  pdf: ^3.10.7

  # Image handling
  image_picker: ^1.0.4
  cached_network_image: ^3.3.1

  # Data tables
  data_table_2: ^2.5.12

  # Notifications
  flutter_local_notifications: ^16.3.0

  # Audio alerts
  just_audio: ^0.9.36
```

## 📊 Dashboard Features

### 📈 Analytics Dashboard

```dart
class BusinessAnalytics {
  // Métricas clave
  final double todayRevenue;
  final int todayOrders;
  final double averageOrderValue;
  final double weeklyGrowth;

  // Productos destacados
  final List<Product> topProducts;
  final List<Product> lowStockProducts;

  // Horarios pico
  final Map<int, int> hourlyOrders; // hora -> cantidad
  final Map<String, double> categoryRevenue;
}
```

### 🔔 Sistema de Notificaciones

```dart
class OrderNotificationSystem {
  // Tipos de notificaciones
  static const String newOrder = 'new_order';
  static const String orderTimeout = 'order_timeout';
  static const String lowStock = 'low_stock';
  static const String dailyReport = 'daily_report';

  // Configuración de sonidos
  static const String orderSound = 'order_alert.mp3';
  static const Duration vibrationPattern = Duration(milliseconds: 500);

  // Envío de notificaciones
  void playOrderAlert() {
    // Reproducir sonido
    // Mostrar notificación visual
    // Vibrar (si es tablet/híbrido)
  }
}
```

### 📝 Gestión de Menú Avanzada

```dart
class MenuManagement {
  // Estructura de productos
  class Product {
    final String id;
    final String name;
    final String description;
    final List<String> images;
    final double basePrice;
    final List<ProductVariation> variations;
    final List<String> allergens;
    final bool isAvailable;
    final int preparationTime; // minutos
    final String category;
  }

  // Variaciones de productos
  class ProductVariation {
    final String name;        // "Tamaño", "Extra"
    final List<String> options; // ["Pequeño", "Mediano", "Grande"]
    final List<double> prices;   // [10.0, 15.0, 20.0]
  }
}
```

## 📱 Responsive Design

### Breakpoints

```dart
class Breakpoints {
  static const double mobile = 600;
  static const double tablet = 900;
  static const double desktop = 1200;
  static const double wide = 1600;
}
```

### Layout Adaptativo

- **📱 Mobile (< 600px)**: Stack vertical, menú hamburguesa
- **📱 Tablet (600-900px)**: Sidebar colapsable, grid 2 columnas
- **💻 Desktop (900-1200px)**: Sidebar fijo, grid 3 columnas
- **🖥️ Wide (> 1200px)**: Dashboard completo, múltiples paneles

## 🔔 Notificaciones en Tiempo Real

### WebSocket Integration

```dart
class RealtimeOrderService {
  late WebSocketChannel _channel;

  void connectToOrderStream() {
    _channel = WebSocketChannel.connect(
      Uri.parse('wss://goplus-api.com/orders/stream'),
    );

    _channel.stream.listen((message) {
      final orderData = json.decode(message);
      _handleNewOrder(orderData);
    });
  }

  void _handleNewOrder(Map<String, dynamic> orderData) {
    // Reproducir sonido de alerta
    _playOrderAlert();

    // Mostrar notificación visual
    _showOrderNotification(orderData);

    // Actualizar contador de pedidos
    _updateOrderCount();
  }
}
```

### Configuración de Alertas

```dart
class NotificationSettings {
  bool soundEnabled = true;
  bool visualEnabled = true;
  bool emailEnabled = false;

  // Horarios de notificación
  TimeOfDay startTime = TimeOfDay(hour: 8, minute: 0);
  TimeOfDay endTime = TimeOfDay(hour: 22, minute: 0);

  // Tipos de alertas
  Set<String> enabledAlerts = {
    'new_order',
    'order_timeout',
    'low_stock',
  };
}
```

## 📊 Reportes Avanzados

### Tipos de Reportes

```dart
class ReportTypes {
  // Reportes de ventas
  static const String dailySales = 'daily_sales';
  static const String weeklySales = 'weekly_sales';
  static const String monthlySales = 'monthly_sales';

  // Reportes de productos
  static const String topProducts = 'top_products';
  static const String lowPerformers = 'low_performers';
  static const String stockLevels = 'stock_levels';

  // Reportes de tiempo
  static const String peakHours = 'peak_hours';
  static const String preparationTimes = 'preparation_times';
  static const String deliveryTimes = 'delivery_times';
}
```

### Exportación de Datos

```dart
class DataExporter {
  // Exportar a Excel
  Future<void> exportToExcel(List<Order> orders) async {
    final excel = Excel.createExcel();
    final sheet = excel['Orders'];

    // Headers
    sheet.appendRow(['ID', 'Cliente', 'Total', 'Fecha', 'Estado']);

    // Data
    for (final order in orders) {
      sheet.appendRow([
        order.id,
        order.customerName,
        order.total,
        order.createdAt.toString(),
        order.status,
      ]);
    }

    // Guardar archivo
    final bytes = excel.encode();
    await FileSaver.instance.saveFile(
      'orders_report.xlsx',
      bytes!,
      'xlsx',
    );
  }

  // Exportar a PDF
  Future<void> exportToPDF(BusinessReport report) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (context) => pw.Column(
          children: [
            pw.Text('Reporte de Ventas', style: pw.TextStyle(fontSize: 24)),
            pw.SizedBox(height: 20),
            pw.Text('Total de ventas: ${report.totalSales}'),
            pw.Text('Pedidos procesados: ${report.totalOrders}'),
            // Más contenido...
          ],
        ),
      ),
    );

    final bytes = await pdf.save();
    await FileSaver.instance.saveFile('sales_report.pdf', bytes, 'pdf');
  }
}
```

## 🧪 Testing

### Tests Específicos

```bash
# Tests de dashboard
flutter test test/features/dashboard/

# Tests de gestión de menú
flutter test test/features/menu/

# Tests de reportes
flutter test test/features/reports/

# Tests de notificaciones
flutter test test/services/notification_service_test.dart
```

### Integration Tests

```bash
# Tests de flujo completo
flutter test integration_test/business_flow_test.dart

# Tests de responsive design
flutter test integration_test/responsive_test.dart
```

## 🔧 Configuración Avanzada

### Variables de Entorno

```dart
class BusinessConfig {
  // Configuración de la app
  static const String appName = 'GoPlus Business';
  static const String version = '1.0.0';

  // Configuración de notificaciones
  static const int orderTimeoutMinutes = 10;
  static const int lowStockThreshold = 5;

  // Configuración de reportes
  static const int reportsRetentionDays = 365;
  static const int maxExportRows = 10000;
}
```

### Personalización por Negocio

```dart
class BusinessTheme {
  // Colores personalizados por negocio
  final Color primaryColor;
  final Color accentColor;
  final String logoUrl;

  // Configuración de la interfaz
  final bool showAdvancedAnalytics;
  final bool enableMultiLocation;
  final bool showInventoryManagement;

  BusinessTheme({
    required this.primaryColor,
    required this.accentColor,
    required this.logoUrl,
    this.showAdvancedAnalytics = false,
    this.enableMultiLocation = false,
    this.showInventoryManagement = false,
  });
}
```

## 🔒 Seguridad

### Control de Acceso

```dart
class BusinessPermissions {
  // Roles dentro del negocio
  static const String owner = 'owner';
  static const String manager = 'manager';
  static const String employee = 'employee';

  // Permisos por rol
  static const Map<String, List<String>> rolePermissions = {
    'owner': [
      'manage_menu',
      'view_reports',
      'manage_staff',
      'configure_business',
      'export_data',
    ],
    'manager': [
      'manage_menu',
      'view_reports',
      'manage_orders',
    ],
    'employee': [
      'manage_orders',
      'update_product_availability',
    ],
  };
}
```

### Audit Trail

```dart
class BusinessAuditLog {
  final String userId;
  final String action;
  final String details;
  final DateTime timestamp;
  final String ipAddress;

  // Acciones auditadas
  static const String menuUpdate = 'menu_update';
  static const String orderAccepted = 'order_accepted';
  static const String orderRejected = 'order_rejected';
  static const String priceChanged = 'price_changed';
  static const String reportExported = 'report_exported';
}
```

## 📈 Performance

### Optimizaciones Web

```dart
// Lazy loading para imágenes
class OptimizedImage extends StatelessWidget {
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      placeholder: (context, url) => ShimmerPlaceholder(),
      errorWidget: (context, url, error) => Icon(Icons.error),
      memCacheHeight: 200, // Optimizar memoria
      memCacheWidth: 200,
    );
  }
}

// Paginación para listas grandes
class PaginatedOrderList extends StatelessWidget {
  static const int pageSize = 20;

  // Implementar paginación infinita
  // Cargar datos bajo demanda
}
```

### Caching Strategy

```dart
class BusinessCache {
  // Cache de datos frecuentes
  static const Duration menuCacheDuration = Duration(minutes: 5);
  static const Duration ordersCacheDuration = Duration(minutes: 1);
  static const Duration reportsCacheDuration = Duration(hours: 1);

  // Invalidación de cache
  void invalidateMenuCache() {
    // Limpiar cache cuando se actualiza el menú
  }
}
```

## 🚀 Deployment

### Build Optimizado

```bash
# Build con optimizaciones específicas
flutter build web --release \
  --web-renderer canvaskit \
  --base-href /business/ \
  --source-maps \
  --tree-shake-icons
```

### PWA Configuration

```dart
// Configuración para Progressive Web App
class PWAConfig {
  static const String manifestPath = 'web/manifest.json';
  static const String serviceWorkerPath = 'web/sw.js';

  // Configuración de cache offline
  static const List<String> cacheResources = [
    '/business/',
    '/business/assets/',
    '/business/icons/',
  ];
}
```

### CDN Integration

```dart
// Optimización de recursos estáticos
class CDNConfig {
  static const String imagesCDN = 'https://cdn.goplus.com/business/images/';
  static const String assetsCDN = 'https://cdn.goplus.com/business/assets/';

  static String getOptimizedImageUrl(String imageUrl, {int? width, int? height}) {
    return '$imagesCDN$imageUrl?w=$width&h=$height&q=80';
  }
}
```

---

## 📞 Support

Para issues específicos del dashboard de negocios:

- Verificar conexión a internet estable
- Confirmar permisos de negocio en el sistema
- Revisar configuración de notificaciones del navegador
- Limpiar cache del navegador si hay problemas de carga
- Contactar soporte con screenshots del problema específico

### Recursos Adicionales

- 📖 [Guía de Usuario](../docs/business-user-guide.md)
- 🎯 [Mejores Prácticas](../docs/business-best-practices.md)
- 🔧 [Troubleshooting](../docs/business-troubleshooting.md)
- 📊 [Analytics Guide](../docs/business-analytics.md)
