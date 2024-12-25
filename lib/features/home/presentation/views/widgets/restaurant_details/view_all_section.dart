import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_app/core/exenstions/context_extenstion.dart';
import 'package:food_app/features/home/presentation/bloc/restaurant_details_bloc/restaurant_details_bloc.dart';
import 'package:food_app/features/home/presentation/bloc/restaurant_details_bloc/restaurant_details_state.dart';

import '../../../../../../core/utils/app_strings.dart';
import '../../../bloc/restaurant_details_bloc/restaurant_details_event.dart';

class ViewAllSection extends StatelessWidget {
  const ViewAllSection({super.key});
  @override
  Widget build(BuildContext context) {
      return BlocBuilder<RestaurantDetailsBloc,RestaurantDetailsState>(

        builder: (BuildContext context, RestaurantDetailsState state) {
          return  Row(
            children: [
              Text(
                "Popular Menu",
                style: context.textTheme.labelLarge?.copyWith(fontSize: 15.sp),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {
                  context.read<RestaurantDetailsBloc>().add(ToggleViewPMenuAll());
                },
                child: Text(state.showPMenu ? AppStrings.viewLess :AppStrings.viewAll,
                    style: context.textTheme.bodySmall
                        ?.copyWith(color: context.colorScheme.scrim)),
              )
            ],
          );
        },

      );
  }
}
