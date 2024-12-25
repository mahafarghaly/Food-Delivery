import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_app/core/exenstions/context_extenstion.dart';
import 'package:food_app/core/exenstions/widget_extensions.dart';

class RateSection extends StatelessWidget {
  const RateSection({super.key, required this.rate});
final double? rate;
  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        Icon(
         rate!=null&& rate! <= 4.5 &&rate!>=2
              ? Icons.star_half_outlined
              :  rate!=null&& rate! <= 5&& rate!>4.5
              ? Icons.star_sharp
              : Icons.star_outline,
          color: context.colorScheme.primary,
        ).paddingRight(10.w),
        Text(
          "${rate ?? "UnRated"}${rate != null ? " Rating" : ""}",
          style: context.textTheme.bodyMedium?.copyWith(
              color: context.colorScheme.outlineVariant
                  .withOpacity(0.3)),
        )
      ],
    );
  }
}
