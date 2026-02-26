abstract class CartState {}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartSuccess extends CartState {
  final int itemCount;
  final double totalPrice;

  CartSuccess(this.itemCount, this.totalPrice);
}

class CartError extends CartState {
  final String message;

  CartError(this.message);
}
