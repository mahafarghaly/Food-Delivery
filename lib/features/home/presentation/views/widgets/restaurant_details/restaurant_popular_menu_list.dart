import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_app/core/exenstions/context_extenstion.dart';
import 'package:food_app/core/utils/app_assets.dart';
import 'package:food_app/features/home/presentation/bloc/restaurant_details_bloc/restaurant_details_bloc.dart';
import 'package:food_app/features/home/presentation/bloc/restaurant_details_bloc/restaurant_details_state.dart';
import 'package:food_app/features/home/presentation/views/widgets/restaurant_details/restaurant_menu_item.dart';
import 'package:lottie/lottie.dart';

import '../../../../../../core/utils/app_strings.dart';
import '../../../../data/model/restaurant.dart';

class RestaurantPopularMenuList extends StatelessWidget {
  const RestaurantPopularMenuList({super.key, required this.restaurant});

  final Restaurant restaurant;

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      height: 171.h,
      child: restaurant.menu == null || restaurant.menu!.isEmpty? Center(
          child: Lottie.asset(AppAssets.notFoundAnimation)
      ): BlocBuilder<RestaurantDetailsBloc, RestaurantDetailsState>(
              builder: (BuildContext context, RestaurantDetailsState state) {
                return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: state.showPMenu
                        ? restaurant.menu?.length ?? 0
                        : (restaurant.menu?.length ?? 0) > 3
                            ? 3
                            : (restaurant.menu?.length ?? 0),
                    itemBuilder: (context, index) => RestaurantMenuItem(
                          name: restaurant.menu?[index].name,
                          image: restaurant.menu?[index].image,
                          price: restaurant.menu?[index].price,
                        ));
              },
            ),
    );
  }
}
