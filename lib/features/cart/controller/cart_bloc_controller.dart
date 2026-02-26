import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talabat_like_app/features/cart/controller/cart_bloc_event.dart';

class CartBlocController extends Bloc<CounterEvent, int> {
  CartBlocController() : super(0) {
    on<CounterIncrement>((event, emit) {
      itemCount++;
      totalPrice = itemCount * 10.0;
      emit(state + 1);
    });
    on<CounterDecrement>((event, emit) {
      if (state == 0) return;
      emit(state - 1);
    });
    on<CounterReset>((event, emit) => emit(0));
  }
  int itemCount = 1;
  double totalPrice = 0.0;
}
