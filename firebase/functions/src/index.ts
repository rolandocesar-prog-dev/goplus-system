// firebase/functions/src/index.ts
import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';

admin.initializeApp();

// Trigger: Crear perfil de usuario después del registro
export const onUserCreated = functions.auth.user().onCreate(async (user) => {
  const { uid, email, displayName, photoURL } = user;
  
  // Determinar rol basado en el email domain o metadata
  let role = 'customer'; // default
  if (email?.includes('@goplus.admin')) {
    role = 'admin';
  } else if (email?.includes('@business')) {
    role = 'business';
  }
  
  // Crear documento de usuario
  await admin.firestore().collection('users').doc(uid).set({
    uid,
    email,
    displayName: displayName || '',
    photoURL: photoURL || '',
    role,
    status: 'active',
    createdAt: admin.firestore.FieldValue.serverTimestamp(),
    updatedAt: admin.firestore.FieldValue.serverTimestamp()
  });
  
  // Configurar custom claims para roles
  await admin.auth().setCustomUserClaims(uid, { role });
});

// Trigger: Actualizar estado del negocio cuando hay nuevo pedido
export const onOrderCreated = functions.firestore
  .document('orders/{orderId}')
  .onCreate(async (snap, context) => {
    const order = snap.data();
    const { businessId } = order;
    
    // Notificar al negocio (FCM)
    // TODO: Implementar push notification
    
    // Actualizar contador de pedidos
    await admin.firestore().collection('businesses').doc(businessId).update({
      'stats.pendingOrders': admin.firestore.FieldValue.increment(1),
      'stats.totalOrders': admin.firestore.FieldValue.increment(1)
    });
});