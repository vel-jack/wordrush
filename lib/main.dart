import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:wordrush/controller/user_controller.dart';

import 'package:wordrush/utils/constants.dart';
import 'package:wordrush/views/home_page.dart';

void main() async {
  runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp().then((value) => {Get.put(UserController())});
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
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
