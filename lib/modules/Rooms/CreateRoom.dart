import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../commponet/CustomText.dart';
import '../../commponet/TextFormField.dart';
import '../../commponet/commpnet.dart';
import '../../commponet/const.dart';
import '../../commponet/customdatefield.dart';
import '../../cubit/cubit.dart';
import '../../cubit/state.dart';
import 'RoomsScreen.dart';

class CreateRoom extends StatefulWidget {
  const CreateRoom({Key? key}) : super(key: key);

  @override
  State<CreateRoom> createState() => _CreateRoomState();
}

class _CreateRoomState extends State<CreateRoom> {
  @override
  late bool _isSelected;
  late GlobalKey<ScaffoldState> _key;

  late List<String> _filters;

  @override
  void initState() {
    super.initState();
    _isSelected = false;
    _key = GlobalKey<ScaffoldState>();

    _filters = <String>[];
  }

  var nameroomController = TextEditingController();

  var DescriptionController = TextEditingController();
  var expectedEndDateController = TextEditingController();
  var startDateController = TextEditingController();
  var priceController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => learnUpCuibit()

        ..GetAllInterests(),
      child: BlocConsumer<learnUpCuibit, learnUpStates>(
        listener: (context, state) {
          if(state is CreateRoomSuccessState ){
            if (state.room.isSuccess) {

              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) =>   RoomsScreen( id: state.room.result)),
              );


            }


          }


        },
        builder: (context, Object? state) {
          var cubit = learnUpCuibit.get(context);
          return Scaffold(
              key: _key,
              body: SafeArea(
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.0.w, vertical: 20.h),
                      child: Column(
                        children: [
                          customText(
                            maxline: 1,
                            fontWeight: FontWeight.bold,
                            text: "Create your Room",
                            alignment: Alignment.topLeft,
                            fontSize: 22.sp,
                            color: Colors.black,
                          ),
                          SizedBox(
                            height: 25.h,
                          ),
                          customText(
                            maxline: 1,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.sp,
                            text: "Name your Room",
                          ),
                          Padding(
                              padding: EdgeInsets.symmetric(vertical: 10.0.h),
                              child: textFormField(
                                controller: nameroomController,
                                maxLines: null,
                                type: TextInputType.name,
                                label: 'What do you want to talk about?',
                                validator: ( text) {
                                  if (text == null || text.isEmpty) {
                                    return 'Enter name room please';
                                  }
                                  return null;
                                },
                                inputAction: TextInputAction.next,
                              )),
                          customText(
                            maxline: 1,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.sp,
                            text: "Room description",
                          ),
                          Padding(
                              padding: EdgeInsets.symmetric(vertical: 10.0.h),
                              child: textFormField(
                                controller: DescriptionController,
                                maxLines: null,
                                type: TextInputType.multiline,
                                label:
                                    'Write a description you want people to see!',
                                validator: (text) {
                                  if (text == null || text.isEmpty) {
                                    return 'Enter  room Description please';
                                  }
                                  return null;
                                },
                                inputAction: TextInputAction.next,
                              )),
                          customText(
                            maxline: 1,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.sp,
                            text: "Room Cost",
                          ),
                          Padding(
                              padding: EdgeInsets.symmetric(vertical: 10.0.h),
                              child: textFormField(
                                controller: priceController,
                                maxLines: null,
                                type: TextInputType.number,
                                label: 'What is the room cost?',
                                validator: (text) {
                                  if (text == null || text.isEmpty) {
                                    return 'Enter cost of room please';
                                  }
                                  return null;
                                },
                                inputAction: TextInputAction.next,
                              )),


                          customText(
                            maxline: 1,
                            fontWeight: FontWeight.bold,
                            text: "Choose Interests",
                          ),
                          SizedBox(height: 10.h,),
                          ConditionalBuilder(
                            condition: cubit.getAllinterest != null,
                            builder: (context) {
                              return SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    Wrap(
                                      spacing: 6.0,
                                      runSpacing: 6.0,
                                      children: List<Widget>.generate(
                                          cubit.getAllinterest!.result!.length,
                                          (int index) {
                                        return FilterChip(
                                            label: Text(cubit.getAllinterest!
                                                .result![index].id),
                                            selected: _filters.contains(cubit
                                                .getAllinterest!
                                                .result![index]
                                                .id),


                                            shape: const StadiumBorder(

                                                side: BorderSide(

                                                )),

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
                                    ),
                                  ],
                                ),
                              );
                            },
                            fallback: (BuildContext context) => Container(
                                color: Colors.white,
                                child: Center(child: spinkitCircle)),
                          ),
                          SizedBox(height: 15.h,),
                          Padding(
                            padding:   EdgeInsets.symmetric(vertical: 8.0.h),
                            child: Row(

                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [

                                customText(
                                  maxline: 1,
                                  fontWeight: FontWeight.bold,
                                  text: "Start date",
                                ),
                                customText(
                                  maxline: 1,
                                  fontWeight: FontWeight.bold,
                                  text: " Expected end date",
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 150.w,
                                child: DateTimePicker(
                                  toolbarOptions:
                                      ToolbarOptions(copy: true, paste: true),
                                  routeSettings: RouteSettings(),
                                  decoration: InputDecoration(
                                    hintText: "startDate",
                                    iconColor: Colors.cyanAccent,
                                    errorStyle: const TextStyle(
                                      color: Colors.redAccent,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    border: const OutlineInputBorder(),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(8.0.r),
                                      borderSide: BorderSide(
                                        color: Colors.grey.withOpacity(0.5),
                                      ),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(8.0.r),
                                      borderSide: const BorderSide(
                                        color: Colors.redAccent,
                                        width: 2,
                                      ),
                                    ),
                                    prefixIcon: const Icon(
                                      Icons.date_range_outlined,
                                    ),
                                  ),
                                  controller: startDateController,
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime(2100),
                                  dateLabelText: 'Date',
                                  onChanged: (val) => print(val.toUpperCase()),
                                  validator:  (val) {
                                    if (val == null || val.isEmpty) {
                                      return 'Enter start date  please';
                                    }
                                    return null;
                                  },
                                  onSaved: (val) => print(val),
                                ),
                              ),
                              SizedBox(
                                width: 150.w,
                                child: DateTimePicker(
                                  toolbarOptions:
                                  ToolbarOptions(copy: true, paste: true),
                                  routeSettings: RouteSettings(),
                                  decoration: InputDecoration(
                                    hintText: "expectedEndDate",
                                    iconColor: Colors.cyanAccent,
                                    errorStyle: const TextStyle(
                                      color: Colors.redAccent,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    border: const OutlineInputBorder(),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.circular(8.0.r),
                                      borderSide: BorderSide(
                                        color: Colors.grey.withOpacity(0.5),
                                      ),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.circular(8.0.r),
                                      borderSide: const BorderSide(
                                        color: Colors.redAccent,
                                        width: 2,
                                      ),
                                    ),
                                    prefixIcon: const Icon(
                                      Icons.date_range_outlined,
                                    ),
                                  ),

                                  controller: expectedEndDateController,
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime(2100),
                                  dateLabelText: 'Date',
                                  onChanged: (val) => print(val.toUpperCase()),
                                  validator:  (val) {
                                    if (val == null || val.isEmpty) {
                                      return 'Enter expected end date please';
                                    }
                                    return null;
                                  },
                                  onSaved: (val) => print(val),
                                ),
                              ),

                            ],
                          ),
SizedBox(height: 100.h,),
                          TextButton( onPressed:(){
                     if (_formKey.currentState!.validate()&&_filters.isNotEmpty) {
                       cubit.CreateRooms(Cost: int.parse(priceController.text),
                           description: DescriptionController.text,
                           EndDate: expectedEndDateController.text,
                           interests: _filters,
                           Name: nameroomController.text,
                           StartDate: startDateController.text);
                     } else{
                       Fluttertoast.showToast(
                           msg: "Cannot Create Room with no interest",
                           toastLength: Toast.LENGTH_LONG,
                           gravity: ToastGravity.BOTTOM,
                           timeInSecForIosWeb: 5,
                           textColor: Colors.white,
                           backgroundColor: redColor,
                           fontSize: 16.0.sp);

                     }
                          } ,
                            child: Container(

                              height: MediaQuery.of(context).size.height * 1 / 15,
                              width: MediaQuery.of(context).size.width * 3 / 4,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      Colors.indigo,
                                      mainColor,
                                    ]),
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                // ignore: prefer_const_literals_to_create_immutables
                                children: [
                                  const Text(""),
                                   Text(
                                    "Create Room",
                                    style: TextStyle(
                                        fontSize: 20.0.sp,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white),
                                  ),
                                  Container(
                                      padding:   EdgeInsets.symmetric(horizontal: 8.0.w,vertical: 8.h),
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.circle, color: Colors.white),
                                      child:  Icon(
                                        Icons.arrow_right_alt_outlined,
                                        size: 25.0.sp,
                                        color:mainColor,
                                      ))
                                ],
                              ),
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
              ));
        },
      ),
    );
  }
}
