import * as admin from 'firebase-admin';
import * as functions from 'firebase-functions';

// Inicializar Firebase Admin
admin.initializeApp();

// Referencias a Firestore
const db = admin.firestore();

// =======================================
// FUNCTIONS PARA MANEJO DE PEDIDOS
// =======================================

/**
 * Función que se ejecuta cuando se crea un nuevo pedido
 * - Notifica al negocio
 * - Actualiza estadísticas
 * - Busca repartidores disponibles
 */
export const onOrderCreated = functions.firestore
  .document('orders/{orderId}')
  .onCreate(async (snap, context) => {
    const orderId = context.params.orderId;
    const orderData = snap.data();
    
    console.log(` Nuevo pedido creado: ${orderId}`);
    
    try {
      // 1. Notificar al negocio
      await sendNotificationToBusiness(orderData.businessId, {
        title: ' Nuevo Pedido!',
        body: `Pedido #${orderId} por $${orderData.total}`,
        data: {
          type: 'new_order',
          orderId: orderId,
          amount: orderData.total.toString()
        }
      });
      
      // 2. Actualizar estadísticas del negocio
      await updateBusinessStats(orderData.businessId, {
        totalOrders: admin.firestore.FieldValue.increment(1),
        pendingOrders: admin.firestore.FieldValue.increment(1)
      });
      
      // 3. Crear registro de analytics
      await db.collection('analytics').add({
        type: 'order_created',
        orderId: orderId,
        businessId: orderData.businessId,
        customerId: orderData.customerId,
        amount: orderData.total,
        timestamp: admin.firestore.FieldValue.serverTimestamp()
      });
      
      console.log(` Pedido ${orderId} procesado correctamente`);
      
    } catch (error) {
      console.error(`❌ Error procesando pedido ${orderId}:`, error);
    }
  });

/**
 * Función que se ejecuta cuando cambia el estado de un pedido
 */
export const onOrderStatusChanged = functions.firestore
  .document('orders/{orderId}')
  .onUpdate(async (change, context) => {
    const orderId = context.params.orderId;
    const beforeData = change.before.data();
    const afterData = change.after.data();
    
    // Solo procesar si cambió el status
    if (beforeData.status === afterData.status) return;
    
    console.log(`Estado del pedido ${orderId} cambió: ${beforeData.status} → ${afterData.status}`);
    
    try {
      switch (afterData.status) {
        case 'confirmed':
          await handleOrderConfirmed(orderId, afterData);
          break;
        case 'preparing':
          await handleOrderPreparing(orderId, afterData);
          break;
        case 'ready':
          await handleOrderReady(orderId, afterData);
          break;
        case 'picked_up':
          await handleOrderPickedUp(orderId, afterData);
          break;
        case 'delivered':
          await handleOrderDelivered(orderId, afterData);
          break;
        case 'cancelled':
          await handleOrderCancelled(orderId, afterData, beforeData.status);
          break;
      }
    } catch (error) {
      console.error(`Error procesando cambio de estado del pedido ${orderId}:`, error);
    }
  });

// =======================================
//  FUNCTIONS PARA NOTIFICACIONES
// =======================================

/**
 * Función para enviar notificaciones push
 */
export const sendPushNotification = functions.https.onCall(async (data, context) => {
  // Verificar autenticación
  if (!context.auth) {
    throw new functions.https.HttpsError('unauthenticated', 'Usuario debe estar autenticado');
  }
  
  const { userId, title, body, data: notificationData } = data;
  
  try {
    // Obtener token FCM del usuario
    const userDoc = await db.collection('users').doc(userId).get();
    const fcmToken = userDoc.data()?.fcmToken;
    
    if (!fcmToken) {
      throw new functions.https.HttpsError('not-found', 'Token FCM no encontrado');
    }
    
    // Enviar notificación
    const message = {
      token: fcmToken,
      notification: {
        title: title,
        body: body
      },
      data: notificationData || {}
    };
    
    const response = await admin.messaging().send(message);
    console.log(` Notificación enviada exitosamente: ${response}`);
    
    return { success: true, messageId: response };
    
  } catch (error) {
    console.error(' Error enviando notificación:', error);
    throw new functions.https.HttpsError('internal', 'Error enviando notificación');
  }
});

// =======================================
//  FUNCTIONS PARA REPARTIDORES
// =======================================

/**
 * Función para asignar repartidor a un pedido
 */
export const assignDeliveryDriver = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError('unauthenticated', 'Usuario debe estar autenticado');
  }
  
  const { orderId } = data;
  
  try {
    // Buscar repartidores disponibles cerca del negocio
    const orderDoc = await db.collection('orders').doc(orderId).get();
    const orderData = orderDoc.data();
    
    if (!orderData) {
      throw new functions.https.HttpsError('not-found', 'Pedido no encontrado');
    }
    
    const businessDoc = await db.collection('businesses').doc(orderData.businessId).get();
    const businessLocation = businessDoc.data()?.location;
    
    // Buscar repartidores activos (esto es una implementación simplificada)
    const availableDrivers = await db.collection('delivery_drivers')
      .where('status', '==', 'available')
      .where('isOnline', '==', true)
      .limit(5)
      .get();
    
    if (availableDrivers.empty) {
      throw new functions.https.HttpsError('not-found', 'No hay repartidores disponibles');
    }
    
    // Seleccionar el primer repartidor disponible (aquí podrías implementar lógica más sofisticada)
    const selectedDriver = availableDrivers.docs[0];
    const driverId = selectedDriver.id;
    
    // Actualizar el pedido con el repartidor asignado
    await db.collection('orders').doc(orderId).update({
      driverId: driverId,
      status: 'assigned',
      assignedAt: admin.firestore.FieldValue.serverTimestamp()
    });
    
    // Actualizar estado del repartidor
    await db.collection('delivery_drivers').doc(driverId).update({
      status: 'busy',
      currentOrderId: orderId
    });
    
    // Notificar al repartidor
    await sendNotificationToDriver(driverId, {
      title: ' Nuevo Pedido Asignado',
      body: `Pedido #${orderId} - $${orderData.total}`,
      data: {
        type: 'order_assigned',
        orderId: orderId
      }
    });
    
    return { success: true, driverId: driverId };
    
  } catch (error) {
    console.error(' Error asignando repartidor:', error);
    throw new functions.https.HttpsError('internal', 'Error asignando repartidor');
  }
});

// =======================================
//  FUNCTIONS PARA ANALYTICS Y REPORTES
// =======================================

/**
 * Función programada para generar reportes diarios
 */
export const generateDailyReports = functions.pubsub
  .schedule('0 2 * * *') // Todos los días a las 2 AM
  .timeZone('America/Lima')
  .onRun(async (context) => {
    console.log(' Generando reportes diarios...');
    
    const today = new Date();
    const yesterday = new Date(today.getTime() - 24 * 60 * 60 * 1000);
    
    try {
      // Obtener pedidos del día anterior
      const ordersSnapshot = await db.collection('orders')
        .where('createdAt', '>=', yesterday)
        .where('createdAt', '<', today)
        .get();
      
      const orders = ordersSnapshot.docs.map(doc => ({ id: doc.id, ...doc.data() }));
      
      // Calcular métricas
      const totalOrders = orders.length;
      const totalRevenue = orders.reduce((sum, order) => sum + (order.total || 0), 0);
      const completedOrders = orders.filter(order => order.status === 'delivered').length;
      const cancelledOrders = orders.filter(order => order.status === 'cancelled').length;
      
      // Guardar reporte
      await db.collection('daily_reports').add({
        date: yesterday,
        totalOrders,
        totalRevenue,
        completedOrders,
        cancelledOrders,
        completionRate: totalOrders > 0 ? (completedOrders / totalOrders) * 100 : 0,
        generatedAt: admin.firestore.FieldValue.serverTimestamp()
      });
      
      console.log(` Reporte diario generado: ${totalOrders} pedidos, $${totalRevenue} ingresos`);
      
    } catch (error) {
      console.error(' Error generando reporte diario:', error);
    }
  });

// =======================================
//  FUNCIONES AUXILIARES
// =======================================

async function sendNotificationToBusiness(businessId: string, notification: any) {
  const businessDoc = await db.collection('businesses').doc(businessId).get();
  const ownerFcmToken = businessDoc.data()?.ownerFcmToken;
  
  if (ownerFcmToken) {
    const message = {
      token: ownerFcmToken,
      notification: {
        title: notification.title,
        body: notification.body
      },
      data: notification.data
    };
    
    await admin.messaging().send(message);
  }
}

async function sendNotificationToDriver(driverId: string, notification: any) {
  const driverDoc = await db.collection('delivery_drivers').doc(driverId).get();
  const fcmToken = driverDoc.data()?.fcmToken;
  
  if (fcmToken) {
    const message = {
      token: fcmToken,
      notification: {
        title: notification.title,
        body: notification.body
      },
      data: notification.data
    };
    
    await admin.messaging().send(message);
  }
}

async function updateBusinessStats(businessId: string, updates: any) {
  await db.collection('businesses').doc(businessId).update(updates);
}

async function handleOrderConfirmed(orderId: string, orderData: any) {
  // Notificar al cliente que el pedido fue confirmado
  // Actualizar tiempo estimado de entrega
  console.log(` Pedido ${orderId} confirmado`);
}

async function handleOrderPreparing(orderId: string, orderData: any) {
  // Notificar al cliente que el pedido está siendo preparado
  console.log(` Pedido ${orderId} en preparación`);
}

async function handleOrderReady(orderId: string, orderData: any) {
  // Notificar al repartidor que el pedido está listo para recoger
  console.log(` Pedido ${orderId} listo para recoger`);
}

async function handleOrderPickedUp(orderId: string, orderData: any) {
  // Notificar al cliente que el pedido fue recogido y está en camino
  console.log(` Pedido ${orderId} recogido`);
}

async function handleOrderDelivered(orderId: string, orderData: any) {
  // Marcar repartidor como disponible
  // Procesar pago
  // Generar factura
  console.log(` Pedido ${orderId} entregado`);
}

async function handleOrderCancelled(orderId: string, orderData: any, previousStatus: string) {
  // Liberar repartidor si estaba asignado
  // Procesar reembolso si aplica
  // Notificar a todas las partes
  console.log(` Pedido ${orderId} cancelado (anterior: ${previousStatus})`);
}