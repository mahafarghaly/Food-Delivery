import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_app/core/exenstions/context_extenstion.dart';
import '../../../bloc/restaurant_details_bloc/restaurant_details_bloc.dart';
import '../../../bloc/restaurant_details_bloc/restaurant_details_event.dart';
import '../../../bloc/restaurant_details_bloc/restaurant_details_state.dart';
import '../background_box.dart';

class FavoriteButton extends StatelessWidget {
  const FavoriteButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RestaurantDetailsBloc, RestaurantDetailsState>(
        builder: (BuildContext context, RestaurantDetailsState state) {
    return InkWell(
      onTap: () {
        context
            .read<RestaurantDetailsBloc>()
            .add(ToggleFavoriteEvent());
      },
      child: BackgroundBox(
        color: context.colorScheme.outline.withOpacity(0.1),
        radius: 18.5.sp,
        height: 34.sp,
        width: 34.sp,
        child: state.isFavorite == true
            ? Icon(Icons.favorite,
            size: 16.w, color: context.colorScheme.outline)
            : Icon(Icons.favorite_outline,
            size: 16.sp, color: context.colorScheme.outline),
      ),
    );
        },

    );
  }
}
