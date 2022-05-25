import 'package:flutter/material.dart';

class textFormField extends StatelessWidget {
  TextEditingController controller;
  TextInputType type;
  String label;
  FormFieldValidator validator;
  TextInputAction inputAction;
  int? maxLines = 1;


      textFormField(
  {Key? key,
  required this.controller,
  required this.type,
  required this.label, required this.maxLines,

  required this.inputAction,
  required this.validator,
  })

      :

  super

  (

  key

      :

  key

  );

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction: inputAction,
      controller: controller,
      keyboardType: type,
      validator: validator,
      maxLines: maxLines,
      decoration: InputDecoration.collapsed(

        hintText: label,

      ),
    );
  }
}