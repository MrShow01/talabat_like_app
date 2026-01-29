import 'dart:developer';

import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final TextEditingController searchController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isVisible = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 16,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xff111c3033),
                            spreadRadius: 0,
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.asset(
                          'assets/person.png',
                          height: 80,
                          width: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Current location',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),

                            Image.asset('assets/location.png'),
                          ],
                        ),
                        Text(
                          '19 Golf Street Naser City, Cairo Egypt',
                          style: TextStyle(
                            fontSize: 15,
                            color: Color(0xff515151),
                          ),
                        ),
                      ],
                    ),
                    Image.asset(
                      'assets/notification.png',
                      height: 40,
                      width: 40,
                    ),
                  ],
                ),
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
                            borderSide: BorderSide(color: Color(0xffF55540)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(35),
                            borderSide: BorderSide(color: Color(0xffF55540)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(35),
                            borderSide: BorderSide(color: Color(0xffF55540)),
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
                            padding: const EdgeInsets.symmetric(horizontal: 16),
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
                          Container(
                            decoration: BoxDecoration(
                              color: Color(0xffF55540),
                              borderRadius: BorderRadius.circular(16),
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
                          Text('Burger', style: TextStyle(fontSize: 16)),
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
                          Text('Chicken', style: TextStyle(fontSize: 16)),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        spacing: 8,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Color(0xff00A991),
                              borderRadius: BorderRadius.circular(16),
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
                          Text('Sea Food', style: TextStyle(fontSize: 16)),
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
                          Text('Meat', style: TextStyle(fontSize: 16)),
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
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Row(
                  spacing: 16,
                  children: [
                    Expanded(
                      child: Column(
                        spacing: 8,
                        children: [
                          Container(
                            width: double.infinity,
                            height: 150,
                            decoration: BoxDecoration(
                              color: Color(0xffFEEEEC),
                              borderRadius: BorderRadius.circular(16),
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Column(
                                spacing: 4,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Sea Food',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Row(
                                    spacing: 8,
                                    children: [
                                      Image.asset(
                                        'assets/burger-icon.png',
                                        width: 20,
                                        height: 20,
                                      ),
                                      Text(
                                        'Fast Food',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xff868686),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    spacing: 8,
                                    children: [
                                      Image.asset(
                                        'assets/star.png',
                                        width: 20,
                                        height: 20,
                                      ),
                                      Text(
                                        '5.0 (+500)',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    '150 L.E',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Color(0xff868686),
                                    ),
                                  ),
                                ],
                              ),
                              IconButton(
                                style: ButtonStyle(
                                  backgroundColor: WidgetStatePropertyAll(
                                    Color(0xffF55540),
                                  ),

                                  shape: WidgetStatePropertyAll(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(8),
                                        bottomLeft: Radius.circular(8),
                                      ),
                                    ),
                                  ),

                                  padding: WidgetStatePropertyAll(
                                    EdgeInsets.all(10),
                                  ),
                                  minimumSize: WidgetStatePropertyAll(
                                    Size(0, 0),
                                  ),
                                ),
                                onPressed: () {},
                                icon: Image.asset(
                                  'assets/cart.png',
                                  height: 28,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        spacing: 8,
                        children: [
                          Container(
                            width: double.infinity,
                            height: 150,
                            decoration: BoxDecoration(
                              color: Color(0xffFEEEEC),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            padding: EdgeInsets.all(8),
                            child: Image.asset(
                              'assets/sea-food.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Column(
                                spacing: 4,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Sea Food',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Row(
                                    spacing: 8,
                                    children: [
                                      Image.asset(
                                        'assets/burger-icon.png',
                                        width: 20,
                                        height: 20,
                                      ),
                                      Text(
                                        'Fast Food',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xff868686),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    spacing: 8,
                                    children: [
                                      Image.asset(
                                        'assets/star.png',
                                        width: 20,
                                        height: 20,
                                      ),
                                      Text(
                                        '5.0 (+500)',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    '150 L.E',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Color(0xff868686),
                                    ),
                                  ),
                                ],
                              ),
                              ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: WidgetStatePropertyAll(
                                    Color(0xffF55540),
                                  ),

                                  shape: WidgetStatePropertyAll(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(8),
                                        bottomLeft: Radius.circular(8),
                                      ),
                                    ),
                                  ),

                                  padding: WidgetStatePropertyAll(
                                    EdgeInsets.all(10),
                                  ),
                                  minimumSize: WidgetStatePropertyAll(
                                    Size(0, 0),
                                  ),
                                ),
                                onPressed: () {},
                                child: Image.asset(
                                  'assets/cart.png',
                                  height: 28,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          formKey.currentState!.validate();
        },
        backgroundColor: Colors.black,
        child: Icon(Icons.search, color: Colors.white),
      ),
    );
  }
}
