import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bookstore_app/core/theme/colors.dart';
import 'package:bookstore_app/features/booksdetails/presentation/manager/book_details_cubit.dart';
import 'package:bookstore_app/features/booksdetails/presentation/manager/quantity_manager_cubit.dart';
import 'package:bookstore_app/features/booksdetails/presentation/ui/widget/add_to_cart_widget.dart';

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

                    // هنا استخدمنا الويدجت الجديد القابل للتوسيع مع Read more ملتصق
                    _ExpandableDescription(text: _removeHtmlTags(book.description)),

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
                    SizedBox(height: 16,),
                  ],
                ),
              );
            } else if (state is BookDetailsError) {
              return Center(child: Text(state.msg));
            }
            return const SizedBox();
          },
        ),
        
        bottomNavigationBar: AddToCartWidget(bookId: booksId),
      ),
    );
  }

  String _removeHtmlTags(String htmlContent) {
    return htmlContent.replaceAll(RegExp(r'<[^>]*>'), '');
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
    final defaultStyle = const TextStyle(fontSize: 12, color: AppColors.greyColor);
    final linkStyle = const TextStyle(fontSize: 12, color: AppColors.blackColor, fontWeight: FontWeight.w600);

    if (isExpanded) {
      // النص مكشوف كامل + زر Read less مع سهم مثلث لأعلى
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
                const Text("▲", style: TextStyle(fontSize: 14, color: AppColors.blackColor)),
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
