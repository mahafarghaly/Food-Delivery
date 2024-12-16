import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_app/core/exenstions/context_extenstion.dart';
import 'package:food_app/core/exenstions/widget_extensions.dart';
import 'package:food_app/core/utils/app_assets.dart';

class RestaurantItem extends StatelessWidget {
  const RestaurantItem({super.key, this.name, this.image});
final String? name;
final String? image;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 184.h,
      width: 147.w,
      child: Card(
        color:context.colorScheme.onSecondaryContainer,
          margin: EdgeInsetsDirectional.symmetric(horizontal: 10.w),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22.0.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            image!=null?
            Image.network(image!,height: 90.h,width: 90.w,fit: BoxFit.cover,).paddingHorizontal(26.w):
            Image.asset(AppAssets.testImage),
            Text(name??"not found",style:context.textTheme.labelLarge,).paddingTop(10),
            SizedBox(height: 4.h,),
            Text("10 Min",style: context.textTheme.labelSmall?.copyWith(
                fontSize: 13.sp,
                color: context.colorScheme.surfaceDim.withOpacity(0.5)
            ),)//.paddingBottom(26)




          ],
        )
      ),
    );
  }
}
