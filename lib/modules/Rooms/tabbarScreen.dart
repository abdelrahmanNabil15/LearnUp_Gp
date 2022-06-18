import 'dart:convert';

import 'package:LearnUP/i_cons_icons.dart';
import 'package:agora_uikit/agora_uikit.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart ';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';

import '../../commponet/CustomText.dart';
import '../../commponet/DefaultFormField.dart';
import '../../commponet/commpnet.dart';
import '../../commponet/const.dart';
import '../../network/CacheHelper.dart';
import '../../network/DioHelper.dart';
import '../../network/end_pionts.dart';
import 'QuestionScreen.dart';
import 'package:mime_type/mime_type.dart';

class TabBarPages extends StatefulWidget {
  @override
  final cubit, id,UserId;

  const TabBarPages({Key? key, this.cubit, this.id, this.UserId}) : super(key: key);


  tabBarPagesState createState() => tabBarPagesState();
}
dynamic Idowner = CacheHelper.getData(key: 'id');

final _answerkey = GlobalKey<FormState>();
final _QuestionKey = GlobalKey<FormState>();

class tabBarPagesState extends State<TabBarPages> {
  var QuestionsController = TextEditingController();
  var AnswerController = TextEditingController();

  bool submit = false;

  void initState() {
    // TODO: implement initState
    super.initState();
    QuestionsController.addListener(() {
      setState(() {
        submit = QuestionsController.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    QuestionsController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Expanded(
        child: Column(
          children: <Widget>[
            // construct the profile details widget here

            // the tab bar with three items
            SizedBox(
              child: TabBar(
                indicatorColor: mainColor,
                isScrollable: true,
                tabs: [
                  Tab(
                    child: Row(
                      children: [
                        Icon(Iconsax.message_question),
                        SizedBox(
                          width: 5.w,
                        ),
                        Text(" questions  "),
                      ],
                    ),
                  ),
                  Tab(
                    child: Row(
                      children: [
                        Icon(Icons.file_open_outlined),
                        SizedBox(
                          width: 5.w,
                        ),
                        Text(" metrials  "),
                      ],
                    ),
                  ),
                  Tab(
                    child: Row(
                      children: [
                        Icon(Iconsax.user),
                        SizedBox(
                          width: 5.w,
                        ),
                        Text("Joined users"),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // create widgets for each tab bar here
            Expanded(
              child: TabBarView(
                children: [
                  // first tab bar view widget
                  Container(
                    color: Colors.white,
                    child: Scaffold(
                      body: ListView(
                        physics: BouncingScrollPhysics(),
                        children: [
                          ConditionalBuilder(
                              condition: widget.cubit.questionModel != null,
                              builder: (context) {
                                return ListView.separated(
                                    itemCount: widget
                                        .cubit.questionModel!.Questions!.length,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    separatorBuilder: (context, index) =>
                                        const Divider(),
                                    itemBuilder: (context, index) {
                                      return Column(
                                        children: [
//question widget for users
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              customText(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                text: widget
                                                    .cubit
                                                    .questionModel!
                                                    .Questions![index]
                                                    .userName!,
                                              ),
                                              IconButton(
                                                  onPressed: () async {
                                                    showModalBottomSheet(
                                                        isScrollControlled:
                                                            true,
                                                        context: context,
                                                        backgroundColor:
                                                            Colors.transparent,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      30.0.r),
                                                        ),
                                                        builder: (context) =>
                                                            DraggableScrollableSheet(
                                                                initialChildSize:
                                                                    0.2,
                                                                minChildSize:
                                                                    0.0,
                                                                maxChildSize:
                                                                    0.3,
                                                                builder: (_,
                                                                        controller) =>
                                                                    Container(
                                                                      decoration: const BoxDecoration(
                                                                          color: Colors
                                                                              .white,
                                                                          borderRadius:
                                                                              BorderRadius.vertical(top: Radius.circular(20))),
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            EdgeInsets.only(
                                                                          top: 20.0
                                                                              .h,
                                                                        ),
                                                                        child: Column(
                                                                            children: [
                                                                              TextButton(
                                                                                  onPressed: () {},
                                                                                  child: Row(
                                                                                    children: [
                                                                                      Padding(
                                                                                        padding: EdgeInsets.only(left: 20.w),
                                                                                        child: const Icon(Icons.edit, color: Colors.grey),
                                                                                      ),
                                                                                      SizedBox(
                                                                                        width: 15.w,
                                                                                      ),
                                                                                      customText(
                                                                                        fontWeight: FontWeight.bold,
                                                                                        text: "Edit question",
                                                                                      ),
                                                                                    ],
                                                                                  )),
                                                                              TextButton(
                                                                                  onPressed: () {
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
                                                                                        padding: EdgeInsets.only(left: 20.w),
                                                                                        child: Icon(Icons.delete_forever, color: Colors.grey),
                                                                                      ),
                                                                                      SizedBox(
                                                                                        width: 15.w,
                                                                                      ),
                                                                                      customText(
                                                                                        fontWeight: FontWeight.bold,
                                                                                        text: "Delete question",
                                                                                      ),
                                                                                    ],
                                                                                  ))
                                                                            ]),
                                                                      ),
                                                                    )));
                                                  },
                                                  icon: Icon(Iconsax.more))
                                            ],
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 20.0.w),
                                            child: customText(
                                              color: Colors.black54,
                                              fontWeight: FontWeight.normal,
                                              text: widget
                                                  .cubit
                                                  .questionModel!
                                                  .Questions![index]
                                                  .questionDescription,
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 18.0.w),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                TextButton(
                                                    onPressed: () {
                                                      widget.cubit.Getanswer(
                                                          idquestion: widget
                                                              .cubit
                                                              .questionModel!
                                                              .Questions![index]
                                                              .id!
                                                              .toString());
                                                      Navigator.of(context)
                                                          .push(
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                QuestionScreen(
                                                                  idQuestion: widget
                                                                      .cubit
                                                                      .questionModel!
                                                                      .Questions![
                                                                          index]
                                                                      .id!
                                                                      .toString(),
                                                                )),
                                                      );
                                                    },
                                                    child: Text(
                                                        "View replies....")),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      right: 20.0.w),
                                                  child: TextButton(
                                                    onPressed: () {
                                                      Future.delayed(
                                                          const Duration(
                                                              seconds: 0),
                                                          () => showDialog(
                                                              context: context,
                                                              builder:
                                                                  (context) =>
                                                                      AlertDialog(
                                                                        title: customText(
                                                                            maxline:
                                                                                1,
                                                                            fontWeight: FontWeight
                                                                                .bold,
                                                                            text:
                                                                                "Replying ..",
                                                                            fontSize:
                                                                                18.sp,
                                                                            color: Colors.black),
                                                                        content:
                                                                            Form(
                                                                          key:
                                                                              _answerkey,
                                                                          child:
                                                                              TextFormField(
                                                                            controller:
                                                                                AnswerController,
                                                                            decoration:
                                                                                InputDecoration(hintText: "add your answer", hintStyle: TextStyle(color: Colors.grey)),
                                                                            validator:
                                                                                (val) {
                                                                              if (val == null || val.isEmpty) {
                                                                                return 'Replying .. ';
                                                                              }
                                                                              return null;
                                                                            },
                                                                          ),
                                                                        ),
                                                                        actions: <
                                                                            Widget>[
                                                                          Row(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.end,
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.end,
                                                                            children: [
                                                                              TextButton(
                                                                                onPressed: () {
                                                                                  Navigator.pop(context, 'Cancel');
                                                                                  Navigator.pop(context, 'Cancel');
                                                                                },
                                                                                child: customText(maxline: 1, fontWeight: FontWeight.bold, text: 'Cancel', color: Colors.black),
                                                                              ),
                                                                              TextButton(
                                                                                onPressed: () {
                                                                                  if (_answerkey.currentState!.validate()) {
                                                                                    widget.cubit.AddAnswers(YourAnwer: AnswerController.text, id: widget.id, Idansweer: widget.cubit.questionModel!.Questions![index].id.toString());
                                                                                    AnswerController.clear();
                                                                                    Navigator.pop(context, 'Confirm');
                                                                                    Navigator.pop(context, 'Confirm');
                                                                                  }
                                                                                },
                                                                                child: customText(maxline: 1, fontWeight: FontWeight.bold, text: 'Confirm', fontSize: 16.sp, color: mainColor),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ],
                                                                      )));
                                                    },
                                                    child: customText(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      text: "Reply",
                                                      alignment:
                                                          Alignment.topRight,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      );
                                    });
                              },
                              fallback: (BuildContext context) {
                                return Container(
                                    color: Colors.white,
                                    child: Center(child: spinkitCircle));
                              }),
                        ],
                      ),
                      floatingActionButton: FloatingActionButton(
                        backgroundColor: mainColor,
                        child: const Icon(Iconsax.message_add),
                        onPressed: () {
                          Future.delayed(
                              const Duration(seconds: 0),
                              () => showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                        title: customText(
                                            maxline: 1,
                                            fontWeight: FontWeight.bold,
                                            text: "Ask Qusetion ..",
                                            fontSize: 18.sp,
                                            color: Colors.black),
                                        content: Form(
                                          key: _QuestionKey,
                                          child: TextFormField(
                                            controller: QuestionsController,
                                            decoration: InputDecoration(
                                                hintText: "add your Question!",
                                                hintStyle: TextStyle(
                                                    color: Colors.grey)),
                                            validator: (val) {
                                              if (val == null || val.isEmpty) {
                                                return "can't be empty.. ";
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                        actions: <Widget>[
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(
                                                      context, 'Cancel');

                                                  QuestionsController.clear();
                                                },
                                                child: customText(
                                                    maxline: 1,
                                                    fontWeight: FontWeight.bold,
                                                    text: 'Cancel',
                                                    color: Colors.black),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  if (_QuestionKey.currentState!
                                                      .validate()) {
                                                    submit
                                                        ? widget.cubit.CreateQuestion(
                                                            description:
                                                                QuestionsController
                                                                    .text,
                                                            id: widget.id
                                                                .toString(),
                                                            title:
                                                                QuestionsController
                                                                    .text)
                                                        : null;
                                                    QuestionsController.clear();
                                                  }
                                                },
                                                child: customText(
                                                    maxline: 1,
                                                    fontWeight: FontWeight.bold,
                                                    text: 'Confirm',
                                                    fontSize: 16.sp,
                                                    color: mainColor),
                                              ),
                                            ],
                                          ),
                                        ],
                                      )));
                        },
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.red,
                    child: Scaffold(
                      body: ConditionalBuilder(
                        condition: widget.cubit.materialsModel != null,
                        builder: (context) {
                          return ListView.separated(
                            physics: BouncingScrollPhysics(),
                            itemCount:
                                widget.cubit.materialsModel["result"].length,
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return const Divider(
                                color: Colors.white,
                              );
                            },
                            itemBuilder: (BuildContext context, int index) {
                              return ListTile(
                                title: Card(
                                  elevation: 6,
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      child: Icon(Iconsax.document),
                                    ),
                                    title: Text(widget.cubit
                                            .materialsModel["result"]![index]
                                        ["fileName"]),
                                    trailing: Icon(Icons.download),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        fallback: (BuildContext context) => Container(
                            color: Colors.white,
                            child: Center(child: spinkitCircle)),
                      ),
                      floatingActionButton:_getFAB()


                    ),
                  ),

                  /// second tab bar viiew user join
                  Container(
                      color: Colors.white,
                      child: ConditionalBuilder(
                        condition: widget.cubit.GetRoomReportsModel["result"] != null,
                        builder: (context) {
                          return ListView.separated(
                            physics: BouncingScrollPhysics(),
                            itemCount: widget
                                .cubit
                                .GetRoomReportsModel["result"]
                                    ["joinedUserRoomActivities"]
                                .length,
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return Divider(
                                color: Colors.white,
                              );
                            },
                            itemBuilder: (BuildContext context, int index) {
                              return ListTile(
                                title: Card(
                                  elevation: 6,
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      child: Icon(Iconsax.profile_2user),
                                    ),
                                    title: Text(widget.cubit
                                                .GetRoomReportsModel["result"][
                                            "joinedUserRoomActivities"][index]
                                        ["userName"]),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        fallback: (BuildContext context) => Container(
                            color: Colors.white,
                            child: Center(child: spinkitCircle)),
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
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

  Widget _getFAB() {
    if (widget.UserId==Idowner) {
      return FloatingActionButton(
        onPressed: () {
          widget.cubit.pickFiles(IdRoomfile: widget.id.toString(),filetype:"All" );

          widget.cubit.GetMaterial(idRoom: widget.id.toString());
        },
        child: Icon(Iconsax.document_upload),
        backgroundColor: mainColor,
      );;
    } else {
      return Container();
    }
  }
}
