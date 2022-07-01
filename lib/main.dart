import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:wordrush/controller/user_controller.dart';
import 'package:wordrush/utils/constants.dart';
import 'package:wordrush/views/home_page.dart';

Future<void> _onBackgroundMessage(RemoteMessage message) async {
  Firebase.initializeApp();
  debugPrint('background message received ${message.notification?.title}');
}

const AndroidNotificationChannel androidNotificationChannel =
    AndroidNotificationChannel(
  'word_notification',
  'Word Notification',
  description: 'Receive words suggestions to solve',
  playSound: true,
  importance: Importance.high,
);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void _onMessage(RemoteMessage msg) {
  RemoteNotification? notification = msg.notification;
  AndroidNotification? androidNotification = msg.notification?.android;
  if (notification != null && androidNotification != null) {
    flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
            android: AndroidNotificationDetails(
          androidNotificationChannel.id,
          androidNotificationChannel.name,
          playSound: true,
          channelDescription: androidNotificationChannel.description,
          icon: androidNotification.smallIcon,
        )));
  }
}

void main() async {
  runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp().then((value) => {Get.put(UserController())});
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    FirebaseMessaging.onBackgroundMessage(_onBackgroundMessage);
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(androidNotificationChannel);
    FirebaseMessaging.onMessage.listen(_onMessage);

    runApp(const MyApp());
  },
      (error, stack) =>
          FirebaseCrashlytics.instance.recordError(error, stack, fatal: true));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Word Rush',
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      theme: Theme.of(context).copyWith(scaffoldBackgroundColor: kLightBgColor),
    );
  }
}
