// ignore_for_file: file_names, non_constant_identifier_names, avoid_print, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';


import '../../commponet/CustomText.dart';
import '../../commponet/DefaultFormField.dart';
import '../../commponet/commpnet.dart';
import '../../commponet/const.dart';
import '../../commponet/customdatefield.dart';
import '../../commponet/defult_button.dart';
import '../../home_Layout.dart';
import '../login/Loginscreen.dart';
import 'cubit/cubit.dart';
import 'cubit/state.dart';

class RegisterScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var detaController = TextEditingController();
  var PasswordController = TextEditingController();

  RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => RegisterCubit(),
        child: BlocConsumer<RegisterCubit, RegisterStates>(
            listener: (context, state) {
          if (state is RegisterSuccessState) {
            if (state.registerModel.isSuccess) {
              Fluttertoast.showToast(
                  msg: state.registerModel.messageCode,
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 5,
                  textColor: Colors.white,
                  backgroundColor: mainColor,
                  fontSize: 16.0.sp);
            } else {
              Fluttertoast.showToast(
                  msg: state.registerModel.messageCode,
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 5,
                  textColor: Colors.white,
                  backgroundColor: redColor,
                  fontSize: 16.0.sp);
            }
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const HomeLayout()),
                (Route<dynamic> route) => false);
          }
            }, builder: (context, state) {
          return Scaffold(
              body: SafeArea(
                child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(children: [
                            Container(
                              height: 140.h,
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
                        padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 11.h),
                        child: Text(
                          "  Welcome",
                          style: TextStyle(
                              fontSize: 30.sp, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 22.h,
                        child: MaterialButton(
                          onPressed: () {},
                          child: const Text(
                            'Sign in',
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                color: Colors.cyan),
                          ),
                        ),
                      ),
                    ],
                  ),
                   Padding(
                    padding: EdgeInsets.symmetric(horizontal:16.w),
                    child: Text(
                      "  Sign Up to Continue",
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
                    padding: EdgeInsets.symmetric(horizontal: 16.0.w,),
                    child: DefaultFormField(
                              isobscureText: false,
                      controller: nameController,
                      inputAction: TextInputAction.next,
                      label: 'UserName',
                      prefix: Icons.person,
                      type: TextInputType.name,
                      validator: (String value) {
                        if (value.isEmpty) {
                          print("please enter username ");
                        }
                      },
                    ),
                  ),
                   SizedBox(
                    height: 15.h,
                  ),
                  Padding(
                      padding:   EdgeInsets.symmetric(horizontal: 16.0.w ),
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
                      )),
                   SizedBox(
                    height: 15.h,
                  ),
                  Padding(
                    padding:EdgeInsets.symmetric(horizontal: 16.0.w),
                    child: DefaultFormField(
                      isobscureText: false,
                      controller: phoneController,
                      inputAction: TextInputAction.next,
                      label: 'phone',
                      prefix: Icons.phone,
                      type: TextInputType.phone,
                      validator: (String value) {
                        if (value.isEmpty) {
                          print("please enter phone ");
                        }
                      },
                    ),
                  ),
                    SizedBox(
                    height:15.h,
                  ),
                  Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 16.w),
                      child: CustomdateField(
                        dateController: detaController,
                      )),
                   SizedBox(
                    height: 15.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: DefaultFormField(
                      isobscureText: true,
                      controller: PasswordController,
                      inputAction: TextInputAction.done,
                      label: 'Password',
                      prefix: Icons.lock,
                      type: TextInputType.visiblePassword,
                      validator: (String value) {
                        if (value.isEmpty) {
                          print("please enter password");
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  if (state is! RegisterLoadingState)
                    Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 16.w),
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        color: Colors.cyan,
                        child: DefaultButton(
                          function: () {
                            RegisterCubit.get(context).userregister(
                              name: nameController.text,
                              phone: phoneController.text,
                              email: emailController.text,
                              password: PasswordController.text,
                              date: detaController.text,
                            );
                          },
                          text: 'SIGN IN',
                        ),
                      ),
                    ),
                   SizedBox(
                    height: 15.h,
                  ),
                  if (state is RegisterLoadingState)
                      Center(child: spinkit),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    const Text(
                      'I have an account?',
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()),
                            (Route<dynamic> route) => false);
                      },
                      child: customText(
                        text: 'Login',
                        fontWeight: FontWeight.w600,
                        maxline: 1,
                        color: mainColor,
                        fontSize: 15.sp,

                      ),
                    ),
                              ]),
                        ])),
              ));
        }));
  }
}
