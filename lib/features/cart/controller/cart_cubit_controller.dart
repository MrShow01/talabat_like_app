import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talabat_like_app/features/cart/controller/cart_cubit_state.dart';

class CartCubitController extends Cubit<CartState> {
  CartCubitController() : super(CartInitial());
  int itemCount = 1;
  double totalPrice = 0.0;

  void increment() {
    emit(CartLoading());
    Future.delayed(Duration(seconds: 1), () {
      itemCount++;
      totalPrice = itemCount * 10.0;
      if (itemCount > 10) {
        emit(CartError('Maximum quantity is 10'));
        return;
      }
      emit(CartSuccess(itemCount, totalPrice));
    });
  }

  void decrement() {
    if (itemCount > 1) {
      emit(CartLoading());
      Future.delayed(Duration(seconds: 1), () {
        itemCount--;
        totalPrice = itemCount * 10.0;
        if (itemCount > 10) {
          emit(CartError('Maximum quantity is 10'));
          return;
        }
        emit(CartSuccess(itemCount, totalPrice));
      });
    }
  }
}
