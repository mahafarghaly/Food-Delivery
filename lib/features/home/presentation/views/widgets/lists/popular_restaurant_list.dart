import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_app/features/home/data/model/restaurant.dart';

import '../../../../../base/data/helpers/request_state.dart';
import '../../../bloc/restaurant_bloc/restaurant_bloc.dart';
import '../../../bloc/restaurant_bloc/restaurant_state.dart';
import '../restaurant_item.dart';

class PopularRestaurantList extends StatelessWidget {
  const PopularRestaurantList({super.key, this.filteredRestaurant});
final List<Restaurant>?filteredRestaurant;
  @override
  Widget build(BuildContext context) {
        return BlocConsumer<RestaurantsBloc, RestaurantsState>(
            listener: (BuildContext context, RestaurantsState state) {
              if(filteredRestaurant!=null){
                print("filteredRestaurants:cccccccc****: ${filteredRestaurant!.length}");

              }else {
                print("empty----");
              }
            },
          builder: (BuildContext context, RestaurantsState state) {
            switch (state.restaurantsState) {
              case RequestState.loading:
                return const Center(
                  child: CircularProgressIndicator(),
                );

              case RequestState.loaded:
                final popularRestaurants =filteredRestaurant!=null?filteredRestaurant!.where((restaurant) {
            return (restaurant.rate ?? 0) >= 4.0;
            }).toList():state.restaurants.where((restaurant) {
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
                  gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10.h,
                    crossAxisSpacing: 10.w,
                    childAspectRatio: 147.w / 184.h,

                  ),
                  itemCount:itemCount,
                  itemBuilder: (context, index) {
                    final restaurant = popularRestaurants[index];
                    return RestaurantItem(
                      name: restaurant.name,
                      image: restaurant.imageUrl,
                    );
                  },
                );


              case RequestState.error:
                return Center(
                  child: Text(state.restaurantsMessage),
                );
            }
          }
        );

  }
}
