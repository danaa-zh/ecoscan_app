import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repositories/auth_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({required AuthRepository authRepository})
      : _repo = authRepository,
        super(const AuthInitial()) {
    on<AuthGoogleSignInRequested>(_onGoogle);
    on<AuthEmailSignInRequested>(_onEmail);
    on<AuthRegisterRequested>(_onRegister);
    on<AuthSignOutRequested>(_onSignOut);
  }

  final AuthRepository _repo;

  Future<void> _onGoogle(AuthGoogleSignInRequested event, Emitter<AuthState> emit) async {
    emit(const AuthLoading());
    try {
      final user = await _repo.signInWithGoogle();
      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _onEmail(AuthEmailSignInRequested event, Emitter<AuthState> emit) async {
    emit(const AuthLoading());
    try {
      final user = await _repo.signInWithEmail(event.email, event.password);
      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _onRegister(AuthRegisterRequested event, Emitter<AuthState> emit) async {
    emit(const AuthLoading());
    try {
      final user = await _repo.registerWithEmail(
        email: event.email,
        password: event.password,
        username: event.username,
        name: event.name,
        surname: event.surname,
      );
      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _onSignOut(AuthSignOutRequested event, Emitter<AuthState> emit) async {
    emit(const AuthLoading());
    try {
      await _repo.signOut();
      emit(const AuthInitial());
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }
}