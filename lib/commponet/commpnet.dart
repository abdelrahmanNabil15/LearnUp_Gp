// ignore_for_file: non_constant_identifier_names

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';


import '../modules/Rooms/RoomBycategory.dart';
import '../modules/Rooms/RoomsScreen.dart';
import 'CustomText.dart';
import 'const.dart';

Widget Cateogery(cubit) => SizedBox(
      height: 100.h,
      child: ListView.separated(
          itemBuilder: (context, index) {
            const BouncingScrollPhysics();

            return Column(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => RoomByCateory(
                              InterestCateogry:
                                  cubit.getAllinterest!.result![index].id)),
                    );


                  },
                  child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: mainColor, width: 0.7.w),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade100,
                            offset: Offset(3.0.w, 3.0.h),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(15.r),
                        color: Colors.white,
                      ),
                      height: 60.h,
                      width: 100.w,
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: customText(
                              maxline: 1,
                              fontWeight: FontWeight.bold,
                              text: cubit.getAllinterest!.result![index].id,
                              alignment: Alignment.center,
                              fontSize: 15.sp),
                        ),
                      )),
                ),
              ],
            );
          },
          separatorBuilder: (context, index) => SizedBox(
                width: 15.w,
              ),
          scrollDirection: Axis.horizontal,
          itemCount: cubit.getAllinterest!.result!.length > 6
              ? 6
              : cubit.getAllinterest!.result!.length),
    );



Widget Rooms() => ListView.separated(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0.w, vertical: 15.h),
          child: Container(
            width: double.infinity,
            height: 190.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.r),
              color: Colors.grey.shade50,
            ),
            child: Column(
              children: [
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 8.0.w, vertical: 8.h),
                  child: customText(
                    maxline: 1,
                    fontWeight: FontWeight.bold,
                    text: 'LIVE',
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                  child: customText(
                    maxline: 2,
                    fontWeight: FontWeight.bold,
                    text: 'Roadmap <> Flutter  Enginger Flutter dev chat |Ep05',
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                  child: customText(
                    maxline: 1,
                    fontWeight: FontWeight.normal,
                    text: '44 listening',
                  ),
                ),
                Expanded(
                  child: Container(
                    height: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.r),
                      color: Colors.grey.shade100,
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.0.w, vertical: 7.h),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                  height: 25.h,
                                  width: 30.w,
                                  child:
                                      Image.asset('assets/Profile Image.png')),
                              SizedBox(
                                width: 10.w,
                              ),
                              customText(
                                maxline: 1,
                                fontWeight: FontWeight.bold,
                                text: 'Pawann Kumaar',
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Container(
                                color: Colors.white,
                                height: 22.h,
                                child: customText(
                                  maxline: 1,
                                  fontWeight: FontWeight.normal,
                                  text: 'Host',
                                ),
                              )
                            ],
                          ),
                          Expanded(
                            child: customText(
                              maxline: 4,
                              fontWeight: FontWeight.normal,
                              text:
                                  'In this case, you should try Wrap widgetin flutterrrrrrrrrrrrremmmmmmm mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm;mlmklnkjdbshbfhsebdyfvkdbsbIY;FBSAYFV;DSVF;HVDSAFDHKSFHDSGUIHFUDISBFYBDSYIFVED',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
      itemCount: 3,
      physics: const BouncingScrollPhysics(),
      separatorBuilder: (context, index) => SizedBox(
        width: 20.w,
      ),
      scrollDirection: Axis.vertical,
    );

Widget AddInterest(_formKey, interestController, cubit) =>
    SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text("Choose your intersts"),
        centerTitle: true,),
        body: Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius:
              BorderRadius.vertical(top: Radius.circular(20))),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: ListView(

              children: [
                Form(
                  key: _formKey,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                   ///add interest  for users

                    ///icons intersts
                      Expanded(
                          flex: 1,
                          child: IconButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  cubit.Addintrest(
                                      interestdata:
                                      interestController.text);
                                  interestController.clear();
                                  cubit.GetInterest();
                                }
                              },
                              icon: const Icon(
                                Icons.add_circle_outline,
                                color: Colors.cyan,
                              ))),
                    ],
                  ),
                ),
                ConditionalBuilder(
                  condition: cubit.getinterest != null,
                  builder: (context) {
                    return Wrap(
                      spacing: 6.0,
                      runSpacing: 6.0,
                      children: List<Widget>.generate(
                          cubit.getinterest!.result!.length, (int index) {
                        return Chip(
                          label: Text(cubit.getinterest!.result![index].id),
                        );
                      }),
                    );
                  },
                  fallback: (BuildContext context) => Container(
                      color: Colors.white,
                      child: Center(child: spinkitCircle)),
                )
              ],
            ),
          ),
        ),
      ),
    );

final spinkit = SpinKitThreeBounce(
  color: mainColor,
  size: 30.0.sp,
);
final spinkitCircle = SpinKitCircle(
  color: mainColor,
  size: 30.0.sp,
);

showtoast(String title, Color backgournd) => Fluttertoast.showToast(
    msg: title,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.SNACKBAR,
    timeInSecForIosWeb: 5,
    textColor: Colors.white,
    backgroundColor: backgournd,
    fontSize: 14.0.sp);

Widget ROOMS(cubit) => GestureDetector(
        child: ListView.separated(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0.w, vertical: 15.h),
          child: Container(
            width: double.infinity,
            constraints: BoxConstraints(
              minHeight: 100.h,
              maxHeight: 190.h,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.r),
              color: Colors.grey.shade50,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 8.0.w, vertical: 8.h),
                      child: customText(
                        maxline: 1,
                        fontWeight: FontWeight.bold,
                        text: cubit.roombyInterest!.result![index].statusId,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        {
                          if (cubit.roombyInterest!.result![index]
                                  .userRoomStatus!.id ==
                              "ACCEPTED"||cubit.roombyInterest!.result![index]
                              .userRoomStatus!.id == "JOINED") {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => RoomsScreen(
                                      id: cubit
                                          .roombyInterest!.result![index].id)),
                            );
                          } else if (cubit.roombyInterest!.result![index]
                                  .userRoomStatus!.id ==
                              "NO_REQUEST") {
                            cubit.joinRoom(cubit
                                .roombyInterest!.result![index].id
                                .toString());
                          } else {

                            showtoast(
                                "Owner Reject you please  try in another time",
                                Colors.red);
                          }
                        }

                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height * 1 / 25,
                        width: MediaQuery.of(context).size.width * 3 / 12,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Colors.indigo,
                                mainColor,
                              ]),
                          borderRadius: BorderRadius.circular(16.0.r),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
// ignore: prefer_const_literals_to_create_immutables
                          children: [
                            Text(
                              cubit.roombyInterest!.result![index]
                                  .userRoomStatus!.nameEnglish=="not joined"?"Join":cubit.roombyInterest!.result![index]
                                  .userRoomStatus!.nameEnglish,
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                  child: customText(
                    maxline: 2,
                    fontWeight: FontWeight.bold,
                    text: cubit.roombyInterest!.result![index].name,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                  child: customText(
                    maxline: 1,
                    fontWeight: FontWeight.normal,
                    text:  cubit
                        .roombyInterest!.result![index].numberOfJoinedUsers.toString()=="0"?"no listening": cubit
                        .roombyInterest!.result![index].numberOfJoinedUsers.toString()+"  listening",
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.r),
                      color: Colors.grey.shade100,
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.0.w, vertical: 7.h),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [

                              SizedBox(
                                width: 10.w,
                              ),
                              customText(
                                maxline: 1,
                                fontWeight: FontWeight.bold,
                                text: cubit
                                    .roombyInterest!.result![index].ownerName,
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Container(
                                color: Colors.white,
                                height: 22.h,
                                child: customText(
                                  maxline: 1,
                                  fontWeight: FontWeight.normal,
                                  text: 'Host',
                                ),
                              )
                            ],
                          ),
                          Expanded(
                            child: customText( maxline: 3,
                              fontWeight: FontWeight.normal,
                              text: cubit
                                  .roombyInterest!.result![index].description,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
      itemCount: cubit.roombyInterest!.result!.length,
      physics: const BouncingScrollPhysics(),
      separatorBuilder: (context, index) => SizedBox(
        width: 20.w,
      ),
      scrollDirection: Axis.vertical,
    ));
void showToast({
  required String message,
  required ToastStates state,
}) =>
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 14.0,
    );

// enum
enum ToastStates { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastStates state) {
  Color color;

  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }

  return color;
}
void navigateTo(context, widget) => Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
);

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
      (route) => false,
);
