import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_app/core/exenstions/context_extenstion.dart';


BottomNavigationBarItem buildNavItem(BuildContext context,{
  required String icon,
  required String label,
  required bool isSelected,
}) {
  return BottomNavigationBarItem(
    icon: Container(
     margin: EdgeInsets.only(left: 12.w, right: 12.w, top: 12.h),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: isSelected
          ? BoxDecoration(
        color: Colors.green.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16.r),
      )
          : null,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child:SvgPicture.asset(
            icon,
              color: isSelected?context.colorScheme.primary:context.colorScheme.primary.withOpacity(0.5),
              // colorFilter: ColorFilter.mode(Colors.red, BlendMode.srcIn),
            ),
            // Icon(
            //   icon,
            // ),
          ),
          SizedBox(
            width: 8.w,
          ),
          if (isSelected)
            Expanded(
              flex: 2,
              child: Text(
                label,
                style: context.textTheme.labelMedium?.copyWith(
                  overflow: TextOverflow.ellipsis,
                    fontFamily: "BentonSans Medium"
                )

              ),
            ),
        ],
      ),
    ),
    label: "",
  );
}
/*
 const TextStyle(
                color: Colors.black,
                overflow: TextOverflow.ellipsis,
              ),
 */