import 'package:agora_uikit/agora_uikit.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:icon_badge/icon_badge.dart';
import 'package:iconsax/iconsax.dart';
import 'package:untitled2/commponet/CustomText.dart';
import 'package:untitled2/commponet/const.dart';
import 'package:untitled2/modules/Rooms/test.dart';

import '../../commponet/DefaultFormField.dart';
import '../../commponet/commpnet.dart';
import '../../commponet/defult_button.dart';
import '../../cubit/cubit.dart';
import '../../cubit/state.dart';
import '../../network/CacheHelper.dart';
import '../../videoCall/call.dart';
import 'QuestionScreen.dart';
import 'RequestedUsers.dart';

class RoomsScreen extends StatelessWidget {
  RoomsScreen({
    Key? key,
    required this.id,
  }) : super(key: key);
  final id;
  var nameController = TextEditingController();
  dynamic idowner = CacheHelper.getData(key: 'id');

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => learnUpCuibit()
          ..GetRoombyId(id)
          ..RequestedUsers(id.toString())
          ..GetQuestions(idRoom: id.toString())..Getanswer(idquestion:2.toString()),
        child: BlocConsumer<learnUpCuibit, learnUpStates>(
            listener: (context, state) {},
            builder: (context, Object? state) {
              var cubit = learnUpCuibit.get(context);

              return ConditionalBuilder(
                condition: cubit.roombyId != null,
                builder: (context) {
                  String owner = cubit.roombyId!.result!.ownerId;
                  return Scaffold(
                    appBar: AppBar(
                      actions: [
                        ConditionalBuilder(
                          condition:
                              cubit.requesteduserss != null && owner == idowner,
                          builder: (context) {
                            return IconBadge(
                              icon: Icon(Iconsax.notification_status),
                              itemCount: cubit.requesteduserss!.result!.length,
                              badgeColor: Colors.red,
                              itemColor: Colors.white,
                              hideZero: true,
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) => RequestedUsers(
                                            IDRoom: id,
                                          )),
                                );
                              },
                            );
                          },
                          fallback: (context) => Text(""),
                        ),
                      ],
                      title: customText(
                          text: cubit.roombyId!.result!.name,
                          fontWeight: FontWeight.bold,
                          maxline: 1,
                          fontSize: 20.sp),
                    ),
                    body: Padding(
                      padding: const EdgeInsets.all(13),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsets.symmetric(vertical: 8.0.h),
                                child: customText(
                                    text: cubit.roombyId!.result!.name,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.sp),
                              ),
                              owner == idowner
                                  ? TextButton(
                                      onPressed: () async {
                                        {
                                          await _handleCameraAndMic(
                                              Permission.camera);
                                          await _handleCameraAndMic(
                                              Permission.microphone);
                                          // push video page with given channel name
                                          await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  CallPage(
                                                channelName: cubit
                                                    .roombyId!
                                                    .result!
                                                    .name,
                                                role: ClientRole
                                                    .Broadcaster,
                                                UserName: cubit.roombyId!
                                                    .result!.ownerName,
                                              ),
                                            ),
                                          );
                                        }
                                        ;
                                      },
                                      child: Container(
                                        height: 40.h,
                                        width: 100.w,
                                        decoration: BoxDecoration(
                                          gradient: const LinearGradient(
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                              colors: [
                                                Colors.indigo,
                                                mainColor,
                                              ]),
                                          borderRadius:
                                              BorderRadius.circular(
                                                  8.0.r),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceAround,
                                          // ignore: prefer_const_literals_to_create_immutables
                                          children: [
                                            Text(
                                              "Create meeting",
                                              style: TextStyle(
                                                  fontSize: 12.sp,
                                                  fontWeight:
                                                      FontWeight.w600,
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  : TextButton(
                                      onPressed: () {
                                        {
                                          // Navigator.of(context).push(
                                          //   MaterialPageRoute(builder: (context) =>   RoomsScreen(id: cubit.roombyInterest!
                                          //       .result!.)),
                                          // );

                                        }
                                        ;
                                      },
                                      child: Container(
                                        height: 40.h,
                                        width: 100.w,
                                        decoration: BoxDecoration(
                                          gradient: const LinearGradient(
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                              colors: [
                                                Colors.indigo,
                                                mainColor,
                                              ]),
                                          borderRadius:
                                              BorderRadius.circular(
                                                  8.0.r),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceAround,
                                          // ignore: prefer_const_literals_to_create_immutables
                                          children: [
                                            Text(
                                              "Join to meeting",
                                              style: TextStyle(
                                                  fontSize: 12.sp,
                                                  fontWeight:
                                                      FontWeight.w600,
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
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
                                  text: cubit.roombyId!.result!.ownerName,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.sp),
                            ],
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          customText(
                            fontSize: 25.sp,
                            fontWeight: FontWeight.normal,
                            text: "Overview",
                            color: Colors.black,
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          customText(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.normal,
                            text: cubit.roombyId!.result!.description,
                            alignment: Alignment.topLeft,
                            color: Colors.black54,
                          ),
                          Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: 15.w),
                            child: customText(
                              fontSize: 12.sp,
                              maxline: 3,
                              fontWeight: FontWeight.normal,
                              text: " this room started at " +
                                  cubit.roombyId!.result!.startDate +
                                  " and will end in " +
                                  cubit
                                      .roombyId!.result!.expectedEndDate +
                                  " we thank you to joined with us",
                              alignment: Alignment.center,
                            ),
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          TabBarPages(id: id,
                            cubit: cubit,

                          ),
//                           DefaultFormField(
//                             isobscureText: false,
//                             controller: nameController,
//                             inputAction: TextInputAction.next,
//                             label: 'Write Comment',
//                             prefix: Iconsax.message_add,
//                             suffix: IconButton(
//                                 onPressed: () {
//                                   Navigator.of(context).push(
//                                   MaterialPageRoute(builder: (context) =>   profilePage( )),
//                                   );
//                                   cubit.CreateQuestion(
//                                       description: nameController.text,
//                                       id: id.toString(),
//                                       title: nameController.text);
//                                   nameController.clear();
//                                   Fluttertoast.showToast(
//                                       msg: "commoented",
//                                       toastLength: Toast.LENGTH_LONG,
//                                       gravity: ToastGravity.TOP,
//                                       timeInSecForIosWeb: 3,
//                                       textColor: Colors.black,
//                                       backgroundColor: Colors.black45,
//                                       fontSize: 14.0.sp);
//                                 },
//                                 icon: const Icon(
//                                   Iconsax.send_14,
//                                   color: mainColor,
//                                 )),
//                             type: TextInputType.name,
//                             validator: (String value) {
//                               if (value.isEmpty) {
//                                 print("please enter username ");
//                               }
//                             },
//                           ),
//                           Expanded(
//                             child: ConditionalBuilder(
//                                 condition: cubit.questionModel != null,
//                                 builder: (context) {
//                                   return SingleChildScrollView(
//                                     child: SizedBox(
//                                       height: MediaQuery.of(context)
//                                               .size
//                                               .height *
//                                           0.40,
//                                       child: ListView.separated(
//                                           itemCount: cubit.questionModel!
//                                               .Questions!.length,
//                                           physics:
//                                               const BouncingScrollPhysics(),
//                                           separatorBuilder:
//                                               (context, index) =>
//                                                   const Divider(),
//                                           shrinkWrap: true,
//                                           itemBuilder: (context, index) {
//                                             return Column(
//                                               children: [
// //question widget for users
//                                                 Row(
//                                                   mainAxisAlignment:
//                                                       MainAxisAlignment
//                                                           .spaceBetween,
//                                                   children: [
//                                                     customText(
//                                                       color: Colors.black,
//                                                       fontWeight:
//                                                           FontWeight.bold,
//                                                       text: cubit
//                                                           .questionModel!
//                                                           .Questions![index]
//                                                           .userName!,
//                                                     ),
//                                                     IconButton(
//                                                         onPressed: () {},
//                                                         icon: Icon(
//                                                             Iconsax.more))
//                                                   ],
//                                                 ),
//                                                 Padding(
//                                                   padding:
//                                                       EdgeInsets.symmetric(
//                                                           horizontal:
//                                                               20.0.w),
//                                                   child: customText(
//                                                     color: Colors.black54,
//                                                     fontWeight:
//                                                         FontWeight.normal,
//                                                     text: cubit
//                                                         .questionModel!
//                                                         .Questions![index]
//                                                         .questionDescription,
//                                                   ),
//                                                 ),
//                                                 Padding(
//                                                   padding:
//                                                       EdgeInsets.symmetric(
//                                                           horizontal:
//                                                               18.0.w),
//                                                   child: Row(
//                                                     mainAxisAlignment:
//                                                         MainAxisAlignment
//                                                             .spaceBetween,
//                                                     children: [
//                                                       TextButton(
//                                                           onPressed: () {
//                                                             cubit.Getanswer(idquestion:cubit
//                                                                 .questionModel!
//                                                                 .Questions![index]
//                                                                 .id!.toString() );
//                                                             Navigator.of(
//                                                                     context)
//                                                                 .push(
//                                                               MaterialPageRoute(
//                                                                   builder:
//                                                                       (context) =>
//                                                                           QuestionScreen(
//                                                                             idQuestion:cubit
//                                                                                 .questionModel!
//                                                                                 .Questions![index]
//                                                                                 .id!.toString()  ,
//
//                                                                           )),
//                                                             );
//                                                           },
//                                                           child: Text(
//                                                               "View replies....")),
//                                                       Padding(
//                                                         padding:
//                                                             EdgeInsets.only(
//                                                                 right:
//                                                                     20.0.w),
//                                                         child: TextButton(
//                                                           onPressed: () {},
//                                                           child: customText(
//                                                             color: Colors
//                                                                 .black,
//                                                             fontWeight:
//                                                                 FontWeight
//                                                                     .bold,
//                                                             text: "Reply",
//                                                             alignment:
//                                                                 Alignment
//                                                                     .topRight,
//                                                           ),
//                                                         ),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 ),
//
//
//                                               ],
//                                             );
//                                           }),
//                                     ),
//                                   );
//                                 },
//                                 fallback: (BuildContext context) {
//                                   return Container(
//                                       color: Colors.white,
//                                       child: Center(child: spinkitCircle));
//                                 }),
//                           ),
                        ],
                      ),
                    ),
                  );
                },
                fallback: (BuildContext context) => Container(
                    color: Colors.white, child: Center(child: spinkitCircle)),
              );
            }));
  }

  Future<void> _handleCameraAndMic(Permission permission) async {
    final status = await permission.request();
    print(status);
  }
}
