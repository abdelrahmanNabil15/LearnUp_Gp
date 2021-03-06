import 'package:LearnUP/modules/Rooms/tabbarScreen.dart';
import 'package:agora_uikit/agora_uikit.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:icon_badge/icon_badge.dart';
import 'package:iconsax/iconsax.dart';


import '../../commponet/CustomText.dart';
import '../../commponet/DefaultFormField.dart';
import '../../commponet/commpnet.dart';
import '../../commponet/const.dart';
import '../../commponet/defult_button.dart';
import '../../cubit/cubit.dart';
import '../../cubit/state.dart';
import '../../network/CacheHelper.dart';
import '../../videoCall/call.dart';
import '../Report/ReportRoomById.dart';
import '../Report/ReportRoomJoined.dart';
import '../inviteion/inviteUesr.dart';
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
  var appBarHeight = AppBar().preferredSize.height;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => learnUpCuibit()
          ..GetRoombyId(id)
          ..RequestedUsers(id.toString())
          ..GetQuestions(idRoom: id.toString())..GetMaterial(idRoom: id.toString())..GetRoomReports(idroom: id.toString())  ,
        child: BlocConsumer<learnUpCuibit, learnUpStates>(
            listener: (context, state) {

              if(state is UploadFilesSuccessState){
                showToast(message: 'The file has been uploaded successfully', state: ToastStates.SUCCESS);
                learnUpCuibit.get(context).GetMaterial(idRoom: id.toString());

              }else if(state is UploadFilesErrorState){
                showToast(message: 'The file was not uploaded, please try again later', state: ToastStates.ERROR);
                learnUpCuibit.get(context).GetMaterial(idRoom: id.toString());
              }

              },
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
                          condition:cubit.requesteduserss!=null&&owner == idowner,
                          builder: (context) {
                            return Row(

                              children: [
                                IconBadge(
                                  icon: const Icon(Iconsax.notification_status),
                                  itemCount:cubit.roombyId!.result!.numberOfRequestedUsers,
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
                                ),
                                PopupMenuButton(

                                    itemBuilder:(context) => [

                                      PopupMenuItem(
                                        child: const Text("ReportRooms"),
                                        onTap: (){
                                        },
                                        value: 1,
                                      ),
                                      const PopupMenuItem(
                                        child: Text("Invite friend"),
                                        value: 2,
                                      )
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
                                        navigateTo(context, ReportRoomById(IdReport: id.toString(), ));
                                      }
                                      if(value==2){

                                        navigateTo(context, IniviteScreen(RoomIds: id.toString(), ));
                                      }


                                  },
                                )
                              ],
                            );
                          },
                          fallback: (context) => const Text(""),
                        ),
                      ],
                      title: customText(
                          text: cubit.roombyId!.result!.name,
                          fontWeight: FontWeight.bold,
                          maxline: 1,
                          fontSize: 20.sp),
                    ),
                    body: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 13.w),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(vertical: 8.0.h),
                                  child: customText(
                                    maxline: null,
                                      text: cubit.roombyId!.result!.name,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.sp),
                                ),
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
                                                channelName: cubit.roombyId!.result!.name,
                                                role: ClientRole.Broadcaster,
                                                UserName: cubit.roombyId!.result!.ownerName,
                                              ),




                                            ),
                                          );
                                        }

                                      },
                                      child: Container (
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
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                              builder: (context) =>

                                              CallPage(
                                                channelName: cubit.roombyId!.result!.name,
                                                role: ClientRole.Broadcaster,
                                                UserName: cubit.roombyId!.result!.ownerName,
                                              )));

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
                                  cubit.roombyId!.result!.startDate + " and will end in " +
                                  cubit.roombyId!.result!.expectedEndDate + " we thank you to joined with us",
                              alignment: Alignment.center,
                            ),
                          ),

                          TabBarPages(id: id,
                            cubit: cubit,UserId: cubit.roombyId!.result!.ownerId,

                          ),

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
