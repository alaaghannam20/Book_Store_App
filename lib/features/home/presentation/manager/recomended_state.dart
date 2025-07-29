

part of 'recomended_cubit.dart';

@immutable
abstract class RecomendedState {}

class RecomendedInitial extends RecomendedState {}

class RecomendedLoading extends RecomendedState {}

class RecomendedSuccess extends RecomendedState {
  final List<Products> books;

  RecomendedSuccess(this.books);
}

class RecomendedError extends RecomendedState {
  final String msg;

  RecomendedError(this.msg);
}
