

import 'package:bookstore_app/core/theme/colors.dart';
import 'package:flutter/material.dart';

class BookRaitingWidget extends StatelessWidget {
  const BookRaitingWidget({
    super.key,
    required this.rating,
    required this.totalReviews

    });

    final double rating;
    final double totalReviews;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment : WrapCrossAlignment.center,
      spacing: 5,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(5, (i) {
            if (i < rating.floor()) {
              return const Icon(Icons.star,
                  color: AppColors.starsColor, size: 16);
            } else if (i < rating) {
              return const Icon(Icons.star_half,
                  color: AppColors.starsColor, size: 16);
            } else {
              return const Icon(Icons.star_border,
                  color: AppColors.starsColor, size: 16);
            }
          }),
        ),
        Text(
          '($totalReviews Reviews)',
          style: TextStyle(
            fontSize: 10,
            color: AppColors.reviewColor,
            fontWeight: FontWeight.w400,
            fontFamily: 'Open Sans'
          ),
        ),
      ],
    );
  }
}