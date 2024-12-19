import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_app/core/exenstions/context_extenstion.dart';

import '../../../../../core/utils/app_strings.dart';
import '../../bloc/restaurant_bloc/restaurant_bloc.dart';
import '../../bloc/restaurant_bloc/restaurant_event.dart';
import '../../bloc/restaurant_bloc/restaurant_state.dart';

class ListViewMoreSection extends StatelessWidget {
  const ListViewMoreSection(
      {super.key, required this.name, required this.showMore, required this.restaurantsEvent});

  final String name;
  final bool showMore;
  final RestaurantsEvent restaurantsEvent;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          name,
          style: context.textTheme.labelLarge?.copyWith(fontSize: 15.sp),
        ),
        const Spacer(),
        TextButton(
          onPressed: () {
            context.read<RestaurantsBloc>().add(restaurantsEvent);
          },
          child: Text(showMore ? AppStrings.viewLess :AppStrings.viewMore,
              style: context.textTheme.bodySmall
                  ?.copyWith(color: context.colorScheme.scrim)),
        )
      ],
    );
  }
}
