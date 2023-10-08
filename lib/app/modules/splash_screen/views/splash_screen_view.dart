import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncverse/app/modules/home_screen/views/bottom_navigation.dart';
import 'package:syncverse/app/modules/home_screen/views/home_screen_view.dart';
import 'package:syncverse/app/modules/login_screen/views/login_screen_view.dart';
import '../controllers/splash_screen_controller.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

class SplashScreenView extends GetView<SplashScreenController> {
  SplashScreenView({Key? key}) : super(key: key);
  Widget isLogin(BuildContext context) {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    if (user != null) {
      return MyHomePage();
    } else {
      return LoginScreenView();
    }
  }

  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Image.asset('assets/icon.png'),
      nextScreen: isLogin(context),
      duration: 2500,
      backgroundColor: Colors.white,
      splashTransition: SplashTransition.fadeTransition,
      splashIconSize: 200,
    );
  }
}
