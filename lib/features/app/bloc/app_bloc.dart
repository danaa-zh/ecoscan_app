import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/user_model.dart';
import '../../../data/repositories/auth_repository.dart';

enum AppStatus {
  initial,
  authenticated,
  unauthenticated,
}

class AppState extends Equatable {
  const AppState({
    required this.status,
    required this.user,
  });

  final AppStatus status;
  final UserModel user;

  const AppState.initial()
      : this(
          status: AppStatus.initial,
          user: UserModel.empty,
        );

  const AppState.authenticated(UserModel user)
      : this(
          status: AppStatus.authenticated,
          user: user,
        );

  const AppState.unauthenticated()
      : this(
          status: AppStatus.unauthenticated,
          user: UserModel.empty,
        );

  @override
  List<Object?> get props => [status, user];
}

sealed class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object?> get props => [];
}

class AppStarted extends AppEvent {
  const AppStarted();
}

class AppAuthStateChanged extends AppEvent {
  const AppAuthStateChanged(this.user);

  final UserModel user;

  @override
  List<Object?> get props => [user];
}

class AppSignOutRequested extends AppEvent {
  const AppSignOutRequested();
}

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc({
    required AuthRepository authRepository,
  })  : _authRepository = authRepository,
        super(const AppState.initial()) {
    on<AppStarted>(_onStarted);
    on<AppAuthStateChanged>(_onAuthStateChanged);
    on<AppSignOutRequested>(_onSignOutRequested);

    _authSubscription = _authRepository.authStateChanges.listen((user) {
      add(AppAuthStateChanged(user));
    });

    add(const AppStarted());
  }

  final AuthRepository _authRepository;
  late final StreamSubscription<UserModel> _authSubscription;

  Future<void> _onStarted(
    AppStarted event,
    Emitter<AppState> emit,
  ) async {
    if (!_authRepository.isLoggedIn) {
      emit(const AppState.unauthenticated());
    }
  }

  void _onAuthStateChanged(
    AppAuthStateChanged event,
    Emitter<AppState> emit,
  ) {
    if (event.user.isNotEmpty) {
      emit(AppState.authenticated(event.user));
    } else {
      emit(const AppState.unauthenticated());
    }
  }

  Future<void> _onSignOutRequested(
    AppSignOutRequested event,
    Emitter<AppState> emit,
  ) async {
    await _authRepository.signOut();
  }

  @override
  Future<void> close() async {
    await _authSubscription.cancel();
    return super.close();
  }
}