import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ecoscan_app/core/services/firebase_auth_service.dart';
import 'package:ecoscan_app/core/services/firestore_service.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required FirebaseAuthService authService,
    required FirestoreService firestore,
  })  : _auth = authService,
        _db = firestore,
        super(const AuthState.initial()) {
    on<AuthEmailSignInRequested>(_emailSignIn);
    on<AuthRegisterRequested>(_register);
    on<AuthGoogleSignInRequested>(_googleSignIn);
    on<AuthSignOutRequested>(_signOut);
  }

  final FirebaseAuthService _auth;
  final FirestoreService _db;

  Future<void> _emailSignIn(AuthEmailSignInRequested e, Emitter<AuthState> emit) async {
    emit(const AuthState.loading());
    try {
      final cred = await _auth.signInWithEmail(e.email, e.password);
      final u = cred.user;
      if (u == null) throw Exception('Auth user is null');
      await _ensureUserDoc(
        uid: u.uid,
        email: u.email ?? e.email,
        username: e.login,
      );
      emit(AuthState.success(uid: u.uid, email: u.email ?? e.email));
    } catch (err) {
      emit(AuthState.failure(_friendlyAuthError(err)));
    }
  }

  Future<void> _register(AuthRegisterRequested e, Emitter<AuthState> emit) async {
    emit(const AuthState.loading());
    try {
      if (e.password != e.repeatPassword) {
        emit(const AuthState.failure('Пароли не совпадают'));
        return;
      }
      final cred = await _auth.registerWithEmail(e.email, e.password);
      final u = cred.user;
      if (u == null) throw Exception('Auth user is null');

      await _db.setUser(u.uid, {
        'uid': u.uid,
        'email': e.email,
        'username': e.login,
        'name': e.name,
        'surname': e.surname,
        'level': 1,
        'bonusBalance': 0,
        'createdAtMillis': DateTime.now().millisecondsSinceEpoch,
      });

      emit(AuthState.success(uid: u.uid, email: e.email));
    } catch (err) {
      emit(AuthState.failure(_friendlyAuthError(err)));
    }
  }

  Future<void> _googleSignIn(AuthGoogleSignInRequested e, Emitter<AuthState> emit) async {
    emit(const AuthState.loading());
    try {
      final cred = await _auth.signInWithGoogle();
      final u = cred.user;
      if (u == null) throw Exception('Auth user is null');

      await _ensureUserDoc(
        uid: u.uid,
        email: u.email ?? '',
        username: '',
      );

      emit(AuthState.success(uid: u.uid, email: u.email ?? ''));
    } catch (err) {
      emit(AuthState.failure(_friendlyAuthError(err)));
    }
  }

  Future<void> _signOut(AuthSignOutRequested e, Emitter<AuthState> emit) async {
    emit(const AuthState.loading());
    try {
      await _auth.signOut();
      emit(const AuthState.initial());
    } catch (err) {
      emit(AuthState.failure(_friendlyAuthError(err)));
    }
  }

  Future<void> _ensureUserDoc({
    required String uid,
    required String email,
    required String username,
  }) async {
    final existing = await _db.getUser(uid);
    if (existing != null) return;

    await _db.setUser(uid, {
      'uid': uid,
      'email': email,
      'username': username,
      'name': '',
      'surname': '',
      'level': 1,
      'bonusBalance': 0,
      'createdAtMillis': DateTime.now().millisecondsSinceEpoch,
    });
  }

  String _friendlyAuthError(Object err) {
    if (err is FirebaseAuthException) {
      switch (err.code) {
        case 'invalid-email':
          return 'Неверный формат email';
        case 'user-not-found':
          return 'Пользователь не найден';
        case 'wrong-password':
          return 'Неверный пароль';
        case 'email-already-in-use':
          return 'Этот email уже зарегистрирован';
        case 'weak-password':
          return 'Слишком простой пароль';
        case 'account-exists-with-different-credential':
          return 'Аккаунт уже существует с другим способом входа';
        case 'CANCELLED':
          return 'Вход через Google отменён';
        case 'NO_ID_TOKEN':
          return 'Google вход не настроен (нет idToken)';
        default:
          return err.message ?? 'Ошибка авторизации';
      }
    }
    return err.toString();
  }
}

sealed class AuthEvent extends Equatable {
  const AuthEvent();
  @override
  List<Object?> get props => [];
}

class AuthEmailSignInRequested extends AuthEvent {
  const AuthEmailSignInRequested({
    required this.login,
    required this.email,
    required this.password,
  });

  final String login;
  final String email;
  final String password;

  @override
  List<Object?> get props => [login, email, password];
}

class AuthRegisterRequested extends AuthEvent {
  const AuthRegisterRequested({
    required this.name,
    required this.surname,
    required this.login,
    required this.email,
    required this.password,
    required this.repeatPassword,
  });

  final String name;
  final String surname;
  final String login;
  final String email;
  final String password;
  final String repeatPassword;

  @override
  List<Object?> get props => [name, surname, login, email, password, repeatPassword];
}

class AuthGoogleSignInRequested extends AuthEvent {
  const AuthGoogleSignInRequested();
}

class AuthSignOutRequested extends AuthEvent {
  const AuthSignOutRequested();
}

class AuthState extends Equatable {
  const AuthState._({
    required this.status,
    this.uid,
    this.email,
    this.error,
  });

  final AuthStatus status;
  final String? uid;
  final String? email;
  final String? error;

  const AuthState.initial() : this._(status: AuthStatus.initial);
  const AuthState.loading() : this._(status: AuthStatus.loading);
  const AuthState.success({required String uid, required String email})
      : this._(status: AuthStatus.success, uid: uid, email: email);
  const AuthState.failure(String message)
      : this._(status: AuthStatus.failure, error: message);

  @override
  List<Object?> get props => [status, uid, email, error];
}

enum AuthStatus { initial, loading, success, failure }