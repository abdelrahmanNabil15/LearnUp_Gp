// ignore_for_file: camel_case_types

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class notification_screen extends StatelessWidget {
  const notification_screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'notification ',
        style: TextStyle(
          fontSize: 50,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
