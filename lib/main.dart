import 'package:flutter/material.dart';
import 'package:flutter_todoapp/DB_Helper.dart';
import 'package:flutter_todoapp/UI/homescreen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_todoapp/UI/splashScreen.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  await DBHelper.initdb();
  runApp(const MyApp());
}

final getxStorage = GetStorage();

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    checkMode();
    super.initState();
  }

  void checkMode() {
    final theme = getxStorage.read('thememode');
    if (theme != null) {
      theme
          ? Get.changeTheme(ThemeData.light())
          : Get.changeTheme(ThemeData.dark());
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      //initialBinding: NetworkBinding(),
      theme: Themedata().lightTheme,
      darkTheme: Themedata().darkTheme,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', 'US'), // English
      ],
      //translations: LocaleString(),
      locale: Locale('en', 'US'),
      getPages: [
        GetPage(name: '/homescreen', page: () => Homescreen()),
        // GetPage(name: '/detailpage', page: () => ProductDetailPAge()),
        // // ignore: prefer_const_constructors
        // GetPage(name: '/cartscreen', page: () => CartScreen()),
      ],
      home: SplashScreen(),
    );
  }
}

class Themedata {
  final lightTheme = ThemeData.light().copyWith(
      backgroundColor: Colors.white,
      primaryColor: Colors.white,
      textTheme: TextTheme(headline1: TextStyle(color: Colors.black)));

  final darkTheme = ThemeData.light().copyWith(
      backgroundColor: Colors.grey,
      primaryColor: Colors.black,
      textTheme: TextTheme(headline1: TextStyle(color: Colors.white)));
}
