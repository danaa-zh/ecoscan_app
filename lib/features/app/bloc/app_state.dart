import 'package:equatable/equatable.dart';
import '../../../data/models/user_model.dart';

enum AppStatus { initial, authenticated, unauthenticated }

class AppState extends Equatable {
  const AppState({
    required this.status,
    required this.user,
  });

  final AppStatus status;
  final UserModel user;

  const AppState.initial() : this(status: AppStatus.initial, user: UserModel.empty);
  const AppState.authenticated(UserModel user) : this(status: AppStatus.authenticated, user: user);
  const AppState.unauthenticated() : this(status: AppStatus.unauthenticated, user: UserModel.empty);

  @override
  List<Object?> get props => [status, user];
}