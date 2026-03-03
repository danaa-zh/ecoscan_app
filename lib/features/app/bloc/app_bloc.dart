import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repositories/auth_repository.dart';
import 'app_event.dart';
import 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(const AppState.initial()) {
    on<AppStarted>(_onStarted);
    on<AppAuthStateChanged>(_onAuthChanged);
    on<AppSignOutRequested>(_onSignOut);

    _sub = _authRepository.authStateChanges.listen((user) {
      add(AppAuthStateChanged(user));
    });
  }

  final AuthRepository _authRepository;
  late final StreamSubscription _sub;

  Future<void> _onStarted(AppStarted event, Emitter<AppState> emit) async {
    // auth stream will push immediately, nothing else required
  }

  void _onAuthChanged(AppAuthStateChanged event, Emitter<AppState> emit) {
    if (event.user.isNotEmpty) {
      emit(AppState.authenticated(event.user));
    } else {
      emit(const AppState.unauthenticated());
    }
  }

  Future<void> _onSignOut(AppSignOutRequested event, Emitter<AppState> emit) async {
    await _authRepository.signOut();
  }

  @override
  Future<void> close() async {
    await _sub.cancel();
    return super.close();
  }
}