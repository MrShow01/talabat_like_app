import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:talabat_like_app/features/api_products/controller/api_product_cubit.dart';
import 'package:talabat_like_app/features/api_products/controller/api_product_state.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // use the bloc builder to build the ui based on the state of the bloc
    return BlocBuilder<ApiProductCubit, ApiProductState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: const Text('Products')),
          // show a loading indicator while the products are being loaded
          body: (state is ApiProductLoading)
              ? Center(child: Lottie.asset('assets/loading.json'))
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        // show an error message if there was an error loading the products
                        if (state is ApiProductError)
                          Center(
                            child: const Text(
                              'Failed to load products',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        // show the list of products if they were loaded successfully
                        if (state is ApiProductLoaded)
                          GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 0.65,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                ),
                            itemBuilder: (context, index) {
                              return Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    color: Colors.grey.shade300,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.shade200,
                                      blurRadius: 5,
                                      offset: const Offset(0, 5),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    // show the product image with a loading indicator while the image is being loaded
                                    Image.network(
                                      state.products[index].thumbnail ?? '',
                                      loadingBuilder:
                                          (
                                            context,
                                            child,
                                            loadingProgress,
                                          ) => loadingProgress == null
                                          ? child
                                          : Center(
                                              // show a circular progress indicator while the image is being loaded
                                              child: CircularProgressIndicator(
                                                value:
                                                    loadingProgress
                                                            .expectedTotalBytes !=
                                                        null
                                                    ? loadingProgress
                                                              .cumulativeBytesLoaded /
                                                          loadingProgress
                                                              .expectedTotalBytes!
                                                    : null,
                                              ),
                                            ),
                                    ),
                                    // show the product title, description, and price
                                    Text(
                                      state.products[index].title ?? '',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    // show the product description with a maximum of 2 lines and an ellipsis if the description is too long
                                    Text(
                                      state.products[index].description ?? '',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    // show the product price
                                    Text(
                                      state.products[index].price.toString(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            // set the number of items in the grid to the number of products
                            itemCount: state.products.length,
                            shrinkWrap: true,
                            // disable scrolling for the grid view since it's inside a single child scroll view
                            physics: NeverScrollableScrollPhysics(),
                          ),
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }
}
