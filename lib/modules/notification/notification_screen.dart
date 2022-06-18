// ignore_for_file: camel_case_types

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../commponet/CustomText.dart';
import '../../commponet/commpnet.dart';
import '../../commponet/const.dart';
import '../../cubit/cubit.dart';
import '../../cubit/state.dart';

class Notification_screen extends StatefulWidget{
  const Notification_screen({Key? key}) : super(key: key);

  @override
  State<Notification_screen> createState() => _notification_screenState();
}


class _notification_screenState extends State<Notification_screen> {


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) =>
        learnUpCuibit()..GetInvites() ,
        child: BlocConsumer<learnUpCuibit, learnUpStates>(
        listener: (context, state) {

      if(state is AcceptInvitesSuccessState){
        showToast(message: 'invite accepted', state: ToastStates.SUCCESS);
        learnUpCuibit.get(context).GetInvites() ;


      }
      else if(state is AcceptInvitesErrorState){

        showToast(message:
            state.error=="ALREADY_REQUESTED_TO_ROOM"?'Alredy accepted ,':"Alredy accepted ",
            state: ToastStates.ERROR);
        learnUpCuibit.get(context).GetInvites()   ;

      }
      if(state is RejectInvitesSuccessState){
        showToast(message: ' invite rejected', state: ToastStates.SUCCESS);
        learnUpCuibit.get(context).GetInvites() ;


      }
      else if(state is RejectInvitesErrorState){
        showToast(message:
        state.error=="ALREADY_REQUESTED_TO_ROOM"?'Already invite rejected,' :"Already invite rejected",
            state: ToastStates.ERROR);
        learnUpCuibit.get(context).GetInvites()  ;

      }

    },
    builder: (context, Object? state) {
    var cubit = learnUpCuibit.get(context);

    return ConditionalBuilder(
    fallback: (BuildContext context) => Container(
    color: Colors.white, child: Center(child: spinkitCircle)),
    condition: cubit.Myinvite["result"]!= null,
    builder: (context) {
    return  Scaffold(
        appBar: AppBar( title: const Text(" LEARN UP "), ),
        body: SafeArea(
          child: ListView.separated(
              separatorBuilder:
                  (BuildContext context, int index) {
                return SizedBox(height: 20.h,);
              },
            itemCount: cubit.Myinvite["result"].length,
              scrollDirection: Axis.vertical,
            itemBuilder: (context, index) =>

            // Display the list item
             Expanded(
              child: Container(

                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.r),
                  color: Colors.grey.shade100,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(text:"@"+cubit.Myinvite["result"][index]["ownerName"], style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue,)),
                          const TextSpan(text: ' invited you to visit his room '),
                          TextSpan(text:cubit.Myinvite["result"][index]["roomName"],style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue,fontSize: 18) ),

                        ],

                      ),

                    ),
                        Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            customText(fontWeight: FontWeight.bold,text: "Status: ",),
                            customText(fontWeight: FontWeight.bold,text:
                            cubit.Myinvite["result"][index]["statusId"]=="ACCEPTED"?"Accepted":
                            cubit.Myinvite["result"][index]["statusId"]=="REJECTED"?"Rejected":"Pending",
                              color: cubit.Myinvite["result"][index]["statusId"]=="ACCEPTED"?Colors.green:cubit.Myinvite["result"][index]["statusId"]=="REJECTED"?Colors.red:Colors.blue,)

                          ],
                        ),

                        cubit.Myinvite["result"][index]["statusId"]=="ACCEPTED"||
                            cubit.Myinvite["result"][index]["statusId"]=="REJECTED"?

                        const Text(""): Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: mainColor, // background
                                onPrimary: Colors.white, // foreground
                              ),
                              onPressed: () {

                                cubit.AcceptInvites(InviteId: cubit.Myinvite["result"][index]["id"].toString());

                                },
                              child: Text('Accept'),
                            ),
                            SizedBox(width: 50.w,),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.grey.shade500, // background
                                onPrimary: Colors.white, // foreground
                              ),
                              onPressed: () {
                                cubit.RejectInvites(InviteId: cubit.Myinvite["result"][index]["id"].toString());
                              },
                              child: Text('Remove'),
                            ),
                          ],
                        )




                  ]),
                ),
              ),
            )
          ),
        ));}

    );}));
  }
}
