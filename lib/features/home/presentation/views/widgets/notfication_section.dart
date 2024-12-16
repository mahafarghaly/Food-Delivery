import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_app/core/exenstions/context_extenstion.dart';
import 'package:food_app/features/home/presentation/views/widgets/background_box.dart';
import '../../../../../core/utils/app_assets.dart';

class NotificationSection extends StatelessWidget {
  const NotificationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BackgroundBox(
        color: context.colorScheme.onPrimary,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 13.w),
          child: Stack(
            alignment: AlignmentDirectional.topEnd,
            children: [
              Column(
                children: [
                  SvgPicture.asset(
                    AppAssets.notification,
                    // colorFilter: ColorFilter.mode(Colors.red, BlendMode.srcIn),
                    width: 19.w,
                    height: 19.h,
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  SvgPicture.asset(
                    AppAssets.curve,
                    // colorFilter: ColorFilter.mode(Colors.red, BlendMode.srcIn),
                    width: 20.w,
                    height: 4.h,
                  ),
                ],
              ),
              CircleAvatar(
                radius: 7.r,
                backgroundColor: context.colorScheme.onPrimary,
                child: CircleAvatar(
                  radius: 5.r,
                  backgroundColor: Theme.of(context).colorScheme.onError,
                ),
              )
            ],
          ),
        ));
  }
}
