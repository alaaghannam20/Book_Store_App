
import 'package:bookstore_app/core/models/products_models.dart';
import 'package:bookstore_app/core/services/networking/dio_factory.dart';

class BookDetailsRepo {
  static Future<Products> getBookDetails(int bookId) async {
    try {
      final result = await DioFactory.getRequest(url: 'products/$bookId');

      final validResponse = result != null &&
          result.statusCode == 200 &&
          result.data['data'] != null;

      if (validResponse) {
        return Products.fromJson(result.data['data']);
      } else {
        throw Exception('Unable to fetch book information.');
      }
    } catch (error) {
      throw Exception('An error occurred while loading book details: $error');
    }
  }
}
