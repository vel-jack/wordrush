import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:wordrush/controller/user_controller.dart';
import 'package:wordrush/utils/constants.dart';
import 'package:wordrush/views/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(UserController());
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
