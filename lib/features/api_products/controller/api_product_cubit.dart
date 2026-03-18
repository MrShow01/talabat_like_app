import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:talabat_like_app/features/api_products/controller/api_product_state.dart';
import 'package:talabat_like_app/features/api_products/model/api_product_model.dart';

class ApiProductCubit extends Cubit<ApiProductState> {
  ApiProductCubit() : super(ApiProductInitial());
  void fetchProducts() async {
    emit(ApiProductLoading());
    // call the api to get the products
    final response = await http.get(
      Uri.parse('https://dummyjson.com/products'),
      headers: {'Accept': 'application/json'},
    );
    // check the status code of the response
    if (response.statusCode == 200) {
      // decode the response body from string to json
      final data = jsonDecode(response.body);
      // create a map of the data and convert it to a list of products
      ProductsResponse productsResponse = ProductsResponse.fromJson(data);
      // emit the loaded state with the list of products
      emit(ApiProductLoaded(productsResponse.products ?? []));
    } else {
      // emit the error state with the error message
      emit(ApiProductError());
    }
  }

  void fetchDioProducts() async {
    emit(ApiProductLoading());
    // call the api to get the products using dio package
    var dio = Dio();
    dio.options.headers['Accept'] = 'application/json';
    dio.options.headers['Content-Type'] = 'application/json';
    // dio.options.headers['Token'] = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE0ODUxNDA5ODQsImlhdCI6MTQ4NTEzNzM4NCwiaXNzIjoiYWNtZS5jb20iLCJzdWIiOiIyOWFjMGMxOC0wYjRhLTQyY2YtODJmYy0wM2Q1NzAzMThhMWQiLCJhcHBsaWNhdGlvbklkIjoiNzkxMDM3MzQtOTdhYi00ZDFhLWFmMzctZTAwNmQwNWQyOTUyIiwicm9sZXMiOltdfQ.Mp0Pcwsz5VECK11Kf2ZZNF_SMKu5CgBeLN9ZOP04kZo';
    dio.options.baseUrl = 'https://dummyjson.com/';
    dio.options.connectTimeout = Duration(seconds: 15); // 15 seconds
    // add a log interceptor to log the request and response
    dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestBody: true,
        responseBody: true,
        requestUrl: true,
        responseUrl: true,
        responseHeader: false,
        requestHeader: false,
      ),
    );
    // make a get request to the api endpoint
    final response = await dio.get('products');
    // check the status code of the response
    if (response.statusCode == 200) {
      // create a map of the data and convert it to a list of products
      ProductsResponse productsResponse = ProductsResponse.fromJson(
        response.data,
      );

      // emit the loaded state with the list of products
      emit(ApiProductLoaded(productsResponse.products ?? []));
    } else {
      // emit the error state with the error message
      emit(ApiProductError());
    }
  }
}
