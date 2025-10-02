import '../entities/user_entity.dart';

/// Repositorio para gestionar usuarios en Firestore
abstract class UserRepository {
  /// Obtiene un usuario por su ID
  Future<UserEntity?> getUserById(String uid);

  /// Crea o actualiza un usuario en Firestore
  Future<void> createOrUpdateUser(UserEntity user);

  /// Actualiza información del usuario
  Future<void> updateUser(String uid, Map<String, dynamic> data);

  /// Elimina un usuario (soft delete)
  Future<void> deleteUser(String uid);

  /// Stream de cambios del usuario
  Stream<UserEntity?> watchUser(String uid);
}
