// ignore_for_file: prefer_const_constructors

import 'package:bookstore_app/core/app_routes/routes.dart';
import 'package:bookstore_app/core/models/products_models.dart';
import 'package:flutter/material.dart';

class SearchResults extends StatelessWidget {
  const SearchResults({
    super.key,
    required this.searchResults,
  });

  final List<Products> searchResults;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Search Results",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 12),
          ...searchResults.map(
            (product) => GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, Routes.bookDetailsScreen,
                    arguments: product.id);
              },
              child: ListTile(
                leading: Image.network(product.image, width: 40),
                title: Text(product.name),
              ),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
