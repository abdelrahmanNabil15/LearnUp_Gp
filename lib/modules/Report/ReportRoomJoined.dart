import 'package:LearnUP/commponet/CustomText.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pie_chart/pie_chart.dart';

import '../../commponet/commpnet.dart';
import '../../cubit/cubit.dart';
import '../../cubit/state.dart';

class ReportRoomsJoined extends StatefulWidget {
  const ReportRoomsJoined({Key? key}) : super(key: key);

  @override
  State<ReportRoomsJoined> createState() => _ReportRoomsJoinedState();
}

class _ReportRoomsJoinedState extends State<ReportRoomsJoined> {
  late int defaultChoiceIndex;
  List<String> _choicesList = [
    'JoinedRooms',
    'RequestedRooms',
    'RejectedRooms',
    'LeftRooms'
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    defaultChoiceIndex = 0;
  }

  bool _selected = false;
  List<Color> colorList = [
    const Color(0xffD95AF3),
    const Color(0xff3EE094),
    const Color(0xff3398F6),
    const Color(0xffFA4A42),
  ];

  final gradientList = <List<Color>>[
    [
      Color.fromRGBO(223, 250, 92, 1),
      Color.fromRGBO(129, 250, 112, 1),
    ],
    [
      Color.fromRGBO(129, 182, 205, 1),
      Color.fromRGBO(91, 253, 199, 1),
    ],
    [
      Color.fromRGBO(175, 63, 62, 1.0),
      Color.fromRGBO(254, 154, 92, 1),
    ]
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => learnUpCuibit()..GetUserRoomsReport(),
        child: BlocConsumer<learnUpCuibit, learnUpStates>(
            listener: (BuildContext context, state) {},
            builder: (BuildContext context, Object? state) {
              var cubit = learnUpCuibit.get(context);
              return Scaffold(
                appBar: AppBar(
                  centerTitle: true,
                  title: const Text("ReportRoomsJoined"),
                ),
                body: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: ConditionalBuilder(
                    condition: cubit.userRoomsReport != null,
                    builder: (context) {
                      Map<String, double> dataMap = {
                        "JoinedRooms": cubit
                                .userRoomsReport!.result!.numberOfJoinedRooms /
                            cubit.userRoomsReport!.result!.totalRequestedRooms *
                            100,
                        "RequestedRooms": cubit
                                .userRoomsReport!.result!.numberOfRequestedRooms /
                            cubit.userRoomsReport!.result!.totalRequestedRooms *
                            100,
                        "RejectedRooms": cubit
                                .userRoomsReport!.result!.numberOfRejectedRooms /
                            cubit.userRoomsReport!.result!.totalRequestedRooms *
                            100,
                        "LeftRooms": cubit
                                .userRoomsReport!.result!.numberOfRejectedRooms /
                            cubit.userRoomsReport!.result!.totalRequestedRooms *
                            100,
                      };
                      return SafeArea(
                        child: Column(
                          children: [
                            PieChart(
                              dataMap: dataMap,
                              colorList: colorList,
                              chartRadius: MediaQuery.of(context).size.width / 2,
                              centerText: "RoomsReport",
                              ringStrokeWidth: 24,
                              animationDuration: const Duration(seconds: 3),
                              chartValuesOptions: const ChartValuesOptions(
                                  showChartValues: true,
                                  showChartValuesOutside: true,
                                  showChartValuesInPercentage: true,
                                  showChartValueBackground: false),
                              legendOptions: const LegendOptions(
                                  showLegends: true,
                                  legendShape: BoxShape.rectangle,
                                  legendTextStyle: TextStyle(fontSize: 15),
                                  legendPosition: LegendPosition.bottom,
                                  showLegendsInRow: true),
                              gradientList: gradientList,
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,

                              child: Row(
                                children: [
                                  Wrap(
                                    spacing: 8,
                                    children: List.generate(_choicesList.length,
                                        (index) {
                                      return ChoiceChip(
                                        labelPadding: EdgeInsets.all(2.0),
                                        label: Text(
                                          _choicesList[index],
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2!
                                                .copyWith(
                                                    color: Colors.white,
                                                    fontSize: 14),
                                        ),
                                        selected: defaultChoiceIndex == index,
                                        selectedColor: Colors.deepPurple,
                                        onSelected: (value) {
                                          setState(() {
                                            defaultChoiceIndex = value
                                                ? index
                                                : defaultChoiceIndex;
                                          });
                                        },
                                        // backgroundColor: color,
                                        elevation: 1,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.w),
                                      );
                                    }),
                                  ),
                                ],
                              ),

                            ),
                            Content(cubit)
                      ],
                        ),
                      );
                    },
                    fallback: (context) =>
                        Center(child: Container(child: spinkitCircle)),
                  ),
                ),
              );
            }));
  }

 Widget Content(cubit){
      switch(defaultChoiceIndex) {
      case  0: return ListView.separated(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: cubit.userRoomsReport!.result!.joinedRooms.length ,
        separatorBuilder: (BuildContext context, int index) { return Divider(color: Colors.white,); },
        itemBuilder: (BuildContext context, int index) { return Card(
            elevation: 6, child: Container(  
            alignment: Alignment.topLeft,child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      customText(fontWeight: FontWeight.bold,color: Colors.black,text: "NameRoom:"),
                      Expanded(child: customText(fontWeight: FontWeight.normal,color: Colors.black,text:cubit.userRoomsReport!.result!.joinedRooms[index].roomName )),
                    ],
                  ),


                  Row(
                    children: [
                      customText(fontWeight: FontWeight.bold,color: Colors.black,text: "Host: "),
                      Expanded(child: customText(fontWeight: FontWeight.normal,color: Colors.black,text:cubit.userRoomsReport!.result!.joinedRooms[index].ownerName )),
                    ],
                  ),
                  Row(
                    children: [
                      customText(fontWeight: FontWeight.bold,color: Colors.black,text: "Requested date: "),
                      Expanded(
                        child: customText(fontWeight: FontWeight.normal,color: Colors.black,text:cubit.userRoomsReport!.result!.joinedRooms[index].requestDate.toString()
                            .substring(0,10) ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      customText(fontWeight: FontWeight.bold,color: Colors.black,text: "final date: "),
                      Expanded(
                        child: customText(fontWeight: FontWeight.normal,color: Colors.black,text:cubit.userRoomsReport!.result!.joinedRooms[index].finalDate.toString()
                            .substring(0,10) ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      customText(fontWeight: FontWeight.bold,color: Colors.black,text: "Status: "),
                      Expanded(child: customText(fontWeight: FontWeight.normal,color: Colors.black,text:cubit.userRoomsReport!.result!.joinedRooms[index].statusId)),
                    ],
                  ), ],
              ),
            ))); },

      );



      break;
//requsetUsers
      case 1: return cubit.userRoomsReport!.result!.requestedRooms.isNotEmpty?  ListView.separated(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: cubit.userRoomsReport!.result!.requestedRooms.length ,
        separatorBuilder: (BuildContext context, int index) { return Divider(color: Colors.white,); },
        itemBuilder: (BuildContext context, int index) { return Card(
            elevation: 6, child: Container(
            alignment: Alignment.topLeft,child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  customText(fontWeight: FontWeight.bold,color: Colors.black,text: "NameRoom:"),
                  Expanded(child: customText(fontWeight: FontWeight.normal,color: Colors.black,text:cubit.userRoomsReport!.result!.requestedRooms[index].roomName )),
                ],
              ),


              Row(
                children: [
                  customText(fontWeight: FontWeight.bold,color: Colors.black,text: "Host: "),
                  Expanded(child: customText(fontWeight: FontWeight.normal,color: Colors.black,text:cubit.userRoomsReport!.result!.requestedRooms[index].ownerName )),
                ],
              ),
              Row(
                children: [
                  customText(fontWeight: FontWeight.bold,color: Colors.black,text: "Requested date: "),
                  Expanded(
                    child: customText(fontWeight: FontWeight.normal,color: Colors.black,text:cubit.userRoomsReport!.result!.requestedRooms[index].requestDate.toString()
                        .substring(0,10) ),
                  ),
                ],
              ),
              Row(
                children: [
                  customText(fontWeight: FontWeight.bold,color: Colors.black,text: "final date: "),
                  Expanded(
                    child: customText(fontWeight: FontWeight.normal,color: Colors.black,text:cubit.userRoomsReport!.result!.requestedRooms[index].finalDate.toString()
                        .substring(0,10) ),
                  ),
                ],
              ),
              Row(
                children: [
                  customText(fontWeight: FontWeight.bold,color: Colors.black,text: "Status: "),
                  Expanded(child: customText(fontWeight: FontWeight.normal,color: Colors.black,text:cubit.userRoomsReport!.result!.requestedRooms[index].statusId)),
                ],
              ), ],
          ),
        ))); },

      ) :Container( color:Colors.white,child: Column(
        children: [
          Center( child:  Image.asset('assets/Empty .png'),),
          customText(fontWeight: FontWeight.bold,text: "There are no rooms!",
            color: Colors.black,
            fontSize: 22.sp,alignment: Alignment.center,)
        ],
      ));
      break;

      case 2:  return cubit.userRoomsReport!.result!.rejectedRooms.isNotEmpty? ListView.separated(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: cubit.userRoomsReport!.result!.rejectedRooms.length ,
        separatorBuilder: (BuildContext context, int index) { return Divider(color: Colors.white,); },
        itemBuilder: (BuildContext context, int index) { return Card(
            elevation: 6, child: Container(
            alignment: Alignment.topLeft,child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  customText(fontWeight: FontWeight.bold,color: Colors.black,text: "NameRoom:"),
                  Expanded(child: customText(fontWeight: FontWeight.normal,color: Colors.black,text:cubit.userRoomsReport!.result!.rejectedRooms[index].roomName )),
                ],
              ),


              Row(
                children: [
                  customText(fontWeight: FontWeight.bold,color: Colors.black,text: "Host: "),
                  Expanded(child: customText(fontWeight: FontWeight.normal,color: Colors.black,text:cubit.userRoomsReport!.result!.rejectedRooms[index].ownerName )),
                ],
              ),
              Row(
                children: [
                  customText(fontWeight: FontWeight.bold,color: Colors.black,text: "Requested date: "),
                  Expanded(
                    child: customText(fontWeight: FontWeight.normal,color: Colors.black,text:cubit.userRoomsReport!.result!.rejectedRooms[index].requestDate.toString()
                        .substring(0,10) ),
                  ),
                ],
              ),
              Row(
                children: [
                  customText(fontWeight: FontWeight.bold,color: Colors.black,text: "final date: "),
                  Expanded(
                    child: customText(fontWeight: FontWeight.normal,color: Colors.black,text:cubit.userRoomsReport!.result!.joinedRooms[index].finalDate.toString()
                        .substring(0,10) ),
                  ),
                ],
              ),
              Row(
                children: [
                  customText(fontWeight: FontWeight.bold,color: Colors.black,text: "Status: "),
                  Expanded(child: customText(fontWeight: FontWeight.normal,color: Colors.black,text:cubit.userRoomsReport!.result!.rejectedRooms[index].statusId)),
                ],
              ), ],
          ),
        ))); },

      ): Container( color:Colors.white,child: Column(
        children: [
          Center( child:  Image.asset('assets/Empty .png'),),
          customText(fontWeight: FontWeight.bold,text: "There are no rooms!",
            color: Colors.black,
            fontSize: 22.sp,alignment: Alignment.center,)
        ],
      ));
      break;

      case  3: return cubit.userRoomsReport!.result!.leftRooms.isNotEmpty? ListView.separated(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: cubit.userRoomsReport!.result!.leftRooms.length ,
        separatorBuilder: (BuildContext context, int index) { return Divider(color: Colors.white,); },
        itemBuilder: (BuildContext context, int index) { return Card(
            elevation: 6, child: Container(
            alignment: Alignment.topLeft,child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  customText(fontWeight: FontWeight.bold,color: Colors.black,text: "NameRoom:"),
                  Expanded(child: customText(fontWeight: FontWeight.normal,color: Colors.black,text:cubit.userRoomsReport!.result!.leftRooms[index].roomName )),
                ],
              ),


              Row(
                children: [
                  customText(fontWeight: FontWeight.bold,color: Colors.black,text: "Host: "),
                  Expanded(child: customText(fontWeight: FontWeight.normal,color: Colors.black,text:cubit.userRoomsReport!.result!.leftRooms[index].ownerName )),
                ],
              ),
              Row(
                children: [
                  customText(fontWeight: FontWeight.bold,color: Colors.black,text: "Requested date: "),
                  Expanded(
                    child: customText(fontWeight: FontWeight.normal,color: Colors.black,text:cubit.userRoomsReport!.result!.leftRooms[index].requestDate.toString()
                        .substring(0,10) ),
                  ),
                ],
              ),
              Row(
                children: [
                  customText(fontWeight: FontWeight.bold,color: Colors.black,text: "final date: "),
                  Expanded(
                    child: customText(fontWeight: FontWeight.normal,color: Colors.black,text:cubit.userRoomsReport!.result!.leftRooms[index].finalDate.toString()
                        .substring(0,10) ),
                  ),
                ],
              ),
              Row(
                children: [
                  customText(fontWeight: FontWeight.bold,color: Colors.black,text: "Status: "),
                  Expanded(child: customText(fontWeight: FontWeight.normal,color: Colors.black,text:cubit.userRoomsReport!.result!.leftRooms[index].statusId)),
                ],
              ), ],
          ),
        ))); },

      ):Container( color:Colors.white,child: Column(
        children: [
          Center( child:  Image.asset('assets/Empty .png'),),
          customText(fontWeight: FontWeight.bold,text: "There are no rooms!",
            color: Colors.black,
            fontSize: 22.sp,alignment: Alignment.center,)
        ],
      ));
      break;

      default:  return ListView.separated(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: cubit.userRoomsReport!.result!.joinedRooms.length ,
        separatorBuilder: (BuildContext context, int index) { return Divider(color: Colors.white,); },
        itemBuilder: (BuildContext context, int index) { return Card(
            elevation: 6, child: Container(
            alignment: Alignment.topLeft,child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  customText(fontWeight: FontWeight.bold,color: Colors.black,text: "NameRoom:"),
                  Expanded(child: customText(fontWeight: FontWeight.normal,color: Colors.black,text:cubit.userRoomsReport!.result!.joinedRooms[index].roomName )),
                ],
              ),


              Row(
                children: [
                  customText(fontWeight: FontWeight.bold,color: Colors.black,text: "Host: "),
                  Expanded(child: customText(fontWeight: FontWeight.normal,color: Colors.black,text:cubit.userRoomsReport!.result!.joinedRooms[index].ownerName )),
                ],
              ),
              Row(
                children: [
                  customText(fontWeight: FontWeight.bold,color: Colors.black,text: "Requested date: "),
                  Expanded(
                    child: customText(fontWeight: FontWeight.normal,color: Colors.black,text:cubit.userRoomsReport!.result!.joinedRooms[index].requestDate.toString()
                        .substring(0,10) ),
                  ),
                ],
              ),
              Row(
                children: [
                  customText(fontWeight: FontWeight.bold,color: Colors.black,text: "final date: "),
                  Expanded(
                    child: customText(fontWeight: FontWeight.normal,color: Colors.black,text:cubit.userRoomsReport!.result!.joinedRooms[index].finalDate.toString()
                        .substring(0,10) ),
                  ),
                ],
              ),
              Row(
                children: [
                  customText(fontWeight: FontWeight.bold,color: Colors.black,text: "Status: "),
                  Expanded(child: customText(fontWeight: FontWeight.normal,color: Colors.black,text:cubit.userRoomsReport!.result!.joinedRooms[index].statusId)),
                ],
              ), ],
          ),
        ))); },

      );;
      break;
    }
 }
}
