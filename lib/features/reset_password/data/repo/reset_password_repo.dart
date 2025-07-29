import 'package:bookstore_app/core/services/networking/dio_factory.dart';

class ResetPasswordRepo {
  static resetPassword(
      {required String code,
      required String password,
      required String confPassword}) async {
    try {
      final response =
          await DioFactory.PostRequest(url: 'reset-password', data: {
        "verify_code": code,
        "new_password": password,
        "new_password_confirmation": confPassword
      });
      return response;
    } catch (e) {
      return e;
    }
  }
}
