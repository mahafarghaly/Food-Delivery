import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_app/core/exenstions/context_extenstion.dart';
import 'package:food_app/core/utils/app_assets.dart';
import 'package:food_app/features/home/data/model/restaurant.dart';
import 'package:food_app/features/home/presentation/views/widgets/restaurant_details/build_bottom_sheet_content.dart';
class RestaurantDetailsScreen extends StatelessWidget {
  const RestaurantDetailsScreen({super.key, this.restaurant});
  final Restaurant? restaurant;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CachedNetworkImage(
              imageUrl: restaurant?.imageUrl ?? "",
              fit: BoxFit.cover,
              width: double.infinity,
              placeholder: (context, url) => Image.asset(
                    AppAssets.restaurantPlaceholder,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              height: MediaQuery.of(context).size.height * 0.4),
          DraggableScrollableSheet(
            initialChildSize: 0.65,
            minChildSize: 0.65,
            maxChildSize: 0.9,
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: context.colorScheme.onPrimary,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(40.r)),
                ),
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: BuildBottomSheetContent(restaurant: restaurant!),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
