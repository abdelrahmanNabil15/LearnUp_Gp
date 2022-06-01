// ignore_for_file: file_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DefaultFormField extends StatelessWidget {
  TextEditingController controller;
  TextInputType type;
  String label;
  IconData prefix;
  IconButton? suffix;
  TextInputAction inputAction;
  Function(String value) validator;
  bool isobscureText=false;


  DefaultFormField(
      {Key? key,
      required this.controller,
      required this.type,
      required this.label,
      required this.prefix,
      required this.inputAction,
        required this.validator,
        this.suffix,
      required this.isobscureText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction: inputAction,
      controller: controller,
      keyboardType: type,
      obscureText: isobscureText,
      decoration: InputDecoration(


        errorStyle: const TextStyle(
          color: Colors.redAccent,
          fontWeight: FontWeight.bold,
        ),
        border: const OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0.r),
          borderSide: BorderSide(
            color: Colors.grey.withOpacity(0.5),
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0.r),
          borderSide: BorderSide(
            color: Colors.redAccent,
            width: 2.w,
          ),
        ),
        hintText: label,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon:suffix
      ),
    );
  }
}