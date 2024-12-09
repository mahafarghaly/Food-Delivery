import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_app/core/exenstions/context_extenstion.dart';
import 'package:food_app/features/home/presentation/bloc/search_bloc/search_bloc.dart';
import 'package:food_app/features/home/presentation/bloc/search_bloc/search_event.dart';
import 'package:food_app/features/home/presentation/views/widgets/background_box.dart';

import '../../bloc/restaurant_bloc/restaurant_bloc.dart';
import '../../bloc/restaurant_bloc/restaurant_event.dart';
class SearchTextField extends StatelessWidget {
  const SearchTextField({super.key, required this.enable, this.hintText});
final bool enable;
final String? hintText;

  @override
  Widget build(BuildContext context) {
    return BackgroundBox(
      color: context.colorScheme.primaryContainer.withOpacity(0.1),
      child: TextField(
        enabled: enable,
        style: Theme.of(context).textTheme.bodyMedium,
        decoration:  InputDecoration(
          prefixIcon: Icon(Icons.search,color: Theme.of(context).colorScheme.onPrimaryContainer,),
              hintText: hintText??"What do you want to order?"
        ),
          onChanged: (query) {
            context.read<SearchBloc>().add(SearchRestaurantEvent(query));
          },

      ),
    );
  }
}
