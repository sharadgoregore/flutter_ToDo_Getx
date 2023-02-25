import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_todoapp/UI/Login_page.dart';
import 'package:flutter_todoapp/UI/NavigationbarScreen.dart';
import 'package:flutter_todoapp/UI/Signup_page.dart';
import 'package:flutter_todoapp/UI/homescreen.dart';
import 'package:flutter_todoapp/UI/welcome_page.dart';
import 'package:get/get.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 3),
        // () => Get.to(() => WelcomePage()));
          () => Get.to(() => Homescreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset('assets/todo.png'),
      ),
    );
  }
}