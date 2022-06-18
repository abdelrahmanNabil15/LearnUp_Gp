import 'package:LearnUP/modules/Rooms/RoomsScreen.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

import '../../commponet/CustomText.dart';
import '../../commponet/commpnet.dart';
import '../../commponet/const.dart';
import '../../cubit/cubit.dart';
import '../../cubit/state.dart';
import '../../network/CacheHelper.dart';

class QuestionScreen extends StatelessWidget {
  final String idQuestion;
  dynamic idowner = CacheHelper.getData(key: 'id');
  var interestController = TextEditingController();
  var AnswerController = TextEditingController();
  var AddAnswerController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _formKey1 = GlobalKey<FormState>();

  QuestionScreen({Key? key, required this.idQuestion}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) =>
            learnUpCuibit()..Getanswer(idquestion: idQuestion.toString()),
        child: BlocConsumer<learnUpCuibit, learnUpStates>(
            listener: (context, state) {

              if(state is AddanswerSuccessState){
                showToast(message: ' added successfully', state: ToastStates.SUCCESS);
                learnUpCuibit.get(context).Getanswer(idquestion: idQuestion.toString());
              }

              if(state is UpdateanswerSuccessState){
                showToast(message: " Updated successfully", state: ToastStates.SUCCESS);
                learnUpCuibit.get(context).Getanswer(idquestion: idQuestion.toString());
              }
              if(state is DeleteanswerSuccessState){
                showToast(message: " Deleted successfully", state: ToastStates.SUCCESS);
                learnUpCuibit.get(context).Getanswer(idquestion: idQuestion.toString());
              }
        }, builder: (context, Object? state) {
          var cubit = learnUpCuibit.get(context);
          return ConditionalBuilder(
            condition: cubit.answerModel != null||state is !GetanswerLoadingState  ,
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
                          idowner==cubit.answerModel!.Questions!.userId?

                              //edit Qustion and delet it
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
                                                                        Navigator.pop(context);
                                                                    Future.delayed(
                                                                        const Duration(seconds: 0),
                                                                        () => showDialog(
                                                                            context: context,
                                                                            builder: (context) => AlertDialogs( (){
                                                                              cubit.DeleteQuestions(IdQs: idQuestion);
                                                                              Navigator.pop(context);

                                                                              Navigator.pop(context);
                                                                              cubit..GetQuestions(idRoom: cubit.answerModel!.Questions!.roomId.toString());


                                                                            } ,
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
                              icon: Icon(Icons.more_vert_outlined)): Text("")
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

                                      idowner==cubit.answerModel!.Questions!.answers![index].userId?
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
                                                                          () {

                                                                            Future.delayed(
                                                                                const Duration(seconds: 0),
                                                                            () => showDialog(



                                                                                context: context,
                                                                                builder: (context) =>
                                                                            AlertDialog(
                                                                              title: customText(
                                                                                  maxline: 1,
                                                                                  fontWeight: FontWeight.bold,
                                                                                  text: "Edit Answer ",
                                                                                  fontSize: 20.sp,
                                                                                  color: Colors.black),
                                                                              content:Form(
                                                                               key: _formKey1,
                                                                                child: TextFormField (controller: AnswerController,
                                                                                  decoration: InputDecoration(
                                                                                    hintText: "update your answer",
                                                                                    hintStyle: TextStyle(
                                                                                      color: Colors.grey
                                                                                    )
                                                                                  ),
                                                                                  validator:  (val) {
                                                                                    if (val == null || val.isEmpty) {
                                                                                      return 'Enter Your update ';
                                                                                    }
                                                                                    return null;
                                                                                  },


                                                                                ),
                                                                              ),
                                                                              actions: <Widget>[
                                                                                Row(
                                                                                  crossAxisAlignment: CrossAxisAlignment.end,
                                                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                                                  children: [
                                                                                    TextButton(
                                                                                      onPressed: () {

                                                                                        Navigator.pop(context, 'Cancel');
                                                                                        Navigator.pop(context, 'Cancel');},
                                                                                      child: customText(
                                                                                          maxline: 1,
                                                                                          fontWeight: FontWeight.bold,
                                                                                          text: 'Cancel',
                                                                                          color: Colors.black),
                                                                                    ),
                                                                                    TextButton(
                                                                                      onPressed:(){
                                                                                        if (_formKey1.currentState!.validate()){

                                                                                        cubit.UpdateYourAnswer(
                                                                                          UpdateAnswer: AnswerController.text,
                                                                                          IdAns: cubit.answerModel!.Questions!
                                                                                            .answers![index].answerId .toString(),

                                                                                        );
                                                                                        AnswerController.clear();
                                                                                        cubit.Getanswer(idquestion: idQuestion.toString());
                                                                                        Navigator.pop(context, 'Edit');
                                                                                        Navigator.pop(context, 'Edit');
                                                                                      }},
                                                                                      child: customText(
                                                                                          maxline: 1,
                                                                                          fontWeight: FontWeight.bold,
                                                                                          text: 'Confirm',
                                                                                          fontSize: 18.sp,
                                                                                          color: mainColor),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ],
                                                                            )));

                                                                          },
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
                                                                                      () {
                                                                                    cubit.Deleteanswer(idasnwer: cubit.answerModel!.Questions!
                                                                                        .answers![index].answerId .toString());
                                                                                    cubit.Getanswer(idquestion: idQuestion.toString());
                                                                                    Navigator.pop(context, 'Delete');
                                                                                    Navigator.pop(context, 'Delete');

                                                                                  },

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
                                          icon: Icon(Icons.more_vert)):Text("")
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
                            Form(
                              key: _formKey,
                              child: TextFormField(
                                controller:AddAnswerController,
                                validator:  (val) {
                                  if (val == null || val.isEmpty) {
                                    return 'Enter enter your answer';
                                  }
                                  return null;
                                },


                              ),
                            ),
                            // button answer to  question
                            Expanded(
                              child: Align(
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
                                        onPressed: () {
    if (_formKey.currentState!.validate()) {
   cubit.AddAnswers(
       YourAnwer: AddAnswerController.text  ,
       id: cubit.answerModel!.Questions!.roomId,
       Idansweer:idQuestion.toString());
   AddAnswerController.clear();
   cubit.Getanswer(idquestion: idQuestion.toString());


    }

    },
                                        child: const Text(
                                          'Reply',
                                          style:
                                              TextStyle(color: Colors.white),
                                        )),
                                  )),
                            ),
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

  Widget AlertDialogs(VoidCallback? functionDelete, BuildContext context, String title, content,) {
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
              onPressed: () { Navigator.pop(context, 'Cancel');
    Navigator.pop(context, 'Delete');
    },
              child: customText(
                  maxline: 1,
                  fontWeight: FontWeight.bold,
                  text: 'Cancel',
                  color: Colors.black),
            ),
            TextButton(
              onPressed:functionDelete,
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
