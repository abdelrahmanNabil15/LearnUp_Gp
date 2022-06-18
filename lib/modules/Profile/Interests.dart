import 'package:LearnUP/commponet/const.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

import '../../commponet/commpnet.dart';
import '../../commponet/defult_button.dart';
import '../../cubit/cubit.dart';
import '../../cubit/state.dart';
import '../../home_Layout.dart';
import '../home/home_screen.dart';
import 'myinterests.dart';

class InterestScreen extends StatefulWidget {

  const InterestScreen({Key? key}) : super(key: key);

  @override
  State<InterestScreen> createState() => _InterestScreenRoomState();

}


class _InterestScreenRoomState extends State<InterestScreen> {

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late List<String> _filters;
  late bool _isSelected;
  @override
  void initState() {
    super.initState();
    _isSelected = false;


    _filters = <String>[];
  }
  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
        create: (BuildContext context) => learnUpCuibit()
          ..GetInterest() ..GetAllInterests()  ,
        child: BlocConsumer<learnUpCuibit, learnUpStates>(
        listener: (context, state) {

          if(state is InterestsSuccessState){
            showToast(message: 'The interest has been added successfully', state: ToastStates.SUCCESS);

          }else if(state is InterestsErrorState){
            showToast(message: "Inetrest alrady exist", state: ToastStates.ERROR);
            learnUpCuibit.get(context).GetInterest()  ;
          }
        },
    builder: (context, state) => ConditionalBuilder(
    condition: true,
    builder: (context) {
    var cubit = learnUpCuibit.get(context);

    return  SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text("Choose your intersts"),
          centerTitle: true,),
        body: Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius:
              BorderRadius.vertical(top: Radius.circular(20))),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(

                  child: SingleChildScrollView(
                    child: ConditionalBuilder(
                      condition: cubit.getAllinterest != null,
                      builder: (context) {
                        return    Wrap(
                          spacing: 6.0,
                          runSpacing: 6.0,
                          children: List<Widget>.generate(
                              cubit.getAllinterest!.result!.length,
                                  (int index) {
                                return FilterChip( elevation: 1,


                                    selectedColor: mainColor,
                                    label: Text(cubit.getAllinterest!
                                        .result![index].id, style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(
                                        color: Colors.white,
                                        fontSize: 14)),
                                    selected: _filters.contains(cubit
                                        .getAllinterest!
                                        .result![index]
                                        .id),
                                    onSelected: (bool selected) {
                                      setState(() {
                                        if (selected) {
                                          _filters.add(cubit
                                              .getAllinterest!
                                              .result![index]
                                              .id);
                                          _isSelected = selected;
                                        } else {
                                          _filters.removeWhere(
                                                  (String name) {
                                                return name ==
                                                    cubit.getAllinterest!
                                                        .result![index].id;
                                              });
                                        }
                                      });
                                    });
                              }),
                        );
                      },
                      fallback: (BuildContext context) => Container(
                          color: Colors.white,
                          child: Center(child: spinkitCircle)),
                    ),
                  ),
                ),

                Align( alignment: Alignment.bottomCenter,
                  child: Row(

                    children: [


                      Expanded(
                        child: DefaultButton(
                          text: "My Interests",
                          function: (){
                            navigateTo(context,const MyInterestsScreen());

                          },
                           Textcolor: Colors.black,
                          color: Colors.white,
                          isUpper: false,


                        ),
                      ),
                      SizedBox(width: 10.w,),
                      Expanded(
                        child: DefaultButton(
                          text: "Save",
                          function: (){
                               if(  _filters.isNotEmpty){
                            cubit.Addintrest(
                                interestdata: _filters);
                            navigateAndFinish(context, HomeLayout());
                               }
                          },
                          color: _filters.isNotEmpty ?mainColor:Colors.grey.shade300,
                          isUpper: false,


                        ),
                      ),
                    ],
                  ),
                )

              ],
            ),
          ),
        ),
      ),
    );;
    },fallback: (BuildContext context) => Container(
            color: Colors.white, child: Center(child: spinkitCircle)),),));
  }
}
