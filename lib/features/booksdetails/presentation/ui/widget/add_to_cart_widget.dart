import 'package:bookstore_app/core/theme/colors.dart';
import 'package:bookstore_app/features/booksdetails/presentation/manager/quantity_manager_cubit.dart';
import 'package:bookstore_app/features/my_cart/presentation/manager/my_cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddToCartWidget extends StatelessWidget {
  final int bookId;
  const AddToCartWidget({super.key, required this.bookId});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocListener<MyCartCubit, MyCartState>(
        listener: (context, state) {
          if (state is MyCartSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.msg)),
            );
          } else if (state is MyCartError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMsg)),
            );
          }
        },
        child: Container(
          height: 48,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: AppColors.pinkprimary,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 110,
                  height: 33,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: AppColors.whiteColor,
                  ),
                  child: BlocBuilder<QuantityManagerCubit, int>(
                    builder: (context, currentQuantity) {
                      final cubit = context.read<QuantityManagerCubit>();
                      return Row(
                        children: [
                          IconButton(
                            iconSize: 18,
                            onPressed: cubit.subtract,
                            icon: Icon(
                              Icons.remove_circle_outline,
                              color: AppColors.pinkprimary,
                            ),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                          ),
                          Text(
                            '$currentQuantity',
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 24,
                            ),
                          ),
                          IconButton(
                            iconSize: 18,
                            onPressed: cubit.add,
                            icon: Icon(
                              Icons.add_circle_outline,
                              color: AppColors.pinkprimary,
                            ),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  final qty = context.read<QuantityManagerCubit>().state;
                  context.read<MyCartCubit>().addProductToCart(bookId, qty);
                },
                child: const Text(
                  "Add to cart",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: AppColors.whiteColor,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
