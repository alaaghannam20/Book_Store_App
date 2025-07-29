import 'package:bookstore_app/core/models/products_models.dart';
import 'package:bookstore_app/core/theme/colors.dart';
import 'package:bookstore_app/features/Wishlist/presentation/manager/wishlist_cubit.dart';
import 'package:bookstore_app/features/booksdetails/presentation/manager/book_details_cubit.dart';
import 'package:bookstore_app/features/booksdetails/presentation/manager/quantity_manager_cubit.dart';
import 'package:bookstore_app/features/booksdetails/presentation/ui/widget/add_to_cart_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BooksDetailsScreen extends StatelessWidget {
  final int booksId;
  const BooksDetailsScreen({super.key, required this.booksId});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => BookDetailsCubit()..loadBookInfo(booksId)),
        BlocProvider(create: (_) => QuantityManagerCubit()),
      ],
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            padding: EdgeInsets.only(left: 16),
            icon: Icon(Icons.arrow_back_ios_new_rounded, size: 16),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text("Book Details"),
        ),
        body: BlocBuilder<BookDetailsCubit, BookDetailsState>(
          builder: (context, state) {
            if (state is BookDetailsLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is BookDetailsSuccess) {
              final currentBook = state.books;
              return SingleChildScrollView(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Stack(
                        children: [
                          ClipRRect(
                            child: Image.network(
                              currentBook.image,
                              height: 365,
                              width: 254,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            top: 8,
                            right: 8,
                            child: BlocBuilder<WishlistCubit, List<Products>>(
                              builder: (context, favstate) {
                                final isFav = context
                                    .read<WishlistCubit>()
                                    .contains(currentBook);
                                return Container(
                                  width: 36,
                                  height: 36,
                                  decoration: BoxDecoration(
                                    color: AppColors.whiteColor,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: IconButton(
                                    padding: EdgeInsets.zero,
                                    icon: Icon(
                                      isFav
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: isFav
                                          ? AppColors.pinkprimary
                                          : AppColors.blackColor,
                                      size: 20,
                                    ),
                                    onPressed: () {
                                      context
                                          .read<WishlistCubit>()
                                          .updateFavoriteStatus(currentBook);
                                    },
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            currentBook.name,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              '4.5',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Icon(Icons.star,
                                color: AppColors.starsColor, size: 16),
                            Text(
                              '(180)',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          _removeHtmlTags(currentBook.description),
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: AppColors.greyColor,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "\$${currentBook.priceAfterDiscount}",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(width: 8),
                                if (currentBook.discount > 0)
                                  Text(
                                    "\$${currentBook.price}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.greyColor,
                                    ),
                                  ),
                              ],
                            ),
                            _InfoTag(
                              label: currentBook.stock > 0
                                  ? 'Available'
                                  : 'Out of Stock',
                              color: currentBook.stock > 0
                                  ? AppColors.greenColor!
                                  : AppColors.redColor,
                              icon: currentBook.stock > 0
                                  ? Icons.check_circle
                                  : Icons.close,
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            _InfoTag(
                              label: "Discount: Ne212",
                              color: Color(0xFFEAA451)
,
                            ),
                            SizedBox(width: 5),
                            _InfoTag(
                              label: "Free Delivery Today",
                              color: AppColors.greyColor,
                              icon: Icons.local_shipping,
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        _buildInfoRow("Title: ", currentBook.name),
                        _buildInfoRow("Genre: ", currentBook.category),
                        _buildInfoRow("Units Left: ", "${currentBook.stock}"),
                        _buildInfoRow("Rank: ", "#${currentBook.bestSeller}"),
                        SizedBox(height: 16),
                      ],
                    ),
                  ],
                ),
              );
            } else if (state is BookDetailsError) {
              return Center(child: Text(state.msg));
            }
            return SizedBox();
          },
        ),
        bottomNavigationBar: AddToCartWidget(bookId: booksId),
      ),
    );
  }

  String _removeHtmlTags(String htmlContent) {
    return htmlContent.replaceAll(RegExp(r'<[^>]*>'), '');
  }

  Widget _buildInfoRow(String label, String data) {
    return Row(
      children: [
      Text(
  label,
  style: TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
  ),
),

        Expanded(
          child: Text(
  data,
  style: TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
  ),
),

        ),
      ],
    );
  }
}

class _InfoTag extends StatelessWidget {
  final String label;
  final Color color;
  final IconData? icon;

  const _InfoTag({required this.label, required this.color, this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.greyColor),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) Icon(icon, size: 12, color: color),
          if (icon != null) SizedBox(width: 6),
          Text(
  label,
  style: TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: color,
  ),
),

        ],
      ),
    );
  }
}
