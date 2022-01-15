import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:samplenewsapp/screens/news_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'screens/login_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool? isUserLogIn = false;
  getUserLogInState() async {
    await SharedPreferences.getInstance().then((value) {
      setState(() {
        isUserLogIn = value.getBool("isAuth");
      });
    });
  }

  @override
  void initState() {
    getUserLogInState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'News App',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: isUserLogIn != null
          ? isUserLogIn == true
              ? NewsScreen()
              : LoginScreen()
          : LoginScreen(),
    );
  }
}
