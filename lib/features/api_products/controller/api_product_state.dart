import 'package:talabat_like_app/features/api_products/model/api_product_model.dart';

abstract class ApiProductState {}

class ApiProductInitial extends ApiProductState {}

class ApiProductLoading extends ApiProductState {}

// this state will hold the list of products that were loaded successfully
class ApiProductLoaded extends ApiProductState {
  // the list of products that were loaded successfully
  final List<Products> products;

  ApiProductLoaded(this.products);
}

class ApiProductError extends ApiProductState {}
