import 'package:bookstore_app/features/validate_code/data/repo/validate_code_repo.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'validate_code_state.dart';

class VerifyCodeCubit extends Cubit<VerifyCodeState> {
  VerifyCodeCubit() : super(VerifyCodeInitial());

  void verifyCode({
    required String email,
    required String code,
  }) async {
    emit(VerifyCodeLoading());
    final response = await CodeVerficationRepo.codeVerification(
      email: email,
      code: code,
    );

    if (response is Response) {
      if (response.statusCode == 200) {
        emit(VerifyCodeSuccess());
      } else if (response.statusCode == 422) {
        final data = response.data as Map<String, dynamic>;
        String errorMsg = data['message'] as String;
        emit(VerifyCodeError(errorMsg));
      } else {
        emit(VerifyCodeError(
            'A server error occurred, please try again later.'));
      }
    } else {
      emit(VerifyCodeError(
          'An unexpected error occurred, please try again later.'));
    }
  }
}
