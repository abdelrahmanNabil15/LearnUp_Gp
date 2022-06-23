// ignore_for_file: camel_case_types

import 'package:LearnUP/modules/Profile/profile.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iconsax/iconsax.dart';


import '../../commponet/ProfileMenu.dart';
import '../../commponet/commpnet.dart';
import '../../cubit/cubit.dart';
import '../../cubit/state.dart';
import '../Report/ReportRoomJoined.dart';
import '../Rooms/JoinedRoomsScreen.dart';
import '../Rooms/MyRoom.dart';
import 'Interests.dart';
import 'cubit/cubit.dart';
import 'joinedRooms.dart';

class profile_screen extends StatelessWidget {
  profile_screen({Key? key}) : super(key: key);
  var interestController = TextEditingController();


  @override
  Widget build(BuildContext context) {
      return BlocProvider(
          create: (BuildContext context) => learnUpCuibit()
            ..GetUserdata()
            ..GetInterest() ..GetUserRoomsReport( ) ,
          child: BlocConsumer<learnUpCuibit, learnUpStates>(
              listener: (context, state) {},
              builder: (context, state) => ConditionalBuilder(
                    condition: true,
                    builder: (context) {
                      var cubit = learnUpCuibit.get(context);

                      return Scaffold(    appBar: AppBar(
                    title: const Text(" LEARN UP "),
                    actions: [
                    IconButton(onPressed: () {}, icon: const Icon(Iconsax.search_status))
                    ],),
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
                              press: () => {navigateTo(context, MyRoomJoined())
                              },
                            ),
                            profileMeun(
                              text: "Interests",
                              icon: "assets/add-favorite.svg",
                              color: Colors.black,
                              press: () => {
                                {
                                  navigateTo(context, InterestScreen())
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
          CircleAvatar(
            backgroundColor: Colors.white,

            child: Image.asset("assets/profile_pic.png",fit: BoxFit.fitHeight),
          ),
          Positioned(
              right: 12.w,
              bottom: 10.h,
              child: SizedBox(
                  height: 30.h,
                  width: 30.w,
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
