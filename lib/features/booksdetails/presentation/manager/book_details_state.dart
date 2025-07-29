part of 'book_details_cubit.dart';


@immutable
abstract class BookDetailsState {}

class BookDetailsInitial extends BookDetailsState {}

class BookDetailsLoading extends BookDetailsState {}

class BookDetailsSuccess extends BookDetailsState {
  final Products books;
  BookDetailsSuccess(this.books);
}

class BookDetailsError extends BookDetailsState {
  final String msg;
  BookDetailsError(this.msg);
}
