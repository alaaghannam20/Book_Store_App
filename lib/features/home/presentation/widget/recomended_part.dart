import 'package:bookstore_app/core/app_routes/routes.dart';
import 'package:bookstore_app/core/theme/colors.dart';
import 'package:bookstore_app/features/home/presentation/manager/recomended_cubit.dart';
import 'package:bookstore_app/features/home/presentation/widget/recomended_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecomendedPart extends StatelessWidget {
  const RecomendedPart({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RecommendedCubit()..fetchRecommendedBooks(),
      child: BlocBuilder<RecommendedCubit, RecomendedState>(
        builder: (context, state) {
          if (state is RecomendedLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is RecomendedSuccess) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      const Text(
                        'Recommended for you',
                        style: TextStyle(
                          fontFamily: 'Open Sans',
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: AppColors.borderColor,
                        ),
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, Routes.allBooksScreen);
                        },
                        child: const Row(
                          children: [
                            Text(
                              'See all',
                              style: TextStyle(
                                fontFamily: 'Open Sans',
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
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
                ...state.books.map((book) => RecomendedCard(
                    book: book,
                    bookId: book.id,
                    imageUrl: book.image,
                    bookTitle: book.name,
                    authorName: book.category,
                    bookPrice:
                        double.tryParse(book.priceAfterDiscount.toString()) ??
                            0.0,
                    rating: 4.0,
                    totalReviews: 180))
              ],
            );
          } else if (state is RecomendedError) {
            return Center(
              child: Text(state.msg),
            );
          }
          return SizedBox();
        },
      ),
    );
  }
}
