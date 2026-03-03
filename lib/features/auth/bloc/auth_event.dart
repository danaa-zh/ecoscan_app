import 'package:equatable/equatable.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();
  @override
  List<Object?> get props => [];
}

class AuthGoogleSignInRequested extends AuthEvent {
  const AuthGoogleSignInRequested();
}

class AuthEmailSignInRequested extends AuthEvent {
  const AuthEmailSignInRequested({required this.email, required this.password});
  final String email;
  final String password;

  @override
  List<Object?> get props => [email, password];
}

class AuthRegisterRequested extends AuthEvent {
  const AuthRegisterRequested({
    required this.email,
    required this.password,
    required this.username,
    required this.name,
    required this.surname,
  });

  final String email;
  final String password;
  final String username;
  final String name;
  final String surname;

  @override
  List<Object?> get props => [email, password, username, name, surname];
}

class AuthSignOutRequested extends AuthEvent {
  const AuthSignOutRequested();
}