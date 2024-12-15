import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_app/core/exenstions/context_extenstion.dart';


BottomNavigationBarItem buildNavItem(BuildContext context,{
  required IconData icon,
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
            child: Icon(
              icon,
            ),
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