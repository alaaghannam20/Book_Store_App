import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:bookstore_app/core/services/local/shared_prefs_helper.dart';
import 'package:bookstore_app/features/createaccount/data/create_account_repo.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';

part 'create_account_state.dart';

class CreateAccountCubit extends Cubit<CreateAccountState> {
  CreateAccountCubit() : super(CreateAccountInitial());

  void createAccount({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) async {
    emit(CreateAccountLoading());
    final response = await CreateAccountRepo.createAccount(
      name: name,
      email: email,
      password: password,
      passwordConfirmation: passwordConfirmation,
    );

    if (response is Response) {
      if (response.statusCode == 201) {
        SharedPrefsHelper.saveData(
          key: SharedPrefsKey.userToken,
          value: response.data['data']['token'],
        );
        emit(CreateAccountSuccess());
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

        emit(CreateAccountError(errorMsg));
      } else {
        emit(CreateAccountError(
            'A server error occurred, please try again later.'));
      }
    } else {
      emit(CreateAccountError(
          'An unexpected error occurred, please try again later.'));
    }
  }

  Future<void> signInWithGoogle() async {
    emit(CreateAccountLoading());
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        emit(CreateAccountError('Google Sign-In cancelled'));
        return;
      }
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      emit(CreateAccountSuccess());
    } catch (e) {
      emit(CreateAccountError(e.toString()));
    }
  }

  Future<void> signInWithFacebook() async {
    emit(CreateAccountLoading());
    try {
      final LoginResult result = await FacebookAuth.instance.login();
      if (result.status == LoginStatus.success) {
        final OAuthCredential credential =
            FacebookAuthProvider.credential(result.accessToken!.tokenString);
        await FirebaseAuth.instance.signInWithCredential(credential);
        emit(CreateAccountSuccess());
      } else {
        emit(CreateAccountError('Facebook Sign-In failed'));
      }
    } catch (e) {
      emit(CreateAccountError(e.toString()));
    }
  }
}
