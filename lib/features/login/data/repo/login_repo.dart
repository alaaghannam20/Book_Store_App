// file: login_repo.dart

import 'package:bookstore_app/core/services/networking/dio_factory.dart';


class LoginRepo {
 static login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await DioFactory.PostRequest(url: 'login', data: {
        "email": email,
        "password": password,
      }
      );
      return response;
    } catch (e) {
      return e;
    }
  }
}
