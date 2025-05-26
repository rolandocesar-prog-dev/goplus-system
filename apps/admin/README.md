# 🛡️ GoPlus - Panel de Administración

Dashboard web completo para administradores del sistema que gestionan usuarios, negocios, pedidos y configuraciones globales de la plataforma GoPlus.

## 🎯 Características Principales

### 🔐 Autenticación y Roles

- ✅ **Login seguro** con autenticación de dos factores
- ✅ **Gestión de roles** (Super Admin, Admin, Moderador)
- ✅ **Control de acceso** granular por módulos
- ✅ **Audit trail** completo de acciones administrativas
- ✅ **Sesiones seguras** con timeout automático

### 👥 Gestión de Usuarios

- ✅ **CRUD completo** de usuarios (clientes, repartidores, negocios)
- ✅ **Verificación de identidad** y documentos
- ✅ **Suspensión y bloqueo** de cuentas
- ✅ **Historial de actividad** por usuario
- ✅ **Estadísticas** de comportamiento y uso
- ✅ **Sistema de reportes** de usuarios problemáticos

### 🏪 Gestión de Negocios

- ✅ **Aprobación/rechazo** de nuevos negocios
- ✅ **Verificación de documentos** (RUC, licencias)
- ✅ **Control de calidad** de menús y productos
- ✅ **Configuración de comisiones** por negocio
- ✅ **Monitoreo de rendimiento** y calificaciones
- ✅ **Soporte directo** a comercios

### 📦 Supervisión de Pedidos

- ✅ **Dashboard en tiempo real** de todos los pedidos
- ✅ **Intervención manual** en pedidos problemáticos
- ✅ **Resolución de disputas** entre partes
- ✅ **Análisis de patrones** anómalos
- ✅ **Métricas de rendimiento** del sistema
- ✅ **Alertas automáticas** por eventos críticos

### 🔍 Control de Contenido

- ✅ **Moderación de reseñas** y comentarios
- ✅ **Control de productos** ofensivos o inadecuados
- ✅ **Filtros automáticos** de contenido
- ✅ **Sistema de reportes** de usuarios
- ✅ **Blacklist** de palabras prohibidas
- ✅ **Aprobación** de promociones especiales

### 📊 Analytics y Reportes Globales

- ✅ **KPIs del sistema** en tiempo real
- ✅ **Reportes financieros** detallados
- ✅ **Análisis de crecimiento** y tendencias
- ✅ **Mapas de calor** de actividad geográfica
- ✅ **Predicciones** basadas en IA
- ✅ **Exportación masiva** de datos

### ⚙️ Configuración del Sistema

- ✅ **Parámetros globales** de la plataforma
- ✅ **Configuración de pagos** y comisiones
- ✅ **Gestión de promociones** y descuentos
- ✅ **Configuración de notificaciones** masivas
- ✅ **Maintenance mode** y actualizaciones
- ✅ **Backup y restauración** de datos

## 🚀 Ejecución

### Desarrollo

```bash
# Navegar a la carpeta
cd apps/admin

# Instalar dependencias
flutter pub get

# Ejecutar en desarrollo (Web)
flutter run -d chrome

# Modo debug con hot reload
flutter run -d chrome --debug --hot

# Modo release optimizado
flutter run -d chrome --release
```

### VS Code

- Usar la configuración `Admin Debug (Web)` en el debugger
- O ejecutar task: `Flutter: Run Admin App (Web)`

### Build para Producción

```bash
# Build optimizado para administración
flutter build web --release \
  --web-renderer canvaskit \
  --base-href /admin/ \
  --dart-define=ENVIRONMENT=production
```

## 🌐 Deployment Seguro

### Configuración de Seguridad

```bash
# Variables de entorno para producción
export ADMIN_SECRET_KEY="your-super-secret-key"
export FIREBASE_ADMIN_KEY="firebase-admin-service-account"
export ENCRYPT_SENSITIVE_DATA="true"
export LOG_LEVEL="info"
```

### Hosting con Restricciones

```nginx
# Nginx configuration para admin panel
server {
    listen 443 ssl;
    server_name admin.goplus.com;

    # Solo IPs autorizadas
    allow 192.168.1.0/24;  # Oficina principal
    allow 10.0.0.0/8;      # VPN corporativa
    deny all;

    # SSL certificates
    ssl_certificate /path/to/cert.pem;
    ssl_certificate_key /path/to/key.pem;

    location /admin/ {
        proxy_pass http://localhost:5000/admin/;

        # Headers de seguridad
        add_header X-Frame-Options DENY;
        add_header X-Content-Type-Options nosniff;
        add_header X-XSS-Protection "1; mode=block";
    }
}
```

## 🏗️ Arquitectura

### Estructura de Carpetas

```
lib/
├── main.dart                    # Entry point con seguridad
├── app/                         # App configuration
├── core/                        # Core administrativo
│   ├── auth/                    # Autenticación de admin
│   ├── permissions/             # Sistema de permisos
│   ├── security/                # Medidas de seguridad
│   └── audit/                   # Audit trail
├── features/                    # Módulos administrativos
│   ├── dashboard/               # Dashboard principal
│   │   ├── widgets/             # KPIs y métricas
│   │   ├── real_time/           # Updates en tiempo real
│   │   └── alerts/              # Sistema de alertas
│   ├── users/                   # Gestión de usuarios
│   │   ├── clients/             # Administrar clientes
│   │   ├── delivery/            # Administrar repartidores
│   │   ├── business/            # Administrar negocios
│   │   └── moderation/          # Moderación de usuarios
│   ├── orders/                  # Supervisión de pedidos
│   │   ├── monitoring/          # Monitor en tiempo real
│   │   ├── intervention/        # Intervención manual
│   │   ├── disputes/            # Resolución de disputas
│   │   └── analytics/           # Análisis de pedidos
│   ├── content/                 # Control de contenido
│   │   ├── moderation/          # Moderación de contenido
│   │   ├── approval/            # Aprobaciones
│   │   └── reports/             # Reportes de usuarios
│   ├── analytics/               # Analytics globales
│   │   ├── kpis/                # KPIs del sistema
│   │   ├── reports/             # Reportes detallados
│   │   ├── predictions/         # IA y predicciones
│   │   └── exports/             # Exportación de datos
│   ├── finance/                 # Gestión financiera
│   │   ├── commissions/         # Comisiones
│   │   ├── payments/            # Pagos y transacciones
│   │   ├── billing/             # Facturación
│   │   └── reconciliation/      # Conciliación
│   ├── system/                  # Configuración del sistema
│   │   ├── settings/            # Configuraciones globales
│   │   ├── maintenance/         # Mantenimiento
│   │   ├── backups/             # Backup y restauración
│   │   └── monitoring/          # Monitoreo del sistema
│   └── support/                 # Soporte y tickets
│       ├── tickets/             # Sistema de tickets
│       ├── chat/                # Chat de soporte
│       └── knowledge_base/      # Base de conocimiento
├── shared/                      # Componentes compartidos
│   ├── layouts/                 # Layouts administrativos
│   ├── tables/                  # Tablas de datos avanzadas
│   ├── charts/                  # Gráficos y visualizaciones
│   ├── forms/                   # Formularios complejos
│   └── security/                # Componentes de seguridad
└── utils/                       # Utilidades administrativas
    ├── permissions.dart         # Helpers de permisos
    ├── audit_logger.dart        # Logger de auditoría
    └── data_export.dart         # Exportación de datos
```

### Arquitectura de Seguridad

```dart
class AdminSecurity {
  // Autenticación multi-factor
  static Future<bool> verifyMFA(String code) async {
    // Verificar código TOTP
    // Validar contra tiempo actual
    // Registrar intento en audit log
  }

  // Control de acceso basado en roles
  static bool hasPermission(AdminUser user, String permission) {
    return user.role.permissions.contains(permission);
  }

  // Encriptación de datos sensibles
  static String encryptSensitiveData(String data) {
    // Usar AES-256 para encriptar
    // Key management seguro
  }

  // Rate limiting para prevenir ataques
  static bool checkRateLimit(String adminId, String action) {
    // Implementar rate limiting por admin
    // Diferentes límites por tipo de acción
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

  # Data Tables Advanced
  pluto_grid: ^7.0.2
  data_table_2: ^2.5.12

  # Charts & Analytics
  fl_chart: ^0.66.0
  syncfusion_flutter_charts: ^23.2.7
  syncfusion_flutter_datagrid: ^23.2.7

  # Excel & PDF exports
  excel: ^2.1.0
  pdf: ^3.10.7
  printing: ^5.11.1

  # Real-time updates
  web_socket_channel: ^2.4.0

  # Security
  crypto: ^3.0.3
  encrypt: ^5.0.1

  # File handling
  file_picker: ^6.1.1

  # HTTP clients
  dio: ^5.4.0

  # Utilities
  intl: ^0.18.1
  uuid: ^4.2.1
```

## 🛡️ Sistema de Permisos

### Jerarquía de Roles

```dart
enum AdminRole {
  superAdmin,    // Acceso total al sistema
  admin,         // Gestión de usuarios y negocios
  moderator,     // Control de contenido y soporte
  analyst,       // Solo lectura de analytics
  support,       // Solo tickets de soporte
}

class Permission {
  // Gestión de usuarios
  static const String manageUsers = 'manage_users';
  static const String viewUsers = 'view_users';
  static const String suspendUsers = 'suspend_users';

  // Gestión de negocios
  static const String approveBusiness = 'approve_business';
  static const String manageBusiness = 'manage_business';
  static const String viewBusiness = 'view_business';

  // Control de pedidos
  static const String interventeOrders = 'intervene_orders';
  static const String viewAllOrders = 'view_all_orders';
  static const String resolveDisputes = 'resolve_disputes';

  // Control de contenido
  static const String moderateContent = 'moderate_content';
  static const String manageReports = 'manage_reports';

  // Configuración del sistema
  static const String systemConfig = 'system_config';
  static const String maintenanceMode = 'maintenance_mode';
  static const String viewAuditLogs = 'view_audit_logs';

  // Analytics y reportes
  static const String viewAnalytics = 'view_analytics';
  static const String exportData = 'export_data';
  static const String viewFinancials = 'view_financials';
}
```

### Control de Acceso

```dart
class PermissionGuard extends StatelessWidget {
  final String requiredPermission;
  final Widget child;
  final Widget? fallback;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdminAuthBloc, AdminAuthState>(
      builder: (context, state) {
        if (state is AdminAuthenticated &&
            state.user.hasPermission(requiredPermission)) {
          return child;
        }
        return fallback ?? UnauthorizedWidget();
      },
    );
  }
}

// Uso en la UI
PermissionGuard(
  requiredPermission: Permission.manageUsers,
  child: UserManagementPanel(),
  fallback: Text('No autorizado para gestionar usuarios'),
)
```

## 📊 Dashboard de Administración

### KPIs Principales

```dart
class AdminDashboardKPIs {
  // Métricas en tiempo real
  final int activeUsers;
  final int activeBusiness;
  final int activeDelivery;
  final int todayOrders;

  // Métricas financieras
  final double todayRevenue;
  final double platformCommission;
  final double monthlyRecurring;

  // Métricas de calidad
  final double averageRating;
  final int supportTickets;
  final int contentReports;

  // Métricas de crecimiento
  final double userGrowthRate;
  final double businessGrowthRate;
  final double orderGrowthRate;
}
```

### Real-time Monitoring

```dart
class RealtimeMonitor {
  late WebSocketChannel _ordersChannel;
  late WebSocketChannel _alertsChannel;

  void initializeRealtimeConnections() {
    // Canal de pedidos en tiempo real
    _ordersChannel = WebSocketChannel.connect(
      Uri.parse('wss://admin-api.goplus.com/orders/stream'),
    );

    // Canal de alertas del sistema
    _alertsChannel = WebSocketChannel.connect(
      Uri.parse('wss://admin-api.goplus.com/alerts/stream'),
    );

    _ordersChannel.stream.listen(_handleOrderUpdate);
    _alertsChannel.stream.listen(_handleSystemAlert);
  }

  void _handleOrderUpdate(dynamic data) {
    // Actualizar dashboard con nuevo pedido
    // Mostrar alertas si hay problemas
    // Actualizar métricas en tiempo real
  }

  void _handleSystemAlert(dynamic data) {
    final alert = SystemAlert.fromJson(data);

    switch (alert.severity) {
      case AlertSeverity.critical:
        _showCriticalAlert(alert);
        break;
      case AlertSeverity.warning:
        _showWarningNotification(alert);
        break;
      case AlertSeverity.info:
        _updateInfoPanel(alert);
        break;
    }
  }
}
```

## 🔍 Sistema de Moderación

### Auto-Moderación

```dart
class ContentModerationService {
  // Filtros automáticos
  static const List<String> bannedWords = [
    // Lista de palabras prohibidas
  ];

  static const List<String> suspiciousPatterns = [
    // Patrones sospechosos regex
  ];

  // Análisis de sentimientos
  Future<ModerationResult> analyzeContent(String content) async {
    // Usar ML para analizar contenido
    // Detectar spam, lenguaje ofensivo, etc.
    // Retornar nivel de confianza y recomendación
  }

  // Auto-acciones
  Future<void> processAutoModeration(UserReport report) async {
    final analysis = await analyzeContent(report.content);

    if (analysis.confidence > 0.9) {
      if (analysis.recommendation == ModerationAction.remove) {
        await _autoRemoveContent(report.contentId);
        await _notifyUser(report.reportedUserId, 'content_removed');
      }
    } else {
      // Enviar a moderación manual
      await _queueForManualReview(report);
    }
  }
}
```

### Workflow de Moderación

```dart
class ModerationWorkflow {
  // Estados de moderación
  enum ModerationStatus {
    pending,      // Esperando revisión
    approved,     // Aprobado por moderador
    rejected,     // Rechazado
    needsReview,  // Requiere segunda opinión
    escalated,    // Escalado a admin superior
  }

  // Acciones disponibles
  enum ModerationAction {
    approve,
    reject,
    warn,
    suspend,
    ban,
    escalate,
  }

  Future<void> processModerationDecision(
    String reportId,
    ModerationAction action,
    String reason,
    String moderatorId,
  ) async {
    // Registrar decisión en audit log
    await _logModerationAction(reportId, action, reason, moderatorId);

    // Ejecutar acción
    switch (action) {
      case ModerationAction.approve:
        await _approveContent(reportId);
        break;
      case ModerationAction.suspend:
        await _suspendUser(reportId, reason);
        break;
      // ... otras acciones
    }

    // Notificar partes involucradas
    await _sendModerationNotifications(reportId, action);
  }
}
```

## 📈 Analytics Avanzados

### Predictive Analytics

```dart
class PredictiveAnalytics {
  // Predicción de demanda
  Future<DemandForecast> predictDemand(
    String businessId,
    DateTime startDate,
    DateTime endDate,
  ) async {
    // Usar ML para predecir demanda futura
    // Basado en históricos, tendencias, eventos
  }

  // Detección de anomalías
  Future<List<Anomaly>> detectAnomalies() async {
    // Detectar patrones anómalos en:
    // - Pedidos (cantidades inusuales)
    // - Usuarios (comportamiento sospechoso)
    // - Pagos (transacciones fraudulentas)
  }

  // Análisis de churn
  Future<ChurnAnalysis> analyzeUserChurn() async {
    // Identificar usuarios en riesgo de abandono
    // Sugerir acciones de retención
  }

  // Optimización de precios
  Future<PricingRecommendation> suggestPricing(
    String businessId,
    String productId,
  ) async {
    // Analizar competencia, demanda, elasticidad
    // Sugerir precios óptimos
  }
}
```

### Business Intelligence

```dart
class BusinessIntelligence {
  // Cohort Analysis
  Future<CohortAnalysis> generateCohortAnalysis(
    DateTime startDate,
    String metric, // 'retention', 'revenue', etc.
  ) async {
    // Análisis de cohortes por mes de registro
    // Métricas de retención y valor por cohorte
  }

  // Funnel Analysis
  Future<FunnelAnalysis> analyzeFunnel(String funnelType) async {
    // Analizar conversión en diferentes funnels:
    // - Registro -> Primera orden
    // - Visita -> Compra
    // - Negocio aplicado -> Aprobado
  }

  // A/B Testing Results
  Future<ABTestResults> getABTestResults(String testId) async {
    // Resultados de tests A/B en curso
    // Significancia estadística
    // Recomendaciones de implementación
  }
}
```

## 🧪 Testing

### Tests Administrativos

```bash
# Tests de permisos y seguridad
flutter test test/core/permissions/
flutter test test/core/security/

# Tests de moderación
flutter test test/features/content/moderation/

# Tests de analytics
flutter test test/features/analytics/

# Tests de exportación de datos
flutter test test/utils/data_export_test.dart
```

### Integration Tests

```bash
# Test de flujo completo de administración
flutter test integration_test/admin_workflow_test.dart

# Test de sistema de permisos
flutter test integration_test/permissions_test.dart

# Test de moderación automática
flutter test integration_test/auto_moderation_test.dart
```

### Security Tests

```bash
# Tests de penetración automatizados
npm run security:test

# Verificación de permisos
flutter test security_test/permissions_security_test.dart

# Test de rate limiting
flutter test security_test/rate_limiting_test.dart
```

## 🔒 Medidas de Seguridad

### Autenticación Reforzada

```dart
class AdminAuthService {
  // Login con 2FA obligatorio
  Future<AdminAuthResult> loginWithMFA(
    String email,
    String password,
    String mfaCode,
  ) async {
    // Verificar credenciales
    // Validar código MFA
    // Registrar intento de login
    // Crear sesión segura
  }

  // Detección de comportamiento anómalo
  Future<bool> detectAnomalousLogin(
    String adminId,
    String ipAddress,
    String userAgent,
  ) async {
    // Comparar con patrones históricos
    // Verificar geolocalización
    // Análizar dispositivo y navegador
  }

  // Sesiones con timeout automático
  void startSessionMonitoring(String sessionId) {
    Timer.periodic(Duration(minutes: 5), (timer) {
      if (_shouldTerminateSession(sessionId)) {
        _terminateSession(sessionId);
        timer.cancel();
      }
    });
  }
}
```

### Audit Trail Completo

```dart
class AdminAuditLogger {
  // Registrar todas las acciones administrativas
  Future<void> logAction({
    required String adminId,
    required String action,
    required Map<String, dynamic> details,
    String? targetId,
    String? reason,
  }) async {
    final auditEntry = AuditEntry(
      id: uuid.v4(),
      adminId: adminId,
      action: action,
      details: details,
      targetId: targetId,
      reason: reason,
      timestamp: DateTime.now(),
      ipAddress: await _getCurrentIP(),
      userAgent: await _getUserAgent(),
    );

    await _auditRepository.save(auditEntry);

    // Alertar si es acción crítica
    if (_isCriticalAction(action)) {
      await _alertSecurityTeam(auditEntry);
    }
  }

  // Búsqueda avanzada en audit logs
  Future<List<AuditEntry>> searchAuditLogs({
    String? adminId,
    String? action,
    DateRange? dateRange,
    String? targetId,
  }) async {
    return await _auditRepository.search(
      adminId: adminId,
      action: action,
      dateRange: dateRange,
      targetId: targetId,
    );
  }
}
```

## 🚀 Performance y Escalabilidad

### Optimizaciones para Grandes Volúmenes

```dart
class AdminPerformanceOptimizer {
  // Paginación inteligente
  static const int defaultPageSize = 50;
  static const int maxPageSize = 500;

  // Lazy loading para listas grandes
  Widget buildLazyDataTable<T>({
    required Future<List<T>> Function(int page, int size) loader,
    required Widget Function(T item) itemBuilder,
  }) {
    return LazyPaginatedDataTable<T>(
      pageSize: defaultPageSize,
      loader: loader,
      itemBuilder: itemBuilder,
      cacheSize: 5, // Cachear 5 páginas
    );
  }

  // Búsqueda con debounce
  void setupSearch(TextEditingController controller) {
    Timer? debounceTimer;

    controller.addListener(() {
      debounceTimer?.cancel();
      debounceTimer = Timer(Duration(milliseconds: 500), () {
        _performSearch(controller.text);
      });
    });
  }

  // Cache inteligente
  static final Map<String, CacheEntry> _cache = {};

  static Future<T> getCached<T>(
    String key,
    Future<T> Function() fetcher,
    Duration ttl,
  ) async {
    final cached = _cache[key];

    if (cached != null && !cached.isExpired) {
      return cached.data as T;
    }

    final data = await fetcher();
    _cache[key] = CacheEntry(data, DateTime.now().add(ttl));

    return data;
  }
}
```

### Monitoring de Performance

```dart
class AdminPerformanceMonitor {
  // Métricas de rendimiento
  static void trackPageLoad(String pageName, Duration loadTime) {
    if (loadTime > Duration(seconds: 3)) {
      // Alertar sobre páginas lentas
      _alertSlowPage(pageName, loadTime);
    }

    // Registrar métrica
    _recordMetric('page_load_time', {
      'page': pageName,
      'duration_ms': loadTime.inMilliseconds,
    });
  }

  // Memory usage monitoring
  static void monitorMemoryUsage() {
    Timer.periodic(Duration(minutes: 5), (timer) {
      // En web, usar Performance API si está disponible
      final memoryInfo = _getMemoryInfo();

      if (memoryInfo.usedJSHeapSize > _maxMemoryThreshold) {
        _triggerMemoryCleanup();
      }
    });
  }
}
```

## 📊 Exportación Masiva de Datos

### Exportadores Especializados

```dart
class AdminDataExporter {
  // Exportar datos de usuarios
  Future<void> exportUsers({
    UserFilter? filter,
    ExportFormat format = ExportFormat.excel,
    String? filePath,
  }) async {
    final users = await _userRepository.getUsers(filter: filter);

    switch (format) {
      case ExportFormat.excel:
        await _exportUsersToExcel(users, filePath);
        break;
      case ExportFormat.csv:
        await _exportUsersToCSV(users, filePath);
        break;
      case ExportFormat.json:
        await _exportUsersToJSON(users, filePath);
        break;
    }
  }

  // Exportar datos financieros con cifrado
  Future<void> exportFinancialData({
    required DateRange dateRange,
    required String encryptionKey,
  }) async {
    final financialData = await _getFinancialData(dateRange);

    // Encriptar datos sensibles
    final encryptedData = _encryptFinancialData(financialData, encryptionKey);

    // Exportar con protección adicional
    await _saveEncryptedFile(encryptedData, 'financial_report_${dateRange.start}');
  }

  // Exportar logs de auditoría
  Future<void> exportAuditLogs({
    required DateRange dateRange,
    AdminRole? requesterRole,
  }) async {
    // Verificar permisos para exportar audit logs
    if (!_canExportAuditLogs(requesterRole)) {
      throw UnauthorizedException('Insufficient permissions');
    }

    final auditLogs = await _auditRepository.getLogs(dateRange);
    await _exportAuditLogsSecurely(auditLogs);
  }
}
```

## 🚀 Deployment en Producción

### Configuración de Producción

```yaml
# docker-compose.prod.yml
version: "3.8"
services:
  admin-panel:
    image: goplus/admin-panel:latest
    ports:
      - "443:443"
      - "80:80"
    environment:
      - NODE_ENV=production
      - SSL_CERT_PATH=/certs/cert.pem
      - SSL_KEY_PATH=/certs/key.pem
      - ADMIN_SECRET_KEY=${ADMIN_SECRET_KEY}
      - DB_CONNECTION_STRING=${DB_CONNECTION_STRING}
    volumes:
      - ./certs:/certs:ro
      - ./logs:/app/logs
    restart: unless-stopped

  admin-api:
    image: goplus/admin-api:latest
    environment:
      - FIREBASE_ADMIN_KEY=${FIREBASE_ADMIN_KEY}
      - ADMIN_CORS_ORIGINS=https://admin.goplus.com
    restart: unless-stopped
```

### Configuración de Seguridad en Producción

```bash
#!/bin/bash
# deploy-admin-secure.sh

# Configurar firewall
ufw allow 22/tcp    # SSH
ufw allow 80/tcp    # HTTP redirect
ufw allow 443/tcp   # HTTPS
ufw enable

# Configurar SSL certificates (Let's Encrypt)
certbot --nginx -d admin.goplus.com

# Configurar fail2ban para proteger SSH
apt install fail2ban
systemctl enable fail2ban

# Configurar backup automático
crontab -e
# 0 2 * * * /scripts/backup-admin-db.sh
# 0 3 * * 0 /scripts/full-system-backup.sh

# Configurar monitoring
apt install prometheus node-exporter
systemctl enable prometheus node-exporter
```

---

## 📞 Support y Escalación

### Niveles de Soporte

1. **L1 - Support**: Tickets básicos de usuarios
2. **L2 - Moderators**: Moderación de contenido y disputas
3. **L3 - Admins**: Gestión de usuarios y negocios
4. **L4 - Super Admins**: Configuración del sistema y emergencias

### Procedimientos de Emergencia

```dart
class EmergencyProcedures {
  // Activar modo de mantenimiento
  Future<void> activateMaintenanceMode(String reason) async {
    await _systemConfig.set('maintenance_mode', true);
    await _systemConfig.set('maintenance_reason', reason);

    // Notificar a todos los usuarios activos
    await _notificationService.broadcastMaintenance(reason);

    // Registrar en audit log
    await _auditLogger.logCriticalAction('maintenance_activated', reason);
  }

  // Rollback de emergencia
  Future<void> emergencyRollback(String version) async {
    // Verificar que es un super admin
    // Realizar rollback de base de datos
    // Revertir configuraciones
    // Notificar al equipo técnico
  }

  // Bloqueo masivo de usuarios
  Future<void> massUserSuspension(List<String> userIds, String reason) async {
    for (final userId in userIds) {
      await _userService.suspendUser(userId, reason);
    }

    // Registrar acción masiva
    await _auditLogger.logMassAction('mass_suspension', userIds.length, reason);
  }
}
```

### Contactos de Escalación

- 🚨 **Emergencias del Sistema**: Disponible 24/7
- 🔒 **Incidentes de Seguridad**: Respuesta < 1 hora
- 📊 **Issues de Performance**: Respuesta < 4 horas
- 🐛 **Bugs Críticos**: Respuesta < 8 horas
- 💼 **Consultas Generales**: Respuesta < 24 horas
