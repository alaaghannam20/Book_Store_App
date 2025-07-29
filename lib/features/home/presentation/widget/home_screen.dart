import 'package:bookstore_app/core/models/products_models.dart';
import 'package:bookstore_app/features/home/presentation/manager/best_seller_cubit.dart';
import 'package:bookstore_app/features/home/presentation/widget/best_seller_widget.dart';
import 'package:bookstore_app/features/home/presentation/widget/flash_sale_part.dart';
import 'package:bookstore_app/features/home/presentation/widget/recomended_part.dart';
import 'package:bookstore_app/features/home/presentation/widget/search_top_bar.dart';
import 'package:bookstore_app/features/search/presentation/ui/widgets/search_result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Products> searchResults = [];
  @override
  Widget build(BuildContext context) {
     return BlocProvider(
      create: (_) => BestSellerCubit()..fetchBestSellerBooks(),
      child: Scaffold(
        body: SafeArea(
            child: Column(
              children: [
                SearchTopBar(
                  searchResults: (results) {
                    setState(() {
                      searchResults = results;
                    });
                  },
                ),
                SizedBox(height: 16),
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      if (searchResults.isNotEmpty)
                        SearchResults(searchResults: searchResults),
                      BlocBuilder<BestSellerCubit, BestSellerState>(
                        builder: (context, state) {
                          if (state is BestSellerLoading) {
                            return Center(child: CircularProgressIndicator());
                          } else if (state is BestSellerSuccess) {
                            return Column(
                              children: [
                                BestSellerWidget(bestSellerBooks: state.books),
                                SizedBox(height: 24),
                                RecomendedPart(),
                                SizedBox(height: 24),
                                FlashSalePart(books: state.books),
                              ],
                            );
                          } else if (state is BestSellerError) {
                            return Center(child: Text(state.msg));
                          } else {
                            return SizedBox();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          
        ),
      ),
    );
  }
}