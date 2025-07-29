import 'dart:developer';
import 'package:bookstore_app/core/services/local/shared_prefs_helper.dart';
import 'package:bookstore_app/features/reset_password/data/repo/reset_password_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

part 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ResetPasswordCubit() : super(ResetPasswordInitial());

  void resetPassword(
      {required String code,
      required String password,
      required String confPassword}) async {
    emit(ResetPasswordLoading());
    final response = await ResetPasswordRepo.resetPassword(
        code: code, password: password, confPassword: confPassword);

    if (response is Response) {
      if (response.statusCode == 200) {
        SharedPrefsHelper.saveData(
          key: SharedPrefsKey.userToken,
          value: response.data['data']['token'],
        );
        emit(ResetPasswordSuccess());
      } else if (response.statusCode == 422) {
        String errorMsg = response.data['message'];
        if (response.data['errors'] != null && response.data['errors'] is Map) {
          log("message");
          List<String> errorDetails = [];
          response.data['errors'].forEach((key, value) {
            if (value is List) {
              errorDetails.addAll(value.map((e) => e.toString()));
            }
          });

          if (errorDetails.isNotEmpty) {
            errorMsg += '\n' + errorDetails.join('\n');
          }
        }

        emit(ResetPasswordError(errorMsg));
      } else {
        emit(ResetPasswordError(
            'A server error occurred, please try again later.'));
      }
    } else {
      emit(ResetPasswordError(
          'An unexpected error occurred, please try again later.'));
    }
  }
}
