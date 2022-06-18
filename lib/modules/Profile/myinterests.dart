import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../commponet/commpnet.dart';
import '../../cubit/cubit.dart';
import '../../cubit/state.dart';

class MyInterestsScreen extends StatelessWidget {
  const MyInterestsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   return   BlocProvider(
        create: (BuildContext context) => learnUpCuibit()
          ..GetInterest(),
        child: BlocConsumer<learnUpCuibit, learnUpStates>(
        listener: (context, state) {

          if(state is DeleteInterestSuccessState){
            showToast(message: 'The interest has been deleted successfully', state: ToastStates.SUCCESS);
            learnUpCuibit.get(context).GetInterest() ;
          }else if(state is DeleteInterestErrorState){
            showToast(message: "can't delete this interest, please try again later", state: ToastStates.ERROR);
            learnUpCuibit.get(context).GetInterest()  ;
          }


        },
    builder: (context, state) {

      var cubit = learnUpCuibit.get(context);
         return  Scaffold(
           appBar: AppBar(title: Text("My Interests"),
           centerTitle: true),
      body:SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ConditionalBuilder(
            condition: cubit.getinterest != null,
            builder: (context) {
              return Wrap(
                spacing: 6.0,
                runSpacing: 6.0,
                children: List<Widget>.generate(
                    cubit.getinterest!.result!.length, (int index) {
                  return Chip(
                    label: Text(cubit.getinterest!.result![index].id,style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(
                        color: Colors.white,
                        fontSize: 14)),
                    deleteIcon: Icon(Icons.clear),
                    backgroundColor: Colors.redAccent,
                    onDeleted: (){
                     cubit.DeleteInterests(InterestId:cubit.getinterest!.result![index].id );
                    },
                  );
                }),
              );
            },
            fallback: (BuildContext context) => Container(
                color: Colors.white,
                child: Center(child: spinkitCircle)),
          ),
        ),
      ),
    );}));
}

}
