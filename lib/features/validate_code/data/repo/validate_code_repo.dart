
import 'package:bookstore_app/core/services/networking/dio_factory.dart';

class CodeVerficationRepo {
  static codeVerification({
    required String email,
    required String code,
  }) async {
    try {
      final response = await DioFactory.PostRequest(url: 'forget-password', data: {
        "email": email,
        "verify_code" : code,
      }
      );
      return response;
    } catch (e) {
      return e;
    }
  }
}
