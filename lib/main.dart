import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talabat_like_app/features/cart/controller/bloc_observer.dart';
import 'package:talabat_like_app/features/cart/controller/cart_bloc_controller.dart';
import 'package:talabat_like_app/features/cart/controller/cart_cubit_controller.dart';
import 'package:talabat_like_app/features/home/controller/home_cubit_controller.dart';
import 'package:talabat_like_app/view/page_3.dart';
import 'package:talabat_like_app/view/product_details_screen.dart';
import 'package:talabat_like_app/view/root_screen.dart';

void main() {
  Bloc.observer = BlocObserv();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => CartBlocController()),
        BlocProvider(create: (context) => CartCubitController()),
        BlocProvider(
          create: (context) => HomeCubitController()..loadProducts(),
        ),
      ],

      child: const MyApp(),
    ),
  );
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
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
            scaffoldBackgroundColor: Colors.white,
            appBarTheme: AppBarTheme(
              backgroundColor: Colors.white,
              elevation: 0,
              iconTheme: IconThemeData(color: Colors.black),
            ),
          ),
          title: 'Talabat like app',
          // home: child,
          routes: {
            '/': (context) => RootScreen(),

            ProductDetailsScreen.routeName: (context) => ProductDetailsScreen(),
            Page3Screen.routeName: (context) => Page3Screen(),
          },
        );
      },

      //  child: HomeScreen(),
    );
  }
}
