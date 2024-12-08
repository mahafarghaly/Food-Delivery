import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_app/core/exenstions/context_extenstion.dart';
import 'package:food_app/core/exenstions/widget_extensions.dart';
import 'package:food_app/features/home/data/model/menu.dart';
import 'package:food_app/features/home/data/model/restaurant.dart';
import 'package:food_app/features/home/presentation/bloc/restaurant_bloc/restaurant_bloc.dart';
import 'package:food_app/features/home/presentation/bloc/restaurant_bloc/restaurant_state.dart';
import 'package:food_app/features/home/presentation/views/widgets/banner_displayt.dart';
import 'package:food_app/features/home/presentation/views/widgets/home_appbar_section.dart';
import 'package:food_app/features/home/presentation/views/widgets/list_view_more_section.dart';
import 'package:food_app/features/home/presentation/views/widgets/lists/nearest_restaurant.dart';
import 'package:food_app/features/home/presentation/views/widgets/lists/popular_menu_list.dart';
import 'package:food_app/features/home/presentation/views/widgets/menu_item.dart';
import '../../bloc/restaurant_bloc/restaurant_event.dart';
import '../widgets/lists/popular_restaurant_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, this.content});
final Widget? content;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(
        top: 60.h,
      ),
      child: Column(
        children: [
          const HomeAppbarSection(),
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child:content?? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const BannerDisplay()
                          .paddingHorizontal(25.w)
                          .paddingTop(20),
                      // //.paddingRight(9.w),
                      BlocBuilder<RestaurantsBloc, RestaurantsState>(
                        builder:
                            (BuildContext context, RestaurantsState state) {
                          return ListViewMoreSection(
                            name: "Nearest Restaurant",
                            showMore: state.showNearestR,
                            restaurantsEvent: ToggleViewNearestMore(),
                          ).paddingHorizontal(25.w).paddingVertical(8.h);
                        },
                      ),
                      const NearestRestaurantList().paddingHorizontal(20.h),
                      BlocBuilder<RestaurantsBloc, RestaurantsState>(
                        builder:
                            (BuildContext context, RestaurantsState state) {
                          return ListViewMoreSection(
                            name: "Popular Menu",
                            showMore: state.showPMenu,
                            restaurantsEvent: ToggleViewPMenuMore(),
                          ).paddingHorizontal(25.w).paddingVertical(8.h);
                        },
                      ),
                      const PopularMenuList().paddingHorizontal(15.h),
                      BlocBuilder<RestaurantsBloc, RestaurantsState>(
                        builder:
                            (BuildContext context, RestaurantsState state) {
                          return ListViewMoreSection(
                            name: "Popular Restaurants",
                            showMore: state.showPRestaurants,
                            restaurantsEvent: ToggleViewPRestaurantMore(),
                          ).paddingHorizontal(25.w).paddingVertical(8.h);
                        },
                      ),
                      const PopularRestaurantList().paddingHorizontal(15.h),

                    ],
                  ),
                ),


              ],
            ),
          ),
        ],
      ),
    );
  }
}
