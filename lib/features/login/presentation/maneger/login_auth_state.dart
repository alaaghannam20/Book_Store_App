part of 'login_auth_cubit.dart';

@immutable
sealed class LoginAuthState {}

final class LoginInitial extends LoginAuthState {}

final class LoginSuccess extends LoginAuthState {}

final class LoginLoading extends LoginAuthState {}

final class LoginError extends LoginAuthState {
  final String errorMessage;
  LoginError(this.errorMessage);
}
