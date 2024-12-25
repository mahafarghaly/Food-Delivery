import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_app/core/utils/app_strings.dart';
import 'package:food_app/features/base/data/helpers/request_state.dart';
import 'package:food_app/features/home/presentation/bloc/restaurant_bloc/restaurant_bloc.dart';
import 'package:food_app/features/home/presentation/bloc/restaurant_bloc/restaurant_state.dart';
import 'package:food_app/features/home/presentation/views/widgets/restaurant_item.dart';
import 'package:lottie/lottie.dart';
import '../../../../../../core/utils/app_assets.dart';
import '../../../../../../core/utils/app_navigation.dart';
import '../../../../../../core/utils/calculate_distance.dart';
import '../../../../../base/presentation/bloc/app_bloc.dart';
import '../../../../../base/presentation/bloc/app_state.dart';
import '../../screens/restaurant/restaurant_details_screen.dart';

class NearestRestaurantList extends StatelessWidget {
  const NearestRestaurantList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (BuildContext context, state) {
        double? userLat = state.latitude; //30.894228;
        double? userLon = state.longitude; //30.611446;
        print("${state.latitude}");
        print("${state.longitude}");
        return BlocBuilder<RestaurantsBloc, RestaurantsState>(
          // buildWhen: (previous, current) =>
          // previous.restaurants != current.restaurants,
          builder: (BuildContext context, RestaurantsState state) {
            switch (state.restaurantsState) {
              case RequestState.loading:
                return SizedBox(
                  height: 184.h,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              case RequestState.loaded:
                final filteredRestaurants =
                    state.restaurants.where((restaurant) {
                  final distance = calculateDistance(
                    userLat ?? 0,
                    userLon ?? 0,
                    restaurant.lat!,
                    restaurant.long!,
                  );
                  return distance <= 10; // 10 km radius
                }).toList();
                final itemCount = state.showNearestR
                    ? filteredRestaurants.length : (filteredRestaurants.length > 3
                        ? 3
                        : filteredRestaurants.length);

                return SizedBox(
                  height: 184.h,
                  child: filteredRestaurants.isEmpty
                      ? Center(
                          child: Lottie.asset(AppAssets.notFoundAnimation),
                          //Text(AppStrings.noNRestaurantsAvailable),
                        )
                      : ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: itemCount,
                          itemBuilder: (context, index) => InkWell(
                            onTap: (){
                              AppNavigation.navigationTo(context, RestaurantDetailsScreen(restaurant: filteredRestaurants[index],));

                            },
                            child: RestaurantItem(
                                  name: "${filteredRestaurants[index].name}",
                                  image: "${filteredRestaurants[index].logo}",
                                ),
                          )),
                );
              case RequestState.error:
                return Center(
                  child: Expanded(
                      child: Text(
                    state.restaurantsMessage,
                    overflow: TextOverflow.ellipsis,
                  )),
                );
            }
          },
        );
      },
    );
  }
}
