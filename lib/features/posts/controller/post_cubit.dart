import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:talabat_like_app/features/posts/controller/post_state.dart';
import 'package:talabat_like_app/features/posts/model/post_model.dart';

class PostController extends Cubit<PostState> {
  PostController() : super(PostInitial());

  void fetchPosts() async {
    var headers = {'Accept': 'application/json'};
    var dio = Dio();
    var response = await dio.get(
      'https://dummyjson.com/products',
      options: Options(headers: headers),
    );
    log(response.statusCode.toString());
    log(response.data.toString());
    // create a map of the data and convert it to a list of posts
    ProductsResponse posts = ProductsResponse.fromJson(response.data);

    if (response.statusCode == 200) {
      emit(PostLoaded(posts));
    } else {
      emit(PostError('Failed to load posts'));
    }
  }

  void fetchHttpPosts() async {
    var headers = {'Accept': 'application/json'};

    final response = await http.get(
      Uri.parse('http://jsonplaceholder.typicode.com/posts'),
      headers: headers,
    );
    log(response.statusCode.toString());
    log(response.body);
    var data = jsonDecode(response.body);
    // create a map of the data and convert it to a list of posts
    ProductsResponse posts = ProductsResponse.fromJson(data);

    if (response.statusCode == 200) {
      emit(PostLoaded(posts));
    } else {
      emit(PostError('Failed to load posts'));
    }
  }
}
