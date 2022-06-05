

import 'package:agora_uikit/agora_uikit.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';

import '../../commponet/CustomText.dart';
import '../../commponet/DefaultFormField.dart';
import '../../commponet/commpnet.dart';
import '../../commponet/const.dart';
import 'QuestionScreen.dart';

class TabBarPages extends StatefulWidget {
  @override
  final cubit, id;

  const TabBarPages({Key? key, this.cubit, this.id}) : super(key: key);

  tabBarPagesState createState() => tabBarPagesState();
}

class tabBarPagesState extends State<TabBarPages> {
  var nameController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  String fileType = 'All';
  var fileTypeList = ['All', 'Image', 'Video', 'Audio','MultipleFile'];
  FilePickerResult? result;
  PlatformFile? file;

  void pickFiles(String? filetype) async {
    switch (filetype) {
      case 'Image':
        result = await FilePicker.platform.pickFiles(type: FileType.image);
        if (result == null) return;
        file = result!.files.first;
        setState(() {});
        break;
      case 'Video':
        result = await FilePicker.platform.pickFiles(type: FileType.video);
        if (result == null) return;
        file = result!.files.first;
        setState(() {});
        break;
      case 'Audio':
        result = await FilePicker.platform.pickFiles(type: FileType.audio);
        if (result == null) return;
        file = result!.files.first;
        setState(() {});
        break;
      case 'All':
        result = await FilePicker.platform.pickFiles();
        if (result == null) return;
        file = result!.files.first;
        setState(() {});
        break;
      case 'MultipleFile':
        result = await FilePicker.platform.pickFiles(allowMultiple: true);
        if (result == null) return;
        // loadSelectedFiles(result!.files);
        break;
    }
  }
  // multiple file selected
  // navigate user to 2nd screen to show selected files
  // void loadSelectedFiles(List<PlatformFile> files){
  //   Navigator.of(context).push(
  //       MaterialPageRoute(builder: (context) => FileList(files: files, onOpenedFile:viewFile ))
  //   );
  // }
  // // open the picked file
  // void viewFile(PlatformFile file) {
  //   OpenFile.open(file.path);
  // }



    @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Expanded(
        child: Column(
          children: <Widget>[
            // construct the profile details widget here

            // the tab bar with two items
            SizedBox(
              child: TabBar(
                indicatorColor: mainColor,
                isScrollable: true,
                tabs: [
                  Tab(
                    child: Row(
                      children: [
                        Icon(Iconsax.message_question),
                        SizedBox(
                          width: 5.w,
                        ),
                        Text(" questions  "),
                      ],
                    ),
                  ),
                  Tab(
                    child: Row(
                      children: [
                        Icon(Icons.file_open_outlined),
                        SizedBox(
                          width: 5.w,
                        ),
                        Text(" metrials  "),
                      ],
                    ),
                  ),
                  Tab(
                    child: Row(
                      children: [
                        Icon(Iconsax.user),
                        SizedBox(
                          width: 5.w,
                        ),
                        Text("Joined users"),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // create widgets for each tab bar here
            Expanded(
              child: TabBarView(
                children: [
                  // first tab bar view widget
                  Container(
                    color: Colors.white,
                    child: ListView(
                      physics: BouncingScrollPhysics(),
                      children: [
                        DefaultFormField(
                          isobscureText: false,
                          controller: nameController,
                          inputAction: TextInputAction.next,
                          label: 'Ask Question',
                          prefix: Iconsax.message_add,
                          suffix: IconButton(
                              onPressed: () {
                                widget.cubit.CreateQuestion(
                                    description: nameController.text,
                                    id: widget.id.toString(),
                                    title: nameController.text);
                                nameController.clear();
                                Fluttertoast.showToast(
                                    msg: "commoented",
                                    toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.TOP,
                                    timeInSecForIosWeb: 3,
                                    textColor: Colors.black,
                                    backgroundColor: Colors.black45,
                                    fontSize: 14.0.sp);
                              },
                              icon: const Icon(
                                Iconsax.send_14,
                                color: mainColor,
                              )),
                          type: TextInputType.name,
                          validator: (String value) {
                            if (value.isEmpty) {
                              print("please enter username ");
                            }
                          },
                        ),
                        ConditionalBuilder(
                            condition: widget.cubit.questionModel != null,
                            builder: (context) {
                              return ListView.separated(
                                  itemCount: widget
                                      .cubit.questionModel!.Questions!.length,
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  separatorBuilder: (context, index) =>
                                      const Divider(),
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [
//question widget for users
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            customText(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              text: widget
                                                  .cubit
                                                  .questionModel!
                                                  .Questions![index]
                                                  .userName!,
                                            ),
                                            IconButton(
                                                onPressed: () async{

                                                  pickFiles(fileType);
                                                  },
                                                icon: Icon(Iconsax.more))
                                          ],
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20.0.w),
                                          child: customText(
                                            color: Colors.black54,
                                            fontWeight: FontWeight.normal,
                                            text: widget
                                                .cubit
                                                .questionModel!
                                                .Questions![index]
                                                .questionDescription,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 18.0.w),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                            children: [
                                              TextButton(
                                                  onPressed: () {
                                                    widget.cubit.Getanswer(
                                                        idquestion: widget
                                                            .cubit
                                                            .questionModel!
                                                            .Questions![index]
                                                            .id!
                                                            .toString());
                                                    Navigator.of(context)
                                                        .push(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              QuestionScreen(
                                                                idQuestion: widget
                                                                    .cubit
                                                                    .questionModel!
                                                                    .Questions![
                                                                        index]
                                                                    .id!
                                                                    .toString(),
                                                              )),
                                                    );
                                                  },
                                                  child: Text(
                                                      "View replies....")),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    right: 20.0.w),
                                                child: TextButton(
                                                  onPressed: () {},
                                                  child: customText(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold,
                                                    text: "Reply",
                                                    alignment:
                                                        Alignment.topRight,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    );
                                  });
                            },
                            fallback: (BuildContext context) {
                              return Container(
                                  color: Colors.white,
                                  child: Center(child: spinkitCircle));
                            }),
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.red,
                    child: Center(
                      child: Text(
                        'Bike',
                      ),
                    ),
                  ),

                  // second tab bar viiew widget
                  Container(
                    color: Colors.pink,
                    child: Center(
                      child: Text(
                        'Car',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


