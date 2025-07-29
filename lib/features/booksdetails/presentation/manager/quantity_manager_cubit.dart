import 'package:bloc/bloc.dart';

class QuantityManagerCubit extends Cubit<int> {
  QuantityManagerCubit() : super(1);

  void add() {
    emit(state + 1);
  }

  void subtract() {
    if (state > 1) {
      emit(state - 1);
    }
  }
}
