import 'dart:developer';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:talabat_like_app/features/splash/cubit/splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial()) {
    initApp();
    getFCMToken();
  }

  void initApp() {
    emit(SplashLoading());
    Future.delayed(const Duration(seconds: 3)).then((value) {
      emit(SplashSuccess());
    });
  }

  void getFCMToken() async {
    if (Platform.isIOS) {
      await FirebaseMessaging.instance.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );
      String? token = await FirebaseMessaging.instance.getAPNSToken();
      log(token.toString());
    } else {
      await Permission.notification.request();
      String? token = await FirebaseMessaging.instance.getToken();
      log(token.toString());
    }
  }
}
