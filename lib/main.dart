import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talabat_like_app/view/product_details_screen.dart';
import 'package:talabat_like_app/view/root_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,

      builder: (_, child) {
        return MaterialApp(
          title: 'Talabat like app',
          // home: child,
          routes: {
            '/': (context) => RootScreen(),

            ProductDetailsScreen.routeName: (context) => ProductDetailsScreen(),
          },
        );
      },

      //  child: HomeScreen(),
    );
  }
}
