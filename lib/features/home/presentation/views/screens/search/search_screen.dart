import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_app/core/exenstions/context_extenstion.dart';
import 'package:food_app/core/exenstions/widget_extensions.dart';
import 'package:food_app/core/utils/app_navigation.dart';
import 'package:food_app/core/utils/app_strings.dart';
import 'package:food_app/features/home/presentation/bloc/restaurant_bloc/restaurant_bloc.dart';
import 'package:food_app/features/home/presentation/bloc/restaurant_bloc/restaurant_state.dart';
import 'package:food_app/features/home/presentation/bloc/search_bloc/search_bloc.dart';
import 'package:food_app/features/home/presentation/bloc/search_bloc/search_state.dart';
import 'package:food_app/features/home/presentation/views/widgets/custom_chip.dart';
import 'package:food_app/features/home/presentation/views/widgets/home_appbar_section.dart';
import 'package:food_app/features/home/presentation/views/screens/search/search_result_screen.dart';
import '../../../../../../core/utils/app_assets.dart';
import '../../../bloc/search_bloc/search_event.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();
    return Scaffold(
      body: Stack(
        alignment: Alignment.topRight,
        children: [
          Positioned(
            top: 0,
            right: 0,
            child: Image.asset(AppAssets.homeBackgroundImage),
          ),
          BlocBuilder<SearchBloc, SearchState>(
            builder: (BuildContext context, SearchState searchState) {
              return Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          HomeAppbarSection(
                            enableSearch: true,
                            controller: searchController,
                          ).paddingTop(60.h),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppStrings.type,
                                style: context.textTheme.bodyLarge,
                              ).paddingVertical(20.h),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomChip(
                                    label: AppStrings.restaurant,
                                    isSelected: searchState.selectedChipType ==
                                        AppStrings.restaurant,
                                    onTap: () {
                                      context.read<SearchBloc>().add(
                                           SelectTypeEvent(AppStrings.restaurant));
                                    },
                                    onDelete: () {
                                      context
                                          .read<SearchBloc>()
                                          .add(const SelectTypeEvent(""));
                                    },
                                  ),
                                  SizedBox(width: 10.h),
                                  CustomChip(
                                    label: AppStrings.menu,
                                    isSelected:
                                        searchState.selectedChipType == AppStrings.menu,
                                    onTap: () {
                                      context
                                          .read<SearchBloc>()
                                          .add( SelectTypeEvent( AppStrings.menu));
                                    },
                                    onDelete: () {
                                      context
                                          .read<SearchBloc>()
                                          .add(const SelectTypeEvent(""));
                                    },
                                  ),
                                ],
                              ),
                              Text(
                                AppStrings.location,
                                style: context.textTheme.bodyLarge,
                              ).paddingVertical(20.h),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomChip(
                                    label: AppStrings.oneKm,
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
                                    label: AppStrings.gTenKm,
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
                                    label: AppStrings.lTenKm,
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
                              SizedBox(height: 20.h),
                              Text(
                                AppStrings.food,
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
                                            onDelete: () {
                                              context.read<SearchBloc>().add(
                                                  FilterFoodItemEvent(
                                                      menuItem.name ?? ""));
                                            },
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
                        onPressed: () async {
                          final query = searchController.text.trim();

                          if (query.isNotEmpty) {
                            context
                                .read<SearchBloc>()
                                .add(SearchRestaurantEvent(query));

                            await Future.delayed(
                              const Duration(milliseconds: 300),
                            );
                            final updatedState =
                                context.read<SearchBloc>().state;

                            searchWithQuery(updatedState, context);
                          }
                          else if (searchState.selectedFoodItems.isNotEmpty) {
                            AppNavigation.navigationTo(
                              context,
                               SearchResultScreen(text:AppStrings.popularMenu),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor:
                                    context.colorScheme.onPrimaryContainer,
                                content:  Text(
                                    AppStrings.theOrderCannotBeEmpty),
                                duration: const Duration(seconds: 2),
                              ),
                            );
                          }
                        },
                        child: Text(
                          AppStrings.search,
                          style: context.textTheme.bodyLarge
                              ?.copyWith(fontSize: 14.sp, color: Colors.white),
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

  void searchWithQuery(SearchState updatedState, BuildContext context) {
    if (updatedState.filteredRestaurants.isNotEmpty) {
      AppNavigation.navigationTo(
        context,
         SearchResultScreen(
            text: AppStrings.popularRestaurants),
      );
    } else if (updatedState.filteredMenu.isNotEmpty) {
      AppNavigation.navigationTo(
        context,
         SearchResultScreen(text:AppStrings.popularMenu),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor:
              context.colorScheme.onPrimaryContainer,
          content:  Text(
             AppStrings.noResultsFoundPleaseTryDifferentSearch ),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }
}
