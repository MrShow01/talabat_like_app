import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talabat_like_app/features/splash/cubit/splash_cubit.dart';
import 'package:talabat_like_app/features/splash/cubit/splash_state.dart';
import 'package:talabat_like_app/view/root_screen.dart';

class SplashScreen extends StatelessWidget {
  static const routeName = '/splash-screen';
  const SplashScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashCubit(),

      child: BlocConsumer<SplashCubit, SplashState>(
        listener: (context, state) {
          if (state is SplashSuccess) {
            Navigator.pushReplacementNamed(context, RootScreen.routeName);
          }
        },
        builder: (context, state) {
          return Scaffold(body: Center(child: Text('Splash Screen')));
        },
      ),
    );
  }
}
