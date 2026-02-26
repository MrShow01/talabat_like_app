import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:talabat_like_app/features/home/controller/home_cubit_controller.dart';
import 'package:talabat_like_app/features/home/controller/home_cubit_state.dart';
import 'package:talabat_like_app/features/home/view/widgets/home_food_card_widget.dart';
import 'package:talabat_like_app/shared_widgets/my_location_widget.dart';
import 'package:talabat_like_app/view/product_details_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final TextEditingController searchController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isVisible = true;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubitController, HomeState>(
      builder: (context, state) {
        final homeCubit = BlocProvider.of<HomeCubitController>(context);
        return Scaffold(
          backgroundColor: Colors.white,
          body: (state is HomeLoading)
              ? Center(child: LottieBuilder.asset('assets/loading.json'))
              : SafeArea(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 16,
                        children: [
                          MyLocationWidget(),
                          StatefulBuilder(
                            builder: (context, setState) {
                              return Form(
                                key: formKey,
                                child: TextFormField(
                                  controller: searchController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please search for your favorite food';
                                    }
                                    if (value.length < 3) {
                                      return 'Search must be at least 3 characters';
                                    }
                                    return null;
                                  },
                                  obscureText: isVisible,
                                  onChanged: (value) {
                                    log(value);
                                  },
                                  decoration: InputDecoration(
                                    fillColor: Color(0xffFDF8F8),
                                    filled: true,
                                    focusColor: Color(0xffF55540),

                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(35),
                                      borderSide: BorderSide(
                                        color: Color(0xffF55540),
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(35),
                                      borderSide: BorderSide(
                                        color: Color(0xffF55540),
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(35),
                                      borderSide: BorderSide(
                                        color: Color(0xffF55540),
                                      ),
                                    ),

                                    hintText: 'Search for your favorite food',
                                    hintStyle: TextStyle(
                                      color: Color(0xffFCCAC4),
                                      fontWeight: FontWeight.w400,
                                    ),
                                    suffixIcon: InkWell(
                                      onTap: () {
                                        setState(() {
                                          isVisible = !isVisible;
                                        });
                                      },
                                      child: Icon(
                                        isVisible
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: Color(0xffF55540),
                                      ),
                                    ),
                                    //  labelText: 'Search',
                                    prefixIconConstraints: BoxConstraints(
                                      minWidth: 60,
                                      maxHeight: 60,
                                      maxWidth: 60,
                                      minHeight: 60,
                                    ),
                                    prefixIcon: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                      ),
                                      child: Image.asset('assets/search.png'),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                          /*
                                             Image.asset('assets/search.png', width: 28, height: 28),
                              Text(
                                'What are you looking for ?',
                                style: TextStyle(
                                  color: Color(0xffFCCAC4),
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                                             */
                          Row(
                            spacing: 8,
                            children: [
                              Expanded(
                                child: Column(
                                  spacing: 8,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        // Navigator.of(
                                        //   context,
                                        // ).pushNamed(ProductDetailsScreen.routeName);
                                        // Navigator.of(context).pushReplacementNamed(
                                        //   ProductDetailsScreen.routeName,
                                        // );
                                        // Navigator.of(context).pushNamedAndRemoveUntil(
                                        //   ProductDetailsScreen.routeName,
                                        //   (route) => false,
                                        // );
                                        // Navigator.of(context).push(
                                        //   MaterialPageRoute(
                                        //     builder: (context) => ProductDetailsScreen(),
                                        //   ),
                                        // );
                                        //   Navigator.pop(context);
                                        // Navigator.of(context).pushReplacement(
                                        //   MaterialPageRoute(
                                        //     builder: (context) => ProductDetailsScreen(),
                                        //   ),
                                        // );
                                        // Navigator.of(context).pushAndRemoveUntil(
                                        //   MaterialPageRoute(
                                        //     builder: (context) => ProductDetailsScreen(),
                                        //   ),
                                        //   (route) => false,
                                        // );
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Color(0xffF55540),
                                          borderRadius: BorderRadius.circular(
                                            16,
                                          ),
                                        ),
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 8,
                                        ),
                                        child: Image.asset(
                                          'assets/burger.png',
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      'Burger',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  spacing: 8,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Color(0xffFCCAC4),
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 8,
                                      ),
                                      child: Image.asset(
                                        'assets/chicken.png',
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    Text(
                                      'Chicken',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  spacing: 8,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ProductDetailsScreen(),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Color(0xff00A991),
                                          borderRadius: BorderRadius.circular(
                                            16,
                                          ),
                                        ),
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 8,
                                        ),
                                        child: Image.asset(
                                          'assets/sea-food.png',
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      'Sea Food',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  spacing: 8,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Color(0xffB0E4DD),
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 8,
                                      ),
                                      child: Image.asset(
                                        'assets/meat.png',
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    Text(
                                      'Meat',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Image.asset('assets/banner.png'),
                          ),

                          Text(
                            'Trending 🔥🔥',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          GridView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: homeCubit.productsList.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio: 0.6,
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 16,
                                  crossAxisSpacing: 16,
                                ),
                            itemBuilder: (context, index) {
                              return HomeFoodCardWidget(
                                product: homeCubit.productsList[index],
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
        );
      },
    );
  }
}
