import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_app/core/exenstions/context_extenstion.dart';
import 'package:food_app/core/exenstions/widget_extensions.dart';

import '../../../../../../core/utils/calculate_distance.dart';
import '../../../../../base/presentation/bloc/app_bloc.dart';
import '../../../../../base/presentation/bloc/app_state.dart';

class DistanceSection extends StatelessWidget {
  const DistanceSection({super.key, required this.restaurantLate, required this.restaurantLong});
final double restaurantLate;
  final double restaurantLong;
  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<AppBloc, AppState>(
      builder: (BuildContext context, AppState appState) {
        final distance = calculateDistance(
          appState.latitude ?? 0.0,
          appState.longitude ?? 0.0,
          restaurantLate,
          restaurantLate ,
        );
        return Row(
          children: [
            Icon(
              Icons.location_on_outlined,
              color: context.colorScheme.primary,
            ).paddingRight(10.w),
            Text(
              "${distance.toInt()} KM",
              style: context.textTheme.bodyMedium?.copyWith(
                  color: context.colorScheme.outlineVariant
                      .withOpacity(0.3)),
            )
          ],
        );
      },
    );
  }
}
