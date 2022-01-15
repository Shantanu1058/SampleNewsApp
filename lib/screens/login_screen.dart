import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:samplenewsapp/animations/fade_animation.dart';
import 'package:samplenewsapp/controller/news_controller.dart';
import 'package:samplenewsapp/screens/news_screen.dart';
import 'package:samplenewsapp/screens/register_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final RoundedLoadingButtonController signUpController =
      RoundedLoadingButtonController();
  NewsController newsController = NewsController();
  void _doSomething(RoundedLoadingButtonController controller) async {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      newsController
          .login(email: emailController.text, password: passwordController.text)
          .then((value) async {
        if (value["success"] == 1) {
          controller.reset();
          Fluttertoast.showToast(msg: "Login Successfull");
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setBool("isAuth", true);
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => NewsScreen(),
              ));
        } else {
          Fluttertoast.showToast(msg: value["message"]);
        }
      });
    } else {
      Fluttertoast.showToast(msg: "Enter All the details");
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Widget bottomSheet() {
    return FadeAnimation(
        0.8,
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: double.infinity,
            padding:
                const EdgeInsets.only(left: 12, right: 12, top: 8, bottom: 1),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black),
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(60),
                    topRight: Radius.circular(60))),
            height: MediaQuery.of(context).size.height * 0.55,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Sign In",
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.blue.shade600,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                      hintText: "Email",
                      fillColor: const Color(0xCB816555),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                      hintText: "Password",
                      fillColor: const Color(0xCB816555),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "Forget Password?",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                RoundedLoadingButton(
                  successIcon: Icons.cloud,
                  failedIcon: Icons.cottage,
                  child: const Text('Sign In',
                      style: TextStyle(color: Colors.white)),
                  controller: signUpController,
                  onPressed: () => _doSomething(signUpController),
                ),
                const SizedBox(
                  height: 8,
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 90,
                        height: 2,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 2)),
                      ),
                      const SizedBox(
                        width: 2,
                      ),
                      const Text(
                        "Or Sign In With",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(
                        width: 2,
                      ),
                      Container(
                        width: 90,
                        height: 2,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 2)),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Image(
                      image: AssetImage("assets/google.png"),
                      height: 35,
                    ),
                    Image(
                      image: AssetImage("assets/facebook-logo.png"),
                      height: 35,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an Account?"),
                    TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RegisterScreen(),
                              ));
                        },
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.yellow),
                        ))
                  ],
                )
              ],
            ),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: ExactAssetImage("assets/background.jpg"))),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              decoration: BoxDecoration(color: Colors.white.withOpacity(0.0)),
            ),
          ),
        ),
        const Padding(
            padding: EdgeInsets.only(top: 100, left: 20),
            child: Text(
              "Welcome!!",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 50,
                  fontWeight: FontWeight.bold),
            )),
        bottomSheet(),
      ],
    ));
  }
}
