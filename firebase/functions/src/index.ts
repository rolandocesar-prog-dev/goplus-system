import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';

// Inicializar la aplicaci�n de Firebase
admin.initializeApp();

// Importar funciones espec�ficas
import * as authFunctions from './auth';
import * as orderFunctions from './orders';
import * as notificationFunctions from './notifications';
import * as paymentFunctions from './payments';

// Exportar funciones
export const auth = authFunctions;
export const orders = orderFunctions;
export const notifications = notificationFunctions;
export const payments = paymentFunctions;

// Funci�n de ejemplo
export const helloWorld = functions.https.onRequest((request, response) => {
  functions.logger.info('Hello logs!', {structuredData: true});
  response.send('Hello from Firebase!');
});
