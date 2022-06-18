import 'package:LearnUP/commponet/const.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

import '../../commponet/CustomText.dart';
import '../../commponet/commpnet.dart';
import '../../cubit/cubit.dart';
import '../../cubit/state.dart';
import '../login/cubit/cubit.dart';
import '../login/cubit/state.dart';
import 'RoomBycategory.dart';
import 'RoomsScreen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _searchScreenState();
}
var SearchController = TextEditingController();

class _searchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => learnUpCuibit(),

        child: BlocConsumer<learnUpCuibit, learnUpStates>(
            listener: (context, state) {

              if (state is SearchSuccessState) {

                learnUpCuibit.get(context).SearchR(Word:SearchController.text, SkipInterests: false, SkipRooms: false);

              }

              if(state is JoinRoomSuccessState){
                showToast(message: 'The request has been sent successfully', state: ToastStates.SUCCESS);


              }else if(state is JoinRoomErrorState){
                showToast(message: 'The request was not sent, please try again later', state: ToastStates.ERROR);

              }



            },
            builder: (context, state) {
              var cubit = learnUpCuibit.get(context);
              return Scaffold(
                appBar: AppBar(
                    elevation: 0.6,
                    // The search area here
                    title: Container(
                      width: double.infinity,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5)),
                      child: Center(
                        child: TextField( controller: SearchController,
                          decoration: InputDecoration(
                              prefixIcon: IconButton(
                                icon: const Icon(Iconsax.search_status),
                                onPressed: () {
                                  cubit.SearchR(Word:SearchController.text, SkipInterests: false, SkipRooms: false);
                                },
                              ),
                              suffixIcon: IconButton(
                                icon: const Icon(Icons.clear),
                                onPressed: () {
                                  SearchController.clear();


                                },
                              ),
                              hintText: 'Search...',
                              border: InputBorder.none),
                        ),
                      ),
                    )),
                body: SearchController.text.isNotEmpty?ConditionalBuilder(
                  condition: cubit.searchModel != null,
                  builder: (context) {
                    return SingleChildScrollView(

                      child: Padding(
                        padding:  EdgeInsets.symmetric(vertical: 15.0.h),
                        child: Column(
                          children: [

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: customText(fontWeight: FontWeight.bold,text:  "People ",fontSize: 20.sp, ),
                            ),
                            SizedBox(height: 10.h,),
                            //widget For users Search
                            cubit.searchModel!.result!.usersNumber!=0?  Padding(
                              padding:   EdgeInsets.symmetric(vertical: 10.0.h),
                              child: Container(
                                height: 150,
                                width: double.infinity,
                                child: ListView.separated(
                                    shrinkWrap: true,

                                    scrollDirection: Axis.horizontal,
                                    separatorBuilder:
                                        (BuildContext context, int index) {
                                      return SizedBox(width: 10.w,);
                                    },
                                    physics: const BouncingScrollPhysics(),
                                    itemCount: cubit.searchModel!.result!.usersNumber>6?6:cubit.searchModel!.result!.usersNumber,
                                    itemBuilder: (BuildContext context, int index) {
                                      return Column(
                                        children: [

                                          Container(
                                            height: 150,
                                            width: 100,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(15.r),
                                              color: Colors.grey.shade100,
                                            ),

                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                CircleAvatar(
                                                  child: Stack(
                                                    children: [
                                                      const Align(
                                                          alignment: Alignment.center,
                                                          child: const Icon(Iconsax.profile_2user)),
                                                      Align(
                                                          alignment: Alignment.topRight,
                                                          child: Container(
                                                            height: 10.h,
                                                            width: 10.w,
                                                            decoration:     BoxDecoration(
                                                                color: cubit
                                                                    .searchModel!
                                                                    .result!
                                                                    .users![index]
                                                                    .statusId ==
                                                                    "ACTIVE"
                                                                    ? Colors.green
                                                                    : Colors.grey,
                                                                shape: BoxShape.circle
                                                            ),
                                                            child: const Text(""),
                                                          )),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(height: 10,),
                                                customText(fontWeight: FontWeight.normal,text: cubit
                                                    .searchModel!.result!.users![index].name,alignment: Alignment.center,),

const SizedBox(height: 20,),
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: InkWell( onTap: (){


                                                  },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(4.r),
                                                        color: Colors.blue.shade100,
                                                      ),

                                                      alignment: Alignment.bottomCenter,

                                                      child: customText(fontWeight: FontWeight.normal,text: "Invite",alignment: Alignment.bottomCenter,)  ,
                                                    ),
                                                  ),
                                                )



                                              ],
                                            ),
                                          ),
                                        ],
                                      );
                                    }),
                              ),
                            ):const Center(child: Text("Nothing to see here - yet.")),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: customText(fontWeight: FontWeight.bold,text:  "Rooms ",fontSize: 20.sp, ),
                            ),
                            SizedBox(height: 10.h,),
                            //Widget For Search Rooms
                            cubit.searchModel!.result!.roomsNumber!=0?SizedBox(
                            height: 190.h,
                            width: double.infinity,
                            child: ListView.separated(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 15.0.w, vertical: 15.h),
                                  child: Container(
width: MediaQuery.of(context).size.width-35,
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
                                                text: cubit.searchModel!.result!.rooms![index].statusId,
                                              ),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                {
                                                  if (cubit.searchModel!.result!.rooms![index]
                                                      .userRoomStatus.id ==
                                                      "ACCEPTED"||cubit.searchModel!.result!.rooms![index]
                                                      .userRoomStatus.id == "JOINED") {
                                                    Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (context) => RoomsScreen(
                                                              id: cubit.searchModel!.result!.rooms![index].id)),
                                                    );
                                                  } else if (cubit.searchModel!.result!.rooms![index]
                                                      .userRoomStatus.id ==
                                                      "NO_REQUEST") {
                                                    cubit.joinRoom(cubit.searchModel!.result!.rooms![index].id
                                                        .toString());
                                                  } else {

                                                    showtoast(
                                                        "Owner Reject you, please  try again later",
                                                        Colors.red);
                                                  }
                                                }
                                                ;
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
                                                      cubit.searchModel!.result!.rooms![index]
                                                          .userRoomStatus.nameEnglish=="not joined"?"Join":  cubit.searchModel!.result!.rooms![index]
                                                          .userRoomStatus.nameEnglish,
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
                                            text:cubit.searchModel!.result!.rooms![index].name,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                                          child: customText(
                                            maxline: 1,
                                            fontWeight: FontWeight.normal,
                                            text:  cubit.searchModel!.result!.rooms![index].numberOfJoinedUsers.toString()=="0"?"no listening": cubit.searchModel!.result!.rooms![index].numberOfJoinedUsers.toString()+"  listening",
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
                                                        text: cubit.searchModel!.result!.rooms![index].ownerName,
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
                                                      text: cubit.searchModel!.result!.rooms![index].description,
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
                              itemCount: cubit.searchModel!.result!.rooms!.length>6?20:cubit.searchModel!.result!.rooms!.length,
                              physics: const BouncingScrollPhysics(),
                              separatorBuilder: (context, index) => SizedBox(
                                width: 20.w,
                              ),

                            ),
                          ):const Center(child: Text("Nothing to see here - yet.")),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: customText(
                                fontWeight: FontWeight.bold,
                                maxline: 1,
                                fontSize: 20.sp,
                                text: 'Category',
                              ),
                            ),

                            SizedBox(
                              height: 12.h,
                            ),
                            //Widget for Category
                            cubit.searchModel!.result!.interestsNumber!=0? SizedBox(
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
                                                cubit.searchModel!.result!.interests![index].id)),
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
                                                text: cubit.searchModel!.result!.interests![index].id,
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
                            itemCount: cubit.searchModel!.result!.interestsNumber > 6
                                ? 6
                                : cubit.searchModel!.result!.interestsNumber),
                      ):const Center(child: Text("Nothing to see here - yet."))

                          ],
                        ),
                      ),
                    );
                  },
                  fallback: (BuildContext context) => Container(
                      color: Colors.white, child: Center(child: spinkitCircle)),
                ):
                SingleChildScrollView(
                  child: Container( color:Colors.white,child: Column(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center( child:  Image.asset('assets/search.jpg'),),
                       Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: customText(fontWeight: FontWeight.bold,text: "Try searching for people,rooms,topics,or keywords",
                          color: Colors.black,
                          fontSize: 20 .sp,alignment: Alignment.center,),
                       )
                    ],
                  )),
                ),
              );
            }));
  }
}
