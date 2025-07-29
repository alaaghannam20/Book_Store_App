
import 'package:bloc/bloc.dart';
import 'package:bookstore_app/core/models/products_models.dart';
import 'package:meta/meta.dart';
import 'package:bookstore_app/features/booksdetails/data/repo/book_details_repo.dart';
part 'book_details_state.dart';

class BookDetailsCubit extends Cubit<BookDetailsState> {
  BookDetailsCubit() : super(BookDetailsInitial());

  Future<void> loadBookInfo(int bookId) async {
    emit(BookDetailsLoading());
    try {
      final details = await BookDetailsRepo.getBookDetails(bookId);
      emit(BookDetailsSuccess(details));
    } catch (error) {
      emit(BookDetailsError(error.toString()));
    }
  }
}