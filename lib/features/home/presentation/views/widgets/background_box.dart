import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class BackgroundBox extends StatelessWidget {
  const BackgroundBox({super.key, required this.color, this.child, this.radius= 15, this.height, this.width, });
final Widget? child;
final Color color;
final double? radius;
final double? height;
final double?width;
  @override
  Widget build(BuildContext context) {
    return  Container(
      height: height,
        width: width,
        decoration: BoxDecoration(
        color:color,
        borderRadius: BorderRadius.circular(radius!.r)
    ),
      child: child,
    );
  }
}
