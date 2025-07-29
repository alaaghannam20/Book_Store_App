import 'package:bookstore_app/core/app_routes/routes.dart';
import 'package:bookstore_app/core/models/products_models.dart';
import 'package:bookstore_app/core/theme/colors.dart';
import 'package:bookstore_app/features/home/presentation/widget/icon_circule.dart';
import 'package:bookstore_app/features/home/presentation/widget/search_text.dart';
import 'package:flutter/material.dart';

class SearchTopBar extends StatelessWidget {
  final void Function(List<Products>) searchResults;
  const SearchTopBar({super.key, required this.searchResults});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: SearchText(
              heightForSizeBox: 40,
              widthForSizeBox: 40,
              onResults: (results, query) {
                searchResults(results);
              },
            ),
          ),
          const SizedBox(width: 10),
          IconCircle(
            backgroundColor: AppColors.pinkprimary,
            icon: Icons.shopping_cart,
            iconColor: AppColors.whiteColor,
            onTap: () {
              // cart action
            },
          ),
          const SizedBox(width: 8),
          IconCircle(
            backgroundColor: AppColors.whiteColor,
            icon: Icons.favorite_border,
            iconColor: AppColors.pinkprimary,
            borderColor: AppColors.pinkprimary,
            onTap: () {
              Navigator.pushNamed(context, Routes.wishListScreen);
            },
          ),
        ],
      ),
    );
  }
}
