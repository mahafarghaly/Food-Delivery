import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_app/core/exenstions/context_extenstion.dart';
import 'package:food_app/features/base/data/helpers/request_state.dart';
import 'package:food_app/features/home/data/model/menu_with_restaurant.dart';
import 'package:food_app/features/home/presentation/bloc/restaurant_bloc/restaurant_bloc.dart';
import 'package:food_app/features/home/presentation/bloc/restaurant_bloc/restaurant_state.dart';
import 'package:food_app/features/home/presentation/views/widgets/menu_item.dart';

import '../../../../data/model/menu.dart';

class PopularMenuList extends StatelessWidget {
  const PopularMenuList({super.key, this.filteredMenu, this.selectedDistance});

  final List<MenuWithRestaurant>? filteredMenu;
  final num? selectedDistance;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RestaurantsBloc, RestaurantsState>(
      builder: (BuildContext context, RestaurantsState state) {
        switch (state.restaurantsState) {
          case RequestState.loading:
            return SizedBox(
              height: 87.h,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );

          case RequestState.loaded:
            final restaurants = state.restaurants;
            final popularMenuItems = filteredMenu != null
                ? filteredMenu!.map((menuItem) {
                  if(selectedDistance!=null){

                  }
                    return MenuWithRestaurant(
                      menu: menuItem.menu,
                      restaurantName: menuItem.restaurantName,
                    );
                  }).toList()
                : restaurants
                    .expand((restaurant) => (restaurant.menu ?? [])
                        .where((menuItem) => menuItem.rate! >= 4)
                        .map((menuItem) => MenuWithRestaurant(
                              menu: menuItem,
                              restaurantName: restaurant.name ?? "",
                            ))
                        .take(2))
                    .toList();

            final itemCount = state.showPMenu
                ? popularMenuItems.length
                : (popularMenuItems.length > 3 ? 2 : popularMenuItems.length);
            if (popularMenuItems.isEmpty) {
              return Center(
                child: Text(
                  "No popular menu items available.",
                  style: context.textTheme.bodyLarge,
                ),
              );
            }
            return SizedBox(
              height: 174.h,
              child: ListView.builder(
                itemCount: itemCount,
                // popularMenuItems.length,
                // physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final popularItem = popularMenuItems[index];
                  final menuItem = popularItem.menu;
                  final restaurantName = popularItem.restaurantName;
                  return MenuItem(
                    menu: menuItem.name!,
                    restaurant: restaurantName, //restaurants[index].name!,
                    image: menuItem.image!,
                    price: menuItem.price!,
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
  }
}
