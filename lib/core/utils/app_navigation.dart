import 'package:flutter/material.dart';
class AppNavigation{
  static void navigationTo( BuildContext context ,Widget widget) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) =>  widget),
    );
  }
}
