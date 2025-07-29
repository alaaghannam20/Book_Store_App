import 'package:bookstore_app/core/models/products_models.dart';
import 'package:bookstore_app/core/theme/app_style.dart';
import 'package:bookstore_app/features/auth/flash_sale/presentation/ui/widget/paged_flash_sale_screen.dart';
import 'package:flutter/material.dart';
import 'package:bookstore_app/core/theme/colors.dart';

class FlashSaleScreen extends StatelessWidget {
  final List<Products> books;
  const FlashSaleScreen({super.key, required this.books});

  @override
  Widget build(BuildContext context) {
    final flashBooks = books.where((book) => book.discount > 0).toList();

    return Scaffold(
      backgroundColor: AppColors.screenColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.arrow_back_ios_new,
                      size: 22,
                      color: AppColors.blackColor,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text('Flash sale', style: AppStyle.loginStyle),
                ],
              ),
              const SizedBox(height: 24),
              Expanded(
                child: flashBooks.isEmpty
                    ? Center(
                        child: Text(
                          'No flash sale books available',
                          style: TextStyle(
                            color: AppColors.flashColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    : PagedFlashSaleScreen(flashBooks: flashBooks),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
