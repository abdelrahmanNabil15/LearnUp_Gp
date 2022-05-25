// ignore_for_file: file_names, camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class profileMeun extends StatelessWidget {
  const profileMeun({
    Key? key,
    this.color = Colors.black,
    required this.text,
    required this.icon,
    this.press,
  }) : super(key: key);

  final String text, icon;
  final VoidCallback? press;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: TextButton(
        style: TextButton.styleFrom(
          primary: color,
          padding: const EdgeInsets.all(20),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
          backgroundColor: const Color(0xFFF5F6F9),
        ),
        onPressed: press,
        child: Row(
          children: [
            SvgPicture.asset(
              icon,
              color: color,
              width: 22.w,
            ),  SizedBox(width: 20.w),
            Expanded(
                child: Text(
              text,
              style: TextStyle(color: color),
            )),
            const Icon(Icons.arrow_forward_ios),
          ],
        ),
      ),

    );
  }
}
