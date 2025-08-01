import 'package:bloc/bloc.dart';
import 'package:bookstore_app/core/models/products_models.dart';
import 'package:bookstore_app/core/services/networking/dio_factory.dart';
import 'package:meta/meta.dart';


part 'recomended_state.dart';


class RecommendedCubit extends Cubit<RecomendedState> {
  RecommendedCubit() : super(RecomendedInitial());

  Future<void> fetchRecommendedBooks({int? limit}) async {
    emit(RecomendedLoading());

    try {
      final response = await DioFactory.getRequest(url: 'products');

      if (response?.statusCode == 200 &&
          response?.data['data']?['products'] != null) {
        var allBooks = (response!.data['data']['products'] as List)
        .map((e) => Products.fromJson(e))
        .toList();

       final books = limit != null ? allBooks.take(limit).toList() : allBooks;

        emit(RecomendedSuccess(books));
      } else {
        emit(RecomendedError('Failed to fetch recommended books.'));
      }
    } catch (e) {
      emit(RecomendedError(e.toString()));
    }
  }
}
