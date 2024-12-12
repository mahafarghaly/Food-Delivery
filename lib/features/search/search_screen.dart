import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_app/app.dart';
import 'package:food_app/core/exenstions/context_extenstion.dart';
import 'package:food_app/core/exenstions/widget_extensions.dart';
import 'package:food_app/core/utils/app_navigation.dart';
import 'package:food_app/features/home/presentation/bloc/restaurant_bloc/restaurant_bloc.dart';
import 'package:food_app/features/home/presentation/bloc/restaurant_bloc/restaurant_state.dart';
import 'package:food_app/features/home/presentation/bloc/search_bloc/search_bloc.dart';
import 'package:food_app/features/home/presentation/bloc/search_bloc/search_state.dart';
import 'package:food_app/features/home/presentation/views/screens/home_screen.dart';
import 'package:food_app/features/home/presentation/views/widgets/custom_chip.dart';
import 'package:food_app/features/home/presentation/views/widgets/home_appbar_section.dart';
import 'package:food_app/features/home/presentation/views/widgets/lists/nearest_restaurant.dart';
import 'package:food_app/features/home/presentation/views/widgets/lists/popular_menu_list.dart';
import 'package:food_app/features/home/presentation/views/widgets/lists/popular_restaurant_list.dart';
import 'package:food_app/features/search/search_result_screen.dart';

import '../../core/service/service_locator.dart';
import '../../core/utils/app_assets.dart';
import '../home/presentation/bloc/search_bloc/search_event.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

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
          BlocBuilder<SearchBloc, SearchState>(
            builder: (BuildContext context, SearchState searchState) {
              return Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const HomeAppbarSection(
                            enableSearch: true,
                          ).paddingTop(60.h),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Type",
                                style: context.textTheme.bodyLarge,
                              ).paddingVertical(20.h),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomChip(
                                    label: "Restaurant",
                                    isSelected: searchState.selectedChipType ==
                                        "Restaurant",
                                    onTap: () {
                                      context.read<SearchBloc>().add(
                                          const SelectChipEvent("Restaurant"));
                                    },
                                    onDelete: () {
                                      context
                                          .read<SearchBloc>()
                                          .add(const SelectChipEvent(""));
                                    },
                                  ),
                                  SizedBox(width: 10.h),
                                  CustomChip(
                                    label: "Menu",
                                    isSelected:
                                        searchState.selectedChipType == "Menu",
                                    onTap: () {
                                      context
                                          .read<SearchBloc>()
                                          .add(const SelectChipEvent("Menu"));
                                    },
                                    onDelete: () {
                                      context
                                          .read<SearchBloc>()
                                          .add(const SelectChipEvent(""));
                                    },
                                  ),
                                ],
                              ),
                              Text(
                                "Location",
                                style: context.textTheme.bodyLarge,
                              ).paddingVertical(20.h),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomChip(
                                    label: "1 KM",
                                    isSelected:
                                        searchState.selectedDistance == 1.0,
                                    onTap: () {
                                      context
                                          .read<SearchBloc>()
                                          .add(const SelectDistanceEvent(1.0));
                                    },
                                    onDelete: () {
                                      context
                                          .read<SearchBloc>()
                                          .add(const SelectDistanceEvent(0));
                                    },
                                  ).paddingRight(10.w),
                                  CustomChip(
                                    label: ">10 KM",
                                    isSelected:
                                        searchState.selectedDistance == 50.0,
                                    onTap: () {
                                      context
                                          .read<SearchBloc>()
                                          .add(const SelectDistanceEvent(50.0));
                                    },
                                    onDelete: () {
                                      context
                                          .read<SearchBloc>()
                                          .add(const SelectDistanceEvent(0));
                                    },
                                  ).paddingRight(10.w),
                                  CustomChip(
                                    label: "<10 KM",
                                    isSelected:
                                        searchState.selectedDistance == 5.0,
                                    onTap: () {
                                      context
                                          .read<SearchBloc>()
                                          .add(const SelectDistanceEvent(5.0));
                                    },
                                    onDelete: () {
                                      context
                                          .read<SearchBloc>()
                                          .add(const SelectDistanceEvent(0));
                                    },
                                  )
                                ],
                              ),
                              SizedBox(height: 20.h), // Space before food chips
                              Text(
                                "Food",
                                style: context.textTheme.bodyLarge,
                              ).paddingVertical(10.h),
                              BlocBuilder<RestaurantsBloc, RestaurantsState>(
                                builder: (BuildContext context,
                                    RestaurantsState state) {
                                  return Wrap(
                                    //  spacing: 8.w,
                                    runSpacing: 8.h,
                                    children:
                                        state.restaurants.map((restaurant) {
                                      var foodItems =
                                          restaurant.menu?.take(2).toList() ??
                                              [];
                                      return Row(
                                        children: foodItems.map((menuItem) {
                                          return Expanded(
                                              child: CustomChip(
                                            label: menuItem.name ?? "",
                                            onTap: () {
                                              context.read<SearchBloc>().add(
                                                  FilterFoodItemEvent(
                                                      menuItem.name ?? ""));
                                            },
                                            onDelete: () {},
                                            isSelected: context
                                                .read<SearchBloc>()
                                                .state
                                                .selectedFoodItems
                                                .contains(menuItem.name),
                                          ));
                                        }).toList(),
                                      );
                                    }).toList(),
                                  );
                                },
                              ),
                            ],
                          ).paddingHorizontal(25.w),
                        ],
                      ),
                    ),
                  ),
                  // Container(
                  //     clipBehavior: Clip.antiAliasWithSaveLayer,
                  //     width: double.infinity,
                  //     height: 57.h,
                  //     decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(15.r),
                  //       gradient: LinearGradient(
                  //           colors: [
                  //             context.colorScheme.secondary,
                  //             context.colorScheme.primary,
                  //           ],
                  //           begin: Alignment.topLeft,
                  //           end: Alignment.bottomRight),
                  //     ),
                  //     child: MaterialButton(
                  //       onPressed: () {
                  //         //  Navigator.pop(context);
                  //         if (searchState.selectedFoodItems.isNotEmpty||(searchState.selectedFoodItems.isNotEmpty &&
                  //             searchState.selectedDistance != null)) {
                  //           print("searchState.selectedDistance: ${searchState.selectedDistance}");
                  //           AppNavigation.navigationTo(
                  //               context,
                  //               SearchResultScreen(
                  //                 content: PopularMenuList(
                  //                   filteredMenu: searchState.filteredMenu
                  //                       .where((menuItem) => searchState
                  //                           .selectedFoodItems
                  //                           .contains(menuItem.menu.name))
                  //                       .toList(),
                  //                   selectedDistance: searchState.selectedDistance,
                  //                 ),
                  //                 text:
                  //                     "Popular Menu",
                  //               ));
                  //         }
                  //         else if (searchState
                  //             .filteredRestaurants.isNotEmpty||(searchState
                  //                 .filteredRestaurants.isNotEmpty &&
                  //             searchState.selectedDistance != null)) {
                  //           AppNavigation.navigationTo(
                  //               context,
                  //               SearchResultScreen(
                  //                 content: PopularRestaurantList(
                  //                   filteredRestaurant:
                  //                       searchState.filteredRestaurants,
                  //                   selectedDistance: searchState.selectedDistance,
                  //                 ),
                  //                 text:searchState.selectedDistance!=null?"Nearest Restaurant":" Popular Restaurant",
                  //               ));
                  //         } else if (searchState.filteredMenu.isNotEmpty||(searchState.filteredMenu.isNotEmpty&&
                  //             searchState.selectedDistance != null)) {
                  //           print("searchState.selectedDistance res: ${searchState.selectedDistance}");
                  //
                  //           AppNavigation.navigationTo(
                  //               context,
                  //               SearchResultScreen(
                  //                 content: PopularMenuList(
                  //                   filteredMenu: searchState.filteredMenu,
                  //                   selectedDistance: searchState.selectedDistance,
                  //                 ),
                  //                   text:searchState.selectedDistance != null?"Nearest Menu":"Popular Menu" ,
                  //               ));
                  //         } else {
                  //           AppNavigation.navigationTo(
                  //             context,
                  //             SearchResultScreen(
                  //               content: Center(
                  //                 child: Text(
                  //                   "Not Found",
                  //                   style: context.textTheme.bodyLarge,
                  //                 ),
                  //               ),
                  //             ),
                  //           );
                  //         }
                  //       },
                  //       child: Text(
                  //         "Search",
                  //         style: context.textTheme.bodyLarge?.copyWith(
                  //             fontSize: 14.sp,
                  //             color: context.colorScheme.surface),
                  //       ),
                  //     )).paddingAll(25),
                  Container(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      width: double.infinity,
                      height: 57.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.r),
                        gradient: LinearGradient(
                            colors: [
                              context.colorScheme.secondary,
                              context.colorScheme.primary,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight),
                      ),
                      child: MaterialButton(
                        onPressed: () {
                          //  Navigator.pop(context);
                          if (searchState.selectedFoodItems.isNotEmpty) {
                            AppNavigation.navigationTo(
                                context,
                                SearchResultScreen(
                                  content: PopularMenuList(
                                    filteredMenu: searchState.filteredMenu
                                        .where((menuItem) => searchState
                                            .selectedFoodItems
                                            .contains(menuItem.menu.name))
                                        .toList(),
                                    selectedDistance:
                                        searchState.selectedDistance,
                                  ),
                                  text: "Popular Menu",
                                ));
                          } else if (searchState
                              .filteredRestaurants.isNotEmpty) {
                            AppNavigation.navigationTo(
                                context,
                                SearchResultScreen(
                                  content: PopularRestaurantList(
                                    filteredRestaurant:
                                        searchState.filteredRestaurants,
                                    //selectedDistance: searchState.selectedDistance,
                                  ),
                                  text: " Popular Restaurant",
                                ));
                          } else if (searchState.filteredMenu.isNotEmpty) {
                            AppNavigation.navigationTo(
                                context,
                                SearchResultScreen(
                                  content: PopularMenuList(
                                    filteredMenu: searchState.filteredMenu,
                                    selectedDistance:
                                        searchState.selectedDistance,
                                  ),
                                  text: " Popular Menu",
                                ));
                          } else {
                            AppNavigation.navigationTo(
                              context,
                              SearchResultScreen(
                                content: Center(
                                  child: Text(
                                    "Not Found",
                                    style: context.textTheme.bodyLarge,
                                  ),
                                ),
                              ),
                            );
                          }
                        },
                        child: Text(
                          "Search",
                          style: context.textTheme.bodyLarge?.copyWith(
                              fontSize: 14.sp,
                              color: context.colorScheme.surface),
                        ),
                      )).paddingAll(25),
                ],
              );
            },
          )
        ],
      ),
    );
  }
}
