import '../entities/user_entity.dart';

abstract class AuthRepository {
  /// Stream del estado de autenticación del usuario
  Stream<UserEntity?> get authStateChanges;

  /// Usuario actual autenticado
  UserEntity? get currentUser;

  /// Iniciar sesión con Google
  Future<UserEntity> signInWithGoogle();

  /// Cerrar sesión
  Future<void> signOut();
}
