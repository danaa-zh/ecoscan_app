import 'package:firebase_auth/firebase_auth.dart' as fb;

import '../../core/services/firebase_auth_service.dart';
import '../../core/services/firestore_service.dart';
import '../models/user_model.dart';
import 'user_repository.dart';

class AuthRepository {
  AuthRepository({
    required FirebaseAuthService authService,
    required FirestoreService firestore,
    required UserRepository userRepository,
  })  : _auth = authService,
        _firestore = firestore,
        _userRepo = userRepository;

  final FirebaseAuthService _auth;
  final FirestoreService _firestore;
  final UserRepository _userRepo;

  bool get isLoggedIn => _auth.currentUser != null;

  Stream<UserModel> get authStateChanges async* {
    await for (final u in _auth.authStateChanges()) {
      if (u == null) {
        yield UserModel.empty;
      } else {
        final profile = await _userRepo.getUser(u.uid);
        if (profile != null) {
          yield profile;
        } else {
          // Create minimal profile if absent
          final now = DateTime.now().millisecondsSinceEpoch;
          final created = UserModel(
            uid: u.uid,
            email: u.email ?? '',
            username: '',
            name: u.displayName ?? '',
            surname: '',
            level: 1,
            bonusBalance: 0,
            photoUrl: u.photoURL ?? '',
            createdAtMillis: now,
          );
          await _userRepo.upsertUser(created);
          yield created;
        }
      }
    }
  }

  Future<UserModel> signInWithGoogle() async {
    final cred = await _auth.signInWithGoogle();
    return _ensureUserProfile(cred.user);
  }

  Future<UserModel> signInWithEmail(String email, String password) async {
    final cred = await _auth.signInWithEmail(email, password);
    return _ensureUserProfile(cred.user);
  }

  Future<UserModel> registerWithEmail({
    required String email,
    required String password,
    required String username,
    required String name,
    required String surname,
  }) async {
    final cred = await _auth.registerWithEmail(email, password);
    final u = cred.user;
    if (u == null) throw Exception('User is null after register');

    final now = DateTime.now().millisecondsSinceEpoch;
    final model = UserModel(
      uid: u.uid,
      email: email,
      username: username,
      name: name,
      surname: surname,
      level: 1,
      bonusBalance: 0,
      photoUrl: '',
      createdAtMillis: now,
    );

    await _firestore.setUser(u.uid, model.toJson());
    return model;
  }

  Future<void> signOut() => _auth.signOut();

  Future<UserModel> _ensureUserProfile(fb.User? u) async {
    if (u == null) throw Exception('User is null');

    final existing = await _userRepo.getUser(u.uid);
    if (existing != null) return existing;

    final now = DateTime.now().millisecondsSinceEpoch;
    final model = UserModel(
      uid: u.uid,
      email: u.email ?? '',
      username: '',
      name: u.displayName ?? '',
      surname: '',
      level: 1,
      bonusBalance: 0,
      photoUrl: u.photoURL ?? '',
      createdAtMillis: now,
    );

    await _userRepo.upsertUser(model);
    return model;
  }
}