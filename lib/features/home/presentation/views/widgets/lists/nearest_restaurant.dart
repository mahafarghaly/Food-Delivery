import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_app/features/base/data/helpers/request_state.dart';
import 'package:food_app/features/home/data/model/restaurant.dart';
import 'package:food_app/features/home/presentation/bloc/restaurant_bloc/restaurant_bloc.dart';
import 'package:food_app/features/home/presentation/bloc/restaurant_bloc/restaurant_state.dart';
import 'package:food_app/features/home/presentation/views/widgets/restaurant_item.dart';
import '../../../../../../core/utils/calculate_distance.dart';
import '../../../../../base/presentation/bloc/app_bloc.dart';
import '../../../../../base/presentation/bloc/app_state.dart';
class NearestRestaurantList extends StatelessWidget {
  const NearestRestaurantList({super.key, this.selectedDistance, this.filteredRestaurant});
  final num? selectedDistance;
  final List<Restaurant>? filteredRestaurant;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (BuildContext context,  state) {
         double? userLat = state.latitude;//30.894228;
         double? userLon =state.longitude;//30.611446;
        print("${state.latitude}");
        print("${state.longitude}");
        return BlocBuilder<RestaurantsBloc,RestaurantsState>(
          // buildWhen: (previous, current) =>
          // previous.restaurants != current.restaurants,
          builder: (BuildContext context, RestaurantsState state) {
            switch(state.restaurantsState){
              case RequestState.loading:
                return   SizedBox(
                  height: 184.h,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              case RequestState.loaded:
                final filteredRestaurants =filteredRestaurant!=null?filteredRestaurant!.where((restaurant) {
                  final distance = calculateDistance(
                    userLat!,
                    userLon!,
                    restaurant.lat!,
                    restaurant.long!,
                  );
                  return distance <= (selectedDistance??10);
                }).toList(): state.restaurants.where((restaurant) {
                  final distance = calculateDistance(
                    userLat?? 30.894228,
                    userLon?? 30.611446,
                    restaurant.lat!,
                    restaurant.long!,
                  );
                  return distance <= (selectedDistance??10);
                }).toList();
                final itemCount = state.showNearestR
                    ? filteredRestaurants.length
                    : (filteredRestaurants.length > 3 ? 3 : filteredRestaurants.length);

                return SizedBox(
                  height: 184.h,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount:itemCount,
                      itemBuilder: (context, index) =>  RestaurantItem(name:"${filteredRestaurants[index].name}",image:"${filteredRestaurants[index].imageUrl}" ,)),
                );
              case RequestState.error:
                return Center(
                  child: Text(state.restaurantsMessage),
                );
            }
        
          },
        
        );
      },

    );
  }
}
