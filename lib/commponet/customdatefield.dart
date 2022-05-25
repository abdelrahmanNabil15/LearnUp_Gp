import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomdateField extends StatelessWidget {
  const CustomdateField({
    Key? key,
    required this.dateController,
  }) : super(key: key);
  final TextEditingController dateController;

  @override
  Widget build(BuildContext context) {
    return DateTimePicker(
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
          borderSide: const BorderSide(
            color: Colors.redAccent,
            width: 2,
          ),
        ),
        prefixIcon: const Icon(
          Icons.date_range_outlined,
        ),
      ),
      controller: dateController,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      dateLabelText: 'Date',
      onChanged: (val) => print(val.toUpperCase()),
      validator: (val) {
        return null;
      },
      onSaved: (val) => print(val),
    );
  }
}
