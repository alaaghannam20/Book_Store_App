import 'package:bookstore_app/core/app_routes/routes.dart';
import 'package:bookstore_app/core/models/products_models.dart';
import 'package:bookstore_app/core/theme/colors.dart';
import 'package:bookstore_app/features/Wishlist/presentation/manager/wishlist_cubit.dart';
import 'package:bookstore_app/features/home/presentation/widget/book_raiting_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecomendedCard extends StatelessWidget {
  final Products book;
  final String imageUrl;
  final String bookTitle;
  final String authorName;
  final double bookPrice;
  final double rating;
  final double totalReviews;
  final int bookId;

  const RecomendedCard({
    super.key,
    required this.book,
    required this.bookId,
    required this.imageUrl,
    required this.bookTitle,
    required this.authorName,
    required this.bookPrice,
    required this.rating,
    required this.totalReviews,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          Routes.bookDetailsScreen,
          arguments: {
            'bookId': bookId,
            'withFade': true,
          },
        );
      },
      child: Container(
        margin: const EdgeInsets.all(12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: AppColors.whiteColor),
        child: Row(
          children: [
            ClipRRect(
              child: Image.network(
                imageUrl,
                width: 93,
                height: 124,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              width: 16,
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  bookTitle,
                  style: TextStyle(
                    fontFamily: 'Open Sans',
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.borderColor,
                  ),
                ),
                SizedBox(
                  height: 4,
                ),
                Row(
                  children: [
                    Text(
                      'Author:',
                      style: TextStyle(
                        fontFamily: 'Open Sans',
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        color: AppColors.greyColor,
                      ),
                    ),
                    Text(
                      '$authorName',
                      style: TextStyle(
                        fontFamily: 'Open Sans',
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        color: AppColors.borderColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                BookRaitingWidget(rating: rating, totalReviews: totalReviews),
                SizedBox(
                  height: 14,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "\$${bookPrice.toStringAsFixed(2)}",
                      style: TextStyle(
                        fontFamily: 'Open Sans',
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: AppColors.borderColor,
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: AppColors.pinkprimary,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.shopping_cart,
                                color: AppColors.whiteColor, size: 16),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        BlocBuilder<WishlistCubit, List<Products>>(
                          builder: (context, state) {
                            final isFavorite =
                                context.read<WishlistCubit>().contains(book);
                            return Container(
                                height: 32,
                                width: 32,
                                decoration: BoxDecoration(
                                  color: AppColors.whiteColor,
                                  border: Border.all(
                                      color: AppColors.pinkprimary, width: 1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: IconButton(
                                  onPressed: () {
                                    context
                                        .read<WishlistCubit>()
                                        .updateFavoriteStatus(book);
                                  },
                                  icon: Icon(
                                      isFavorite
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: AppColors.pinkprimary,
                                      size: 16),
                                ));
                          },
                        ),
                      ],
                    )
                  ],
                )
              ],
            ))
          ],
        ),
      ),
    );
  }
}
