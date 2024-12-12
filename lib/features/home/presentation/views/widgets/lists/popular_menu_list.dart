import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_app/features/base/data/helpers/request_state.dart';
import 'package:food_app/features/base/presentation/bloc/app_bloc.dart';
import 'package:food_app/features/base/presentation/bloc/app_state.dart';
import 'package:food_app/features/home/data/model/menu_with_restaurant.dart';
import 'package:food_app/features/home/presentation/bloc/restaurant_bloc/restaurant_bloc.dart';
import 'package:food_app/features/home/presentation/bloc/restaurant_bloc/restaurant_state.dart';
import 'package:food_app/features/home/presentation/views/widgets/menu_item.dart';

import '../../../../../../core/utils/calculate_distance.dart';
import '../../../../data/model/restaurant.dart';

// class PopularMenuList extends StatelessWidget {
//   const PopularMenuList({super.key, this.filteredMenu, this.selectedDistance});
//
//   final List<MenuWithRestaurant>? filteredMenu;
//   final num? selectedDistance;
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<AppBloc,AppState>(
//
//       builder: (BuildContext context, AppState appState) {
//         double? userLat =appState.latitude;
//         double? userLon = appState.longitude;
//         return  BlocBuilder<RestaurantsBloc, RestaurantsState>(
//           builder: (BuildContext context, RestaurantsState state) {
//             switch (state.restaurantsState) {
//               case RequestState.loading:
//                 return SizedBox(
//                   height: 87.h,
//                   child: const Center(
//                     child: CircularProgressIndicator(),
//                   ),
//                 );
//
//               case RequestState.loaded:
//                 final restaurants = state.restaurants;
//                 final popularMenuItems = filteredMenu != null
//                     ? filteredMenu!.map((menuItem) {
//                   if (selectedDistance != null) {
//                     final restaurant = restaurants.firstWhere(
//                           (r) => r.name == menuItem.restaurantName,
//                       orElse: () => Restaurant(
//                         name: "",
//                         lat: 0.0,
//                         long: 0.0,
//                         menu: [],
//                       ),
//                     );
//                     if (restaurant.name!.isNotEmpty) {
//                       final distance = calculateDistance(
//                         userLat ?? 0.0,
//                         userLon ?? 0.0,
//                         restaurant.lat ?? 0.0,
//                         restaurant.long ?? 0.0,
//                       );
//
//                       if (distance > selectedDistance!) {
//                         return null; // Exclude this menu item if the distance exceeds the limit
//                       }
//                     } else {
//                       return null; // Exclude menu items with no valid restaurant match
//                     }
//                   }
//                   return MenuWithRestaurant(
//                     menu: menuItem.menu,
//                     restaurantName: menuItem.restaurantName,
//                   );
//                 }).toList()
//                     : restaurants
//                     .expand((restaurant) => (restaurant.menu ?? [])
//                     .where((menuItem) => menuItem.rate! >= 4)
//                     .map((menuItem) => MenuWithRestaurant(
//                   menu: menuItem,
//                   restaurantName: restaurant.name ?? "",
//                 ))
//                     .take(2))
//                     .toList();
//
//                 final itemCount = state.showPMenu
//                     ? popularMenuItems.length
//                     : (popularMenuItems.length > 3 ? 2 : popularMenuItems.length);
//                 if (popularMenuItems.isEmpty) {
//                   return Center(
//                     child: Text(
//                       "No popular menu items available.",
//                       style: context.textTheme.bodyLarge,
//                     ),
//                   );
//                 }
//                 return SizedBox(
//                   height: 174.h,
//                   child: ListView.builder(
//                     itemCount: itemCount,
//                     // popularMenuItems.length,
//                     // physics: NeverScrollableScrollPhysics(),
//                     itemBuilder: (context, index) {
//                       // final popularItem = popularMenuItems[index];
//                       // final menuItem = popularItem.menu;
//                       // final restaurantName = popularItem.restaurantName;
//                       final popularItem = popularMenuItems[index];
//                       final menuItem = popularItem?.menu;
//                       final restaurantName = popularItem?.restaurantName;
//
//                       return MenuItem(
//                         menu: menuItem?.name??"",
//                         restaurant: restaurantName??"", //restaurants[index].name!,
//                         image: menuItem?.image??"",
//                         price: menuItem?.price??0,
//                       );
//                     },
//                   ),
//                 );
//
//               case RequestState.error:
//                 return Center(
//                   child: Text(state.restaurantsMessage),
//                 );
//             }
//           },
//         );
//       },
//
//     );
//   }
// }
class PopularMenuList extends StatelessWidget {
  const PopularMenuList({super.key, this.filteredMenu, this.selectedDistance});

  final List<MenuWithRestaurant>? filteredMenu;
  final num? selectedDistance;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (BuildContext context, AppState appState) {
        double? userLat = appState.latitude;
        double? userLon = appState.longitude;

        return BlocBuilder<RestaurantsBloc, RestaurantsState>(
          builder: (BuildContext context, RestaurantsState state) {
            print("selected distance****::$selectedDistance");
            switch (state.restaurantsState) {
              case RequestState.loading:
                return const Center(
                  child: CircularProgressIndicator(),
                );

              case RequestState.loaded:
                final restaurants = state.restaurants;
                final popularMenuItems = filteredMenu != null
                    ? filteredMenu!
                    .where((menuItem) {
                  if (selectedDistance != null) {
                    final restaurant = restaurants.firstWhere(
                          (r) => r.name == menuItem.restaurantName,
                      orElse: () => Restaurant(
                        name: null,
                        lat: 0.0,
                        long: 0.0,
                        menu: [],
                      ),);
                    if (restaurant.name!=null) {
                      final distance = calculateDistance(
                        userLat ?? 0.0,
                        userLon ?? 0.0,
                        restaurant.lat ?? 0.0,
                        restaurant.long ?? 0.0,
                      );
                      return (menuItem.menu.rate ?? 0) >= 4.0 &&
                          distance <= selectedDistance!;
                    }
                    return false;
                  }
                  else {
                    return (menuItem.menu.rate ?? 0) >= 4.0;
                  }
                })
                    .toList()
                    : restaurants
                    .expand((restaurant) => (restaurant.menu ?? [])
                    .where((menuItem) => (menuItem.rate ?? 0) >= 4.0)
                    .map((menuItem) => MenuWithRestaurant(
                  menu: menuItem,
                  restaurantName: restaurant.name ?? "",
                ),
                ))
                    .toList();

                final itemCount = state.showPMenu
                    ? popularMenuItems.length
                    : (popularMenuItems.length > 3 ? 2 : popularMenuItems.length);

                return popularMenuItems.isEmpty
                    ? const Center(
                  child: Text("No popular menu items available."),
                )
                    : SizedBox(
                  height: 174.h,
                  child: ListView.builder(
                    itemCount: itemCount,
                    itemBuilder: (context, index) {
                      final menuItem = popularMenuItems[index];
                      return MenuItem(
                        menu: menuItem.menu.name ?? "",
                        restaurant: menuItem.restaurantName,
                        image: menuItem.menu.image ?? "",
                        price: menuItem.menu.price ?? 0,
                      );
                    },
                  ),
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
