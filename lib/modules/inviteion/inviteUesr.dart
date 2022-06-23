import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
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

class IniviteScreen extends StatefulWidget {
  const IniviteScreen({Key? key, required this.RoomIds}) : super(key: key);
final RoomIds;
  @override
  State<IniviteScreen> createState() => _iniviteScreenState();
}
var SearchController = TextEditingController();

class _iniviteScreenState extends State<IniviteScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => learnUpCuibit() ,

        child: BlocConsumer<learnUpCuibit, learnUpStates>(
            listener: (context, state) {

                if (state is SearchSuccessState) {
                  learnUpCuibit.get(context).SearchR(Word:SearchController.text, SkipInterests: false, SkipRooms: false);

                }
                if(state is InvitesSuccessState){
                  showToast(message: 'the invitation has been sent successfully', state: ToastStates.SUCCESS);
                  learnUpCuibit.get(context).GetRoomByInterest("my-first-interest");

                }else if(state is InvitesErrorState){
                  showToast(message:  state.error=="ALREADY_REQUESTED_TO_ROOM"?"Aleady requested to this room":"Aleady requested to this room", state: ToastStates.ERROR);
                  learnUpCuibit.get(context).GetRoomByInterest("my-first-interest")  ;
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
                                  setState(() {

                                  });

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
                    return ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: cubit.searchModel!.result!.usersNumber,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            title: Card(
                              elevation: 6,
                              child: ListTile(
                                leading: CircleAvatar(
                                  child: Stack(
                                    children: [
                                      Align(
                                          alignment: Alignment.center,
                                          child: Icon(Iconsax.profile_2user)),
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
                                              child: Text(""),
                                               )),
                                    ],
                                  ),
                                ),
                                title: Text(cubit
                                    .searchModel!.result!.users![index].name),
                                subtitle: Text(cubit.searchModel!.result!
                                    .users![index].userName),
                                trailing: IconButton(
                                  icon: const Icon(Iconsax.profile_add),
                                  onPressed: () {
                                   cubit. Invites(UserId:cubit. searchModel!.result!.users![index].id,RoomId:widget.RoomIds );
                                  },
                                ),
                              ),
                            ),
                          );
                        });
                  },
                  fallback: (BuildContext context) => Container(
                      color: Colors.white, child: Center(child: spinkitCircle)),
                ):
                Container( color:Colors.white,child: Column(mainAxisAlignment: MainAxisAlignment.start,
                children: [

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: customText(fontWeight: FontWeight.bold,text: "Try searching for people....",
                      color: Colors.grey,
                      fontSize: 12.sp,alignment: Alignment.center,),
                  )
                ],
              )),
              );
            }));
  }
}
