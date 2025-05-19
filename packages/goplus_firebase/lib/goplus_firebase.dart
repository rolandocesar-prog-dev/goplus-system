/// Biblioteca Firebase compartida para todas las aplicaciones GoPlus
///
/// Contiene abstracciones para los servicios de Firebase
library goplus_firebase;
// Auth
export 'src/auth/firebase_auth_service.dart';
export 'src/auth/auth_exceptions.dart';
// Database
export 'src/database/firebase_database_service.dart';
export 'src/database/collection_references.dart';
// Storage
export 'src/storage/firebase_storage_service.dart';
// Messaging
export 'src/messaging/firebase_messaging_service.dart';
export 'src/messaging/notification_handler.dart';
