import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_app/core/exenstions/context_extenstion.dart';
import 'package:food_app/core/exenstions/widget_extensions.dart';
import 'package:food_app/features/home/presentation/bloc/restaurant_bloc/restaurant_bloc.dart';
import 'package:food_app/features/home/presentation/bloc/restaurant_bloc/restaurant_state.dart';
import 'package:food_app/features/home/presentation/views/widgets/lists/popular_restaurant_list.dart';

import '../../core/utils/app_assets.dart';
import '../home/presentation/views/widgets/home_appbar_section.dart';

class SearchResultScreen extends StatelessWidget {
  const SearchResultScreen({super.key, this.content});
final Widget? content;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.topRight,
        children: [
          Positioned(
              top: 0,
              right: 0,
              child: Image.asset(AppAssets.homeBackgroundImage)),
          BlocBuilder<RestaurantsBloc,RestaurantsState>(
            builder: (BuildContext context, RestaurantsState state) {
              state.showPRestaurants = true;
              state.showPMenu= true;
              state.showPRestaurants= true;
             return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const HomeAppbarSection().paddingTop(60.h),
                SizedBox(height: 20.h,),
                Text(
                  "Popular Restaurants",
                  style: context.textTheme.labelLarge?.copyWith(fontSize: 15.sp),
                ).paddingHorizontal(30.w),
                 Expanded(child:content??const Text("Not Exist"))
              ]);

            },
          )
        ],
      ),
    );
  }
}
