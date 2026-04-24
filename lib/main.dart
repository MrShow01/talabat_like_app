import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_ce_flutter/adapters.dart';
import 'package:talabat_like_app/features/api_products/controller/api_product_cubit.dart';
import 'package:talabat_like_app/features/cart/controller/bloc_observer.dart';
import 'package:talabat_like_app/features/cart/controller/cart_bloc_controller.dart';
import 'package:talabat_like_app/features/cart/controller/cart_cubit_controller.dart';
import 'package:talabat_like_app/features/home/controller/home_cubit_controller.dart';
import 'package:talabat_like_app/features/home/model/hive_product_model.g.dart';
import 'package:talabat_like_app/features/login/controller/login_cubit.dart';
import 'package:talabat_like_app/features/login/screens/login_screen.dart';
import 'package:talabat_like_app/features/posts/controller/post_cubit.dart';
import 'package:talabat_like_app/features/splash/cubit/notification_service.dart';
import 'package:talabat_like_app/features/splash/splash_screen.dart';
import 'package:talabat_like_app/firebase_options.dart';
import 'package:talabat_like_app/register/controller/register_cubit.dart';
import 'package:talabat_like_app/register/screens/register_screen.dart';
import 'package:talabat_like_app/view/page_3.dart';
import 'package:talabat_like_app/view/product_details_screen.dart';
import 'package:talabat_like_app/view/root_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Bloc.observer = BlocObserv();

  await Hive.initFlutter();

  Hive.registerAdapter(ProductAdapter());

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => CartBlocController()),
        BlocProvider(create: (context) => CartCubitController()),
        BlocProvider(create: (context) => LoginCubit()),
        BlocProvider(create: (context) => RegisterCubit()),

        BlocProvider(
          create: (context) => HomeCubitController()..loadProducts(),
        ),
        BlocProvider(create: (context) => PostController()..fetchPosts()),
        BlocProvider(
          create: (context) => ApiProductCubit()..fetchDioProducts(),
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
          navigatorKey: NotificationService.navigatorKey,
          // home: child,
          routes: {
            '/': (context) => SplashScreen(),
            SplashScreen.routeName: (context) => SplashScreen(),

            ProductDetailsScreen.routeName: (context) => ProductDetailsScreen(),
            RootScreen.routeName: (context) => RootScreen(),
            LoginScreen.routeName: (context) => LoginScreen(),
            RegisterScreen.routeName: (context) => RegisterScreen(),
            Page3Screen.routeName: (context) => Page3Screen(),
          },
        );
      },

      //  child: HomeScreen(),
    );
  }
}
