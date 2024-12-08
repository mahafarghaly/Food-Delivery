import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_app/core/exenstions/widget_extensions.dart';
import 'package:food_app/core/utils/app_navigation.dart';
import 'package:food_app/features/home/presentation/views/widgets/search_text_field.dart';
import 'package:food_app/features/search/search_screen.dart';

import 'filter_section.dart';
import 'notfication_section.dart';

class HomeAppbarSection extends StatelessWidget {
  const HomeAppbarSection({super.key, this.enableSearch});
final bool? enableSearch;
  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        Row(
          children: [
            Expanded(
                child: Text(
                  "Find Your Favorite Food",
                  style: Theme.of(context).textTheme.headlineMedium,
                ).paddingLeft(31)),
            SizedBox(
              width: 27.w,
            ),
            const NotificationSection().paddingRight(27),
          ],
        ),
        SizedBox(
          height: 18.h,
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: GestureDetector(
                onTap: (){
     AppNavigation.navigationTo(context, const SearchScreen());
                },
                child:  SearchTextField(
                  enable: enableSearch??false,
                ).paddingRight(9.w),
              ),
            ),
            const FilterSection(),
          ],
        ).paddingHorizontal(25.w),
      ],
    );
  }
}
