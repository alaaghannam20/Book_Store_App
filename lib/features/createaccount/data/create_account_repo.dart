import 'package:bookstore_app/core/services/networking/dio_factory.dart';


class CreateAccountRepo {
 static createAccount({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) async {
    try {
      final response = await DioFactory.PostRequest(url: 'register', data: {
        "name": name,
        "email": email,
        "password": password,
        "password_confirmation": passwordConfirmation
      }
      );
      return response;
    } catch (e) {
      return e;
    }
  }
}
