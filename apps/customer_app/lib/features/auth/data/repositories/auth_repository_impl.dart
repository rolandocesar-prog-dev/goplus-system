import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/repositories/user_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  final UserRepository _userRepository;

  AuthRepositoryImpl({
    FirebaseAuth? firebaseAuth,
    GoogleSignIn? googleSignIn,
    required UserRepository userRepository,
  })  : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn(),
        _userRepository = userRepository;

  @override
  Stream<UserEntity?> get authStateChanges {
    return _firebaseAuth.authStateChanges().asyncMap((user) async {
      if (user == null) return null;

      // Intentar obtener los datos completos desde Firestore
      try {
        final firestoreUser = await _userRepository.getUserById(user.uid);
        // Si existe en Firestore, retornar esos datos (incluye phone y address)
        if (firestoreUser != null) {
          return firestoreUser;
        }
      } catch (e) {
        print('⚠️ No se pudo obtener usuario de Firestore: $e');
      }

      // Si no está en Firestore, retornar solo datos de Firebase Auth
      return _mapFirebaseUserToEntity(user);
    });
  }

  @override
  UserEntity? get currentUser {
    final user = _firebaseAuth.currentUser;
    if (user == null) return null;
    return _mapFirebaseUserToEntity(user);
  }

  @override
  Future<UserEntity> signInWithGoogle() async {
    try {
      // Iniciar el flujo de autenticación de Google
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        throw Exception('Inicio de sesión cancelado por el usuario');
      }

      // Obtener los detalles de autenticación
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // Crear credenciales para Firebase
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Autenticar en Firebase
      final userCredential = await _firebaseAuth.signInWithCredential(credential);

      if (userCredential.user == null) {
        throw Exception('Error al autenticar con Firebase');
      }

      final userEntity = _mapFirebaseUserToEntity(userCredential.user!);

      // Crear o actualizar usuario en Firestore
      print('🔥 Intentando crear usuario en Firestore: ${userEntity.uid}');
      try {
        await _userRepository.createOrUpdateUser(userEntity);
        print('✅ Usuario creado/actualizado en Firestore exitosamente');
      } catch (firestoreError) {
        print('❌ Error al guardar en Firestore: $firestoreError');
        rethrow;
      }

      return userEntity;
    } catch (e) {
      print('❌ Error en Google Sign-In: $e');
      throw Exception('Error en Google Sign-In: $e');
    }
  }

  @override
  Future<UserEntity> signInWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      if (userCredential.user == null) {
        throw Exception('Error al autenticar con email y contraseña');
      }

      final userEntity = _mapFirebaseUserToEntity(userCredential.user!);

      // Sincronizar con Firestore
      try {
        await _userRepository.createOrUpdateUser(userEntity);
      } catch (firestoreError) {
        print('❌ Error al sincronizar con Firestore: $firestoreError');
      }

      return userEntity;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          throw Exception('No existe una cuenta con este email');
        case 'wrong-password':
          throw Exception('Contraseña incorrecta');
        case 'invalid-email':
          throw Exception('Email inválido');
        case 'user-disabled':
          throw Exception('Esta cuenta ha sido deshabilitada');
        default:
          throw Exception('Error al iniciar sesión: ${e.message}');
      }
    } catch (e) {
      throw Exception('Error al iniciar sesión: $e');
    }
  }

  @override
  Future<UserEntity> signUpWithEmailPassword({
    required String email,
    required String password,
    String? displayName,
    String? phoneNumber,
    String? address,
  }) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      if (userCredential.user == null) {
        throw Exception('Error al crear la cuenta');
      }

      // Actualizar el nombre de usuario y teléfono si se proporcionaron
      if (displayName != null && displayName.isNotEmpty) {
        await userCredential.user!.updateDisplayName(displayName.trim());
      }

      if (phoneNumber != null && phoneNumber.isNotEmpty) {
        // Firebase Auth no guarda el teléfono directamente en updatePhoneNumber sin verificación
        // Lo guardaremos en Firestore a través de UserEntity
      }

      await userCredential.user!.reload();

      final user = _firebaseAuth.currentUser;
      if (user == null) {
        throw Exception('Error al obtener el usuario creado');
      }

      // Crear entidad con todos los datos
      final userEntity = UserEntity(
        uid: user.uid,
        email: user.email ?? '',
        displayName: displayName?.trim(),
        photoUrl: user.photoURL,
        phoneNumber: phoneNumber?.trim(),
        address: address?.trim(),
      );

      // Crear usuario en Firestore con todos los datos
      try {
        await _userRepository.createOrUpdateUser(userEntity);
      } catch (firestoreError) {
        print('❌ Error al guardar en Firestore: $firestoreError');
        rethrow;
      }

      return userEntity;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'email-already-in-use':
          throw Exception('Ya existe una cuenta con este email');
        case 'invalid-email':
          throw Exception('Email inválido');
        case 'weak-password':
          throw Exception('La contraseña debe tener al menos 6 caracteres');
        default:
          throw Exception('Error al crear cuenta: ${e.message}');
      }
    } catch (e) {
      throw Exception('Error al crear cuenta: $e');
    }
  }

  @override
  Future<void> signOut() async {
    await Future.wait([
      _firebaseAuth.signOut(),
      _googleSignIn.signOut(),
    ]);
  }

  /// Mapea un User de Firebase a nuestra entidad de dominio
  UserEntity _mapFirebaseUserToEntity(User user) {
    return UserEntity(
      uid: user.uid,
      email: user.email ?? '',
      displayName: user.displayName,
      photoUrl: user.photoURL,
      phoneNumber: user.phoneNumber,
    );
  }
}
