import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_app/core/exenstions/context_extenstion.dart';
import 'package:food_app/core/exenstions/widget_extensions.dart';
import 'package:food_app/features/home/presentation/bloc/restaurant_bloc/restaurant_bloc.dart';
import 'package:food_app/features/home/presentation/bloc/restaurant_bloc/restaurant_state.dart';
import 'package:food_app/features/home/presentation/bloc/search_bloc/search_state.dart';
import 'package:food_app/features/home/presentation/views/widgets/lists/popular_restaurant_list.dart';

import '../../core/utils/app_assets.dart';
import '../home/presentation/bloc/search_bloc/search_bloc.dart';
import '../home/presentation/bloc/search_bloc/search_event.dart';
import '../home/presentation/views/widgets/custom_chip.dart';
import '../home/presentation/views/widgets/home_appbar_section.dart';

class SearchResultScreen extends StatelessWidget {
  const SearchResultScreen(
      {super.key,
      this.content,
      this.text,
      this.selectedDistance,
      this.selectedFoodItems});

  final Widget? content;
  final String? text;
  final num? selectedDistance;
  final List<String>? selectedFoodItems;

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
                        SizedBox(
                          height: 20.h,
                        ),
                        Wrap(
                          spacing: 8.0,
                          runSpacing: 8.0,
                          children: [
                            searchState.selectedDistance != null &&
                                    searchState.selectedDistance != 0
                                ? CustomChip(
                                    label: "${selectedDistance!.toString()} KM",
                                    isSelected: searchState.selectedDistance ==
                                        selectedDistance,
                                    onTap: () {},
                                    onDelete: () {
                                      context
                                          .read<SearchBloc>()
                                          .add(const SelectDistanceEvent(0));
                                    },
                                  )
                                : const SizedBox(),
                            if (selectedFoodItems != null)
                              ...selectedFoodItems!.map((food) {
                                return searchState.selectedFoodItems
                                        .contains(food)
                                    ? CustomChip(
                                        label: food,
                                        isSelected: context
                                            .read<SearchBloc>()
                                            .state
                                            .selectedFoodItems
                                            .contains(food),
                                        onTap: () {
                                          context
                                              .read<SearchBloc>()
                                              .add(FilterFoodItemEvent(food));
                                        },
                                        onDelete: () {},
                                      )
                                    : const SizedBox();
                              }),
                          ],
                        ),
                        Text(
                          text ?? "",
                          style: context.textTheme.labelLarge
                              ?.copyWith(fontSize: 15.sp),
                        ).paddingHorizontal(30.w),
                        Expanded(child: content ?? const Text("Not Exist"))
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
