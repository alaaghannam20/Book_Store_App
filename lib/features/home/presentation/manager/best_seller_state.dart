
part of 'best_seller_cubit.dart';

@immutable
abstract class BestSellerState {}

class BestSellerInitial extends BestSellerState {}

class BestSellerLoading extends BestSellerState {}

class BestSellerSuccess extends BestSellerState {
  final List<Products> books;

  BestSellerSuccess(this.books);
}

class BestSellerError extends BestSellerState {
  final String msg;

  BestSellerError(this.msg);
}