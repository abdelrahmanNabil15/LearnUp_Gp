import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'CustomText.dart';

class Rooms extends StatelessWidget {
  const Rooms(
      {Key? key,
      required this.Status,
      required this.host,
      required this.RoomName,
      required this.Roomdescription})
      : super(key: key);

  final String Status, host, RoomName, Roomdescription;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(15),
          child: SafeArea(
            child: Container(
              width: double.infinity,
              height: 190.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.grey.shade50,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //name of rooms
                      Expanded(
                        flex: 4,
                        child: Padding(

                          padding: EdgeInsets.symmetric(horizontal:  8.0.w,vertical: 8.h),
                          child: customText(
                            maxline: 2,
                            fontWeight: FontWeight.bold,
                            text: RoomName,
                            //'Roadmap <> Flutter  Enginger Flutter dev chat |Ep05',
                          ),
                        ),
                      ),
                      //status of room joined or live
                      Expanded( flex: 1,

                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal:  8.0.w,vertical: 8.h),
                          child: customText(
                            alignment: Alignment.topRight,
                            maxline: 1,
                            fontWeight: FontWeight.bold,
                            text: Status,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal:  8.0.w,vertical: 8.h),
                    child: customText(
                      maxline: 1,
                      fontWeight: FontWeight.normal,
                      text: '44 listening',
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.r),
                        color: Colors.grey.shade100,
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal:  10.0.w,vertical: 10.h),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                    height: 30.h,
                                    width: 30.w,
                                    child:
                                        Image.asset('assets/Profile Image.png')),
                                  SizedBox(
                                  width: 10.w,
                                ),
                                customText(
                                  maxline: 1,
                                  fontWeight: FontWeight.bold,
                                  text: host,
                                ),
                                 SizedBox(
                                  width: 10.w,
                                ),
                                Container(
                                  color: Colors.white,
                                  height: 22.h,
                                  child: customText(
                                    maxline: 1,
                                    fontWeight: FontWeight.normal,
                                    text: 'Host',
                                  ),
                                )
                              ],
                            ),
                            Expanded(

                              child: customText(
                                maxline: 1,
                                fontWeight: FontWeight.normal,
                                text: Roomdescription,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
      itemCount: 3,
      physics: const BouncingScrollPhysics(),
      separatorBuilder: (context, index) => const SizedBox(
        width: 20,
      ),
      scrollDirection: Axis.vertical,
    );
    ;
  }
}
