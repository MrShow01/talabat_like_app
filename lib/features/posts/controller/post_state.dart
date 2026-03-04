import 'package:talabat_like_app/features/posts/model/post_model.dart';

abstract class PostState {}

class PostInitial extends PostState {}

class PostLoading extends PostState {}

class PostError extends PostState {
  final String errorMessage;
  PostError(this.errorMessage);
}

class PostLoaded extends PostState {
  final ProductsResponse posts;

  PostLoaded(this.posts);
}
