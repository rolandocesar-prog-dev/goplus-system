# 📦 GoPlus Core

Biblioteca compartida base que contiene modelos, servicios, tema y widgets comunes utilizados por todas las aplicaciones del sistema GoPlus.

## 🎯 Propósito

GoPlus Core es el **foundation package** que proporciona:

- 🏗️ **Modelos de datos** consistentes
- ⚙️ **Servicios base** reutilizables
- 🎨 **Sistema de tema** unificado
- 🧩 **Widgets comunes** estandarizados
- 🔧 **Utilidades** y helpers
- 📏 **Constantes** del sistema

## 📚 Contenido del Package

### 🏗️ Models

```dart
// Modelos principales del negocio
export 'src/models/user_model.dart';          // Usuario del sistema
export 'src/models/order_model.dart';         // Pedido
export 'src/models/product_model.dart';       // Producto
export 'src/models/business_model.dart';      // Negocio/Restaurante
export 'src/models/delivery_model.dart';      // Información de entrega
export 'src/models/payment_model.dart';       // Métodos de pago
```

### ⚙️ Services

```dart
// Servicios base abstractos
export 'src/services/navigation_service.dart';    // Navegación
export 'src/services/local_storage_service.dart'; // Almacenamiento local
export 'src/services/location_service.dart';      // Geolocalización
export 'src/services/notification_service.dart';  // Notificaciones base
```

### 🎨 Theme

```dart
// Sistema de diseño unificado
export 'src/theme/app_theme.dart';           // Tema principal
export 'src/theme/app_colors.dart';          // Paleta de colores
export 'src/theme/app_text_styles.dart';     // Tipografía
export 'src/theme/app_dimensions.dart';      // Espaciado y tamaños
```

### 🧩 Widgets

```dart
// Widgets base reutilizables
export 'src/widgets/app_button.dart';        // Botones estándar
export 'src/widgets/app_text_field.dart';    // Campos de texto
export 'src/widgets/error_widget.dart';      // Widget de error
export 'src/widgets/loading_widget.dart';    // Indicadores de carga
export 'src/widgets/empty_state_widget.dart'; // Estados vacíos
```

### 🔧 Utils

```dart
// Utilidades y helpers
export 'src/utils/validators.dart';          // Validadores de formulario
export 'src/utils/formatters.dart';          // Formateadores de texto
export 'src/utils/constants.dart';           // Constantes del sistema
export 'src/utils/extensions.dart';          // Extensions de Dart
```

## 🚀 Instalación

### En otro package del monorepo:

```yaml
dependencies:
  goplus_core:
    path: ../goplus_core # Ruta relativa
```

### En apps del sistema:

```yaml
dependencies:
  goplus_core:
    path: ../../packages/goplus_core # Desde apps/
```

### Uso básico:

```dart
import 'package:goplus_core/goplus_core.dart';

// Ya tienes acceso a todos los exports del package
```

## 💡 Ejemplos de Uso

### 🏗️ Usando Modelos

```dart
import 'package:goplus_core/goplus_core.dart';

// Crear un usuario
final user = UserModel(
  id: '123',
  name: 'Juan Pérez',
  email: 'juan@example.com',
  phone: '+591 7X XXX XXX',
  userType: UserType.client,
);

// Crear un pedido
final order = OrderModel(
  id: 'order_123',
  userId: user.id,
  businessId: 'business_456',
  products: [product1, product2],
  status: OrderStatus.pending,
  totalAmount: 45.50,
  deliveryAddress: address,
);
```

### 🎨 Usando Tema

```dart
import 'package:goplus_core/goplus_core.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GoPlus',
      theme: AppTheme.lightTheme,      // Tema claro
      darkTheme: AppTheme.darkTheme,   // Tema oscuro
      home: HomeScreen(),
    );
  }
}

// En widgets
Container(
  color: AppColors.primary,           // Color primario
  padding: AppDimensions.paddingL,    // Espaciado large
  child: Text(
    'Hola GoPlus',
    style: AppTextStyles.headline1,   // Estilo de texto
  ),
);
```

### 🧩 Usando Widgets

```dart
import 'package:goplus_core/goplus_core.dart';

// Botón estándar
AppButton(
  text: 'Realizar Pedido',
  onPressed: () => _makeOrder(),
  variant: ButtonVariant.primary,
);

// Campo de texto con validación
AppTextField(
  label: 'Email',
  validator: Validators.email,        // Validador integrado
  keyboardType: TextInputType.emailAddress,
);

// Widget de carga
LoadingWidget(
  message: 'Procesando pedido...',
  showProgress: true,
);
```

### 🔧 Usando Utilidades

```dart
import 'package:goplus_core/goplus_core.dart';

// Validadores
final isValidEmail = Validators.email('test@example.com');
final isValidPhone = Validators.bolivianPhone('+591 7X XXX XXX');

// Formateadores
final formattedPrice = Formatters.currency(45.50);  // "45.50 Bs"
final formattedDate = Formatters.dateTime(DateTime.now());

// Extensions
final isNotEmpty = 'Hello'.isNotNullOrEmpty;  // true
final capitalized = 'goplus'.capitalize();     // "Goplus"
```

## 🏗️ Arquitectura Interna

### Estructura de Carpetas

```
lib/
├── goplus_core.dart              # Export principal
└── src/
    ├── constants/                # Constantes del sistema
    │   ├── app_constants.dart
    │   └── error_constants.dart
    ├── models/                   # Modelos de datos
    │   ├── user_model.dart
    │   ├── order_model.dart
    │   └── ...
    ├── services/                 # Servicios abstractos
    │   ├── navigation_service.dart
    │   └── ...
    ├── theme/                    # Sistema de diseño
    │   ├── app_theme.dart
    │   ├── app_colors.dart
    │   └── ...
    ├── utils/                    # Utilidades
    │   ├── validators.dart
    │   └── ...
    └── widgets/                  # Widgets base
        ├── app_button.dart
        └── ...
```

## 🧪 Testing

```bash
# Ejecutar tests del package
cd packages/goplus_core
flutter test

# Con coverage
flutter test --coverage
```

### Cobertura de Tests

- ✅ **Models**: Serialización/deserialización JSON
- ✅ **Validators**: Todos los casos edge
- ✅ **Formatters**: Formatos correctos
- ✅ **Extensions**: Funcionamiento esperado
- ✅ **Widgets**: Rendering y interacciones básicas

## 📋 Guidelines de Desarrollo

### Añadir Nuevos Modelos

1. Crear el modelo en `src/models/`
2. Implementar `Equatable` para comparaciones
3. Añadir `toJson()/fromJson()` si se usa con APIs
4. Exportar en `goplus_core.dart`
5. Escribir tests comprehensivos

### Añadir Nuevos Widgets

1. Crear widget en `src/widgets/`
2. Seguir patrones de diseño del sistema
3. Documentar parámetros con `///`
4. Añadir ejemplos de uso
5. Incluir tests de widget

### Modificar Tema

1. **NO** romper compatibilidad hacia atrás
2. Añadir nuevos colores/estilos al final
3. Documentar cambios en CHANGELOG
4. Testear en todas las apps

## 🔄 Versionado

Seguimos **Semantic Versioning**:

- `MAJOR`: Cambios breaking (ej: eliminar APIs)
- `MINOR`: Nuevas features (ej: nuevos widgets)
- `PATCH`: Bug fixes y mejoras menores

## 📈 Dependencias

### Core Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  equatable: ^2.0.5 # Para comparación de objetos
  json_annotation: ^4.8.1 # Para serialización JSON
  shared_preferences: ^2.2.2 # Almacenamiento local
  intl: ^0.18.1 # Internacionalización
```

### Dev Dependencies

```yaml
dev_dependencies:
  flutter_test:
    sdk: flutter
  build_runner: ^2.4.7 # Para code generation
  json_serializable: ^6.7.1 # Para generar JSON serializers
```

## 🤝 Contribución

Al contribuir a GoPlus Core:

1. **Mantener compatibilidad** con todas las apps
2. **Documentar cambios** en APIs públicas
3. **Escribir tests** para nueva funcionalidad
4. **Seguir conventions** existentes
5. **Revisar impacto** en otros packages

---

## 📞 Support

Para issues del package core:

- Verificar que el issue no afecte otras apps
- Incluir ejemplos de código problemático
- Especificar versión de Flutter/Dart utilizada
