import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talabat_like_app/features/cart/controller/cart_cubit_state.dart';
import 'package:talabat_like_app/features/home/model/hive_product_model.dart';

class CartCubitController extends Cubit<CartState> {
  CartCubitController() : super(CartInitial());
  int itemCount = 1;
  double totalPrice = 0.0;
  double savedTotalPrice = 0.0;

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

  savePrice() async {
    // Save totalPrice to local storage or database
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final product = Product(
      id: 1,
      name: 'Product 1',
      description: 'Description of Product 1',
      price: totalPrice.toInt(),
      rating: 4.5,
      category: 'Category 1',
      ratingsCount: 10,
      image: 'https://example.com/product1.jpg',
    );
    await prefs.setInt('id', product.id ?? 0);
    await prefs.setString('name', product.name ?? '');
    await prefs.setString('description', product.description ?? '');
    await prefs.setInt('price', product.price ?? 0);
    await prefs.setDouble('rating', product.rating ?? 0.0);
    await prefs.setString('category', product.category ?? '');
    await prefs.setInt('ratingsCount', product.ratingsCount ?? 0);
    await prefs.setString('image', product.image ?? '');
    // log('Price saved: $totalPrice');
    // await Hive.openBox('totalPriceBox');
    // var box = Hive.box('totalPriceBox');
    // box.put('totalPrice', totalPrice);
    // log('Price saved: $totalPrice');
    // await Hive.openBox<Product>('productsBox');
    // final box = Hive.box<Product>('productsBox');
    // box.put('name', 'David');
    // box.put(
    //   'product',
    //   Product(
    //     id: 1,
    //     name: 'Product 1',
    //     description: 'Description of Product 1',
    //     price: 200,
    //     rating: 4.5,
    //     category: 'Category 1',
    //     ratingsCount: 10,
    //     image: 'https://example.com/product1.jpg',
    //   ),
    // );
  }

  getPrice() async {
    // Retrieve totalPrice from local storage or database
    Product product = Product();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    product.id = prefs.getInt('id');
    product.name = prefs.getString('name');
    product.description = prefs.getString('description');
    product.price = prefs.getInt('price');
    product.rating = prefs.getDouble('rating');
    product.category = prefs.getString('category');
    product.ratingsCount = prefs.getInt('ratingsCount');
    product.image = prefs.getString('image');

    // String? savedString = prefs.getString('totalPrice');
    // savedTotalPrice = savedString ?? '';
    // emit(CartSuccess(itemCount, totalPrice));
    // await Hive.openBox<Product>('productsBox');
    // final box = Hive.box<Product>('productsBox');
    // final product = box.get('product');
    // savedTotalPrice = product?.price?.toDouble() ?? 0.0;
    // emit(CartSuccess(itemCount, savedTotalPrice));
    // await Hive.openBox('totalPriceBox');
    // var box = Hive.box('totalPriceBox');
    // double? savedPrice = box.get('totalPrice');
    // if (savedPrice != null) {
    //   savedTotalPrice = savedPrice;
    //   log('Price retrieved: $savedTotalPrice');
    //   emit(CartSuccess(itemCount, savedTotalPrice));
    // } else {
    //   log('No price found');
    //   emit(CartError('No price found'));
    // }
  }
}
