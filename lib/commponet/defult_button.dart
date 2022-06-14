// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import 'const.dart';

class DefaultButton extends StatelessWidget {
  double width;
  Function function;
  String text;
  bool isUpper;
  Color color;

  DefaultButton({
    Key? key,
    required this.function,
    this.width = double.infinity,
    required this.text,
    this.isUpper = true,
    this.color = mainColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width.w,
      height: 40.0.h,
      child: MaterialButton(
        color: color,
        onPressed: () {
          function();
        },
        child: Text(
          isUpper ? text.toUpperCase() : text,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}