import 'dart:developer';

import 'package:bookstore_app/core/models/products_models.dart';
import 'package:bookstore_app/core/services/local/shared_prefs_helper.dart';
import 'package:bookstore_app/core/theme/app_style.dart';
import 'package:bookstore_app/core/theme/colors.dart';
import 'package:bookstore_app/features/auth/book/data/repo/fetch_books_repo.dart';
import 'package:bookstore_app/features/auth/book/presentation/widgets/book_cart.dart';
import 'package:bookstore_app/features/home/presentation/widget/search_text.dart';
import 'package:flutter/material.dart';

class AllBooksScreen extends StatefulWidget {
  const AllBooksScreen({super.key});

  @override
  State<AllBooksScreen> createState() => _AllBooksScreenState();
}

class _AllBooksScreenState extends State<AllBooksScreen> {
  List<Products> allBook = [];
  List<Products> resultsSearch = [];

  int currentPage = 0;
  final int booksPerPage = 6;

  void _handleSearch(List<Products> results, String query) {
    SharedPrefsHelper.addToSearchHistory(query);
    setState(() {
      resultsSearch = results;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchBooks();
  }

  Future<void> fetchBooks() async {
    try {
      final fetchedBooks = await FetchBooksRepo.fetchAllBooks();
      setState(() => allBook = fetchedBooks);
    } catch (error) {
      log("Failed to fetch books: $error");
    }
  }

  List<Products> get currentBooks {
    int totalBooks = allBook.length;
    int fromIndex = currentPage * booksPerPage;
    int toIndex = fromIndex + booksPerPage;
    if (toIndex > totalBooks) {
      toIndex = totalBooks;
    }
    return allBook.sublist(fromIndex, toIndex);
  }

  int get totalPages {
    return (allBook.length / booksPerPage).ceil();
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
    return Scaffold(
      backgroundColor: AppColors.screenColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
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
                  Text('Books', style: AppStyle.loginStyle),
                ],
              ),
              const SizedBox(height: 24),
              if (allBook.isEmpty)
                const Center(child: CircularProgressIndicator())
              else
                Column(
                  children: [
                    SearchText(
                      heightForSizeBox: 31,
                      widthForSizeBox: 39,
                      onResults: _handleSearch,
                    ),
                    const SizedBox(height: 24),

                    /// عرض نتائج البحث
                    if (resultsSearch.isNotEmpty)
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: resultsSearch.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                          childAspectRatio: 164 / 390,
                        ),
                        itemBuilder: (context, index) {
                          return BookCart(books: resultsSearch[index]);
                        },
                      )
                    else ...[
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: currentBooks.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                          childAspectRatio: 164 / 390,
                        ),
                        itemBuilder: (context, index) {
                          return BookCart(books: currentBooks[index]);
                        },
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: currentPage > 0 ? previousPage : null,
                            color: currentPage > 0
                                ? AppColors.pinkprimary
                                : const Color(0xFFF48FB1),
                            icon: const Icon(Icons.arrow_back_ios, size: 16),
                          ),
                          Text(
                            'Previous',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: currentPage > 0
                                  ? AppColors.pinkprimary
                                  : const Color(0xFFF48FB1),
                            ),
                          ),
                          ...List.generate(totalPages, (index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4),
                              child: SizedBox(
                                height: 32,
                                width: 32,
                                child: TextButton(
                                  onPressed: () =>
                                      setState(() => currentPage = index),
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
                                  : const Color(0xFFF48FB1),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.arrow_forward_ios, size: 16),
                            onPressed:
                                currentPage < totalPages - 1 ? nextPage : null,
                            color: currentPage < totalPages - 1
                                ? AppColors.pinkprimary
                                : const Color(0xFFF48FB1),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                    ]
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
