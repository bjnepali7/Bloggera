part of 'auth_bloc.dart';

@immutable
sealed class AuthState {
  AuthState();
}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthSuccess extends AuthState {
  final User user;

  AuthSuccess(this.user);
}

final class AuthError extends AuthState {
  final String message;

   AuthError(this.message);
}
