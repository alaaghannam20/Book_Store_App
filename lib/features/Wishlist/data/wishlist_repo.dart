import 'dart:convert';

import 'package:bookstore_app/core/models/products_models.dart';
import 'package:bookstore_app/core/services/local/shared_prefs_helper.dart';


class WishlistRepo {
  static Future<List<Products>> fetchFavorites(String? email) async {
    if (email?.isEmpty ?? true) return [];

    final rawData = await SharedPrefsHelper.getData(key: 'favorites_$email');
    if (rawData == null) return [];

    try {
      final decoded = json.decode(rawData) as List<dynamic>;
      return decoded.map((entry) => Products.fromJson(entry)).toList();
    } catch (_) {
      return [];
    }
  }

  static Future<void> storeFavorites(String? email, List<Products> items) async {
    if (email == null || email.trim().isEmpty) return;

    final serialized = json.encode(items.map((e) => e.toJson()).toList());
    await SharedPrefsHelper.saveData(key: 'favorites_$email', value: serialized);
  }
}
