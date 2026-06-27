import 'package:attendance_tracker/core/error/error_handler_guard.dart';
import 'package:attendance_tracker/core/error/failures.dart';
import 'package:attendance_tracker/features/auth/domain/entities/user.dart';
import 'package:attendance_tracker/features/auth/domain/entities/user_role.dart';
import 'package:attendance_tracker/features/auth/domain/repositories/auth_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:injectable/injectable.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({
    required firebase_auth.FirebaseAuth firebaseAuth,
    required FirebaseFirestore firestore,
  }) : _firebaseAuth = firebaseAuth,
       _firestore = firestore;

  final firebase_auth.FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  static const _usersCollection = 'users';

  @override
  Stream<User?> watchAuthUser() {
    return _firebaseAuth.authStateChanges().asyncMap((firebaseUser) async {
      if (firebaseUser == null) {
        return null;
      }
      return _fetchUserProfile(firebaseUser.uid);
    });
  }

  @override
  Future<Either<User, Failure>> login({
    required String email,
    required String password,
  }) async {
    return ErrorHandlerGuard.on<User>(() async {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      final profile = await _fetchUserProfile(credential.user!.uid);
      if (profile == null) {
        throw StateError('User profile not found');
      }
      return profile;
    });
  }

  @override
  Future<Either<User, Failure>> register({
    required String name,
    required String email,
    required String password,
  }) async {
    return ErrorHandlerGuard.on<User>(() async {
      firebase_auth.UserCredential? credential;
      try {
        credential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email.trim(),
          password: password,
        );
        final userId = credential.user!.uid;

        final user = User(
          id: userId,
          name: name.trim(),
          email: email.trim(),
          role: UserRole.user,
        );

        await _firestore.collection(_usersCollection).doc(userId).set({
          'name': user.name,
          'email': user.email,
          'role': user.role.firestoreValue,
          'createdAt': FieldValue.serverTimestamp(),
        });

        return user;
      } catch (e) {
        await credential?.user?.delete();
        rethrow;
      }
    });
  }

  @override
  Future<Either<void, Failure>> logout() async {
    return ErrorHandlerGuard.on<void>(() async {
      await _firebaseAuth.signOut();
    });
  }

  Future<User?> _fetchUserProfile(String userId) async {
    final snapshot = await _firestore
        .collection(_usersCollection)
        .doc(userId)
        .get();
    if (!snapshot.exists || snapshot.data() == null) {
      return null;
    }
    final data = snapshot.data()!;
    return User(
      id: userId,
      name: data['name'] as String? ?? '',
      email: data['email'] as String? ?? '',
      role: UserRole.fromFirestore(data['role'] as String?),
      profileImageUrl: data['profileImageUrl'] as String?,
    );
  }
}
