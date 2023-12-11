import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_management/login_screen/login_screen.dart';
import 'package:user_management/login_screen/login_screen_controller.dart';
import 'package:user_management/usage/app_initial_biding_screen.dart';
import 'package:user_management/user_list_screen/user_list_screen.dart';

void main() async {
  final LoginScreenController loginScreenController =
      Get.put(LoginScreenController());

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  bool isLoggedIn = await loginScreenController.checkLoginStatus();

  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  bool isLoggedIn;
  MyApp({super.key, required this.isLoggedIn});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'User Management',
      debugShowCheckedModeBanner: false,
      enableLog: !kReleaseMode,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialBinding: AppInitialBinding(),
      home: isLoggedIn ? UserListScreen() : LoginScreen(),
    );
  }
}
