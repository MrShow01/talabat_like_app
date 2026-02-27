import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:talabat_like_app/features/home/controller/home_cubit_state.dart';
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

        conflictAlgorithm: ConflictAlgorithm.ignore,
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
}
