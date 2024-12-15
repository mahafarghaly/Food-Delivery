import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_app/core/utils/app_assets.dart';
import 'package:food_app/features/base/presentation/bloc/app_bloc.dart';
import 'package:food_app/features/base/presentation/bloc/app_state.dart';
import 'package:food_app/features/home/data/model/restaurant.dart';
import '../../../../../../core/utils/calculate_distance.dart';
import '../../../../../base/data/helpers/request_state.dart';
import '../../../bloc/restaurant_bloc/restaurant_bloc.dart';
import '../../../bloc/restaurant_bloc/restaurant_state.dart';
import '../restaurant_item.dart';

class PopularRestaurantList extends StatelessWidget {
  const PopularRestaurantList(
      {super.key, this.filteredRestaurant, this.selectedDistance});

  final List<Restaurant>? filteredRestaurant;
  final num? selectedDistance;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc,AppState>(

      builder: (BuildContext context, AppState state) {
        double? userLat = state.longitude;
        double? userLon = state.longitude;
        return BlocBuilder<RestaurantsBloc, RestaurantsState>(
            builder: (BuildContext context, RestaurantsState state) {
              switch (state.restaurantsState) {
                case RequestState.loading:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );

                case RequestState.loaded:

                  final popularRestaurants = filteredRestaurant != null
                      ? filteredRestaurant!
                      .where((restaurant) {
                    if (selectedDistance != null) {
                      final distance = calculateDistance(
                        userLat ?? 0.0,
                        userLon ?? 0.0,
                        restaurant.lat ?? 0.0,
                        restaurant.long ?? 0.0,
                      );
                      return (restaurant.rate ?? 0) >= 4.0 && distance <= selectedDistance!;
                    } else {
                      return (restaurant.rate ?? 0) >= 4.0;
                    }
                  })
                      .toList()
                      : state.restaurants.where((restaurant) {
                    return (restaurant.rate ?? 0) >= 4.0;
                  }).toList();
                  final itemCount = state.showPRestaurants
                      ? popularRestaurants.length
                      : (popularRestaurants.length > 3 ? 2 : popularRestaurants.length);

                  return popularRestaurants.isEmpty
                      ? const Center(
                    child: Text("No popular restaurants available."),
                  )
                      : GridView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10.h,
                      crossAxisSpacing: 10.w,
                      childAspectRatio: 147.w / 184.h,
                    ),
                    itemCount: itemCount,
                    itemBuilder: (context, index) {
                      final restaurant = popularRestaurants[index];
                      return RestaurantItem(
                        name: restaurant.name,
                        image: restaurant.imageUrl,
                      );
                    },
                  );

                case RequestState.error:
                  return Expanded(child: Text(state.restaurantsMessage));
              }
            });
      },

    );
  }
}
