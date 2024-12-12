import 'package:equatable/equatable.dart';

sealed class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object?> get props => [];
}

class SearchRestaurantEvent extends SearchEvent {
  final String query;

  const SearchRestaurantEvent(this.query);
}

class SelectChipEvent extends SearchEvent {
  final String chipLabel;

  const SelectChipEvent(this.chipLabel);
}

class SelectDistanceEvent extends SearchEvent {
  final num? distance;

  const SelectDistanceEvent(this.distance);
}
class FilterFoodItemEvent extends SearchEvent {
  final String foodItemName;

  const FilterFoodItemEvent(this.foodItemName);
}
