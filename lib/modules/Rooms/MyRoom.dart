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
import 'RoomsScreen.dart';

class MyRoom extends StatelessWidget {
  const MyRoom({Key? key}) : super(key: key);

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
            appBar: AppBar( ),
              body: ConditionalBuilder(
            condition: cubit.usermodel!=null,
            builder:( context ) {

            return cubit.usermodel!.result!.createdRooms!.isNotEmpty?
                SingleChildScrollView(
                child: Column(
                  children: [
                    ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Padding(
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
                                        text:cubit.usermodel!.result!.createdRooms![index].statusId,
                                      ),
                                    ),


                                    TextButton(onPressed:( ){

                                      {

                                        Navigator.of(context).push(
                                          MaterialPageRoute(builder: (context) =>   RoomsScreen(id: cubit.usermodel!
                                              .result!.createdRooms![index].id)),
                                        );

                                      };

                                    } ,
                                      child: Container(

                                        height: MediaQuery.of(context).size.height * 1 / 25,
                                        width: MediaQuery.of(context).size.width * 3 / 12,
                                        decoration: BoxDecoration(
                                          gradient:  const LinearGradient(
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

                                            Text(cubit.usermodel!.result!.createdRooms![index].userRoomStatus.nameEnglish,
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
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8.0.w),
                                  child: customText(
                                    fontWeight: FontWeight.bold,
                                    text: cubit.usermodel!
                                        .result!.createdRooms![index].name,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8.0.w),
                                  child: customText(
                                    maxline: 1,
                                    fontWeight: FontWeight.normal,
                                    text: '44 listening',
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
                                              customText(
                                                maxline: 1,
                                                fontWeight:
                                                FontWeight.bold,
                                                text: cubit
                                                    .usermodel!
                                                    .result!.name,
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
                                                  .result!.createdRooms![index]
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
                        );
                      },
                      itemCount: cubit.usermodel!.result!.createdRooms!.length,
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
                customText(fontWeight: FontWeight.bold,text: "There is no rooms!",
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
