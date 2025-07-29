
import 'package:bloc/bloc.dart';
import 'package:bookstore_app/core/models/products_models.dart';
import 'package:bookstore_app/features/auth/book/data/repo/fetch_books_repo.dart';
import 'package:meta/meta.dart';

part 'best_seller_state.dart';

class BestSellerCubit extends Cubit<BestSellerState> {
  BestSellerCubit() : super(BestSellerInitial());

  Future<void> fetchBestSellerBooks() async {
    emit(BestSellerLoading());
    try {
      final List<Products> books = await FetchBooksRepo.fetchBestSellerBooks();
      emit(BestSellerSuccess(books));
    } catch (e) {
      emit(BestSellerError("Error fetching books"));
    }
  }
}
