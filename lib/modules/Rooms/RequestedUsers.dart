import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:untitled2/commponet/CustomText.dart';
import 'package:untitled2/commponet/const.dart';
import 'package:untitled2/modules/Rooms/RoomsScreen.dart';

import '../../commponet/commpnet.dart';
import '../../cubit/cubit.dart';
import '../../cubit/state.dart';

class RequestedUsers extends StatefulWidget {
  const RequestedUsers({Key? key, this.IDRoom}) : super(key: key);
  final IDRoom;

  @override
  State<RequestedUsers> createState() => _RequestedUsersState();
}

class _RequestedUsersState extends State<RequestedUsers> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) =>
            learnUpCuibit()..RequestedUsers(widget.IDRoom.toString()),
        child: BlocConsumer<learnUpCuibit, learnUpStates>(
            listener: (context, state) {},
            builder: (context, Object? state) {
              var cubit = learnUpCuibit.get(context);

              return ConditionalBuilder(
                  fallback: (BuildContext context) => Container(
                      color: Colors.white, child: Center(child: spinkitCircle)),
                  condition: cubit.requesteduserss != null,
                  builder: (context) {
                    return Scaffold(
                        appBar: AppBar(),
                        body: SafeArea(
                          child: ListView.builder(
                            itemCount: cubit.requesteduserss!.result!.length,
                            itemBuilder: (context, index) =>

                                // Display the list item
                                Dismissible(
                              key: UniqueKey(),

                              // only allows the user swipe from right to left
                              direction: DismissDirection.startToEnd,

                              // Remove this product from the list
                              // In production enviroment, you may want to send some request to delete it on server side
                              onDismissed: (_) {
                                setState(() {
                                  showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                      title: const Text(' Reject User '),
                                      content: const Text(
                                          'Are you sure want to delete '),
                                      actions: <Widget>[
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            TextButton(
                                              onPressed: () => Navigator.pop(
                                                  context, 'Cancel'),
                                              child: customText(
                                                  maxline: 1,
                                                  fontWeight: FontWeight.normal,
                                                  text: 'Cancel',
                                                  color: mainColor),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                cubit.RejectUser(
                                                    Iduser: cubit
                                                        .requesteduserss!
                                                        .result![index]
                                                        .id
                                                        .toString(),
                                                    IdofRooms: widget.IDRoom
                                                        .toString());

                                                setState(() {
                                                  cubit.requesteduserss!.result!
                                                      .removeAt(index);
                                                  Navigator.pop(
                                                      context, 'Delete');
                                                });
                                                Navigator.pop(
                                                    context, 'Delete'); },
                                              child: customText(
                                                  maxline: 1,
                                                  fontWeight: FontWeight.normal,
                                                  text: 'Delete',
                                                  color: Colors.red),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                });
                              },
                              child: Card(
                                elevation: 6,
                                margin: EdgeInsets.all(10),
                                child: ListTile(
                                  leading: CircleAvatar(
                                    child: Text(cubit
                                        .requesteduserss!.result![index].name
                                        .toUpperCase()
                                        .substring(0, 2)),
                                    backgroundColor: Colors.purple,
                                  ),
                                  title: Text(cubit
                                      .requesteduserss!.result![index].name),
                                  subtitle: Text(cubit.requesteduserss!
                                      .result![index].statusId),
                                  trailing: InkWell(onTap:() {
                                    // cubit.AcceptUsers(
                                    //     Iduser: cubit.requesteduserss!
                                    //         .result![index].id
                                    //         .toString(),
                                    //     IdofRooms:
                                    //     widget.IDRoom.toString());
                                    setState(() {
                                      cubit.requesteduserss!.result!
                                          .removeAt(index);
                                    });
                                  },
                                    child:const Icon(Icons.done_rounded),
                                  ),
                                ),
                              ),
                              // This will show up when the user performs dismissal action
                              // It is a red background and a trash icon
                              background: Container(
                                color: Colors.red,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                alignment: Alignment.centerLeft,
                                child: const Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ));
                  });
            }));
  }
}
