import 'package:bookstore_app/core/app_routes/routes.dart';
import 'package:bookstore_app/core/theme/colors.dart';
import 'package:bookstore_app/features/my_cart/presentation/manager/my_cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyCartScreen extends StatefulWidget {
  const MyCartScreen({super.key});

  @override
  State<MyCartScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyCartScreen> {
  @override
  void initState() {
    super.initState();
    final current = context.read<MyCartCubit>().state;
    if (current is! MyCartLoading) {
      context.read<MyCartCubit>().loadCartData();
    }
  }

  int calculateTotalItems(List<Map<String, dynamic>> data) => data.fold(
      0, (sum, item) => sum + int.tryParse(item['item_quantity'].toString())!);

  String computeFinalAmount(String subtotal, double tax) {
    final base = double.tryParse(subtotal) ?? 0.0;
    return (base + tax).toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.only(left: 16),
          child: BackButton(),
        ),
        title: Text("My Cart"),
      ),
      body: BlocBuilder<MyCartCubit, MyCartState>(
        builder: (context, state) {
          if (state is MyCartLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (state is CartDetailsLoaded) {
            return Stack(
              children: [
                ListView.builder(
                  padding: EdgeInsets.only(bottom: 140),
                  itemCount: state.products.length + 1,
                  itemBuilder: (context, index) {
                    if (index == state.products.length) {
                      return buildSummarySection(state.totalCost);
                    }
                    final product = state.products[index];
                    return buildCartItemCard(product, index);
                  },
                ),
                buildCheckoutBar(state.products, state.totalCost),
              ],
            );
          }

          if (state is MyCartError) {
            return Center(child: Text(state.errorMsg));
          }

          return Center(child: Text("No items in your cart."));
        },
      ),
    );
  }

  Widget buildCartItemCard(Map<String, dynamic> item, int index) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(item['item_product_image'],
                        width: 90, height: 120, fit: BoxFit.cover),
                  ),
                  SizedBox(height: 8),
                  TextButton.icon(
                    onPressed: () =>
                        context.read<MyCartCubit>().deleteItem(index),
                    icon:
                        Icon(Icons.delete_outline, color: AppColors.greyColor),
                    label: Text(
                      "Remove",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.greyColor,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['item_product_name'],
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Text(
                          "Author: ",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            color: AppColors.greyColor,
                          ),
                        ),
                        Text(
                          item['item_product_author'] ?? "N/A",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 6),
                    Text(
                      "\$${item['item_product_price_after_discount']}",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "ASIN: ${item['item_product_asin'] ?? 'N/A'}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: AppColors.greyColor,
                      ),
                    ),
                    SizedBox(height: 12),
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.remove_circle_outline,
                              color: AppColors.pinkprimary),
                          onPressed: () => context
                              .read<MyCartCubit>()
                              .decrementQuantity(index),
                          iconSize: 18,
                        ),
                        Text('${item['item_quantity']}',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        IconButton(
                          icon: Icon(Icons.add_circle_outline,
                              color: AppColors.pinkprimary),
                          onPressed: () => context
                              .read<MyCartCubit>()
                              .incrementQuantity(index),
                          iconSize: 18,
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSummarySection(String subtotal) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          summaryTile("Subtotal", "\$$subtotal"),
          summaryTile("Shipping", "Free Delivery"),
          summaryTile("Tax", "\$4"),
          Divider(),
          summaryTile("Total", "\$${computeFinalAmount(subtotal, 4)}",
              highlight: true),
        ],
      ),
    );
  }

  Widget summaryTile(String label, String amount, {bool highlight = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: highlight ? 20 : 14,
              fontWeight: highlight ? FontWeight.w700 : FontWeight.w400,
              color: highlight ? AppColors.blackColor : AppColors.greyColor,
            ),
          ),
          Text(
            amount,
            style: TextStyle(
              fontSize: highlight ? 20 : 14,
              fontWeight: highlight ? FontWeight.w700 : FontWeight.w400,
              color: highlight ? AppColors.pinkprimary : AppColors.greyColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCheckoutBar(List<Map<String, dynamic>> items, String subtotal) {
    return Positioned(
      bottom: 12,
      left: 24,
      right: 24,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(
          color: AppColors.pinkprimary,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${calculateTotalItems(items)} Item",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.whiteColor,
                  ),
                ),
                Text(
                  "\$${computeFinalAmount(subtotal, 4)}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.whiteColor,
                  ),
                ),
              ],
            ),
            Text(
              "Check Out",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.whiteColor),
            ),
            Container(
              height: 32,
              width: 32,
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: IconButton(
                icon: Icon(Icons.arrow_forward,
                    color: AppColors.pinkprimary, size: 16),
                onPressed: () =>
                    Navigator.pushNamed(context, Routes.chechOutScreen),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
