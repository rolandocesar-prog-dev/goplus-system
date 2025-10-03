import '../entities/user_entity.dart';

abstract class AuthRepository {
  /// Stream del estado de autenticación del usuario
  Stream<UserEntity?> get authStateChanges;

  /// Usuario actual autenticado
  UserEntity? get currentUser;

  /// Iniciar sesión con Google
  Future<UserEntity> signInWithGoogle();

  /// Iniciar sesión con email y contraseña
  Future<UserEntity> signInWithEmailPassword({
    required String email,
    required String password,
  });

  /// Registrarse con email y contraseña
  Future<UserEntity> signUpWithEmailPassword({
    required String email,
    required String password,
    String? displayName,
    String? phoneNumber,
    String? address,
  });

  /// Cerrar sesión
  Future<void> signOut();
}
