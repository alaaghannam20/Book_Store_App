
part of 'reset_password_cubit.dart';

@immutable
sealed class ResetPasswordState  {}

final class ResetPasswordInitial extends ResetPasswordState {}
final class ResetPasswordLoading extends ResetPasswordState {}
final class ResetPasswordSuccess extends ResetPasswordState {}
final class ResetPasswordError extends ResetPasswordState {
  final String errorMessage ;
  ResetPasswordError(this.errorMessage);
}


