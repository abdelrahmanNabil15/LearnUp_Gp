import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:untitled2/commponet/CustomText.dart';
import 'package:untitled2/commponet/const.dart';

import '../../commponet/DefaultFormField.dart';
import '../../commponet/commpnet.dart';
import '../../commponet/customdatefield.dart';
import '../../commponet/defult_button.dart';
import '../../cubit/cubit.dart';
import '../../cubit/state.dart';
import 'cubit/cubit.dart';
import 'cubit/state.dart';

class Profile extends StatelessWidget {
  var emailController = TextEditingController();
  var nameController = TextEditingController();
  var detaController = TextEditingController();
  var phoneController = TextEditingController();

  Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => learnUpCuibit()..GetUserdata(),
        child: BlocConsumer<learnUpCuibit, learnUpStates>(
            listener: (context, state) {},
            builder: (context, state) {
              return ConditionalBuilder(
                condition: learnUpCuibit.get(context).usermodel != null,
                builder: (context) {
                  var cubit = learnUpCuibit.get(context);

                  nameController.text = cubit.usermodel!.result!.name.isNotEmpty
                      ? cubit.usermodel!.result!.name
                      : "not data";
                  phoneController.text =
                      cubit.usermodel!.result!.phoneNumber.isNotEmpty
                          ? cubit.usermodel!.result!.phoneNumber
                          : "no data";

                  detaController.text =
                      cubit.usermodel!.result!.birthdate.isNotEmpty
                          ? cubit.usermodel!.result!.birthdate
                          : "no data";
                  emailController.text =
                      cubit.usermodel!.result!.userName.isNotEmpty
                          ? cubit.usermodel!.result!.userName
                          : "no data";

                  return Scaffold(
                      appBar: AppBar(),
                      body: cubit.usermodel == null
                          ? Container(
                              color: Colors.white,
                              child: const Center(
                                  child: CircularProgressIndicator()))
                          : SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                      alignment: Alignment.center,
                                      child: pic()),
                                  //name of User
                               Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 25.0.w,  ),
                                    child: customText(
                                      maxline: 1,
                                      fontWeight: FontWeight.bold,
                                      text: 'Your name ',
                                      alignment: Alignment.centerLeft,
                                      fontSize: 15.sp,
                                    ),
                                  ),
                                  //name of User in fieldForm
                                  Padding(
                                    padding:   EdgeInsets.only(
                                        left: 25.0.w, right: 25.0.w, top: 7.0.h),
                                    child: DefaultFormField(
                                      isobscureText: false,
                                      controller: nameController,
                                      inputAction: TextInputAction.next,
                                      label: 'Name',
                                      prefix: Icons.person,
                                      type: TextInputType.name,
                                      validator: (String value) {
                                        if (value.isEmpty) {
                                          print("please enter email ");
                                        }
                                      },
                                    ),
                                  ),
                                  //Email of user
                                 Padding(
                                    padding:
                                        EdgeInsets.only(left: 25.0.w, top: 7.0.h),
                                    child: customText(
                                      maxline: 1,
                                      fontWeight: FontWeight.bold,
                                      text: 'Your Email ',
                                      alignment: Alignment.centerLeft,
                                      fontSize: 15.sp,
                                    ),
                                  ),
                                  //email of user in fieldForm
                                  Padding(
                                    padding:   EdgeInsets.only(
                                        left: 25.0.w, right: 25.0.w, top: 7.0.h),
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
                                  //Date of Birth
                                 Padding(
                                    padding:
                                    EdgeInsets.symmetric(horizontal: 25.0.w,  ),
                                    child: customText(
                                      maxline: 1,
                                      fontWeight: FontWeight.bold,
                                      text: ' Date of Birth',
                                      alignment: Alignment.centerLeft,
                                      fontSize: 15.sp,
                                    ),
                                  ),
                                  //date of Birth
                                  Padding(
                                    padding:  EdgeInsets.only(
                                        left: 25.0.w, right: 25.0.w, top: 7.0.h),
                                    child: CustomdateField(
                                      dateController: detaController,
                                    ),
                                  ),
                                  //phone number
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: 25.0.w, top: 7.0.h),
                                    child: customText(
                                      maxline: 1,
                                      fontWeight: FontWeight.bold,
                                      text: 'Phone Number ',
                                      alignment: Alignment.centerLeft,
                                      fontSize: 15.sp,
                                    ),
                                  ),
                                  //phone number
                                  Padding(
                                    padding:   EdgeInsets.only(
                                        left: 25.0.w, right: 25.0.w, top: 7.0.h),
                                    child: DefaultFormField(
                                      isobscureText: false,
                                      controller: phoneController,
                                      inputAction: TextInputAction.next,
                                      label: 'Phone Number',
                                      prefix: Icons.person,
                                      type: TextInputType.phone,
                                      validator: (String value) {
                                        if (value.isEmpty) {
                                          print("please enter phone ");
                                        }
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding:   EdgeInsets.symmetric(horizontal: 15.0.w,vertical: 15.h),
                                    child: DefaultButton(
                                      text: "Update",
                                      function: () {},
                                      color: mainColor,
                                      width: double.infinity,
                                    ),
                                  )
                                ],
                              ),
                            ));
                },
                fallback: (BuildContext context) => Container(
                    color: Colors.white,
                    child:   Center(child: spinkitCircle)),
              );
            }));
  }

  Widget pic() {
    return SizedBox(
      height: 115.h,
      width: 115.h,
      child: Stack(
        alignment: Alignment.center,
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          const CircleAvatar(
            backgroundImage: AssetImage("assets/Profile Image.png"),
          ),
          Positioned(
              right: -16.w,
              bottom: 0.h,
              child: SizedBox(
                  height: 46.h,
                  width: 46.w,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.r),
                          side: const BorderSide(color: Colors.grey)),
                      primary: Colors.grey,
                    ),
                    onPressed: () {},
                    child: SvgPicture.asset("assets/Camera Icon.svg"),
                  )))
        ],
      ),
    );
  }
}
