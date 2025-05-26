# 🎨 GoPlus UI

Package de componentes UI avanzados, animaciones y layouts para todas las aplicaciones del sistema GoPlus. Construye sobre `goplus_core` proporcionando componentes más complejos y especializados.

## 🎯 Propósito

GoPlus UI es el **design system avanzado** que proporciona:

- 🎨 **Componentes UI complejos** y especializados
- ✨ **Animaciones fluidas** y micro-interacciones
- 📱 **Layouts responsivos** para múltiples dispositivos
- 📊 **Visualizaciones de datos** (gráficos, charts)
- 🖼️ **Componentes multimedia** optimizados
- 🎭 **Estados de carga** y transiciones elegantes

## 📚 Contenido del Package

### 🎨 Advanced Components

```dart
// Componentes de tarjetas especializadas
export 'src/components/order_card.dart';           // Tarjeta de pedido
export 'src/components/business_card.dart';        // Tarjeta de negocio
export 'src/components/product_card.dart';         // Tarjeta de producto
export 'src/components/delivery_card.dart';        // Tarjeta de repartidor
export 'src/components/rating_card.dart';          // Sistema de calificaciones

// Componentes de listas avanzadas
export 'src/components/infinite_list.dart';        // Lista infinita
export 'src/components/paginated_list.dart';       // Lista paginada
export 'src/components/searchable_list.dart';      // Lista con búsqueda
export 'src/components/grouped_list.dart';         // Lista agrupada

// Modales y overlays
export 'src/components/modal_sheet.dart';          // Modal sheet customizable
export 'src/components/confirmation_dialog.dart';  // Diálogos de confirmación
export 'src/components/image_viewer.dart';         // Visor de imágenes
export 'src/components/map_overlay.dart';          // Overlay para mapas
```

### ✨ Animations

```dart
// Animaciones de entrada/salida
export 'src/animations/fade_animation.dart';       // Fade in/out
export 'src/animations/slide_animation.dart';      // Slide transitions
export 'src/animations/scale_animation.dart';      // Scale transitions
export 'src/animations/rotation_animation.dart';   // Rotation effects

// Animaciones especializadas
export 'src/animations/order_status_animation.dart'; // Estados de pedido
export 'src/animations/delivery_tracking.dart';      // Tracking de entrega
export 'src/animations/loading_animations.dart';     // Múltiples loaders
export 'src/animations/success_animation.dart';      // Animación de éxito

// Micro-interacciones
export 'src/animations/button_ripple.dart';        // Efecto ripple
export 'src/animations/heart_animation.dart';      // Like/favorite
export 'src/animations/bounce_animation.dart';     // Efecto bounce
export 'src/animations/shake_animation.dart';      // Shake para errores
```

### 📱 Responsive Layouts

```dart
// Layouts base
export 'src/layouts/responsive_layout.dart';       // Layout responsivo base
export 'src/layouts/dashboard_layout.dart';        // Layout de dashboard
export 'src/layouts/mobile_layout.dart';           // Layout móvil optimizado
export 'src/layouts/tablet_layout.dart';           // Layout para tablets

// Layouts especializados
export 'src/layouts/order_flow_layout.dart';       // Flujo de pedidos
export 'src/layouts/menu_layout.dart';             // Layout de menú
export 'src/layouts/map_layout.dart';              // Layout con mapa
export 'src/layouts/chat_layout.dart';             // Layout de chat
```

### 📊 Data Visualizations

```dart
// Gráficos básicos
export 'src/charts/line_chart.dart';               // Gráfico de líneas
export 'src/charts/bar_chart.dart';                // Gráfico de barras
export 'src/charts/pie_chart.dart';                // Gráfico circular
export 'src/charts/area_chart.dart';               // Gráfico de área

// Gráficos especializados para delivery
export 'src/charts/delivery_heatmap.dart';         // Mapa de calor entregas
export 'src/charts/order_timeline.dart';           // Timeline de pedidos
export 'src/charts/earnings_chart.dart';           // Gráfico de ganancias
export 'src/charts/rating_distribution.dart';      // Distribución ratings
```

### 🎭 Loading States

```dart
// Skeletons y placeholders
export 'src/loading/skeleton_card.dart';           // Skeleton de tarjetas
export 'src/loading/skeleton_list.dart';           // Skeleton de listas
export 'src/loading/shimmer_effect.dart';          // Efecto shimmer
export 'src/loading/pulse_loading.dart';           // Loading con pulso

// Estados de error y vacío
export 'src/states/empty_state.dart';              // Estado vacío
export 'src/states/error_state.dart';              // Estado de error
export 'src/states/no_connection.dart';            // Sin conexión
export 'src/states/maintenance_state.dart';        // Mantenimiento
```

## 🚀 Instalación

### En packages del monorepo:

```yaml
dependencies:
  goplus_ui:
    path: ../goplus_ui
```

### En apps del sistema:

```yaml
dependencies:
  goplus_ui:
    path: ../../packages/goplus_ui
```

### Importación:

```dart
import 'package:goplus_ui/goplus_ui.dart';

// Ya tienes acceso a todos los componentes avanzados
```

## 💡 Ejemplos de Uso

### 🎨 Componentes Avanzados

#### Order Card

```dart
import 'package:goplus_ui/goplus_ui.dart';

OrderCard(
  order: OrderModel(
    id: 'order_123',
    businessName: 'Pizza Express',
    items: ['Pizza Margherita', 'Coca Cola'],
    status: OrderStatus.inDelivery,
    total: 45.50,
    estimatedTime: 25,
  ),
  onTap: () => _navigateToOrderDetail(),
  onTrack: () => _showOrderTracking(),
  animation: OrderStatusAnimation.inDelivery,
)
```

#### Business Card

```dart
BusinessCard(
  business: BusinessModel(
    name: 'Burger King',
    category: 'Comida Rápida',
    rating: 4.5,
    deliveryTime: '25-35 min',
    deliveryFee: 5.0,
    imageUrl: 'https://example.com/burger-king.jpg',
  ),
  layout: BusinessCardLayout.horizontal,
  showPromotions: true,
  onTap: () => _navigateToMenu(),
)
```

#### Infinite List

```dart
InfiniteList<Product>(
  itemBuilder: (context, product, index) => ProductCard(
    product: product,
    onAddToCart: _addToCart,
  ),
  loadMore: (page) => _productService.getProducts(page: page),
  emptyState: EmptyState(
    icon: Icons.restaurant_menu,
    title: 'No hay productos',
    subtitle: 'Este negocio aún no tiene productos disponibles',
  ),
  loadingWidget: SkeletonList(itemCount: 6),
)
```

### ✨ Animaciones

#### Order Status Animation

```dart
OrderStatusAnimation(
  status: OrderStatus.preparing,
  size: 120,
  color: AppColors.primary,
  onComplete: () => _showNextStep(),
)

// Cambiará automáticamente la animación según el estado:
// preparing -> cooking icon with rotation
// ready -> checkmark with scale
// inDelivery -> delivery truck moving
// delivered -> success celebration
```

#### Loading Animations

```dart
// Shimmer effect para listas
ShimmerList(
  itemCount: 8,
  shimmerType: ShimmerType.productCard,
  baseColor: Colors.grey[300],
  highlightColor: Colors.grey[100],
)

// Pulse loading para botones
PulseLoading(
  child: AppButton(text: 'Realizando pedido...'),
  isLoading: _isProcessingOrder,
)

// Success animation
SuccessAnimation(
  onComplete: () => Navigator.pop(context),
  message: '¡Pedido realizado con éxito!',
  confetti: true,
)
```

### 📱 Responsive Layouts

#### Dashboard Layout

```dart
DashboardLayout(
  title: 'Panel de Control',
  drawer: _buildNavigationDrawer(),
  body: ResponsiveBuilder(
    mobile: _buildMobileLayout(),
    tablet: _buildTabletLayout(),
    desktop: _buildDesktopLayout(),
  ),
  floatingActionButton: _buildFAB(),
  bottomNavigationBar: _buildBottomNav(), // Solo móvil
)
```

#### Responsive Grid

```dart
ResponsiveGrid(
  children: products.map((product) => ProductCard(product: product)).toList(),
  breakpoints: GridBreakpoints(
    mobile: 1,      // 1 columna en móvil
    tablet: 2,      // 2 columnas en tablet
    desktop: 3,     // 3 columnas en desktop
    wide: 4,        // 4 columnas en pantallas anchas
  ),
  spacing: 16,
  aspectRatio: 0.8,
)
```

### 📊 Data Visualizations

#### Earnings Chart

```dart
EarningsChart(
  data: EarningsData(
    daily: [45.50, 67.20, 89.10, 34.80, 76.40],
    weekly: [320.50, 445.80, 567.20, 389.40],
    monthly: [1250.80, 1456.70, 1698.20],
  ),
  period: ChartPeriod.weekly,
  showGoals: true,
  targetEarnings: 500.0,
  onPeriodChanged: (period) => _updateChartPeriod(period),
  animation: ChartAnimation.slideUp,
)
```

#### Delivery Heatmap

```dart
DeliveryHeatmap(
  deliveries: deliveryData,
  mapStyle: HeatmapStyle.modern,
  intensity: HeatmapIntensity.medium,
  radiusKm: 2.0,
  onRegionTap: (region) => _showRegionDetails(region),
  showLegend: true,
)
```

## 🏗️ Arquitectura de Componentes

### Component Hierarchy

```
GoPlus UI Components
├── Basic Components (from goplus_core)
│   ├── AppButton
│   ├── AppTextField
│   └── LoadingWidget
├── Advanced Components (goplus_ui)
│   ├── OrderCard
│   ├── BusinessCard
│   ├── ProductCard
│   └── DeliveryCard
├── Layout Components
│   ├── ResponsiveLayout
│   ├── DashboardLayout
│   └── GridLayout
└── Specialized Components
    ├── Charts & Graphs
    ├── Maps & Location
    └── Animations
```

### Design System Tokens

```dart
class UITokens {
  // Espaciado consistente
  static const double spacingXS = 4.0;
  static const double spacingS = 8.0;
  static const double spacingM = 16.0;
  static const double spacingL = 24.0;
  static const double spacingXL = 32.0;

  // Radios de borde
  static const double radiusS = 4.0;
  static const double radiusM = 8.0;
  static const double radiusL = 12.0;
  static const double radiusXL = 16.0;

  // Elevaciones
  static const double elevationLow = 2.0;
  static const double elevationMid = 4.0;
  static const double elevationHigh = 8.0;

  // Duraciones de animación
  static const Duration animationFast = Duration(milliseconds: 200);
  static const Duration animationNormal = Duration(milliseconds: 300);
  static const Duration animationSlow = Duration(milliseconds: 500);
}
```

### Theming System

```dart
class GoPlus UITheme {
  // Tema personalizable por app
  static ThemeData getTheme({
    required ColorScheme colorScheme,
    required Typography typography,
    ComponentTheme? componentOverrides,
  }) {
    return ThemeData(
      colorScheme: colorScheme,
      textTheme: typography.textTheme,

      // Extensiones personalizadas
      extensions: [
        OrderCardTheme.fromColorScheme(colorScheme),
        BusinessCardTheme.fromColorScheme(colorScheme),
        ChartTheme.fromColorScheme(colorScheme),
      ],
    );
  }
}

// Uso en apps
MaterialApp(
  theme: GoPlusUITheme.getTheme(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
    typography: Typography.material2021(),
  ),
  home: MyApp(),
)
```

## 🎨 Customización Avanzada

### Component Variants

```dart
// Múltiples variantes del mismo componente
enum OrderCardVariant {
  compact,      // Versión compacta
  detailed,     // Versión detallada
  minimal,      // Versión minimalista
  dashboard,    // Para dashboards
}

OrderCard(
  order: order,
  variant: OrderCardVariant.compact,
  customization: OrderCardCustomization(
    showDeliveryTime: true,
    showRating: false,
    actionButtons: [OrderAction.track, OrderAction.call],
  ),
)
```

### Custom Animations

```dart
// Crear animaciones personalizadas
class CustomOrderAnimation extends StatefulWidget {
  final OrderStatus status;
  final Duration duration;
  final Widget child;

  @override
  _CustomOrderAnimationState createState() => _CustomOrderAnimationState();
}

class _CustomOrderAnimationState extends State<CustomOrderAnimation>
    with TickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _controller.forward();
  }

  void _setupAnimations() {
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    ));

    _colorAnimation = ColorTween(
      begin: Colors.grey,
      end: _getStatusColor(widget.status),
    ).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Container(
            decoration: BoxDecoration(
              color: _colorAnimation.value,
              borderRadius: BorderRadius.circular(12),
            ),
            child: widget.child,
          ),
        );
      },
    );
  }
}
```

## 📊 Performance Guidelines

### Optimización de Renderizado

```dart
class PerformantList extends StatelessWidget {
  final List<Order> orders;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      // Usar itemExtent para mejor performance
      itemExtent: 120.0,

      // Caché de items para scroll rápido
      cacheExtent: 1000.0,

      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];

        // Usar RepaintBoundary para componentes complejos
        return RepaintBoundary(
          child: OrderCard(
            key: ValueKey(order.id), // Keys estables
            order: order,
            variant: OrderCardVariant.compact,
          ),
        );
      },
    );
  }
}
```

### Image Optimization

```dart
class OptimizedImage extends StatelessWidget {
  final String imageUrl;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      width: width,
      height: height,

      // Usar tamaños específicos para reducir memoria
      memCacheWidth: width.toInt(),
      memCacheHeight: height.toInt(),

      // Placeholder shimmer
      placeholder: (context, url) => ShimmerPlaceholder(
        width: width,
        height: height,
      ),

      // Error fallback
      errorWidget: (context, url, error) => Container(
        width: width,
        height: height,
        color: Colors.grey[300],
        child: Icon(Icons.error),
      ),

      // Fade in animation
      fadeInDuration: Duration(milliseconds: 300),
    );
  }
}
```

## 🧪 Testing

### Widget Tests

```bash
# Tests de componentes UI
flutter test test/components/

# Tests de animaciones
flutter test test/animations/

# Tests de layouts responsivos
flutter test test/layouts/
```

### Golden Tests

```dart
// Test visual de componentes
testWidgets('OrderCard golden test', (tester) async {
  await tester.pumpWidget(
    MaterialApp(
      home: OrderCard(
        order: mockOrder,
        variant: OrderCardVariant.detailed,
      ),
    ),
  );

  await expectLater(
    find.byType(OrderCard),
    matchesGoldenFile('order_card_detailed.png'),
  );
});

// Tests para diferentes tamaños de pantalla
testWidgets('ResponsiveLayout golden tests', (tester) async {
  // Mobile
  await tester.binding.setSurfaceSize(Size(360, 640));
  await tester.pumpWidget(testWidget);
  await expectLater(find.byType(ResponsiveLayout),
    matchesGoldenFile('responsive_mobile.png'));

  // Tablet
  await tester.binding.setSurfaceSize(Size(768, 1024));
  await tester.pumpWidget(testWidget);
  await expectLater(find.byType(ResponsiveLayout),
    matchesGoldenFile('responsive_tablet.png'));

  // Desktop
  await tester.binding.setSurfaceSize(Size(1200, 800));
  await tester.pumpWidget(testWidget);
  await expectLater(find.byType(ResponsiveLayout),
    matchesGoldenFile('responsive_desktop.png'));
});
```

### Animation Tests

```dart
testWidgets('OrderStatusAnimation test', (tester) async {
  await tester.pumpWidget(
    MaterialApp(
      home: OrderStatusAnimation(
        status: OrderStatus.preparing,
      ),
    ),
  );

  // Verificar estado inicial
  expect(find.byIcon(Icons.restaurant), findsOneWidget);

  // Avanzar animación
  await tester.pump(Duration(milliseconds: 100));

  // Verificar que la animación está funcionando
  // (esto dependería de la implementación específica)
});
```

## 📚 Design Guidelines

### Component Spacing

```dart
// Espaciado consistente entre componentes
class ComponentSpacing {
  // Dentro de tarjetas
  static const EdgeInsets cardPadding = EdgeInsets.all(16.0);
  static const EdgeInsets cardMargin = EdgeInsets.symmetric(
    horizontal: 16.0,
    vertical: 8.0,
  );

  // Entre elementos de lista
  static const double listItemSpacing = 12.0;

  // Entre secciones
  static const double sectionSpacing = 24.0;

  // Botones de acción
  static const EdgeInsets buttonPadding = EdgeInsets.symmetric(
    horizontal: 24.0,
    vertical: 12.0,
  );
}
```

### Color Usage

```dart
class ColorGuidelines {
  // Estados de pedido
  static const Color orderPending = Colors.orange;
  static const Color orderConfirmed = Colors.blue;
  static const Color orderPreparing = Colors.amber;
  static const Color orderReady = Colors.green;
  static const Color orderDelivered = Colors.teal;
  static const Color orderCancelled = Colors.red;

  // Ratings
  static const Color ratingExcellent = Color(0xFF4CAF50); // 4.5-5.0
  static const Color ratingGood = Color(0xFF8BC34A);      // 3.5-4.4
  static const Color ratingAverage = Color(0xFFFF9800);   // 2.5-3.4
  static const Color ratingPoor = Color(0xFFFF5722);      // 1.0-2.4

  // Categorías de negocio
  static const Map<String, Color> categoryColors = {
    'Comida Rápida': Color(0xFFFF6B35),
    'Pizza': Color(0xFFDC143C),
    'Asiática': Color(0xFFFF1744),
    'Saludable': Color(0xFF4CAF50),
    'Postres': Color(0xFFE91E63),
    'Bebidas': Color(0xFF2196F3),
  };
}
```

## 🔄 Versionado y Compatibilidad

### Breaking Changes Policy

- **Major version**: Cambios que rompen API existente
- **Minor version**: Nuevos componentes y features
- **Patch version**: Bug fixes y mejoras menores

### Migration Guide

```dart
// v1.0.0 -> v2.0.0
// Cambio en OrderCard API

// ANTES (v1.0.0)
OrderCard(
  orderId: 'order_123',
  businessName: 'Pizza Express',
  total: 45.50,
)

// DESPUÉS (v2.0.0)
OrderCard(
  order: OrderModel(
    id: 'order_123',
    businessName: 'Pizza Express',
    total: 45.50,
  ),
)
```

## 🤝 Contribución

### Añadir Nuevos Componentes

1. **Crear el componente** en la carpeta apropiada
2. **Seguir naming conventions** existentes
3. **Implementar variantes** si es necesario
4. **Documentar propiedades** con `///`
5. **Añadir tests comprehensivos**
6. **Incluir golden tests** para verificación visual
7. **Actualizar exports** en el archivo principal

### Guidelines de Design

- **Consistencia** con el design system existente
- **Accesibilidad** (contrast ratios, semantic labels)
- **Performance** (evitar rebuilds innecesarios)
- **Responsividad** (funciona en todos los tamaños)
- **Theming** (respeta el tema actual)

---

## 📞 Support

Para issues del package UI:

- Incluir screenshots del problema visual
- Especificar dispositivo y tamaño de pantalla
- Proporcionar código mínimo para reproducir
- Mencionar versión del package y dependencias

### Recursos Adicionales

- 🎨 [Design System Guide](../docs/design-system.md)
- 📱 [Responsive Guidelines](../docs/responsive-design.md)
- ✨ [Animation Cookbook](../docs/animations.md)
- 🧪 [Testing UI Components](../docs/ui-testing.md)
