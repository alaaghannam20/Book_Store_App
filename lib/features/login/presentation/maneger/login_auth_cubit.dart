import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:bookstore_app/core/services/local/shared_prefs_helper.dart';
import 'package:bookstore_app/features/login/data/repo/login_repo.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart';

part 'login_auth_state.dart';

class LoginCubit extends Cubit<LoginAuthState> {
  LoginCubit() : super(LoginInitial());
  void login({
    required String email,
    required String password,
  }) async {
    emit(LoginLoading());
    final response = await LoginRepo.login(
      email: email,
      password: password,
    );

    if (response is Response) {
      if (response.statusCode == 200) {
        SharedPrefsHelper.saveData(
          key: SharedPrefsKey.userToken,
          value: response.data['data']['token'],
        );
        emit(LoginSuccess());
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

        emit(LoginError(errorMsg));
      } else {
        emit(LoginError('A server error occurred, please try again later.'));
      }
    } else {
      emit(LoginError('An unexpected error occurred, please try again later.'));
    }
  }

  Future<void> signInWithGoogle() async {
    emit(LoginLoading());
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        emit(LoginError('Google Sign-In cancelled'));
        return;
      }
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      emit(LoginSuccess());
    } catch (e) {
      emit(LoginError(e.toString()));
    }
  }

  Future<void> signInWithFacebook() async {
    emit(LoginLoading());
    try {
      final LoginResult result = await FacebookAuth.instance.login();
      if (result.status == LoginStatus.success) {
        final OAuthCredential credential =
            FacebookAuthProvider.credential(result.accessToken!.tokenString);
        await FirebaseAuth.instance.signInWithCredential(credential);
        emit(LoginSuccess());
      } else {
        emit(LoginError('Facebook Sign-In failed'));
      }
    } catch (e) {
      emit(LoginError(e.toString()));
    }
  }
}
