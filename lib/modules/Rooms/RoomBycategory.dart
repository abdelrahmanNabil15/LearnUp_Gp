


import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled2/commponet/CustomText.dart';

import '../../commponet/commpnet.dart';
import '../../cubit/cubit.dart';
import '../../cubit/state.dart';

class RoomByCateory extends StatefulWidget {
  final  String InterestCateogry;

   RoomByCateory({Key? key, required this.InterestCateogry}) : super(key: key);

  @override
  State<RoomByCateory> createState() => _RoomByCateoryState();
}

class _RoomByCateoryState extends State<RoomByCateory> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) =>
        learnUpCuibit()..GetRoomByInterest(widget.InterestCateogry) ,
        child: BlocConsumer<learnUpCuibit, learnUpStates>(
        listener: (context, state) {},
    builder: (context, Object? state) {
      var cubit = learnUpCuibit.get(context);
      return ConditionalBuilder(
        condition:cubit.roombyInterest != null,
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
           title:   Text(widget.InterestCateogry),
            ),
            body: cubit.roombyInterest!.result!.isNotEmpty? ROOMS(cubit):Container( color:Colors.white,child: Column(crossAxisAlignment: CrossAxisAlignment.center,
              children: [SizedBox(height: 80.h,),
                Center( child:  Image.asset('assets/Warning.png'),),
                customText(fontWeight: FontWeight.bold,text: "There is no rooms!",
                color: Colors.black,
                fontSize: 22.sp,alignment: Alignment.center,)
              ],
            )),
          );
        }, fallback: (context) =>Container( color:Colors.white,child: Center( child: spinkitCircle,)),
      );
    })
          );
    }
  }

