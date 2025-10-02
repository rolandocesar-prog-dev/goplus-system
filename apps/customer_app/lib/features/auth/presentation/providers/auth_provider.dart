import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../data/repositories/user_repository_impl.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/repositories/user_repository.dart';

/// Provider del repositorio de usuarios
final userRepositoryProvider = Provider<UserRepository>((ref) {
  return UserRepositoryImpl();
});

/// Provider del repositorio de autenticación
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final userRepository = ref.watch(userRepositoryProvider);
  return AuthRepositoryImpl(userRepository: userRepository);
});

/// Provider del estado de autenticación (stream)
final authStateProvider = StreamProvider<UserEntity?>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return authRepository.authStateChanges;
});

/// Provider del usuario actual
final currentUserProvider = Provider<UserEntity?>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return authRepository.currentUser;
});

/// Provider del controlador de autenticación
final authControllerProvider = Provider<AuthController>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return AuthController(authRepository: authRepository);
});

/// Controlador de autenticación
class AuthController {
  final AuthRepository authRepository;

  AuthController({required this.authRepository});

  /// Iniciar sesión con Google
  Future<UserEntity> signInWithGoogle() async {
    return await authRepository.signInWithGoogle();
  }

  /// Cerrar sesión
  Future<void> signOut() async {
    await authRepository.signOut();
  }
}
