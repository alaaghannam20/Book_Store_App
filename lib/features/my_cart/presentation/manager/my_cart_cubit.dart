import 'package:bookstore_app/features/my_cart/data/my_cart_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'my_cart_state.dart';

class MyCartCubit extends Cubit<MyCartState> {
  final MyCartRepo repo;
  final BuildContext context;

  MyCartCubit(this.repo, this.context) : super(const MyCartStart());

  Future<void> addProductToCart(int prodId, int amount) async {
    emit(const MyCartLoading());

    final response = await repo.addItemToCart(id: prodId, qty: amount);

    if (response['success'] == true) {
      List<int> items = [];

      if (state is MyCartSuccess) {
        items = List.from((state as MyCartSuccess).cartContent);
      }

      items.add(prodId);

      emit(MyCartSuccess(
        msg: response['message'],
        cartContent: items,
      ));
    } else {
      emit(MyCartError(errorMsg: response['message']));
    }
  }

  Future<void> loadCartData() async {
    emit(const MyCartLoading());

    final output = await repo.fetchCartContents();

    if (output['success'] == true) {
      final cartBody = output['data'] as Map<String, dynamic>;
      final productsList = (cartBody['cart_items'] as List)
          .map((e) => e as Map<String, dynamic>)
          .toList();

      emit(CartDetailsLoaded(
        msg: output['message'],
        products: productsList,
        totalCost: cartBody['total'].toString(),
      ));
    } else if ((output['error'] as List).contains('Unauthorized')) {
      emit(CartAccessDenied(errorMsg: output['message']));
    } else {
      emit(MyCartError(errorMsg: output['message']));
    }
  }

  void incrementQuantity(int i) {
    if (state is CartDetailsLoaded) {
      final curr = (state as CartDetailsLoaded);
      List<Map<String, dynamic>> freshList = List.from(curr.products);

      int currentQty = int.tryParse(freshList[i]['item_quantity'].toString()) ?? 1;
      freshList[i]['item_quantity'] = currentQty + 1;

      double unitPrice = double.tryParse(
              freshList[i]['item_product_price_after_discount'].toString()) ??
          0;
      freshList[i]['item_total'] =
          ((currentQty + 1) * unitPrice).toStringAsFixed(2);

      String updatedTotal = _calculateTotal(freshList).toStringAsFixed(2);

      emit(CartDetailsLoaded(
        msg: "Item quantity increased",
        products: freshList,
        totalCost: updatedTotal,
      ));
    }
  }

  void decrementQuantity(int i) {
    if (state is CartDetailsLoaded) {
      final curr = (state as CartDetailsLoaded);
      List<Map<String, dynamic>> tempList = List.from(curr.products);

      int currentQty = int.tryParse(tempList[i]['item_quantity'].toString()) ?? 1;

      if (currentQty > 1) {
        tempList[i]['item_quantity'] = currentQty - 1;

        double unitPrice = double.tryParse(
                tempList[i]['item_product_price_after_discount'].toString()) ?? 0;
            
        tempList[i]['item_total'] =
            ((currentQty - 1) * unitPrice).toStringAsFixed(2);

        String newTotal = _calculateTotal(tempList).toStringAsFixed(2);

        emit(CartDetailsLoaded(
          msg: "Item quantity decreased",
          products: tempList,
          totalCost: newTotal,
        ));
      }
    }
  }

  void deleteItem(int i) {
    if (state is CartDetailsLoaded) {
      final s = (state as CartDetailsLoaded);
      List<Map<String, dynamic>> clone = List.from(s.products)..removeAt(i);

      String total = _calculateTotal(clone).toStringAsFixed(2);

      emit(CartDetailsLoaded(
        msg: "Item removed from cart",
        products: clone,
        totalCost: total,
      ));
    }
  }

  double _calculateTotal(List<Map<String, dynamic>> items) {
    double total = 0;
    for (var item in items) {
      total += double.tryParse(item['item_total'].toString()) ?? 0;
    }
    return total;
  }
}
