import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../commponet/commpnet.dart';
import '../../cubit/cubit.dart';
import '../../cubit/state.dart';

class QuestionScreen extends StatefulWidget {
  final String idQuestion;
  const QuestionScreen({Key? key, required this.idQuestion}) : super(key: key);

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => learnUpCuibit()
          ..Getanswer(idquestion:2.toString()),
        child: BlocConsumer<learnUpCuibit, learnUpStates>(
        listener: (context, state) {},
    builder: (context, Object? state) {
    var cubit = learnUpCuibit.get(context);
    return   ConditionalBuilder(
      condition:     cubit.answerModel != null,
      builder: (context) {

        return Scaffold(
        appBar: AppBar(),
        body:Text("data")

        );
        },
          fallback:  (BuildContext context) => Container(
              color: Colors.white, child: Center(child: spinkitCircle)),



      );
        }
    )
    );

  }
}
