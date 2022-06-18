import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pie_chart/pie_chart.dart';

import '../../commponet/CustomText.dart';
import '../../commponet/commpnet.dart';
import '../../cubit/cubit.dart';
import '../../cubit/state.dart';

class ReportRoomById extends StatefulWidget {
  const ReportRoomById({Key? key, this.IdReport,  }) : super(key: key);
final IdReport;
  @override
  State<ReportRoomById> createState() => _ReportRoomByIdState();
}

class _ReportRoomByIdState extends State<ReportRoomById> {
  late int defaultChoiceIndex;
  List<String> _choicesList = [
    'Materials',
    'Joined members',
    'Requested members',
    'Rejected members'
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
        create: (BuildContext context) => learnUpCuibit()..GetRoomReports(idroom:widget.IdReport.toString()) ,
        child: BlocConsumer<learnUpCuibit, learnUpStates>(
            listener: (BuildContext context, state) {

            },
            builder: (BuildContext context, Object? state) {
              var cubit = learnUpCuibit.get(context);
              return Scaffold(
                appBar: AppBar(
                  centerTitle: true,
                  title: const Text("Report Room"),
                ),
                body: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: ConditionalBuilder(
                    condition: cubit. GetRoomReportsModel["result"]!=null,
                    builder: (context) {
                      Map<String, double> dataMap = {
                        "Materials": cubit.GetRoomReportsModel["result"]["addedMaterials"].toDouble() ,
                        "Joined members":cubit. GetRoomReportsModel["result"]["numberOfJoinedUsers"].toDouble(),
                        "Requested members":cubit.GetRoomReportsModel["result"]["numberOfRequestedUsers"].toDouble(),
                        "Rejectedmembers":cubit.GetRoomReportsModel["result"]["numberOfRejectedUsers"].toDouble(),
                      };
                      return SafeArea(
                        child: Column(
                          children: [
                            SizedBox(height: 50.h,),
                            PieChart(
                              dataMap: dataMap,
                              colorList: colorList,
                              chartRadius: MediaQuery.of(context).size.width / 2,
                              centerText: "RoomReport",
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
      case  0: return cubit.GetRoomReportsModel["result"]["roomMaterialsActivities"].isNotEmpty?ListView.separated(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: cubit.GetRoomReportsModel["result"]["roomMaterialsActivities"].length ,
        separatorBuilder: (BuildContext context, int index) { return Divider(color: Colors.white,); },
        itemBuilder: (BuildContext context, int index) { return ListTile(
        title: Card(
        elevation: 6,
        child: ListTile(
          leading: CircleAvatar(
            child: Icon(Iconsax.document),
          ),

          title: Text(cubit.GetRoomReportsModel["result"]["roomMaterialsActivities"][index]["materialName"]),
          subtitle:customText(fontWeight: FontWeight.normal,color: Colors.grey,text:cubit.GetRoomReportsModel["result"]["roomMaterialsActivities"][index]["createdAt"].toString().substring(0,10))) ,
        ),
        ); },

      ):Container( color:Colors.white,child: Column(
        children: [
          Center( child:  Image.asset('assets/nofile.png'),),
          customText(fontWeight: FontWeight.bold,text: "There are no Materials!",
            color: Colors.black,
            fontSize: 22.sp,alignment: Alignment.center,)
        ],
      ));



      break;
//requsetUsers
      case 1: return cubit.GetRoomReportsModel["result"]["joinedUserRoomActivities"].isNotEmpty?  ListView.separated(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: cubit.GetRoomReportsModel["result"]["joinedUserRoomActivities"].length ,
        separatorBuilder: (BuildContext context, int index) { return Divider(color: Colors.white,); },
        itemBuilder: (BuildContext context, int index) { return Card(
            elevation: 6, child: Container(
            alignment: Alignment.topLeft,child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  customText(fontWeight: FontWeight.bold,color: Colors.black,text: "Member: "),
                  Expanded(child: customText(fontWeight: FontWeight.normal,color: Colors.black,text:cubit.GetRoomReportsModel["result"]["joinedUserRoomActivities"][index]["userName"])),
                ],
              ),

              Row(
                children: [
                  customText(fontWeight: FontWeight.bold,color: Colors.black,text: "Joined: "),
                  Expanded(
                    child: customText(fontWeight: FontWeight.normal,color: Colors.black,text:cubit.GetRoomReportsModel["result"]["joinedUserRoomActivities"][index]["createdAt"].toString().substring(0,10)
                        .substring(0,10) ),
                  ),
                ],
              ),
              Row(
                children: [
                  customText(fontWeight: FontWeight.bold,color: Colors.black,text: "Status: "),
                  Expanded(child: customText(fontWeight: FontWeight.normal,color: Colors.green,text:cubit.GetRoomReportsModel["result"]["joinedUserRoomActivities"][index]["statusId"]),
                  ) ],
              ), ],
          ),
        ))); },

      ) :Container( color:Colors.white,child: Column(
        children: [
          Center( child:  Image.asset('assets/nousers.png'),),
          customText(fontWeight: FontWeight.bold,text: "There are no members!",
            color: Colors.black,
            fontSize: 22.sp,alignment: Alignment.center,)
        ],
      ));
      break;

      case 2:  return cubit.GetRoomReportsModel["result"]["requestedUserRoomActivities"].isNotEmpty? ListView.separated(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: cubit.GetRoomReportsModel["result"]["requestedUserRoomActivities"].length ,
        separatorBuilder: (BuildContext context, int index) { return Divider(color: Colors.white,); },
        itemBuilder: (BuildContext context, int index) { return Card(
            elevation: 6, child: Container(
            alignment: Alignment.topLeft,child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  customText(fontWeight: FontWeight.bold,color: Colors.black,text: "Member: "),
                  Expanded(child: customText(fontWeight: FontWeight.normal,color: Colors.black,text:cubit.GetRoomReportsModel["result"]["requestedUserRoomActivities"][index]["userName"])),
                ],
              ),

              Row(
                children: [
                  customText(fontWeight: FontWeight.bold,color: Colors.black,text: "Joined: "),
                  Expanded(
                    child: customText(fontWeight: FontWeight.normal,color: Colors.black,text:cubit.GetRoomReportsModel["result"]["requestedUserRoomActivities"][index]["createdAt"].toString().substring(0,10)
                        .substring(0,10) ),
                  ),
                ],
              ),
              Row(
                children: [
                  customText(fontWeight: FontWeight.bold,color: Colors.black,text: "Status: "),
                  Expanded(child: customText(fontWeight: FontWeight.normal,color: Colors.green,text:cubit.GetRoomReportsModel["result"]["requestedUserRoomActivities"][index]["statusId"]),
                  ) ],
              ), ],
          ),
        ))); },

      ): Container( color:Colors.white,child: Column(
        children: [
          Center( child:  Image.asset('assets/nousers.png'),),
          customText(fontWeight: FontWeight.bold,text: "There are no members!",
            color: Colors.black,
            fontSize: 22.sp,alignment: Alignment.center,)
        ],
      ));
      break;

      case  3: return cubit.GetRoomReportsModel["result"]["rejectedUserRoomActivities"].isNotEmpty? ListView.separated(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: cubit.GetRoomReportsModel["result"]["rejectedUserRoomActivities"].length ,
        separatorBuilder: (BuildContext context, int index) { return Divider(color: Colors.white,); },
        itemBuilder: (BuildContext context, int index) { return Card(
            elevation: 6, child: Container(
            alignment: Alignment.topLeft,child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  customText(fontWeight: FontWeight.bold,color: Colors.black,text: "Member: "),
                  Expanded(child: customText(fontWeight: FontWeight.normal,color: Colors.black,text:cubit.GetRoomReportsModel["result"]["rejectedUserRoomActivities"][index]["userName"])),
                ],
              ),

              Row(
                children: [
                  customText(fontWeight: FontWeight.bold,color: Colors.black,text: "Joined: "),
                  Expanded(
                    child: customText(fontWeight: FontWeight.normal,color: Colors.black,text:cubit.GetRoomReportsModel["result"]["rejectedUserRoomActivities"][index]["createdAt"].toString().substring(0,10)
                        .substring(0,10) ),
                  ),
                ],
              ),
              Row(
                children: [
                  customText(fontWeight: FontWeight.bold,color: Colors.black,text: "Status: "),
                  Expanded(child: customText(fontWeight: FontWeight.normal,color: Colors.green,text:cubit.GetRoomReportsModel["result"]["rejectedUserRoomActivities"][index]["statusId"]),
                  ) ],
              ), ],
          ),
        ))); },

      )
        :Container( color:Colors.white,child: Column(
        children: [
          Center( child:  Image.asset('assets/nousers.png'),),
          customText(fontWeight: FontWeight.bold,text: "There are no members!",
            color: Colors.black,
            fontSize: 22.sp,alignment: Alignment.center,)
        ],
      ));
      break;

      default:  return ListView.separated(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: cubit.GetRoomReportsModel["result"]["joinedUserRoomActivities"].length ,
        separatorBuilder: (BuildContext context, int index) { return Divider(color: Colors.white,); },
        itemBuilder: (BuildContext context, int index) { return Card(
            elevation: 6, child: Container(
            alignment: Alignment.topLeft,child: Padding(
          padding: const EdgeInsets.all(8.0),
          child:Column(mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  customText(fontWeight: FontWeight.bold,color: Colors.black,text: "Member: "),
                  Expanded(child: customText(fontWeight: FontWeight.normal,color: Colors.black,text:cubit.GetRoomReportsModel["result"]["joinedUserRoomActivities"][index]["userName"])),
                ],
              ),

              Row(
                children: [
                  customText(fontWeight: FontWeight.bold,color: Colors.black,text: "Joined: "),
                  Expanded(
                    child: customText(fontWeight: FontWeight.normal,color: Colors.black,text:cubit.GetRoomReportsModel["result"]["joinedUserRoomActivities"][index]["createdAt"].toString().substring(0,10)
                        .substring(0,10) ),
                  ),
                ],
              ),
              Row(
                children: [
                  customText(fontWeight: FontWeight.bold,color: Colors.black,text: "Status: "),
                  Expanded(child: customText(fontWeight: FontWeight.normal,color: Colors.green,text:cubit.GetRoomReportsModel["result"]["joinedUserRoomActivities"][index]["statusId"]),
                  ) ],
              ), ],
          ),
        ))); },

      );

      break;
    }
  }
}