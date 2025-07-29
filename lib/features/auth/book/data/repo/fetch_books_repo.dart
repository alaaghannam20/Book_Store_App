
import 'package:bookstore_app/core/models/products_models.dart';
import 'package:bookstore_app/core/services/networking/dio_factory.dart';

class FetchBooksRepo {  

  static Future<List<Products>> fetchBestSellerBooks() async {
    try {
      var response = await DioFactory.getRequest(url: 'products-bestseller');
      
      if (response != null) {
        if (response.statusCode == 200) {
          List<dynamic> productsJson = response.data['data']['products'];
          
          List<Products> productsList = [];
          for (var item in productsJson) {
            productsList.add(Products.fromJson(item));
          }
          
          return productsList;
        } else {
          throw Exception('Request failed');
        }
      } else {
        throw Exception('Response is null');
      }
    } catch (e) {
      throw Exception('Error fetching books: $e');
    }
  }

  static Future<List<Products>> fetchAllBooks() async {
    var response = await DioFactory.getRequest(url: 'products');

    if (response != null && response.statusCode == 200) {
      List<dynamic> productsJson = response.data['data']['products'];
      
      List<Products> productsList = [];
      for (var item in productsJson) {
        productsList.add(Products.fromJson(item));
      }
      
      return productsList;
    } else {
      throw Exception('Failed to fetch products');
    }
  }

  static Future<List<Products>> fetchAllBooksSortedByName() async {
    List<Products> products = await fetchAllBooks();
    
    products.sort((a, b) => a.name.compareTo(b.name));
    
    return products;
  }
}
