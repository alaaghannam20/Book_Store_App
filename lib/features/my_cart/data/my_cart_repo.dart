
import 'package:bookstore_app/core/services/networking/dio_factory.dart';

class MyCartRepo {
  Future<Map<String, dynamic>> addItemToCart({
    required int id,
    required int qty,
  }) async {
    try {
      final result = await DioFactory.PostRequest(
        url: 'add-to-cart',
        data: {
          'product_id': id,
          'quantity': qty,
        },
      );

      final status = result?.statusCode;

      if (status == 201) {
        return _buildSuccessResponse(
          message: result?.data['message'] ?? 'Item added successfully',
          data: result?.data['data'],
        );
      } else {
        return _buildFailureResponse(
          message: result?.data['message'] ?? 'Unable to add item',
          errorDetails: result?.data['error'],
        );
      }
    } catch (error) {
      return _handleException(error);
    }
  }

  Future<Map<String, dynamic>> fetchCartContents() async {
    try {
      final result = await DioFactory.getRequest(url: 'cart');

      final code = result?.statusCode;

      if (code == 200) {
        return _buildSuccessResponse(
          message: result?.data['message'] ?? 'Cart loaded',
          data: result?.data['data'],
        );
      } else if (code == 401) {
        return _buildFailureResponse(
          message: 'Unauthorized access - empty or expired cart',
          errorDetails: ['Unauthorized'],
        );
      } else {
        return _buildFailureResponse(
          message: result?.data['message'] ?? 'Could not load cart',
          errorDetails: result?.data['error'],
        );
      }
    } catch (error) {
      return _handleException(error);
    }
  }


  Map<String, dynamic> _buildSuccessResponse({
    required String message,
    dynamic data,
  }) {
    return {
      'success': true,
      'message': message,
      'data': data,
    };
  }

  Map<String, dynamic> _buildFailureResponse({
    required String message,
    dynamic errorDetails,
  }) {
    return {
      'success': false,
      'message': message,
      'error': errorDetails ?? [],
    };
  }

  Map<String, dynamic> _handleException(dynamic error) {
    return {
      'success': false,
      'message': 'An error occurred: $error',
      'error': [error.toString()],
    };
  }
}
