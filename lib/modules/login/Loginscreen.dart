// ignore_for_file: file_names, must_be_immutable, non_constant_identifier_names, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:untitled2/commponet/CustomText.dart';
import 'package:untitled2/commponet/DefaultFormField.dart';
import 'package:untitled2/commponet/defult_button.dart';
import 'package:untitled2/modules/Register/RegisterScreen.dart';

import '../../commponet/commpnet.dart';
import '../../commponet/const.dart';
import '../../home_Layout.dart';
import '../../network/CacheHelper.dart';
import 'cubit/cubit.dart';
import 'cubit/state.dart';

class LoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var PasswordController = TextEditingController();
  dynamic token = CacheHelper.getData(key: 'result');
  dynamic idd = CacheHelper.getData(key: 'id');

  LoginScreen({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            if (state.registerModel.isSuccess) {
              Fluttertoast.showToast(
                  msg: state.registerModel.messageCode,
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 5,
                  textColor: Colors.white,
                  backgroundColor: Colors.cyan,
                  fontSize: 16.0.sp);
            } else {
              Fluttertoast.showToast(
                  msg: state.registerModel.messageCode,
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 5,
                  textColor: Colors.white,
                  backgroundColor: Colors.red,
                  fontSize: 16.0.sp);
            }
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const HomeLayout()),
                (Route<dynamic> route) => false);
          }
        },
        builder: (context, state) {
          return Scaffold(
              body: SafeArea(
            child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Stack(children: [
                    Container(
                      height: 200.h,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                          color: Colors.cyan,
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(200),
                              topLeft: Radius.circular(200))),
                    ),
                  ]),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 11.h),
                        child: Text(
                          "  Welcome",
                          style: TextStyle(
                              fontSize: 30.sp, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 22.h,
                        child: MaterialButton(
                          onPressed: () { print(idd); print(token);},
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                color: Colors.cyan),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Text(
                      "  Sign in to Continue,",
                      style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                    child: DefaultFormField(
                      isobscureText: false,
                      controller: emailController,
                      inputAction: TextInputAction.next,
                      label: 'Email Address',
                      prefix: Icons.email,
                      type: TextInputType.emailAddress,
                      validator: (String value) {
                        if (value.isEmpty) {
                          print("please enter email ");
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                    ),
                    child: DefaultFormField(
                      controller: PasswordController,
                      isobscureText: true,
                      type: TextInputType.emailAddress,
                      prefix: Icons.lock,
                      label: "Password",
                      inputAction: TextInputAction.done,
                      validator: (String value) {
                        if (value.isEmpty) {
                          print('pelease enter your password ');
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 5.0.w),
                    child: MaterialButton(
                      onPressed: () {},
                      child: customText(
                          text: 'Forgot Password?',
                          fontWeight: FontWeight.normal,
                          maxline: 1,
                          alignment: Alignment.bottomRight,
                          fontSize: 14.sp),
                    ),
                  ),
                  if (state is! LoginLoadingState)
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                      ),
                      child: DefaultButton(
                        function: () {
                          LoginCubit.get(context).userLogin(
                            email: emailController.text,
                            password: PasswordController.text,
                          );
                        },
                        text: 'SIGN IN',
                      ),
                    ),
                   SizedBox(
                    height: 9.h,
                  ),
                  if (state is LoginLoadingState)
                      Center(child:spinkit),
                 SizedBox(
                    height: 20.0.h,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    const Text(
                      'Don\'t have an account?',
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => RegisterScreen()),
                            (Route<dynamic> route) => false);
                      },
                      child:  customText(
                        text: 'Register',
                        fontWeight: FontWeight.w600,
                        maxline: 1,
                        color: mainColor,
                        fontSize: 15.sp,

                      ),
                    ),
                  ]),
                ])),
          ));
        },
      ),
    );
  }
}
