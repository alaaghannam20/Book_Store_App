import 'package:bookstore_app/core/app_routes/routes.dart';
import 'package:bookstore_app/core/models/products_models.dart';
import 'package:bookstore_app/core/theme/colors.dart';
import 'package:flutter/material.dart';

class PagedFlashSaleScreen extends StatefulWidget {
  final List<Products> flashBooks;
  const PagedFlashSaleScreen({super.key, required this.flashBooks});

  @override
  State<PagedFlashSaleScreen> createState() => _PagedFlashSaleScreenState();
}

class _PagedFlashSaleScreenState extends State<PagedFlashSaleScreen> {
  int currentPage = 0;
  final int booksPerPage = 4;

  List<Products> get currentBooks {
    int totalBooks = widget.flashBooks.length;

    int fromIndex = currentPage * booksPerPage;
    int toIndex = fromIndex + booksPerPage;

    if (toIndex > totalBooks) {
      toIndex = totalBooks;
    }

    return widget.flashBooks.sublist(fromIndex, toIndex);
  }

  int get totalPages {
    return (widget.flashBooks.length / booksPerPage).ceil();
  }

  void nextPage() {
    if (currentPage < totalPages - 1) {
      setState(() => currentPage++);
    }
  }

  void previousPage() {
    if (currentPage > 0) {
      setState(() => currentPage--);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            separatorBuilder: (_, __) => SizedBox(height: 12),
            itemCount: currentBooks.length,
            itemBuilder: (context, index) {
              final book = currentBooks[index];
              final double progress = (100 - book.discount) / 100;
              final double oldPrice = book.price ?? 0;
              final double newPrice = book.priceAfterDiscount;

              return Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.flashColor,
                ),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          Routes.bookDetailsScreen,
                          arguments: book.id,
                        );
                      },
                      child: ClipRRect(
                        child: Image.network(
                          book.image,
                          width: 93,
                          height: 131,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            book.name,
                            style: TextStyle(
                              fontFamily: 'Open Sans',
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColors.whiteColor,
                            ),
                          ),
                          SizedBox(height: 4),
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
                              SizedBox(width: 4), 
                              Text(
                                "${book.category}",
                                style: TextStyle(
                                  fontFamily: 'Open Sans',
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.whiteColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          LinearProgressIndicator(
                            value: progress,
                            color: AppColors.amberColor,
                            backgroundColor: AppColors.greyColor,
                            minHeight: 6,
                          ),
                          SizedBox(height: 9),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${book.stock} books left",
                                style: TextStyle(
                                  fontFamily: 'Open Sans',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 10,
                                  color: Color(0x80FFFFFF),
                                ),
                              ),
                              Row(
                                children: [
                                  Icon(Icons.star,
                                      color: AppColors.starsColor, size: 16),
                                  SizedBox(width: 4),
                                  Text(
                                    "4.5",
                                    style: TextStyle(
                                      fontFamily: 'Open Sans',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                      color: AppColors.whiteColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "\$$oldPrice",
                                    style: TextStyle(
                                      fontFamily: 'Open Sans',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13,
                                      color: Color(0x80FFFFFF),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(width: 4),
                              Text(
                                "\$$newPrice",
                                style: TextStyle(
                                  fontFamily: 'Open Sans',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 17,
                                  color: AppColors.whiteColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: AppColors.pinkprimary,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: IconButton(
                              onPressed: () {
                              },
                              icon: Icon(Icons.shopping_cart,
                                  color: AppColors.whiteColor, size: 16),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: currentPage > 0 ? previousPage : null,
              color:
                  currentPage > 0 ? AppColors.pinkprimary : Color(0xFFF48FB1),
              icon: Icon(
                Icons.arrow_back_ios,
                size: 16,
              ),
            ),
            Text(
              'Previous',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color:
                    currentPage > 0 ? AppColors.pinkprimary : Color(0xFFF48FB1),
              ),
            ),
            ...List.generate(totalPages, (index) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 4),
                child: SizedBox(
                  height: 32,
                  width: 32,
                  child: TextButton(
                    onPressed: () => setState(() => currentPage = index),
                    style: TextButton.styleFrom(
                      backgroundColor: currentPage == index
                          ? AppColors.pinkprimary
                          : AppColors.whiteColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      '${index + 1}',
                      style: TextStyle(
                        color: currentPage == index
                            ? AppColors.whiteColor
                            : AppColors.pinkprimary,
                      ),
                    ),
                  ),
                ),
              );
            }),
            Text(
              "Next",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: currentPage < totalPages - 1
                    ? AppColors.pinkprimary
                    : Color(0xFFF48FB1),
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.arrow_forward_ios,
                size: 16,
              ),
              onPressed: currentPage < totalPages - 1 ? nextPage : null,
              color: currentPage < totalPages - 1
                  ? AppColors.pinkprimary
                  : Color(0xFFF48FB1),
            ),
          ],
        ),
        SizedBox(height: 16),
      ],
    );
  }
}
