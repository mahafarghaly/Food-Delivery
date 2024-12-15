import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class BackgroundBox extends StatelessWidget {
  const BackgroundBox({super.key, required this.color,required this.child, });
final Widget child;
final Color color;
  @override
  Widget build(BuildContext context) {
    return  Container(
        decoration: BoxDecoration(
        color:color,
        borderRadius: BorderRadius.circular(15.r)
    ),
      child: child,
    );
  }
}
