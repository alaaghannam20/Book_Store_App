import 'package:bookstore_app/core/app_routes/routes.dart';
import 'package:bookstore_app/core/models/products_models.dart';
import 'package:bookstore_app/core/theme/colors.dart';
import 'package:flutter/material.dart';

class BestSellerWidget extends StatefulWidget {
  final List<Products> bestSellerBooks;

  const BestSellerWidget({super.key, required this.bestSellerBooks});

  @override
  State<BestSellerWidget> createState() => _BestSellerWidgetState();
}

class _BestSellerWidgetState extends State<BestSellerWidget> {
  late final PageController _bookOverviewPageController;
  int currentIndexBookPage = 0;

  @override
  void initState() {
    super.initState();
    _bookOverviewPageController = PageController(viewportFraction: 0.43);
  }

  void goBack() {
    if (currentIndexBookPage > 0) {
      setState(() {
        currentIndexBookPage--;
        _bookOverviewPageController.animateToPage(
          currentIndexBookPage,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      });
    }
  }

  void goForward() {
    if (currentIndexBookPage < widget.bestSellerBooks.length - 1) {
      setState(() {
        currentIndexBookPage++;
        _bookOverviewPageController.animateToPage(
          currentIndexBookPage,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool hasPrevious = currentIndexBookPage > 0;
    final bool hasNext =
        currentIndexBookPage < widget.bestSellerBooks.length - 1;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.all(12.0),
        child: Text(
          "Best seller",
          style: TextStyle(
            fontFamily: 'Open Sans',
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: AppColors.blackColor,
          ),
        ),
      ),
      SizedBox(
        height: 24,
      ),
      SizedBox(
        height: 180,
        child: PageView.builder(
          itemCount: widget.bestSellerBooks.length,
          controller: _bookOverviewPageController,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final Products = widget.bestSellerBooks[index];
            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, Routes.bookDetailsScreen,
                    arguments: Products.id);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 4,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      Products.image,
                      fit: BoxFit.cover,
                      width: 119.77,
                      height: 180,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
      SizedBox(height: 16,),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 36,
            width: 36,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.hintTextColor , width: 1),
            ),
            child: IconButton(onPressed: hasPrevious ? goBack : null,
             icon: Icon(Icons.arrow_back_ios , size: 20, weight: 1.5,),
             color: hasPrevious ? AppColors.blackColor : AppColors.borderColor,
          ),
          ),
          SizedBox(width: 24,),
  Container(
            height: 36,
            width: 36,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.hintTextColor , width: 1),
            ),
            child: IconButton(onPressed: hasNext ? goForward : null,
             icon: Icon(Icons.arrow_forward_ios , size: 20, weight: 1.5,),
             color: hasPrevious ? AppColors.blackColor : AppColors.borderColor,
          ),
          ),
        ],
      )
    ]);
  }
}
