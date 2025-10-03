import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final FirebaseFirestore _firestore;
  final String _usersCollection = 'users';

  UserRepositoryImpl({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  @override
  Future<UserEntity?> getUserById(String uid) async {
    try {
      final doc = await _firestore.collection(_usersCollection).doc(uid).get();
      if (!doc.exists) return null;
      return UserEntity.fromFirestore(doc);
    } catch (e) {
      throw Exception('Error al obtener usuario: $e');
    }
  }

  @override
  Future<void> createOrUpdateUser(UserEntity user) async {
    try {
      print('📝 UserRepository: Iniciando creación/actualización para UID: ${user.uid}');
      final docRef = _firestore.collection(_usersCollection).doc(user.uid);
      final doc = await docRef.get();

      if (doc.exists) {
        print('🔄 Usuario existe, actualizando...');
        // Usuario existe, actualizar solo campos necesarios
        await docRef.update({
          'displayName': user.displayName,
          'photoUrl': user.photoUrl,
          'phoneNumber': user.phoneNumber,
          'address': user.address,
          'updatedAt': FieldValue.serverTimestamp(),
        });
        print('✅ Usuario actualizado correctamente');
      } else {
        print('🆕 Usuario nuevo, creando documento...');
        // Usuario nuevo, crear documento completo
        final data = {
          'email': user.email,
          'displayName': user.displayName,
          'photoUrl': user.photoUrl,
          'phoneNumber': user.phoneNumber,
          'address': user.address,
          'isActive': true,
          'createdAt': FieldValue.serverTimestamp(),
          'updatedAt': FieldValue.serverTimestamp(),
        };
        print('📤 Datos a guardar: $data');
        await docRef.set(data);
        print('✅ Usuario creado correctamente en Firestore');
      }
    } catch (e) {
      print('❌ Error en UserRepository: $e');
      throw Exception('Error al crear/actualizar usuario: $e');
    }
  }

  @override
  Future<void> updateUser(String uid, Map<String, dynamic> data) async {
    try {
      await _firestore.collection(_usersCollection).doc(uid).update({
        ...data,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Error al actualizar usuario: $e');
    }
  }

  @override
  Future<void> deleteUser(String uid) async {
    try {
      // Soft delete: marcar como inactivo
      await _firestore.collection(_usersCollection).doc(uid).update({
        'isActive': false,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Error al eliminar usuario: $e');
    }
  }

  @override
  Stream<UserEntity?> watchUser(String uid) {
    return _firestore
        .collection(_usersCollection)
        .doc(uid)
        .snapshots()
        .map((doc) {
      if (!doc.exists) return null;
      return UserEntity.fromFirestore(doc);
    });
  }
}
