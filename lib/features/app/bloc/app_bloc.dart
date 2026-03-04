import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/user_model.dart';
import '../../../data/repositories/auth_repository.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(const AppState.initial()) {
    on<AppAuthStateChanged>(_onAuthChanged);
    on<AppSignOutRequested>(_onSignOut);

    _sub = _authRepository.authStateChanges.listen((user) {
      add(AppAuthStateChanged(user));
    });
  }

  final AuthRepository _authRepository;
  late final StreamSubscription<UserModel> _sub;

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

sealed class AppEvent extends Equatable {
  const AppEvent();
  @override
  List<Object?> get props => [];
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

enum AppStatus { initial, authenticated, unauthenticated }

class AppState extends Equatable {
  const AppState({
    required this.status,
    required this.user,
  });

  final AppStatus status;
  final UserModel user;

  const AppState.initial()
      : this(status: AppStatus.initial, user: UserModel.empty);

  const AppState.authenticated(UserModel user)
      : this(status: AppStatus.authenticated, user: user);

  const AppState.unauthenticated()
      : this(status: AppStatus.unauthenticated, user: UserModel.empty);

  @override
  List<Object?> get props => [status, user];
}