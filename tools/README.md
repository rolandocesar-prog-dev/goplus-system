# 🔧 GoPlus - Tools & Scripts

Colección de herramientas, scripts y utilidades para automatizar el desarrollo, testing, deployment y mantenimiento del sistema GoPlus.

## 📁 Estructura de Tools

```
tools/
├── scripts/                     # Scripts de automatización
│   ├── setup/                   # Scripts de configuración inicial
│   │   ├── setup_project.ps1    # Setup completo del proyecto
│   │   ├── install_deps.ps1     # Instalar dependencias
│   │   └── configure_env.ps1    # Configurar variables de entorno
│   ├── ci/                      # Scripts de CI/CD
│   │   ├── run_tests.ps1        # Ejecutar todos los tests
│   │   ├── build_all.ps1        # Build de todas las apps
│   │   ├── deploy.ps1           # Deploy automatizado
│   │   └── quality_check.ps1    # Verificación de calidad
│   ├── dev/                     # Scripts de desarrollo
│   │   ├── run_dev.ps1          # Ejecutar en modo desarrollo
│   │   ├── hot_restart.ps1      # Hot restart de todas las apps
│   │   ├── generate_code.ps1    # Generación de código
│   │   └── clean_project.ps1    # Limpiar archivos temporales
│   ├── maintenance/             # Scripts de mantenimiento
│   │   ├── backup_db.ps1        # Backup de base de datos
│   │   ├── update_deps.ps1      # Actualizar dependencias
│   │   ├── security_scan.ps1    # Scan de seguridad
│   │   └── performance_test.ps1 # Tests de rendimiento
│   └── utils/                   # Utilidades generales
│       ├── generate_icons.ps1   # Generar iconos para apps
│       ├── optimize_images.ps1  # Optimizar imágenes
│       ├── extract_strings.ps1  # Extraer strings para i18n
│       └── generate_docs.ps1    # Generar documentación
├── templates/                   # Plantillas de código
│   ├── feature_template/        # Plantilla para nuevas features
│   ├── component_template/      # Plantilla para componentes
│   ├── service_template/        # Plantilla para servicios
│   └── test_template/           # Plantilla para tests
├── configs/                     # Configuraciones
│   ├── docker/                  # Configuraciones Docker
│   ├── nginx/                   # Configuraciones Nginx
│   ├── firebase/                # Configuraciones Firebase
│   └── vscode/                  # Configuraciones VS Code
└── generators/                  # Generadores de código
    ├── feature_generator.dart   # Generar features completas
    ├── model_generator.dart     # Generar modelos
    └── api_generator.dart       # Generar código de API
```

## 🚀 Scripts Principales

### 📋 Setup Scripts

#### `setup_project.ps1`

Script principal para configurar el proyecto completo desde cero.

```powershell
# Ejecutar setup completo
./tools/scripts/setup/setup_project.ps1

# Parámetros opcionales
./tools/scripts/setup/setup_project.ps1 -SkipFirebase -DevMode
```

**Funcionalidades:**

- ✅ Verifica prerequisitos (Flutter, Firebase CLI, etc.)
- ✅ Instala dependencias de todos los packages y apps
- ✅ Configura Firebase projects
- ✅ Genera certificados de desarrollo
- ✅ Configura variables de entorno
- ✅ Ejecuta tests de verificación

#### `install_deps.ps1`

Instala dependencias de forma optimizada.

```powershell
# Instalar todas las dependencias
./tools/scripts/setup/install_deps.ps1

# Solo packages específicos
./tools/scripts/setup/install_deps.ps1 -OnlyPackages

# Solo apps específicas
./tools/scripts/setup/install_deps.ps1 -OnlyApps
```

### 🧪 CI/CD Scripts

#### `run_tests.ps1`

Ejecuta todos los tests del proyecto de forma organizada.

```powershell
# Ejecutar todos los tests
./tools/scripts/ci/run_tests.ps1

# Solo unit tests
./tools/scripts/ci/run_tests.ps1 -UnitOnly

# Con coverage report
./tools/scripts/ci/run_tests.ps1 -Coverage

# Tests específicos
./tools/scripts/ci/run_tests.ps1 -Target "packages/goplus_core"
```

**Features:**

- 🔍 **Tests paralelos** para mejor performance
- 📊 **Coverage reports** detallados
- 🚨 **Alertas** por tests fallidos
- 📝 **Logs** estructurados por módulo
- ⏱️ **Timeout** configurable por test suite

#### `build_all.ps1`

Construye todas las aplicaciones para diferentes plataformas.

```powershell
# Build completo (todas las apps, todas las plataformas)
./tools/scripts/ci/build_all.ps1

# Solo apps específicas
./tools/scripts/ci/build_all.ps1 -Apps "cliente,repartidor"

# Solo plataformas específicas
./tools/scripts/ci/build_all.ps1 -Platforms "android,web"

# Build de release
./tools/scripts/ci/build_all.ps1 -Release

# Build con optimizaciones específicas
./tools/scripts/ci/build_all.ps1 -Optimize -Obfuscate
```

#### `deploy.ps1`

Deploy automatizado a diferentes environments.

```powershell
# Deploy a staging
./tools/scripts/ci/deploy.ps1 -Environment staging

# Deploy a production
./tools/scripts/ci/deploy.ps1 -Environment production -Confirm

# Deploy solo web apps
./tools/scripts/ci/deploy.ps1 -WebOnly

# Rollback
./tools/scripts/ci/deploy.ps1 -Rollback -Version "1.2.3"
```

### 💻 Development Scripts

#### `run_dev.ps1`

Ejecuta múltiples apps en modo desarrollo simultáneamente.

```powershell
# Ejecutar todas las apps
./tools/scripts/dev/run_dev.ps1

# Apps específicas
./tools/scripts/dev/run_dev.ps1 -Apps "cliente,negocio"

# Con hot reload avanzado
./tools/scripts/dev/run_dev.ps1 -HotReload

# Con logs centralizados
./tools/scripts/dev/run_dev.ps1 -CentralizedLogs
```

#### `generate_code.ps1`

Genera código automáticamente (models, services, etc.).

```powershell
# Generar todo el código
./tools/scripts/dev/generate_code.ps1

# Solo models JSON
./tools/scripts/dev/generate_code.ps1 -JsonOnly

# Solo localization
./tools/scripts/dev/generate_code.ps1 -L10nOnly

# Watch mode (regenera automáticamente)
./tools/scripts/dev/generate_code.ps1 -Watch
```

#### `clean_project.ps1`

Limpia archivos temporales y caché.

```powershell
# Limpieza completa
./tools/scripts/dev/clean_project.ps1

# Solo build artifacts
./tools/scripts/dev/clean_project.ps1 -BuildOnly

# Solo node_modules y pub cache
./tools/scripts/dev/clean_project.ps1 -DepsOnly

# Limpieza profunda (incluye IDE files)
./tools/scripts/dev/clean_project.ps1 -Deep
```

## 🛠️ Generators

### Feature Generator

Genera una feature completa con toda la estructura necesaria.

```bash
# Generar nueva feature
dart run tools/generators/feature_generator.dart \
  --name user_profile \
  --app cliente \
  --type crud

# Con estado management específico
dart run tools/generators/feature_generator.dart \
  --name order_tracking \
  --app repartidor \
  --state-management bloc \
  --include-tests
```

Genera:

```
lib/features/user_profile/
├── data/
│   ├── datasources/
│   ├── models/
│   └── repositories/
├── domain/
│   ├── entities/
│   ├── repositories/
│   └── usecases/
├── presentation/
│   ├── bloc/
│   ├── pages/
│   └── widgets/
└── user_profile_module.dart
```

### Model Generator

Genera modelos con serialización JSON automática.

```bash
# Desde schema JSON
dart run tools/generators/model_generator.dart \
  --from-json schemas/user_model.json \
  --output lib/models/

# Con validaciones
dart run tools/generators/model_generator.dart \
  --name ProductModel \
  --fields "name:String,price:double,category:String" \
  --validations \
  --equatable
```

### API Generator

Genera clientes de API desde especificaciones OpenAPI.

```bash
# Desde OpenAPI spec
dart run tools/generators/api_generator.dart \
  --spec api/goplus_api.yaml \
  --output lib/services/api/

# Con interceptors personalizados
dart run tools/generators/api_generator.dart \
  --spec api/goplus_api.yaml \
  --interceptors auth,logging,retry
```

## 📊 Monitoring & Analytics

### Performance Monitor

Script para monitorear performance de las apps.

```powershell
# Monitor básico
./tools/scripts/monitoring/performance_monitor.ps1

# Con métricas detalladas
./tools/scripts/monitoring/performance_monitor.ps1 -Detailed

# Monitor continuo
./tools/scripts/monitoring/performance_monitor.ps1 -Continuous -Interval 60

# Exportar métricas
./tools/scripts/monitoring/performance_monitor.ps1 -Export csv
```

### Bundle Analyzer

Analiza el tamaño de los bundles de las apps.

```powershell
# Análisis completo
./tools/scripts/analysis/bundle_analyzer.ps1

# Solo app específica
./tools/scripts/analysis/bundle_analyzer.ps1 -App cliente

# Con visualización
./tools/scripts/analysis/bundle_analyzer.ps1 -Visualize

# Comparar con versión anterior
./tools/scripts/analysis/bundle_analyzer.ps1 -Compare "1.2.0"
```

## 🔒 Security Tools

### Security Scan

Escaneo automático de vulnerabilidades.

```powershell
# Scan completo
./tools/scripts/security/security_scan.ps1

# Solo dependencias
./tools/scripts/security/security_scan.ps1 -DepsOnly

# Con severity filter
./tools/scripts/security/security_scan.ps1 -MinSeverity medium

# Generar reporte
./tools/scripts/security/security_scan.ps1 -Report json
```

### License Checker

Verifica licencias de dependencias.

```powershell
# Verificar todas las licencias
./tools/scripts/security/license_checker.ps1

# Solo licencias problemáticas
./tools/scripts/security/license_checker.ps1 -ProblematicOnly

# Exportar reporte
./tools/scripts/security/license_checker.ps1 -Export licenses_report.json
```

## 🏗️ Template System

### Project Templates

Plantillas para generar código consistente.

#### Feature Template

```
templates/feature_template/
├── data/
│   ├── datasources/
│   │   └── {{feature_name}}_datasource.dart.template
│   ├── models/
│   │   └── {{feature_name}}_model.dart.template
│   └── repositories/
│       └── {{feature_name}}_repository_impl.dart.template
├── domain/
│   ├── entities/
│   │   └── {{feature_name}}_entity.dart.template
│   ├── repositories/
│   │   └── {{feature_name}}_repository.dart.template
│   └── usecases/
│       ├── get_{{feature_name}}.dart.template
│       └── create_{{feature_name}}.dart.template
└── presentation/
    ├── bloc/
    │   ├── {{feature_name}}_bloc.dart.template
    │   ├── {{feature_name}}_event.dart.template
    │   └── {{feature_name}}_state.dart.template
    ├── pages/
    │   └── {{feature_name}}_page.dart.template
    └── widgets/
        └── {{feature_name}}_widget.dart.template
```

#### Component Template

```
templates/component_template/
├── {{component_name}}.dart.template
├── {{component_name}}_theme.dart.template
├── {{component_name}}_variants.dart.template
└── test/
    ├── {{component_name}}_test.dart.template
    └── golden/
        └── {{component_name}}_golden_test.dart.template
```

## 🐳 Docker & Deployment

### Docker Configurations

```
configs/docker/
├── Dockerfile.web              # Para apps web
├── Dockerfile.api              # Para Firebase Functions
├── docker-compose.dev.yml      # Desarrollo local
├── docker-compose.prod.yml     # Producción
└── nginx/
    ├── nginx.conf              # Configuración base
    ├── ssl.conf                # Configuración SSL
    └── gzip.conf               # Compresión
```

### Deployment Scripts

```powershell
# Deploy con Docker
./tools/scripts/deploy/docker_deploy.ps1 -Environment production

# Deploy a Kubernetes
./tools/scripts/deploy/k8s_deploy.ps1 -Namespace goplus-prod

# Deploy serverless
./tools/scripts/deploy/serverless_deploy.ps1 -Stage prod
```

## 📈 Analytics & Reporting

### Usage Analytics

Script para generar reportes de uso del código.

```powershell
# Análisis de código no utilizado
./tools/scripts/analysis/dead_code_analysis.ps1

# Métricas de complejidad
./tools/scripts/analysis/complexity_analysis.ps1

# Dependencias duplicadas
./tools/scripts/analysis/duplicate_deps.ps1

# Reporte completo
./tools/scripts/analysis/generate_analytics_report.ps1
```

### Dependency Graph

Genera grafos de dependencias visuales.

```powershell
# Grafo completo
./tools/scripts/analysis/dependency_graph.ps1

# Solo packages internos
./tools/scripts/analysis/dependency_graph.ps1 -InternalOnly

# Con formato específico
./tools/scripts/analysis/dependency_graph.ps1 -Format svg
```

## 🔧 Configuration Management

### Environment Manager

Gestiona configuraciones por environment.

```powershell
# Configurar development
./tools/scripts/config/setup_env.ps1 -Environment dev

# Configurar staging
./tools/scripts/config/setup_env.ps1 -Environment staging

# Configurar production
./tools/scripts/config/setup_env.ps1 -Environment prod -Secure

# Migrar configuraciones
./tools/scripts/config/migrate_config.ps1 -From dev -To staging
```

### Secrets Manager

Gestiona secretos y API keys de forma segura.

```powershell
# Configurar secretos
./tools/scripts/config/secrets_manager.ps1 -Set API_KEY "your-key"

# Obtener secretos
./tools/scripts/config/secrets_manager.ps1 -Get API_KEY

# Rotar secretos
./tools/scripts/config/secrets_manager.ps1 -Rotate API_KEY

# Auditoría de secretos
./tools/scripts/config/secrets_manager.ps1 -Audit
```

## 📝 Documentation Tools

### Auto Documentation

Genera documentación automáticamente desde código.

```powershell
# Generar docs completas
./tools/scripts/docs/generate_docs.ps1

# Solo API documentation
./tools/scripts/docs/generate_docs.ps1 -ApiOnly

# Con diagramas
./tools/scripts/docs/generate_docs.ps1 -IncludeDiagrams

# Deploy a GitHub Pages
./tools/scripts/docs/deploy_docs.ps1
```

### Architecture Diagrams

Genera diagramas de arquitectura.

```powershell
# Diagrama completo del sistema
./tools/scripts/docs/generate_architecture.ps1

# Solo componentes específicos
./tools/scripts/docs/generate_architecture.ps1 -Component auth

# Con detalles de flujo de datos
./tools/scripts/docs/generate_architecture.ps1 -DataFlow
```

## 🧪 Testing Tools

### Test Runner Avanzado

```powershell
# Ejecutar tests con configuración avanzada
./tools/scripts/testing/advanced_test_runner.ps1 \
  -Parallel 4 \
  -Timeout 300 \
  -Retry 2 \
  -Coverage \
  -Report json,html

# Tests de integración
./tools/scripts/testing/integration_tests.ps1 \
  -Platform android \
  -Device "Pixel 4"

# Tests de performance
./tools/scripts/testing/performance_tests.ps1 \
  -Profile cpu,memory \
  -Duration 300
```

### Golden Test Manager

```powershell
# Actualizar golden files
./tools/scripts/testing/golden_manager.ps1 -Update

# Comparar golden files
./tools/scripts/testing/golden_manager.ps1 -Compare

# Limpiar golden files obsoletos
./tools/scripts/testing/golden_manager.ps1 -Cleanup
```

## 🔍 Quality Assurance

### Code Quality Checker

```powershell
# Verificación completa de calidad
./tools/scripts/qa/quality_check.ps1

# Solo linting
./tools/scripts/qa/quality_check.ps1 -LintOnly

# Con métricas detalladas
./tools/scripts/qa/quality_check.ps1 -Metrics

# Generar reporte de calidad
./tools/scripts/qa/quality_check.ps1 -Report
```

### Pre-commit Hooks

```powershell
# Instalar hooks
./tools/scripts/qa/install_hooks.ps1

# Configurar hooks personalizados
./tools/scripts/qa/install_hooks.ps1 -Custom lint,test,format

# Verificar hooks
./tools/scripts/qa/check_hooks.ps1
```

## 📊 Usage Examples

### Flujo de Desarrollo Típico

```powershell
# 1. Setup inicial (solo primera vez)
./tools/scripts/setup/setup_project.ps1

# 2. Desarrollo diario
./tools/scripts/dev/run_dev.ps1 -Apps "cliente,negocio"

# 3. Antes de commit
./tools/scripts/qa/quality_check.ps1
./tools/scripts/ci/run_tests.ps1 -Fast

# 4. Build para testing
./tools/scripts/ci/build_all.ps1 -Debug

# 5. Deploy a staging
./tools/scripts/ci/deploy.ps1 -Environment staging
```

### CI/CD Pipeline

```yaml
# .github/workflows/ci.yml
name: CI/CD Pipeline

on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Setup
        run: ./tools/scripts/setup/setup_project.ps1 -CI
      - name: Test
        run: ./tools/scripts/ci/run_tests.ps1 -Coverage
      - name: Quality Check
        run: ./tools/scripts/qa/quality_check.ps1 -CI

  build:
    needs: test
    runs-on: ubuntu-latest
    steps:
      - name: Build All
        run: ./tools/scripts/ci/build_all.ps1 -Release
      - name: Security Scan
        run: ./tools/scripts/security/security_scan.ps1

  deploy:
    needs: [test, build]
    if: github.ref == 'refs/heads/main'
    runs-on: ubuntu-latest
    steps:
      - name: Deploy to Staging
        run: ./tools/scripts/ci/deploy.ps1 -Environment staging
```

## 🔧 Customización

### Configuración de Scripts

Personaliza el comportamiento de los scripts editando:

```json
// tools/config.json
{
  "project": {
    "name": "GoPlus",
    "version": "1.0.0",
    "flutter_version": "3.10.0"
  },
  "apps": [
    {
      "name": "cliente",
      "platform": ["android", "ios"],
      "build_config": "release"
    },
    {
      "name": "negocio",
      "platform": ["web"],
      "build_config": "release"
    }
  ],
  "testing": {
    "timeout": 300,
    "parallel_jobs": 4,
    "coverage_threshold": 80
  },
  "deployment": {
    "staging_url": "https://staging.goplus.com",
    "prod_url": "https://goplus.com"
  }
}
```

### Variables de Entorno

```powershell
# .env.tools
FLUTTER_PATH=C:\flutter\bin
FIREBASE_PROJECT_DEV=goplus-dev
FIREBASE_PROJECT_PROD=goplus-prod
ANDROID_SDK_ROOT=C:\Android\Sdk
COVERAGE_THRESHOLD=80
TEST_TIMEOUT=300
```

## 📞 Support

### Troubleshooting Scripts

```powershell
# Diagnosticar problemas comunes
./tools/scripts/troubleshoot/diagnose.ps1

# Verificar setup del proyecto
./tools/scripts/troubleshoot/verify_setup.ps1

# Reparar configuración automáticamente
./tools/scripts/troubleshoot/auto_repair.ps1

# Generar reporte de debug
./tools/scripts/troubleshoot/debug_report.ps1
```

### Logs y Debugging

- 📁 **Logs de scripts**: `tools/logs/`
- 🔍 **Debug mode**: Añadir `-Debug` a cualquier script
- 📊 **Performance logs**: `tools/logs/performance/`
- ⚠️ **Error logs**: `tools/logs/errors/`

---

## 🤝 Contribución

Para contribuir con nuevos tools:

1. Seguir la estructura de carpetas existente
2. Documentar parámetros y funcionalidad
3. Incluir manejo de errores robusto
4. Añadir logging apropiado
5. Crear tests para scripts críticos
6. Actualizar este README

### Template para Nuevos Scripts

```powershell
# tools/scripts/template.ps1
param(
    [string]$Parameter1,
    [switch]$Debug,
    [switch]$Help
)

# Show help
if ($Help) {
    Write-Host "Usage: ./template.ps1 -Parameter1 <value> [-Debug] [-Help]"
    exit 0
}

# Enable debug logging
if ($Debug) {
    $DebugPreference = "Continue"
}

# Script logic here
try {
    Write-Host "Starting script..." -ForegroundColor Green

    # Main functionality

    Write-Host "Script completed successfully!" -ForegroundColor Green
}
catch {
    Write-Error "Script failed: $_"
    exit 1
}
```
