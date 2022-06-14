// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import 'commponet/const.dart';
import 'home_Layout.dart';
import 'modules/login/Loginscreen.dart';
import 'network/CacheHelper.dart';
import 'network/DioHelper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();

  dynamic token = CacheHelper.getData(key: 'result');
  //Widget widget;
  // if (token != null)
  //  widget = HomeScreen();
  // else
  // widget = LoginScreen();

  runApp(MyApp(token: token));
}

class MyApp extends StatelessWidget {
  String? token;

  MyApp({
    Key? key,
    this.token,
  }) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(360, 690),
    minTextAdapt: true,
    splitScreenMode: true,
    builder: (child) {
return      MaterialApp( debugShowCheckedModeBanner: false,

        theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            primaryColor: Colors.cyan,

            appBarTheme: AppBarTheme(

                titleTextStyle:   TextStyle(

                    color: Colors.black,
                    fontSize: 20.0.sp,
                    fontWeight: FontWeight.bold),
                iconTheme: const IconThemeData(color: Colors.black),
                systemOverlayStyle: const SystemUiOverlayStyle(

                    statusBarColor: mainColor,
                    statusBarBrightness: Brightness.dark),
                backgroundColor: Colors.white,

                elevation: 0.0),
            bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                selectedItemColor: mainColor,
                elevation: 20.0,

                type: BottomNavigationBarType.fixed)),
        home: token != null ? const HomeLayout() : LoginScreen(),
      );
    }
    );
  }
}


//sondosehab67@gmail.com     email for api omara