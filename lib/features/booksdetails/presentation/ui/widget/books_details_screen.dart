import 'package:bookstore_app/core/models/products_models.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bookstore_app/core/theme/colors.dart';
import 'package:bookstore_app/features/booksdetails/presentation/manager/book_details_cubit.dart';
import 'package:bookstore_app/features/booksdetails/presentation/manager/quantity_manager_cubit.dart';
import 'package:bookstore_app/features/booksdetails/presentation/ui/widget/add_to_cart_widget.dart';
import 'package:bookstore_app/features/home/presentation/manager/recomended_cubit.dart';
import 'package:bookstore_app/features/home/presentation/widget/recomended_card.dart';


class BooksDetailsScreen extends StatefulWidget {
  final int booksId;
  const BooksDetailsScreen({super.key, required this.booksId});

  @override
  State<BooksDetailsScreen> createState() => _BooksDetailsScreenState();
}

class _BooksDetailsScreenState extends State<BooksDetailsScreen> {
  late final PageController _recommendedPageController;
  int currentRecommendedIndex = 0;

    @override
  void initState() {
    super.initState();
     _recommendedPageController = PageController(viewportFraction: 1.0);
  }

  @override
void dispose() {
  _recommendedPageController.dispose();
  super.dispose();
}

    void goBack() {
    if (currentRecommendedIndex > 0) {
      setState(() {
        currentRecommendedIndex--;
        _recommendedPageController.animateToPage(
          currentRecommendedIndex,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      });
    }
  }

   void goForward(int max) {
    if (currentRecommendedIndex < max - 1) {
      setState(() {
        currentRecommendedIndex++;
        _recommendedPageController.animateToPage(
          currentRecommendedIndex,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => BookDetailsCubit()..loadBookInfo(widget.booksId)),
        BlocProvider(create: (_) => QuantityManagerCubit()),
        BlocProvider(
            create: (_) => RecommendedCubit()..fetchRecommendedBooks()),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Book details"),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 16),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: BlocBuilder<BookDetailsCubit, BookDetailsState>(
          builder: (context, state) {
            if (state is BookDetailsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is BookDetailsSuccess) {
              final book = state.books;
              return SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            book.image,
                            width: 254,
                            height: 365,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: 12),
                        Column(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: AppColors.hintTextColor,
                                  width: 1,
                                ),
                              ),
                              child: Icon(
                                Icons.favorite_border,
                                size: 16,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: AppColors.hintTextColor,
                                  width: 1,
                                ),
                              ),
                              child: Icon(
                                Icons.share,
                                size: 16,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 63),
                            _Thumbnail(imageUrl: book.image),
                            SizedBox(height: 7),
                            _Thumbnail(imageUrl: book.image),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            book.name,
                            style: const TextStyle(
                                fontFamily: 'Open Sans',
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: AppColors.borderColor),
                          ),
                        ),
                        Row(
                          children: const [
                            Text("4.5",
                                style: TextStyle(
                                    fontFamily: 'Open Sans',
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.borderColor)),
                            SizedBox(
                              width: 4,
                            ),
                            Icon(Icons.star,
                                size: 16, color: AppColors.starsColor),
                            Text(" (180)",
                                style: TextStyle(
                                    fontSize: 12, color: AppColors.greyColor)),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 8),
                    _ExpandableDescription(
                        text: _removeHtmlTags(book.description)),
                    const SizedBox(height: 12),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Text(
                              "\$${book.priceAfterDiscount}",
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              "\$${book.price}",
                              style: const TextStyle(
                                fontSize: 14,
                                color: AppColors.greyColor,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        _InfoTag(
                          label: book.stock > 0 ? "In Stock" : "Out of Stock",
                          color: book.stock > 0
                              ? Color(0xFF25D994)
                              : AppColors.redColor,
                          icon:
                              book.stock > 0 ? Icons.check_circle : Icons.close,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: const [
                        _InfoTag(
                          label: "Discount code: Ne212",
                          color: Color(0xFFEAA451),
                        ),
                        SizedBox(width: 8),
                        _InfoTag(
                            label: "Free Shipping Today",
                            color: AppColors.greyColor,
                            icon: Icons.local_shipping),
                      ],
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    DefaultTabController(
                        length: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: TabBar(
                                  isScrollable: true,
                                  labelColor: AppColors.blackColor,
                                  unselectedLabelColor: AppColors.greyColor,
                                  indicatorColor: Color(0xFFEAA451),
                                  tabs: [
                                    Tab(text: 'Product Details'),
                                    Tab(text: 'Customer Reviews'),
                                    Tab(text: 'Recomended For You'),
                                  ]),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            SizedBox(
                              height: 299,
                              child: TabBarView(
                                children: [
                                  _buildProductDetailsTab(book),
                                  Center(
                                      child:
                                          Text("Customer Reviews")), 
                                  _buildRecommendedTab(), 
                                ],
                              ),
                            )
                          ],
                        ))
                  ],
                ),
              );
            } else if (state is BookDetailsError) {
              return Center(child: Text(state.msg));
            }
            return const SizedBox();
          },
        ),
        bottomNavigationBar: AddToCartWidget(bookId: widget.booksId),
      ),
    );
  }

  String _removeHtmlTags(String htmlContent) {
    return htmlContent.replaceAll(RegExp(r'<[^>]*>'), '');
  }

  Widget _buildProductDetailsTab(Products book) {
    return ListView(
      padding: const EdgeInsets.only(top: 8),
      children: [
        _buildDetailRow("Book Title", book.name),
        _buildDetailRow("Author", book.category),
        _buildDetailRow("Publication Date", "1997"),
        _buildDetailRow("ASIN", book.id.toString()),
        _buildDetailRow("Language", "English"),
        _buildDetailRow("Publisher", "Printer"),
        _buildDetailRow("Pages", "336"),
        _buildDetailRow("Book Format", "Hard Cover"),
        _buildDetailRow("Best Seller Rank", "#${book.bestSeller}"),
      ],
    );
  }

  Widget _buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: "$title : ",
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: AppColors.borderColor,
                fontSize: 14,
              ),
            ),
            TextSpan(
              text: value,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                color: AppColors.greyColor,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

Widget _buildRecommendedTab() {
  return BlocBuilder<RecommendedCubit, RecomendedState>(
    builder: (context, state) {
      if (state is RecomendedLoading) {
        return Center(child: CircularProgressIndicator());
      } else if (state is RecomendedError) {
        return Center(child: Text(state.msg));
      } else if (state is RecomendedSuccess) {
        final books = state.books;
        final hasPrevious = currentRecommendedIndex > 0;
        final hasNext = currentRecommendedIndex < books.length - 1;

        return Column(
          children: [
            SizedBox(
               height: 190, 
  width: double.infinity,
              child: SizedBox(
                child: PageView.builder(
                  controller: _recommendedPageController,
                  itemCount: books.length,
                  onPageChanged: (index) {
                    setState(() {
                      currentRecommendedIndex = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    final book = books[index];
                    return RecomendedCard(
                      book: book,
                      bookId: book.id,
                      imageUrl: book.image,
                      bookTitle: book.name,
                      authorName: book.category,
                      bookPrice: book.priceAfterDiscount,
                      rating: 4.5,
                      totalReviews: 180,
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 36,
                  width: 36,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.hintTextColor, width: 1),
                  ),
                  child: IconButton(
                    onPressed: hasPrevious ? goBack : null,
                    icon: const Icon(Icons.arrow_back_ios, size: 20, weight: 1.5),
                    color: hasPrevious ? AppColors.blackColor : AppColors.borderColor,
                  ),
                ),
                const SizedBox(width: 24),
                Container(
                  height: 36,
                  width: 36,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.hintTextColor, width: 1),
                  ),
                  child: IconButton(
                    onPressed: hasNext ? () => goForward(books.length) : null,
                    icon: const Icon(Icons.arrow_forward_ios, size: 20, weight: 1.5),
                    color: hasNext ? AppColors.blackColor : AppColors.borderColor,
                  ),
                ),
              ],
            )
          ],
        );
      } else {
        return const SizedBox.shrink();
      }
    },
  );
}

}

class _ExpandableDescription extends StatefulWidget {
  final String text;
  const _ExpandableDescription({required this.text});

  @override
  State<_ExpandableDescription> createState() => _ExpandableDescriptionState();
}

class _ExpandableDescriptionState extends State<_ExpandableDescription> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final defaultStyle =
        const TextStyle(fontSize: 12, color: AppColors.greyColor);
    final linkStyle = const TextStyle(
        fontSize: 12, color: AppColors.blackColor, fontWeight: FontWeight.w600);

    if (isExpanded) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.text, style: defaultStyle),
          const SizedBox(height: 4),
          InkWell(
            onTap: () {
              setState(() {
                isExpanded = false;
              });
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Read less", style: linkStyle),
                const SizedBox(width: 4),
                const Text("▲",
                    style:
                        TextStyle(fontSize: 14, color: AppColors.blackColor)),
              ],
            ),
          ),
        ],
      );
    } else {
      return LayoutBuilder(
        builder: (context, constraints) {
          final textPainter = TextPainter(
            text: TextSpan(text: widget.text, style: defaultStyle),
            maxLines: 3,
            textDirection: TextDirection.ltr,
          );
          textPainter.layout(maxWidth: constraints.maxWidth);

          if (!textPainter.didExceedMaxLines) {
            return Text(widget.text, style: defaultStyle);
          }

          String text = widget.text;
          int endIndex = text.length;
          int startIndex = 0;
          int mid;

          String readMoreText = "… Read more ▶️";

          while (startIndex < endIndex) {
            mid = (startIndex + endIndex) ~/ 2;
            final testText = text.substring(0, mid) + readMoreText;
            final testPainter = TextPainter(
              text: TextSpan(text: testText, style: defaultStyle),
              maxLines: 3,
              textDirection: TextDirection.ltr,
            );
            testPainter.layout(maxWidth: constraints.maxWidth);
            if (testPainter.didExceedMaxLines) {
              endIndex = mid - 1;
            } else {
              startIndex = mid + 1;
            }
          }

          final displayText = text.substring(0, endIndex) + "… ";

          return RichText(
            text: TextSpan(
              style: defaultStyle,
              children: [
                TextSpan(text: displayText),
                TextSpan(
                  text: "Read more ▶️",
                  style: linkStyle,
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      setState(() {
                        isExpanded = true;
                      });
                    },
                ),
              ],
            ),
            maxLines: 3,
            overflow: TextOverflow.clip,
          );
        },
      );
    }
  }
}

class _Thumbnail extends StatelessWidget {
  final String imageUrl;
  const _Thumbnail({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.network(
        imageUrl,
        height: 96,
        width: 74,
        fit: BoxFit.cover,
      ),
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
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.hintTextColor),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) Icon(icon, size: 12, color: color),
          if (icon != null) const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(fontSize: 12, color: color),
          ),
        ],
      ),
    );
  }
}
