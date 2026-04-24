import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:talabat_like_app/features/splash/splash_screen.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessageBackgroundHandle(RemoteMessage message) async {
  log("BackGround Message :: ${message.from}");
}

class NotificationService {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  initInfo() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions();

    var request = await FirebaseMessaging.instance.requestPermission();

    if (request.authorizationStatus == AuthorizationStatus.authorized ||
        request.authorizationStatus == AuthorizationStatus.provisional) {
      const AndroidInitializationSettings initializationSettingsAndroid =
          AndroidInitializationSettings('@mipmap/ic_launcher');
      var iosInitializationSettings = const DarwinInitializationSettings();
      final InitializationSettings initializationSettings =
          InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: iosInitializationSettings,
          );

      await flutterLocalNotificationsPlugin.initialize(
        onDidReceiveNotificationResponse: (payload) {
          log("::::::::onDidReceiveNotificationResponse:::::::::::");
          log(payload.payload.toString());
          log(payload.notificationResponseType.toString());

          navigatorKey.currentState?.pushNamed(SplashScreen.routeName);
        },
        settings: initializationSettings,
        onDidReceiveBackgroundNotificationResponse: (payload) {
          log("::::::::onDidReceiveBackgroundNotificationResponse:::::::::::");
          log(payload.payload.toString());
        },
      );
      setupInteractedMessage();
    }
  }

  Future<void> setupInteractedMessage() async {
    //  await FirebaseMessaging.instance.subscribeToTopic("your_topic_name");
    RemoteMessage? initialMessage = await FirebaseMessaging.instance
        .getInitialMessage();
    if (initialMessage != null) {
      FirebaseMessaging.onBackgroundMessage(
        (message) => firebaseMessageBackgroundHandle(message),
      );
    }

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log("::::::::::::onMessage:::::::::::::::::");
      if (message.notification != null) {
        log(message.notification.toString());
        log(message.notification!.title.toString());
        log(message.notification!.body.toString());

        display(message);
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      log("::::::::::::onMessageOpenedApp:::::::::::::::::");
      if (message.notification != null) {
        log(message.notification.toString());
        log(message.notification!.title.toString());
        log(message.notification!.body.toString());

        log("::::::::::::onMessageOpenedApp:::::::::::::::::");
        navigatorKey.currentState?.pushNamed(SplashScreen.routeName);
        // display(message);
      }
    });
  }

  static getToken() async {
    String? token;
    if (Platform.isIOS) {
      token = await FirebaseMessaging.instance.getAPNSToken();
    } else {
      token = await FirebaseMessaging.instance.getToken();
    }

    return token ?? '';
  }

  void display(RemoteMessage message) async {
    log('Got a message whilst in the foreground!');
    log('Message data: ${message.notification!.body.toString()}');
    try {
      // final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;

      AndroidNotificationChannel channel = const AndroidNotificationChannel(
        '0',
        'customer',
        description: 'Show QuickLAI Notification',
        importance: Importance.high,
      );
      AndroidNotificationDetails notificationDetails =
          AndroidNotificationDetails(channel.id, channel.name);
      const DarwinNotificationDetails darwinNotificationDetails =
          DarwinNotificationDetails();
      NotificationDetails notificationDetailsBoth = NotificationDetails(
        android: notificationDetails,
        iOS: darwinNotificationDetails,
      );
      await FlutterLocalNotificationsPlugin().show(
        id: 0,
        title: message.notification!.title,
        body: message.notification!.body,
        notificationDetails: notificationDetailsBoth,
        payload: jsonEncode(message.data),
      );
    } on Exception catch (e) {
      log(e.toString());
    }
  }
}
