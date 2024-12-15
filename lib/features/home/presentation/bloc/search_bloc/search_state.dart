import 'package:equatable/equatable.dart';
import '../../../data/model/menu_with_restaurant.dart';
import '../../../data/model/restaurant.dart';

class SearchState extends Equatable {
  final List<Restaurant> filteredRestaurants;
  final List<MenuWithRestaurant> filteredMenu;
  final String selectedChipType;
  final num? selectedDistance;
  final List<String> selectedFoodItems;

  const SearchState({
    this.filteredMenu = const [],
    this.filteredRestaurants = const [],
    this.selectedChipType = "",
    this.selectedDistance,
    this.selectedFoodItems = const [],
  });

  SearchState copyWith({
    List<Restaurant>? filteredRestaurants,
    List<MenuWithRestaurant>? filteredMenu,
    String? selectedChipType,
    num? selectedDistance,
    List<String>? selectedFoodItems,
  }) {
    return SearchState(
      filteredRestaurants: filteredRestaurants ?? this.filteredRestaurants,
      filteredMenu: filteredMenu ?? this.filteredMenu,
      selectedChipType: selectedChipType ?? this.selectedChipType,
      selectedDistance: selectedDistance ?? this.selectedDistance,
      selectedFoodItems: selectedFoodItems ?? this.selectedFoodItems,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        filteredRestaurants,
        filteredMenu,
        selectedDistance,
        selectedChipType,
        selectedFoodItems,
      ];
}
