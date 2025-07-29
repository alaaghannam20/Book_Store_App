part of 'my_cart_cubit.dart';

@immutable
sealed class MyCartState {
  const MyCartState();
}

class MyCartStart extends MyCartState {
  const MyCartStart();
}

class MyCartLoading extends MyCartState {
  const MyCartLoading();
}

class MyCartSuccess extends MyCartState {
  final String msg;
  final List<int> cartContent;

  const MyCartSuccess({
    required this.msg,
    required this.cartContent,
  });
}

class MyCartError extends MyCartState {
  final String errorMsg;
  const MyCartError({required this.errorMsg});
}

class  CartAccessDenied extends MyCartState {
  final String errorMsg;
  const CartAccessDenied({required this.errorMsg});
}

class CartDetailsLoaded extends MyCartState {
  final String msg;
  final List<Map<String, dynamic>> products;
  final String totalCost;

  const CartDetailsLoaded({
    required this.msg,
    required this.products,
    required this.totalCost,
  });
}

