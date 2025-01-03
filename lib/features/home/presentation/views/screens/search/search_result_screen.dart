import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_app/core/exenstions/context_extenstion.dart';
import 'package:food_app/core/exenstions/widget_extensions.dart';
import 'package:food_app/core/utils/app_strings.dart';
import 'package:food_app/features/home/presentation/bloc/restaurant_bloc/restaurant_bloc.dart';
import 'package:food_app/features/home/presentation/bloc/restaurant_bloc/restaurant_state.dart';
import 'package:food_app/features/home/presentation/bloc/search_bloc/search_state.dart';
import 'package:food_app/features/home/presentation/views/widgets/lists/popular_restaurant_list.dart';
import '../../../../../../core/utils/app_assets.dart';
import '../../../bloc/search_bloc/search_bloc.dart';
import '../../../bloc/search_bloc/search_event.dart';
import '../../widgets/custom_chip.dart';
import '../../widgets/home_appbar_section.dart';
import '../../widgets/lists/popular_menu_list.dart';

class SearchResultScreen extends StatelessWidget {
  const SearchResultScreen({super.key, this.text,});
  final String? text;
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
          BlocBuilder<RestaurantsBloc, RestaurantsState>(
            builder: (BuildContext context, RestaurantsState state) {
              state.showPRestaurants = true;
              state.showPMenu = true;
              return BlocBuilder<SearchBloc, SearchState>(
                builder: (BuildContext context, SearchState searchState) {
                  return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const HomeAppbarSection().paddingTop(60.h),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 25.w, vertical: 20.h),
                          child: Wrap(
                            spacing: 8.0,
                            runSpacing: 8.0,
                            children: [
                              searchState.selectedDistance != null &&
                                      searchState.selectedDistance != 0 &&
                                      (searchState
                                              .filteredRestaurants.isNotEmpty ||
                                          searchState.filteredMenu.isNotEmpty)
                                  ? CustomChip(
                                      label:searchState.selectedDistance! < 10?AppStrings.lTenKm:searchState.selectedDistance! > 10?AppStrings.gTenKm:
                                          AppStrings.oneKm,
                                      isSelected:
                                          searchState.selectedDistance != 0 ||
                                              searchState.selectedDistance !=
                                                  null,
                                      onTap: () {},
                                      onDelete: () {
                                        context
                                            .read<SearchBloc>()
                                            .add(const SelectDistanceEvent(0));
                                      },
                                    )
                                  : const SizedBox(),
                              if (searchState.selectedFoodItems.isNotEmpty &&
                                  (searchState.filteredRestaurants.isNotEmpty ||
                                      searchState.filteredMenu.isNotEmpty))
                                ...searchState.selectedFoodItems.map((food) {
                                  return searchState.selectedFoodItems
                                          .contains(food)
                                      ? CustomChip(
                                          label: food,
                                          isSelected: context
                                              .read<SearchBloc>()
                                              .state
                                              .selectedFoodItems
                                              .contains(food),
                                          onTap: () {},
                                          onDelete: () {
                                            context
                                                .read<SearchBloc>()
                                                .add(FilterFoodItemEvent(food));
                                          },
                                        )
                                      : const SizedBox();
                                }),
                            ],
                          ),
                        ),
                        Text(
                          text ?? "",
                          style: context.textTheme.labelLarge
                              ?.copyWith(fontSize: 15.sp),
                        ).paddingHorizontal(30.w),
                        Expanded(
                          child: searchState.filteredRestaurants.isNotEmpty
                              ? SingleChildScrollView(
                                child: PopularRestaurantList(
                                    filteredRestaurant:
                                        searchState.filteredRestaurants,
                                    selectedDistance:
                                        searchState.selectedDistance == 0
                                            ? null
                                            : searchState.selectedDistance,
                                  ),
                              )
                              : searchState.filteredMenu.isNotEmpty
                                  ? SingleChildScrollView(
                                    child: PopularMenuList(
                                        filteredMenu: searchState.filteredMenu,
                                        selectedDistance:
                                            searchState.selectedDistance == 0
                                                ? null
                                                : searchState.selectedDistance,
                                      ),
                                  )
                                  :  Center(
                                      child: Text(AppStrings.noResultsFound,style:context.textTheme.bodyLarge?.copyWith(
                                        color: context.colorScheme.outlineVariant,
                                      ),),
                                    ),
                        ),
                      ]);
                },
              );
            },
          )
        ],
      ),
    );
  }
}
