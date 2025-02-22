import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Check login status when the app starts
    checkLoginStatus();
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login App',
      home: Container(), // Start with an empty container
    );
  }

  void checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jwt = prefs.getString('jwt');

    if (jwt == null) {
      // If no JWT, navigate to login screen
      Get.offAll(() => LoginScreen());
    } else {
      // If JWT exists, navigate to home screen
      Get.offAll(() => HomeScreen());
    }
  }
}
