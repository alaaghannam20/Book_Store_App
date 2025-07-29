import 'package:bookstore_app/core/app_routes/routes.dart';
import 'package:bookstore_app/core/models/products_models.dart';
import 'package:bookstore_app/core/theme/colors.dart';
import 'package:bookstore_app/features/home/presentation/widget/flash_sale_card.dart';
import 'package:flutter/material.dart';

class FlashSalePart extends StatelessWidget {
  final List<Products> books;
  const FlashSalePart({super.key, required this.books});

  @override
  Widget build(BuildContext context) {
    final flashSaleBooks = books.take(2).toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Flash sale',
                style: TextStyle(
                  fontFamily: 'Open Sans',
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: AppColors.borderColor,
                ),
              ),
              Spacer(),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, Routes.flashSaleScreen ,  arguments: books, );
                },
                child: const Row(
                  children: [
                    Text(
                      'See all',
                      style: TextStyle(
                        fontFamily: 'Open Sans',
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: AppColors.pinkprimary,
                      ),
                    ),
                    Icon(
                      Icons.arrow_right,
                      size: 23,
                      color: AppColors.pinkprimary,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16,),
        FlashSaleCard(flashSaleBooks: flashSaleBooks, scrollPhysics: NeverScrollableScrollPhysics())
      ],
    );
  }
}
