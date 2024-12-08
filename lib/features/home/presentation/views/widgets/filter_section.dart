import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_app/core/exenstions/context_extenstion.dart';
import '../../../../../core/utils/app_assets.dart';
import 'background_box.dart';

class FilterSection extends StatelessWidget {
  const FilterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BackgroundBox(
      color: context.colorScheme.primaryContainer.withOpacity(0.3),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 13.h, horizontal: 13.w),
        child: SvgPicture.asset(
          AppAssets.filter,
          // colorFilter: ColorFilter.mode(Colors.red, BlendMode.srcIn),
        ),
      ),
    );
  }
}
