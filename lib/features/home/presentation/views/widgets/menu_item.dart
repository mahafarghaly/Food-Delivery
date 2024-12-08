import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_app/core/exenstions/context_extenstion.dart';
import 'package:food_app/core/exenstions/widget_extensions.dart';

class MenuItem extends StatelessWidget {
  const MenuItem({super.key, required this.menu, required this.restaurant, required this.image, required this.price});
final String menu;
final String restaurant;
final String image;
final double price;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 20.w,vertical: 10.h),
      child: Row(
        children: [
          Container(
            padding: EdgeInsetsDirectional.only(
                top: 12.h, bottom: 12.h, start: 10.w, end: 21.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r)
            ),
            child: Image.network(image,
                       fit: BoxFit.cover,
              width: 64.w,
              height: 64.h,
            ),
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(menu,style:context.textTheme.bodyMedium?.copyWith(
                  fontSize: 15
                ),maxLines: 1,overflow: TextOverflow.ellipsis,),
                Text(restaurant,style:context.textTheme.bodyMedium?.copyWith(
                  color: context.colorScheme.outlineVariant.withOpacity(0.3),
                  fontSize: 14,

                ),maxLines: 1,overflow: TextOverflow.ellipsis)
              ],
            ),
          ),
         SizedBox(width: 20.w,),
        //const Spacer(),
          Text("${price.toInt()}\$",style: context.textTheme.labelLarge?.copyWith(
            color: context.colorScheme.onTertiaryContainer,
          ),).paddingRight(20.w)
        ],
      ),
    );
  }
}
