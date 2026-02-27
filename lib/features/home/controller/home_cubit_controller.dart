import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_ce/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:talabat_like_app/features/home/controller/home_cubit_state.dart';
import 'package:talabat_like_app/features/home/model/hive_product_model.dart';
import 'package:talabat_like_app/features/home/model/product_model.dart';

class HomeCubitController extends Cubit<HomeState> {
  HomeCubitController() : super(HomeInitial());
  List<Products> productsList = [];
  ProductModel? productModel;
  late Database database;
  void loadProducts() async {
    emit(HomeLoading());
    try {
      await openDb();
      // final data = await rootBundle.loadString('assets/products.json');
      // Map<String, dynamic> jsonData = await json.decode(data);
      // productModel = ProductModel.fromJson(jsonData);
      // productsList = productModel?.products ?? [];

      //insertProducts(productsList);
      final response = await database.rawQuery('SELECT * FROM Products');
      Map<String, dynamic> fakeJson = {"products": response};
      // 2. Decode the string into a Map
      //  Map<String, dynamic> data = await json.decode(response);

      // 3. Map to your model
      productModel = ProductModel.fromJson(fakeJson);
      productsList = productModel?.products ?? [];

      emit(HomeLoaded());
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  openDb() async {
    var databasesPath = await getDatabasesPath();
    String path = '$databasesPath/demo.db';
    log(path);
    database = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
          'CREATE TABLE Products (id INTEGER PRIMARY KEY, name TEXT, description TEXT, price INTEGER, rating REAL, category TEXT, ratingsCount INTEGER, image TEXT)',
        );
      },
    );
  }

  insertProduct(Products product) async {
    database.transaction((transaction) async {
      await transaction.insert(
        'Products',
        product.toJson(),

        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    });
  }

  updateProduct(Products product) async {
    database.update(
      'Products',
      {
        "name": product.name,
        "description": product.description,
        "price": product.price,
        "rating": product.rating,
        "ratingsCount": product.ratingsCount,
        "category": product.category,
        "image": product.image,
      },
      where: 'id = ?',
      whereArgs: [product.id],

      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> insertProducts(List<Products> productsList) async {
    final batch = database.batch();

    for (var product in productsList) {
      batch.rawInsert(
        'INSERT INTO Products (id, name, description, price, rating, category, ratingsCount, image) VALUES (?, ?, ?, ?, ?, ?, ?, ?)',
        [
          product.id,
          product.name,
          product.description,
          product.price,
          product.rating,
          product.category,
          product.ratingsCount,
          product.image,
        ],
      );
    }
    batch.commit();
  }

  deleteProducts(int id) async {
    await database.delete('Products', where: 'id = $id');
  }

  savePrice() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble('price', 150.0);
    prefs.setString('String price', 'Hi There');
    prefs.setBool('Bool price', true);
    prefs.setStringList('StringList price', ['item1', 'item2']);
  }

  getSavedPrice() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    double? price = prefs.getDouble('price');
    String? stringPrice = prefs.getString('String price');
    bool? boolPrice = prefs.getBool('Bool price');
    List<String>? stringListPrice = prefs.getStringList('StringList price');
    // prefs.remove('price');

    prefs.getKeys().forEach((key) {
      log('Key: $key');
    });
    log(price?.toString() ?? 'No price saved');
    log(stringPrice ?? 'No string price saved');
    log(boolPrice?.toString() ?? 'No bool price saved');
    log(stringListPrice?.toString() ?? 'No string list price saved');
  }

  hiveTest() async {
    // await Hive.openBox('myBox');
    await Hive.openBox<Product>('productsBox');
    final box = Hive.box<Product>('productsBox');
    // box.put('name', 'David');
    box.put(
      'product',
      Product(
        id: 1,
        name: 'Product 1',
        description: 'Description of Product 1',
        price: 100,
        rating: 4.5,
        category: 'Category 1',
        ratingsCount: 10,
        image: 'https://example.com/product1.jpg',
      ),
    );
    final product = box.get('product');
    log('Product Name: ${product?.image}');
    // box.put('price', 150.0);
    // box.put('isAvailable', true);
    // box.put('tags', ['tag1', 'tag2']);
    // final name = box.get('name');
    // final price = box.get('price');
    // final isAvailable = box.get('isAvailable');
    // final tags = box.get('tags');

    // log('Name: $name');
    // log('Price: $price');
    // log('Is Available: $isAvailable');
    // log('Tags: $tags');
  }
}
