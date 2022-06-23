
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../commponet/CustomText.dart';
import '../../commponet/Rooms.dart';
import '../../commponet/commpnet.dart';
import '../../commponet/const.dart';
import '../../cubit/cubit.dart';
import '../../cubit/state.dart';
import '../Report/ReportRoomById.dart';
import '../Report/ReportRoomJoined.dart';
import '../inviteion/inviteUesr.dart';
import 'RoomsScreen.dart';

class MyRoomJoined extends StatelessWidget {
  MyRoomJoined({Key? key}) : super(key: key);
  var appBarHeight = AppBar().preferredSize.height;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => learnUpCuibit()
        ..GetUserdata(),

      child: BlocConsumer<learnUpCuibit, learnUpStates>(
        listener: (BuildContext context, state) {  },
        builder: (BuildContext context, Object? state) {
          var cubit = learnUpCuibit.get(context);
          return  Scaffold(
              appBar: AppBar( title: const Text("Rooms Joined "),

              actions: [
                PopupMenuButton(

                  itemBuilder:(context) => [

                    PopupMenuItem(
                      child: const Text("Report Rooms joined "),
                      onTap: (){
                      },
                      value: 1,
                    ),

                  ],
                  offset: Offset(0.0, appBarHeight),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(8.0),
                      bottomRight: Radius.circular(8.0),
                      topLeft: Radius.circular(8.0),
                      topRight: Radius.circular(8.0),
                    ),),
                  onSelected: (value){
                    if(value==1){
                      navigateTo(context, ReportRoomsJoined(  ));
                    }



                  },
                )


              ],
              ),
              body: ConditionalBuilder(
                condition: cubit.usermodel!=null,
                builder:( context ) {

                  return cubit.usermodel!.result!.joinRooms!.isNotEmpty?
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        ListView.separated(
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: (){
                                navigateTo(context, RoomsScreen(id: cubit.usermodel!
                                    .result!.joinRooms![index].id));
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15.0.w, vertical: 15.h),
                                child: Container(
                                  width: double.infinity,

                                  constraints:   BoxConstraints(
                                    minHeight: 100.h,
                                    maxHeight:190.h,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.circular(15.r),
                                    color: Colors.grey.shade50,
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 8.0.w,
                                                vertical: 8.h),
                                            child: customText(
                                              maxline: 1,
                                              fontWeight: FontWeight.bold,
                                              text:cubit.usermodel!.result!.joinRooms![index].statusId,
                                              color: cubit.usermodel!.result!.joinRooms![index].statusId=="ACTIVE"?Colors.green:Colors.blue,
                                            ),
                                          ),



                                        ],
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8.0.w),
                                        child: customText(
                                          fontWeight: FontWeight.bold,
                                          text: cubit.usermodel!
                                              .result!.joinRooms![index].name,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8.0.w),
                                        child: customText(
                                          maxline: 1,
                                          fontWeight: FontWeight.normal,
                                          text:  cubit.usermodel!
                                              .result!.joinRooms![index].numberOfJoinedUsers.toString()=="0"?"no listening":cubit.usermodel!
                                              .result!.joinRooms![index].numberOfJoinedUsers.toString()+"  listening",
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(

                                          decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(15.r),
                                            color: Colors.grey.shade100,
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10.0.w,
                                                vertical: 7.h),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Row(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .start,
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .start,
                                                  children: [
                                                    SizedBox(
                                                        height: 25.h,
                                                        width: 30.w,
                                                        child: Image.asset(
                                                            'assets/Profile Image.png')),
                                                    SizedBox(
                                                      width: 10.w,
                                                    ),

                                                    ///For edit this
                                                    customText(
                                                      maxline: 1,
                                                      fontWeight:
                                                      FontWeight.bold,
                                                      text: cubit.usermodel!.result!.joinRooms![index].ownerName,
                                                    ),
                                                    SizedBox(
                                                      width: 10.w,
                                                    ),
                                                    Container(
                                                      color: Colors.white,
                                                      height: 22.h,
                                                      child: customText(
                                                        maxline: 1,
                                                        fontWeight:
                                                        FontWeight
                                                            .normal,
                                                        text: 'Host',
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                Expanded(
                                                  child: customText(
                                                    maxline: 3,
                                                    fontWeight:
                                                    FontWeight.normal,
                                                    text: cubit
                                                        .usermodel!
                                                        .result!.joinRooms![index]
                                                        .description,
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
                              ),
                            );
                          },
                          itemCount: cubit.usermodel!.result!.joinRooms!.length,
                          physics: const BouncingScrollPhysics(),
                          separatorBuilder: (context, index) => SizedBox(
                            width: 20.w,
                          ),
                          scrollDirection: Axis.vertical,
                        ),
                      ],
                    ),
                  ):Container( color:Colors.white,child: Column(crossAxisAlignment: CrossAxisAlignment.center,
                    children: [SizedBox(height: 80.h,),
                      Center( child:  Image.asset('assets/Warning.png'),),
                      customText(fontWeight: FontWeight.bold,text: "There are no rooms!",
                        color: Colors.black,
                        fontSize: 22.sp,alignment: Alignment.center,)
                    ],
                  ));

                } ,
                fallback:  (context) => Center(child: Container(child: spinkitCircle)),
              )
          );
        },

      ),
    );
  }
}