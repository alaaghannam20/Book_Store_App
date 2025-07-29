import 'dart:developer';
import 'package:bookstore_app/core/services/local/shared_prefs_helper.dart';
import 'package:bookstore_app/features/forget_password/data/repo/forget_password_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

part 'forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  ForgetPasswordCubit() : super(ForgetPasswordInitial());

  void forgetPassword({
    required String email,
  }) async {
    emit(ForgetPasswordLoading());
    final response = await ForgetPasswordRepo.forgetPassword(
      email: email,
    );

    if (response is Response) {
      if (response.statusCode == 200) {
        SharedPrefsHelper.saveData(
          key: SharedPrefsKey.userToken,
          value: response.data['data']['token'],
        );
        emit(ForgetPasswordSuccess());
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

        emit(ForgetPasswordError(errorMsg));
      } else {
        emit(ForgetPasswordError(
            'A server error occurred, please try again later.'));
      }
    } else {
      emit(ForgetPasswordError(
          'An unexpected error occurred, please try again later.'));
    }
  }
}
