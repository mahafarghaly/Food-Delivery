import 'package:equatable/equatable.dart';

import '../../../../base/data/helpers/request_state.dart';
import '../../../data/model/menu_with_restaurant.dart';
import '../../../data/model/restaurant.dart';

class SearchState extends Equatable {
  final List<Restaurant> filteredRestaurants;
  final List<MenuWithRestaurant> filteredMenu;
  final String selectedChipType;
  final double? selectedDistance;

  const SearchState({
    this.filteredMenu = const [],
    this.filteredRestaurants = const [],
        this.selectedChipType = "",
        this.selectedDistance,
  });

  SearchState copyWith({
    List<Restaurant>? filteredRestaurants,
    List<MenuWithRestaurant>? filteredMenu,
    String? selectedChipType,
    double? selectedDistance,
  }) {
    return SearchState(
      filteredRestaurants: filteredRestaurants ?? this.filteredRestaurants,
      filteredMenu: filteredMenu ?? this.filteredMenu,
        selectedChipType: selectedChipType ?? this.selectedChipType,
        selectedDistance:selectedDistance??this.selectedDistance
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [filteredRestaurants, filteredMenu,selectedDistance,selectedChipType];
}
