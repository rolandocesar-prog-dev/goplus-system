# 🔥 GoPlus - Firebase Functions

Backend serverless para el sistema GoPlus, construido con Firebase Cloud Functions y TypeScript.

## 🎯 Funcionalidades del Backend

### 🔐 Autenticación y Usuarios

- ✅ **Triggers de creación de usuario**
- ✅ **Validación de datos de perfil**
- ✅ **Sistema de roles** (cliente, repartidor, negocio, admin)
- ✅ **Verificación de repartidores**

### 📦 Gestión de Pedidos

- ✅ **Procesamiento de pedidos nuevos**
- ✅ **Asignación automática de repartidores**
- ✅ **Cálculo de precios y comisiones**
- ✅ **Estados de pedido en tiempo real**
- ✅ **Timeouts y cancelaciones automáticas**

### 🔔 Sistema de Notificaciones

- ✅ **Push notifications** a dispositivos
- ✅ **Notificaciones por email**
- ✅ **Webhooks** para integraciones
- ✅ **Notificaciones basadas en eventos**

### 💳 Procesamiento de Pagos

- ✅ **Validación de pagos QR**
- ✅ **Cálculo de comisiones**
- ✅ **Reportes de transacciones**
- ✅ **Integración con sistemas de pago**

### 📊 Analytics y Reportes

- ✅ **Métricas en tiempo real**
- ✅ **Reportes automatizados**
- ✅ **Análisis de rendimiento**
- ✅ **Exportación de datos**

## 🚀 Setup y Desarrollo

### Prerrequisitos

- Node.js 18+
- Firebase CLI
- Proyecto Firebase configurado
- Cuenta de servicio con permisos admin

### Instalación

```bash
# Navegar a functions
cd firebase/functions

# Instalar dependencias
npm install

# Login a Firebase (si no lo has hecho)
firebase login

# Seleccionar proyecto
firebase use --add tu-proyecto-goplus
```

### Desarrollo Local

```bash
# Compilar TypeScript
npm run build

# Modo watch (recompila automáticamente)
npm run build:watch

# Ejecutar emulador local
npm run serve

# Shell interactivo
npm run shell
```

### Testing

```bash
# Ejecutar tests
npm test

# Tests con coverage
npm run test:coverage

# Linting
npm run lint
```

## 🏗️ Estructura del Proyecto

```
firebase/functions/
├── src/                          # Código fuente TypeScript
│   ├── index.ts                  # Entry point principal
│   ├── auth/                     # Funciones de autenticación
│   │   ├── onCreate.ts           # Trigger creación usuario
│   │   ├── onDelete.ts           # Trigger eliminación usuario
│   │   └── roleManagement.ts     # Gestión de roles
│   ├── orders/                   # Funciones de pedidos
│   │   ├── createOrder.ts        # Crear nuevo pedido
│   │   ├── assignDelivery.ts     # Asignar repartidor
│   │   ├── updateStatus.ts       # Actualizar estado
│   │   └── calculatePricing.ts   # Cálculo de precios
│   ├── notifications/            # Sistema de notificaciones
│   │   ├── pushNotifications.ts  # FCM push notifications
│   │   ├── emailNotifications.ts # Emails automáticos
│   │   └── webhooks.ts           # Webhooks externos
│   ├── payments/                 # Procesamiento de pagos
│   │   ├── validatePayment.ts    # Validar pagos
│   │   └── calculateCommissions.ts # Comisiones
│   ├── analytics/                # Analytics y reportes
│   │   ├── generateReports.ts    # Reportes automáticos
│   │   └── trackMetrics.ts       # Métricas en tiempo real
│   ├── scheduled/                # Funciones programadas
│   │   ├── cleanupData.ts        # Limpieza de datos
│   │   └── generateReports.ts    # Reportes periódicos
│   └── utils/                    # Utilidades compartidas
│       ├── validators.ts         # Validadores
│       ├── constants.ts          # Constantes
│       └── helpers.ts            # Funciones helper
├── lib/                         # JavaScript compilado
├── package.json                 # Dependencias y scripts
├── tsconfig.json               # Configuración TypeScript
└── .eslintrc.js                # Configuración ESLint
```

## 🔧 Funciones Principales

### 🔐 Auth Functions

```typescript
// Trigger cuando se crea un nuevo usuario
export const onUserCreate = functions.auth.user().onCreate(async (user) => {
  // Crear documento de perfil en Firestore
  // Asignar rol por defecto
  // Enviar email de bienvenida
});

// Callable function para cambiar roles
export const updateUserRole = functions.https.onCall(async (data, context) => {
  // Verificar permisos de admin
  // Actualizar custom claims
  // Notificar cambio de rol
});
```

### 📦 Order Functions

```typescript
// Crear nuevo pedido
export const createOrder = functions.https.onCall(async (data, context) => {
  // Validar datos del pedido
  // Calcular precios y comisiones
  // Asignar repartidor disponible
  // Crear documento en Firestore
  // Enviar notificaciones
});

// Trigger cuando cambia estado de pedido
export const onOrderStatusChange = functions.firestore
  .document("orders/{orderId}")
  .onUpdate(async (change, context) => {
    // Notificar a partes involucradas
    // Actualizar métricas
    // Procesar pagos si es necesario
  });
```

### 🔔 Notification Functions

```typescript
// Enviar push notification
export const sendPushNotification = functions.https.onCall(
  async (data, context) => {
    const message = {
      notification: {
        title: data.title,
        body: data.body,
      },
      token: data.deviceToken,
    };

    return admin.messaging().send(message);
  }
);

// Notificaciones automáticas por eventos
export const sendOrderNotifications = functions.firestore
  .document("orders/{orderId}")
  .onCreate(async (snapshot, context) => {
    // Notificar al negocio
    // Buscar repartidor disponible
    // Enviar notificación de nuevo pedido
  });
```

### 💰 Payment Functions

```typescript
// Validar pago QR
export const validateQRPayment = functions.https.onCall(
  async (data, context) => {
    // Verificar código QR
    // Validar monto
    // Actualizar estado de pago
    // Procesar comisiones
  }
);

// Calcular comisiones
export const calculateCommissions = functions.https.onCall(
  async (data, context) => {
    const orderTotal = data.amount;
    const businessCommission = orderTotal * 0.05; // 5% para negocio
    const deliveryCommission = orderTotal * 0.15; // 15% para repartidor
    const platformFee = orderTotal * 0.03; // 3% para plataforma

    return {
      business: businessCommission,
      delivery: deliveryCommission,
      platform: platformFee,
    };
  }
);
```

### 📊 Scheduled Functions

```typescript
// Generar reportes diarios
export const generateDailyReports = functions.pubsub
  .schedule("0 1 * * *") // Cada día a la 1 AM
  .timeZone("America/La_Paz")
  .onRun(async (context) => {
    // Obtener datos del día anterior
    // Generar reportes de ventas
    // Calcular métricas de rendimiento
    // Enviar reportes por email
  });

// Limpiar datos antiguos
export const cleanupOldData = functions.pubsub
  .schedule("0 2 * * 0") // Cada domingo a las 2 AM
  .onRun(async (context) => {
    // Eliminar logs antiguos
    // Archivar pedidos completados
    // Optimizar base de datos
  });
```

## ⚙️ Configuración

### Variables de Entorno

```bash
# Configurar variables de entorno
firebase functions:config:set \
  app.name="GoPlus" \
  app.environment="production" \
  notifications.email_enabled=true \
  payments.qr_validation_enabled=true
```

### Secrets Management

```bash
# Para APIs keys sensibles
firebase functions:secrets:set PAYMENT_API_KEY
firebase functions:secrets:set EMAIL_SERVICE_KEY
firebase functions:secrets:set MAPS_API_KEY
```

### CORS Configuration

```typescript
// Para requests desde web apps
import * as cors from "cors";
const corsHandler = cors({ origin: true });

export const publicApiFunction = functions.https.onRequest((req, res) => {
  return corsHandler(req, res, () => {
    // Tu lógica aquí
  });
});
```

## 🚀 Deployment

### Deploy a Producción

```bash
# Deploy todas las functions
npm run deploy

# Deploy function específica
firebase deploy --only functions:createOrder

# Deploy con confirmación
firebase deploy --only functions --force
```

### Staging Environment

```bash
# Usar proyecto de staging
firebase use staging

# Deploy a staging
npm run deploy:staging
```

### Rollback

```bash
# Ver versiones anteriores
firebase functions:list

# Rollback a versión anterior
firebase functions:roll-back functionName --from-version 1
```

## 📊 Monitoring y Logs

### Ver Logs

```bash
# Logs en tiempo real
npm run logs

# Logs de function específica
firebase functions:log --only createOrder

# Logs con filtro
firebase functions:log --only createOrder --lines 50
```

### Métricas en Google Cloud Console

- **Invocaciones** por función
- **Errores** y tasa de fallos
- **Duración** promedio
- **Uso de memoria**
- **Costos** por función

## 🔒 Seguridad

### Reglas de Seguridad

```typescript
// Validar contexto de autenticación
if (!context.auth) {
  throw new functions.https.HttpsError(
    "unauthenticated",
    "Usuario debe estar autenticado"
  );
}

// Verificar roles
const userRole = context.auth.token.role;
if (userRole !== "admin") {
  throw new functions.https.HttpsError(
    "permission-denied",
    "Solo admins pueden realizar esta acción"
  );
}
```

### Rate Limiting

```typescript
// Implementar rate limiting básico
const rateLimiter = new Map<string, number>();

export const limitedFunction = functions.https.onCall(async (data, context) => {
  const userId = context.auth?.uid;
  const now = Date.now();
  const lastCall = rateLimiter.get(userId) || 0;

  if (now - lastCall < 1000) {
    // 1 segundo entre calls
    throw new functions.https.HttpsError(
      "resource-exhausted",
      "Demasiadas solicitudes"
    );
  }

  rateLimiter.set(userId, now);
  // Continuar con la lógica...
});
```

## 💰 Optimización de Costos

### Configuración de Resources

```typescript
// Configurar memory y timeout por función
export const lightweightFunction = functions
  .runWith({ memory: "128MB", timeoutSeconds: 30 })
  .https.onCall(async (data, context) => {
    // Función simple y rápida
  });

export const heavyFunction = functions
  .runWith({ memory: "1GB", timeoutSeconds: 540 })
  .https.onCall(async (data, context) => {
    // Función que requiere más recursos
  });
```

### Batch Operations

```typescript
// Procesar operaciones en lotes para reducir invocaciones
export const batchProcessOrders = functions.pubsub
  .schedule("*/5 * * * *") // Cada 5 minutos
  .onRun(async (context) => {
    // Procesar múltiples pedidos pendientes
    // en una sola invocación
  });
```

---

## 📞 Support y Troubleshooting

### Debugging Common Issues

**Function timeout**

- Incrementar `timeoutSeconds` en configuración
- Optimizar consultas a Firestore
- usar operaciones asíncronas apropiadamente

**Memory exceeded**

- Incrementar `memory` allocation
- Optimizar uso de variables
- Liberar recursos no utilizados

**Permission denied**

- Verificar custom claims de usuario
- Revisar reglas de seguridad en Firestore
- Confirmar configuración de IAM roles

Para soporte específico:

- Revisar logs en Firebase Console
- Verificar métricas en Google Cloud Console
- Contactar equipo de desarrollo con logs específicos
