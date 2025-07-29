import 'package:bookstore_app/core/models/products_models.dart';
import 'package:bookstore_app/core/services/networking/dio_factory.dart';

class SearchResultRepo {
  static Future<List<Products>> fetchMatchingProducts(String query) async {
    final response = await DioFactory.getWithQuery(
      url: 'products-search',
      queryParams: {'name': query},
    );

    if (response != null &&
        response.statusCode == 200 &&
        response.data['data'] != null &&
        response.data['data']['products'] != null) {
      final List<dynamic> productsList = response.data['data']['products'];
      return productsList
          .map((product) => Products.fromJson(product))
          .toList();
    } else {
      return [];
    }
  }
}
