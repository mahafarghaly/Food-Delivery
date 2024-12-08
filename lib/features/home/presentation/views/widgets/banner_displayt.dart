import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_app/core/exenstions/context_extenstion.dart';
import 'package:food_app/core/utils/app_assets.dart';

class BannerDisplay extends StatelessWidget {
  const BannerDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150.h,
      child: Stack(
        alignment: AlignmentDirectional.centerEnd,
        children: [
          Container (
            decoration: BoxDecoration(
              color: context.colorScheme.primary,
              borderRadius: BorderRadius.circular(16.r),
              image: DecorationImage(image: AssetImage(AppAssets.bannerBackground,),fit: BoxFit.cover)
            ),

          ),
          Container(
        //    color: Colors.yellow,
            margin: EdgeInsetsDirectional.only(start: 173.w),
            padding: EdgeInsetsDirectional.symmetric(vertical:30.h,horizontal: 10.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex:2,
                  child: Text("Special Deal For October",style:context.textTheme.titleSmall?.copyWith(
                    color: context.colorScheme.onPrimary
                  ),
                  )
                ),
                Expanded(
                  child: MaterialButton(
                    height: 32.h,
                    color: context.colorScheme.onPrimary,
                    shape:OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6.r),
                      borderSide: BorderSide(color: context.colorScheme.onPrimary)
                    ),
                    onPressed: (){},child: Text("Buy Now",style:context.textTheme.bodySmall?.copyWith(
                    color: context.colorScheme.primary
                  ),)),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
