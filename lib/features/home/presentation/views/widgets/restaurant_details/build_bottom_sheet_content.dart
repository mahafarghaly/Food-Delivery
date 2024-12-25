import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_app/core/exenstions/context_extenstion.dart';
import 'package:food_app/core/exenstions/widget_extensions.dart';
import 'package:food_app/features/home/data/model/restaurant.dart';
import 'package:food_app/features/home/presentation/views/widgets/restaurant_details/rate_section.dart';
import 'package:food_app/features/home/presentation/views/widgets/restaurant_details/restaurant_popular_menu_list.dart';
import 'package:food_app/features/home/presentation/views/widgets/restaurant_details/view_all_section.dart';
import '../../../../../../core/service/service_locator.dart';
import '../../../../../../core/utils/app_navigation.dart';
import '../../../../../../core/utils/constants.dart';
import '../../../bloc/restaurant_details_bloc/restaurant_details_bloc.dart';
import '../../screens/restaurant/restaurant_map_screen.dart';
import '../background_box.dart';
import 'distance_section.dart';
import 'favorite_button.dart';

class BuildBottomSheetContent extends StatelessWidget {
  const BuildBottomSheetContent({super.key, required this.restaurant});
final Restaurant restaurant;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => sl<RestaurantDetailsBloc>(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
              child: BackgroundBox(
                color: context.colorScheme.surfaceTint,
                width: 58.w,
                height: 5.h,
              )).paddingTop(18.5.h),
          SizedBox(
            height: 21.h,
          ),
          Row(
            children: [
              BackgroundBox(
                color: context.colorScheme.primary.withOpacity(0.1),
                child: Padding(
                  padding: EdgeInsets.only(
                      top: 10.h, bottom: 8.h, left: 17.w, right: 14.w),
                  child: Text(
                    "Popular",
                    style: context.textTheme.labelMedium
                        ?.copyWith(color: context.colorScheme.primary),
                  ),
                ),
              ),
              const Spacer(),
              InkWell(
                onTap: () {
                  AppNavigation.navigationTo(
                      context,
                      RestaurantMapScreen(
                          latitude: restaurant.lat ?? 0,
                          longitude: restaurant.long ?? 0));
                },
                child: BackgroundBox(
                  color: context.colorScheme.primary.withOpacity(0.1),
                  radius: 18.5.sp,
                  height: 34.sp,
                  width: 34.sp,
                  child: Icon(Icons.location_on,
                      size: 20.sp, color: context.colorScheme.primary),
                ).paddingRight(10.w),
              ),
              const FavoriteButton()
            ],
          ).paddingHorizontal(30.w),
          SizedBox(
            height: 20.h,
          ),
          Text(
            restaurant.name ?? "",
            style: context.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w400,
            ),
          ).paddingHorizontal(33.w),
          SizedBox(height: 20.h),
          Row(
            children: [
              DistanceSection(
                  restaurantLate: restaurant.lat ?? 0.0,
                  restaurantLong: restaurant.long ?? 0.0),
              SizedBox(
                width: 20.w,
              ),
             RateSection(rate: restaurant.rate?.toDouble()),
            ],
          ).paddingHorizontal(30.w),
          Padding(
            padding: EdgeInsets.only(
                left: 33.w, right: 30.r, top: 20.h, bottom: 20.h),
            child: Text(
             restaurant.description?? "",
              style: context.textTheme.bodySmall
                  ?.copyWith(fontFamily: Constants.bentonSansBookFamily),
            ),
          ),
          const ViewAllSection().paddingHorizontal(33.w),
          RestaurantPopularMenuList(restaurant: restaurant)
              .paddingHorizontal(20.w)
        ],
      ),
    );;
  }
}
