// ignore_for_file: camel_case_types

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:untitled2/commponet/ProfileMenu.dart';

import 'package:untitled2/modules/Profile/profile.dart';



import '../../commponet/commpnet.dart';
import '../../cubit/cubit.dart';
import '../../cubit/state.dart';
import '../Rooms/MyRoom.dart';
import 'cubit/cubit.dart';
import 'joinedRooms.dart';

class profile_screen extends StatelessWidget {
  profile_screen({Key? key}) : super(key: key);
  var interestController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => learnUpCuibit()
          ..GetUserdata()
          ..GetInterest()  ,
        child: BlocConsumer<learnUpCuibit, learnUpStates>(
            listener: (context, state) {},
            builder: (context, state) => ConditionalBuilder(
                  condition: true,
                  builder: (context) {
                    var cubit = learnUpCuibit.get(context);

                    return Scaffold(
                      body: SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                                alignment: Alignment.center, child: pic()),
                            profileMeun(
                              text: "My Account",
                              icon: "assets/User Icon.svg",
                              press: () => {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) => Profile()),
                                )
                              },
                            ),
                            profileMeun(
                              text: "My Rooms",
                              icon: "assets/myspace (2).svg",
                              press: () => {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) => const MyRoom()),
                                )
                              },
                            ),
                            profileMeun(
                              text: "Joined Rooms",
                              icon: "assets/myspace.svg",
                              press: () => {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const JoinedRooms()),
                                )
                              },
                            ),
                            profileMeun(
                              text: "Interests",
                              icon: "assets/add-favorite.svg",
                              color: Colors.black,
                              press: () => {
                                {
                                  showModalBottomSheet(
                                      isScrollControlled: true,
                                      context: context,
                                      backgroundColor: Colors.transparent,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0.r),
                                      ),
                                      builder: (context) => AddInterest(
                                          _formKey, interestController, cubit))
                                },
                              },
                            ),
                            profileMeun(
                              color: Colors.redAccent,
                              text: "Logout",
                              icon: "assets/logout-svgrepo-com.svg",
                              press: () => {cubit.SignOut(context)},
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  fallback: (BuildContext context) => Container(
                      color: Colors.white, child: Center(child: spinkitCircle)),
                )));
  }

  Widget pic() {
    return SizedBox(
      height: 115.h,
      width: 115.w,
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
