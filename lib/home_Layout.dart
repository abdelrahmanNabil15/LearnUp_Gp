// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';


import 'cubit/cubit.dart';
import 'cubit/state.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _homeLayoutState();
}
class _homeLayoutState extends State<HomeLayout> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => learnUpCuibit(),
      child: BlocConsumer<learnUpCuibit, learnUpStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = learnUpCuibit.get(context);
            return Scaffold(

              body: cubit.Screen[cubit.currentIndex],
              bottomNavigationBar: BottomNavigationBar(
                items: cubit.bottomItem,
                currentIndex: cubit.currentIndex,
                onTap: (index) {
                  cubit.changeBottomNavBar(index);
                },
              ),
            );
          }),
    );
  }
}
