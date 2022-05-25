import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../login/Loginscreen.dart';

// ignore: camel_case_types
class Splash_screen extends StatelessWidget {
  const Splash_screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          Image.asset('assets/splash.png') ,

        ],
      ),
      nextScreen: LoginScreen(),
      backgroundColor: Colors.white,
      splashIconSize: double.infinity,
      splashTransition: SplashTransition.fadeTransition ,
      duration: 4000,

      
    );
  
  }
}
