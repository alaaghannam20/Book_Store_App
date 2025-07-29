part of 'validate_code_cubit.dart';

@immutable
sealed class VerifyCodeState {}

final class VerifyCodeInitial extends VerifyCodeState {}

final class VerifyCodeLoading extends VerifyCodeState {}

final class VerifyCodeSuccess extends VerifyCodeState {}

final class VerifyCodeError extends VerifyCodeState {
  final String errorMessage;
  VerifyCodeError(this.errorMessage);
}
