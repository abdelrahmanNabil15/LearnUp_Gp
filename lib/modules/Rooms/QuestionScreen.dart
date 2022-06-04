import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:untitled2/i_cons_icons.dart';

import '../../commponet/CustomText.dart';
import '../../commponet/commpnet.dart';
import '../../commponet/const.dart';
import '../../cubit/cubit.dart';
import '../../cubit/state.dart';

class QuestionScreen extends StatelessWidget {
  final String idQuestion;
  var interestController = TextEditingController();
  var AnswerController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  QuestionScreen({Key? key, required this.idQuestion}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) =>
            learnUpCuibit()..Getanswer(idquestion: idQuestion.toString()),
        child: BlocConsumer<learnUpCuibit, learnUpStates>(
            listener: (context, state) {
          print(learnUpCuibit.get(context).answerModel);
        }, builder: (context, Object? state) {
          var cubit = learnUpCuibit.get(context);
          return ConditionalBuilder(
            condition: cubit.answerModel != null,
            builder: (context) {
              return Scaffold(
                appBar: AppBar(),
                body: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          customText(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            text: cubit.answerModel!.Questions!.userName!,
                          ),
                          IconButton(
                              onPressed: () {
                                showModalBottomSheet(
                                    isScrollControlled: true,
                                    context: context,
                                    backgroundColor: Colors.transparent,
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(30.0.r),
                                    ),
                                    builder: (context) =>
                                        DraggableScrollableSheet(
                                            initialChildSize: 0.2,
                                            minChildSize: 0.1,
                                            maxChildSize: 0.3,
                                            builder:
                                                (_, controller) => Container(
                                                      decoration: const BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius.vertical(
                                                                  top: Radius
                                                                      .circular(
                                                                          20))),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                          top: 20.0.h,
                                                        ),
                                                        child: Column(
                                                            children: [
                                                              TextButton(
                                                                  onPressed:
                                                                      () {},
                                                                  child: Row(
                                                                    children: [
                                                                      Padding(
                                                                        padding:
                                                                            EdgeInsets.only(left: 20.w),
                                                                        child: const Icon(
                                                                            Icons
                                                                                .edit,
                                                                            color:
                                                                                Colors.grey),
                                                                      ),
                                                                      SizedBox(
                                                                        width:
                                                                            15.w,
                                                                      ),
                                                                      customText(
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        text:
                                                                            "Edit question",
                                                                      ),
                                                                    ],
                                                                  )),
                                                              TextButton(
                                                                  onPressed:
                                                                      () {
                                                                    Future.delayed(
                                                                        const Duration(seconds: 0),
                                                                        () => showDialog(
                                                                            context: context,
                                                                            builder: (context) => AlertDialogs(
                                                                                  context,
                                                                                  "Delete question?",
                                                                                  "This can't be undone and it will be removed form your room",
                                                                                )));
                                                                  },
                                                                  child: Row(
                                                                    children: [
                                                                      Padding(
                                                                        padding:
                                                                            EdgeInsets.only(left: 20.w),
                                                                        child: Icon(
                                                                            Icons
                                                                                .delete_forever,
                                                                            color:
                                                                                Colors.grey),
                                                                      ),
                                                                      SizedBox(
                                                                        width:
                                                                            15.w,
                                                                      ),
                                                                      customText(
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        text:
                                                                            "Delete question",
                                                                      ),
                                                                    ],
                                                                  ))
                                                            ]),
                                                      ),
                                                    )));
                              },
                              icon: Icon(Icons.more_vert_outlined))
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                      child: customText(
                        color: Colors.black54,
                        fontWeight: FontWeight.normal,
                        text: cubit.answerModel!.Questions!.questionDescription,
                      ),
                    ),
                    Divider(),
                    // answer Lists  widgets for user
                    Expanded(
                      child: ListView.separated(
                          itemCount:
                              cubit.answerModel!.Questions!.answers!.length,
                          physics: const BouncingScrollPhysics(),
                          separatorBuilder: (context, index) => SizedBox(
                                height: 20.h,
                              ),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 30.w),
                                  child: Row(  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      customText(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        text: cubit.answerModel!.Questions!
                                            .answers![index].userName,
                                      ),
                                      //icon more


                                      IconButton(
                                          onPressed: () {
                                            showModalBottomSheet(
                                                isScrollControlled: true,
                                                context: context,
                                                backgroundColor: Colors.transparent,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(30.0.r),
                                                ),
                                                builder: (context) =>
                                                    DraggableScrollableSheet(
                                                        initialChildSize: 0.2,
                                                        minChildSize: 0.1,
                                                        maxChildSize: 0.3,
                                                        builder:
                                                            (_, controller) => Container(
                                                          decoration: const BoxDecoration(
                                                              color: Colors.white,
                                                              borderRadius:
                                                              BorderRadius.vertical(
                                                                  top: Radius
                                                                      .circular(
                                                                      20))),
                                                          child: Padding(
                                                            padding:
                                                            EdgeInsets.only(
                                                              top: 20.0.h,
                                                            ),
                                                            child: Column(
                                                                children: [
                                                                  TextButton(
                                                                      onPressed:
                                                                          () {},
                                                                      child: Row(
                                                                        children: [
                                                                          Padding(
                                                                            padding:
                                                                            EdgeInsets.only(left: 20.w),
                                                                            child: const Icon(
                                                                                Icons
                                                                                    .edit,
                                                                                color:
                                                                                Colors.grey),
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                            15.w,
                                                                          ),
                                                                          customText(
                                                                            fontWeight:
                                                                            FontWeight.bold,
                                                                            text:
                                                                            "Edit answer",
                                                                          ),
                                                                        ],
                                                                      )),

                                                                  TextButton(
                                                                      onPressed:
                                                                          () {
                                                                        Future.delayed(
                                                                            const Duration(seconds: 0),
                                                                                () => showDialog(
                                                                                context: context,
                                                                                builder: (context) => AlertDialogs(
                                                                                  context,
                                                                                  "Delete answer?",
                                                                                  "This can't be undone and it will be removed form your room",
                                                                                )));
                                                                      },
                                                                      child: Row(
                                                                        children: [
                                                                          Padding(
                                                                            padding:
                                                                            EdgeInsets.only(left: 20.w),
                                                                            child: Icon(
                                                                                Icons
                                                                                    .delete_forever,
                                                                                color:
                                                                                Colors.grey),
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                            15.w,
                                                                          ),
                                                                          customText(
                                                                            fontWeight:
                                                                            FontWeight.bold,
                                                                            text:
                                                                            "Delete answer",
                                                                          ),
                                                                        ],
                                                                      ))
                                                                ]),
                                                          ),
                                                        )));
                                          },
                                          icon: Icon(Icons.more_vert))
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 40.0.w),
                                  child: customText(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.normal,
                                    text: cubit.answerModel!.Questions!
                                        .answers![index].answerDescription,
                                  ),
                                )
                              ],
                            );
                          }),
                    ),

                    //answer contianer
                    Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(
                            top: BorderSide(
                              //                   <--- left side
                              color: Colors.grey,
                              width: 0.7.w,
                            ),
                          ),
                        ),
                        height: 127.h,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: [
                            //mention host of qusetion
                            Padding(
                              padding:  EdgeInsets.only(top: 8.0.h),
                              child: Row(children: [
                                customText(
                                  color: Colors.grey.shade500,
                                  fontWeight: FontWeight.normal,
                                  text: "Replying to ",
                                ),
                                customText(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.normal,
                                  text:  cubit.answerModel!.Questions!.userName,
                                ),

                              ],),
                            ),
                            // textFormField for answer
                            TextFormField(
                              controller:AnswerController ,
                              validator:  (val) {
                                if (val == null || val.isEmpty) {
                                  return 'Enter start date  please';
                                }
                                return null;
                              },


                            ),
                            // button answer to  question
                            Align(
                                alignment: Alignment.bottomRight,
                                child: Padding(
                                  padding:
                                        EdgeInsets.only(right: 10.0.w),
                                  child: ElevatedButton(
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  mainColor),
                                          shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          18.0),
                                                  side: const BorderSide(
                                                      color: mainColor)))),
                                      onPressed: () {},
                                      child: const Text(
                                        'Reply',
                                        style:
                                            TextStyle(color: Colors.white),
                                      )),
                                )),
                          ],
                        ))
                  ],
                ),
                // bottomSheet:
              );
            },
            fallback: (BuildContext context) => Container(
                color: Colors.white, child: Center(child: spinkitCircle)),
          );
        }));
  }

  Widget AlertDialogs(
    BuildContext context,
    String title,
    content,
  ) {
    return AlertDialog(
      title: customText(
          maxline: 1,
          fontWeight: FontWeight.bold,
          text: title,
          fontSize: 20.sp,
          color: Colors.black),
      content: Text(content),
      actions: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: customText(
                  maxline: 1,
                  fontWeight: FontWeight.bold,
                  text: 'Cancel',
                  color: Colors.black),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, 'Delete');
              },
              child: customText(
                  maxline: 1,
                  fontWeight: FontWeight.bold,
                  text: 'Delete',
                  fontSize: 18.sp,
                  color: Colors.black),
            ),
          ],
        ),
      ],
    );
  }
}
