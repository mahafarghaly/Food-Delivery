import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


BottomNavigationBarItem buildNavItem({
  required IconData icon,
  required String label,
  required bool isSelected,
}) {
  return BottomNavigationBarItem(
    icon: Container(
      margin: EdgeInsets.only(left: 12.w, right: 12.w, top: 12),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: isSelected
          ? BoxDecoration(
        color: Colors.green.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16.r),
      )
          : null,
      child: Row(
        children: [
          Icon(
            icon,
          ),
          SizedBox(
            width: 8.w,
          ),
          if (isSelected)
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  color: Colors.black,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
        ],
      ),
    ),
    label: "",
  );
}