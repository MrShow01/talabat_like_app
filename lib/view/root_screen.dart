import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talabat_like_app/features/add_product/view/add_product_screen.dart';
import 'package:talabat_like_app/features/cart/view/cart_screen.dart';
import 'package:talabat_like_app/features/home/controller/home_cubit_controller.dart';
import 'package:talabat_like_app/features/home/view/home_screen.dart';
import 'package:talabat_like_app/view/category_list.dart';
import 'package:talabat_like_app/view/drag_playground_screen.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  List<Widget> screens = [
    HomeScreen(),
    DragPlaygroundScreen(),
    CategoryList(),
    CartPage(),
  ];
  int currentIndex = 0;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],

      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      resizeToAvoidBottomInset: true,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
            onPressed: () async {
              context.read<HomeCubitController>().savePrice();
            },
            child: Text('save price', style: TextStyle(color: Colors.white)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
            onPressed: () async {
              context.read<HomeCubitController>().hiveTest();
            },
            child: Text('Get price', style: TextStyle(color: Colors.white)),
          ),
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddProductScreen()),
              ).whenComplete(
                () => context.read<HomeCubitController>().loadProducts(),
              );
            },
            backgroundColor: Colors.black,
            child: Icon(Icons.add, color: Colors.white),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        elevation: 5,
        currentIndex: currentIndex,

        onTap: (index) {
          log(index.toString());
          setState(() {
            currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.drag_handle), label: 'Drag'),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Category',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
        ],
      ),
    );
  }

  Future<void> loading() async {
    setState(() {
      isLoading = true;
    });
    await Future.delayed(Duration(seconds: 5)).whenComplete(() {
      log('delayed');
    });
    try {
      double result;
      dynamic a = 'a';
      result = 1 / a;
      log(result.toString());
    } catch (e) {
      log(e.toString());
    }
    log('after delayed');
    setState(() {
      isLoading = false;
    });
  }

  // Future<void> printSomething() async {
  //   setState(() {
  //     isLoading = true;
  //   });
  //   try {
  //     await Future.delayed(Duration(seconds: 5)).whenComplete(() {
  //       log('delayed');
  //       double result;
  //       dynamic a = 'a';
  //       result = 1 / a;
  //       log(result.toString());
  //     });
  //   } catch (e) {
  //     log(e.toString());
  //   }

  //   setState(() {
  //     isLoading = false;
  //   });
  // }
}
