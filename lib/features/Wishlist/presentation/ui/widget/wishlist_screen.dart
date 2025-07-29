import 'package:bookstore_app/core/models/products_models.dart';
import 'package:bookstore_app/core/theme/app_style.dart';
import 'package:bookstore_app/core/theme/colors.dart';
import 'package:bookstore_app/features/Wishlist/presentation/manager/wishlist_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screenColor,
      body: Padding(
        padding: const EdgeInsets.only(top: 60, left: 16, right: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                  Text('Wishlist', style: AppStyle.loginStyle),
                ],
              ),
              const SizedBox(height: 16),
              BlocBuilder<WishlistCubit, List<Products>>(
                builder: (context, favorite) {
                  if (favorite.isEmpty) {
                    return Center(
                      child: Text(
                        'No Favorite Items',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: AppColors.pinkprimary,
                        ),
                      ),
                    );
                  }

                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: favorite.length,
                    itemBuilder: (context, index) {
                      final productFav = favorite[index];

                      return Card(
                        elevation: 2.0,
                        color: AppColors.whiteColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(4.0),
                                        child: Image.network(
                                          productFav.image,
                                          width: 93,
                                          height: 124,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(width: 12),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        productFav.name,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(height: 4.0),
                                      Row(
                                        children: [
                                          Text(
                                            'Author: ',
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: AppColors.greyColor,
                                            ),
                                          ),
                                          Text(
                                            productFav.category,
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: AppColors.blackColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8.0),
                                      if (productFav.stock <= 0)
                                        const Text(
                                          'Item out of stock',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Color(0xFFEB4335),
                                          ),
                                        )
                                      else
                                        Text(
                                          '\$${productFav.price.toStringAsFixed(2)}',
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.blackColor,
                                          ),
                                        ),
                                      const SizedBox(height: 8.0),
                                      Row(
                                        children: [
                                          Text(
                                            'ASIN : ',
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w700,
                                              color: AppColors.greyColor,
                                            ),
                                          ),
                                          Text(
                                           ' ${productFav.id}' ,
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.greyColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 80,
                                        height: 32,
                                        child: OutlinedButton.icon(
                                          onPressed: () {
                                            context
                                                .read<WishlistCubit>()
                                                .updateFavoriteStatus(
                                                    productFav);
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                    '${productFav.name} removed from wishlist.'),
                                                duration:
                                                    const Duration(seconds: 1),
                                              ),
                                            );
                                          },
                                          icon: const Icon(
                                            Icons.delete_outline,
                                            size: 16,
                                            color: AppColors.greyColor,
                                          ),
                                          label: Text(
                                            'Remove',
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: AppColors.greyColor,
                                            ),
                                          ),
                                          style: OutlinedButton.styleFrom(
                                            padding: EdgeInsets.zero,
                                            side: BorderSide(
                                                color: AppColors.greyColor!),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      SizedBox(
                                        width: 107,
                                        height: 32,
                                        child: OutlinedButton.icon(
                                          onPressed: () {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                    'Moving ${productFav.name} to cart...'),
                                                duration:
                                                    const Duration(seconds: 1),
                                              ),
                                            );
                                          },
                                          icon: const Icon(
                                            Icons.shopping_cart_outlined,
                                            size: 16,
                                            color: AppColors.greyColor,
                                          ),
                                          label: Text(
                                            'Move to cart',
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: AppColors.greyColor,
                                            ),
                                          ),
                                          style: OutlinedButton.styleFrom(
                                            padding: EdgeInsets.zero,
                                            side: BorderSide(
                                                color: AppColors.greyColor!),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    width: 32,
                                    height: 32,
                                    decoration:  BoxDecoration(
                                      color: Colors.transparent,
                                      border:   Border.all(
                                        color: AppColors.greyColor,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                      
                                    ),
                                    child: IconButton(
                                      onPressed: () {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                                'Share functionality not implemented.'),
                                            duration: Duration(seconds: 1),
                                          ),
                                        );
                                      },
                                      icon: const Icon(
                                        Icons.share,
                                        size: 16,
                                        color: AppColors.greyColor,
                                      ),
                                      padding: EdgeInsets.zero,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
