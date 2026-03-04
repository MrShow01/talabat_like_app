import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:talabat_like_app/features/posts/controller/post_cubit.dart';
import 'package:talabat_like_app/features/posts/controller/post_state.dart';

class PostsScreen extends StatelessWidget {
  const PostsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<PostController>().fetchHttpPosts();
        },
        backgroundColor: Colors.black,
        child: Icon(Icons.refresh, color: Colors.white),
      ),
      body: BlocBuilder<PostController, PostState>(
        builder: (context, state) {
          return (state is PostLoading)
              ? LottieBuilder.asset('assets/loading.json')
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      Text('Posts Screen'),
                      if (state is PostLoaded)
                        ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: state.posts.products?.length ?? 0,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(
                                state.posts.products?[index].title ??
                                    'No title',
                              ),
                              subtitle: Text(
                                state.posts.products?[index].description ??
                                    'No description',
                              ),
                            );
                          },
                        ),
                    ],
                  ),
                );
        },
      ),
    );
  }
}
