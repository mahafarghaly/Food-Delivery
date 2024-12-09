import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_app/app.dart';
import 'package:food_app/core/exenstions/context_extenstion.dart';
import 'package:food_app/core/exenstions/widget_extensions.dart';
import 'package:food_app/core/utils/app_navigation.dart';
import 'package:food_app/features/home/presentation/bloc/search_bloc/search_bloc.dart';
import 'package:food_app/features/home/presentation/bloc/search_bloc/search_state.dart';
import 'package:food_app/features/home/presentation/views/screens/home_screen.dart';
import 'package:food_app/features/home/presentation/views/widgets/custom_chip.dart';
import 'package:food_app/features/home/presentation/views/widgets/home_appbar_section.dart';
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
            builder: (BuildContext context, SearchState state) {
              return Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          HomeAppbarSection(
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
                                    isSelected:
                                        state.selectedChipType == "Restaurant",
                                    onTap: () {
                                      context.read<SearchBloc>().add(
                                           const SelectChipEvent("Restaurant"));
                                    },
                                  ),
                                  SizedBox(width: 10.h),
                                  CustomChip(
                                    label: "Menu",
                                    isSelected:
                                        state.selectedChipType == "Menu",
                                    onTap: () {
                                      context
                                          .read<SearchBloc>()
                                          .add(const SelectChipEvent("Menu"));
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
                                    isSelected:  state.selectedDistance == 1.0,
                                    onTap: () {
                                      context
                                          .read<SearchBloc>().add(SelectDistanceEvent(1.0));
                                    },
                                  ).paddingRight(10.w),
                                  CustomChip(
                                    label: ">10 KM",
                                      isSelected:  state.selectedDistance == 10.0,
                                      onTap: () {
                                        context
                                            .read<SearchBloc>().add(SelectDistanceEvent(10.0));
                                      },
                                  ).paddingRight(10.w),
                                  CustomChip(
                                    label: "<10 KM",
                                    isSelected:  state.selectedDistance == 50.0,
                                    onTap: () {
                                      context
                                          .read<SearchBloc>().add(SelectDistanceEvent(50.0));
                                    },
                                  )
                                ],
                              ),
                            ],
                          ).paddingHorizontal(25.w),

                          // const Spacer(),
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
                              end: Alignment.bottomRight)),
                      child: MaterialButton(
                        onPressed: () {
                          //  Navigator.pop(context);
                          if (state.filteredRestaurants.isNotEmpty) {
                            AppNavigation.navigationTo(
                                context,
                                SearchResultScreen(
                                  content: PopularRestaurantList(
                                    filteredRestaurant:
                                        state.filteredRestaurants,
                                  ),
                                  text: " Popular Restaurant",
                                ));
                          } else if (state.filteredMenu.isNotEmpty) {
                            AppNavigation.navigationTo(
                                context,
                                SearchResultScreen(
                                  content: PopularMenuList(
                                    filteredMenu: state.filteredMenu,
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
