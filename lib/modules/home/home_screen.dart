import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:untitled2/commponet/CustomText.dart';
import 'package:untitled2/commponet/commpnet.dart';
import 'package:untitled2/commponet/const.dart';
import 'package:untitled2/cubit/cubit.dart';
import 'package:untitled2/cubit/state.dart';
import 'package:untitled2/modules/Rooms/RoomsScreen.dart';

import '../Rooms/CreateRoom.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _homeScreenState();
}

class _homeScreenState extends State<HomeScreen> {
  late bool _isSelected;
  bool  Joining=false;
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
      create: (BuildContext context) =>
          learnUpCuibit()..GetRoomByInterest("my-first-interest")..GetAllInterests() ,
      child: BlocConsumer<learnUpCuibit, learnUpStates>(
        listener: (context, state) {},
        builder: (context, Object? state) {
          var cubit = learnUpCuibit.get(context);
          return Scaffold(
            key: _key,
            body: ConditionalBuilder(
              condition: cubit.roombyInterest != null&& cubit.getAllinterest!=null,
              builder: (context) => Padding(
                padding: const EdgeInsets.all(15),
                child:SingleChildScrollView(


                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ///category widget
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          customText(
                            fontWeight: FontWeight.bold,
                            maxline: 1,
                            fontSize: 20.sp,
                            text: 'Category',
                          ),
                          MaterialButton(
                            onPressed: () {



                            },
                            child: customText(
                              fontWeight: FontWeight.bold,
                              maxline: 1,
                              text: 'More...',
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 12.h,
                      ),
                      Cateogery(cubit),

                      SingleChildScrollView(

                        child: Column(
                          children: [

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                customText(
                                  fontWeight: FontWeight.bold,
                                  maxline: 1,
                                  fontSize: 20.sp,
                                  text: 'Rooms',
                                ),
                                MaterialButton(
                                  onPressed: () {},
                                  child: customText(
                                    fontWeight: FontWeight.bold,
                                    maxline: 1,
                                    text: 'More...',
                                  ),
                                ),
                              ],
                            ),
                            ROOMS(cubit)
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              fallback: (context) => Center(child: Container(child: spinkitCircle)),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {

                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const CreateRoom()),
                );
              },

              backgroundColor: mainColor,
              child: const Icon(Icons.add),
            ),
          );
        },
      ),
    );
  }
}
