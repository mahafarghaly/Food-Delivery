import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_app/core/exenstions/context_extenstion.dart';
import 'package:food_app/core/exenstions/widget_extensions.dart';
import 'package:food_app/core/utils/constants.dart';

import '../../../../../../core/utils/app_assets.dart';

class RestaurantMenuItem extends StatelessWidget {
  const RestaurantMenuItem({super.key, this.name, this.image, this.price});

  final String? name;
  final String? image;
  final double? price;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 171.h,
      width: 147.w,
      child: Card(
          color: context.colorScheme.onSecondaryContainer,
          margin:
              EdgeInsetsDirectional.symmetric(horizontal: 10.w, vertical: 1.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22.0.r),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              image != null
                  ?
              CachedNetworkImage(
                      imageUrl: image!,
                      height: 71.h,
                      width: 71.w,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => const CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    )
                  .paddingTop(25.h)
                  : Image.asset(AppAssets.testImage),
              Text(
                textAlign: TextAlign.center,
                name ?? "not found",
                style: context.textTheme.labelLarge?.copyWith(
                  fontSize: 15.sp,
                  fontFamily: Constants.bentonSansMediumFamily,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ).paddingTop(16.h).paddingHorizontal(14.w),
              SizedBox(
                height: 8.h,
              ),
              Expanded(
                  child: Text(
                "${price ?? "UnKnow"} \$",
                style: context.textTheme.labelSmall?.copyWith(
                    fontSize: 13.sp,
                    color: context.colorScheme.surfaceDim.withOpacity(0.5)),
              ))
            ],
          )),
    );
  }
}
