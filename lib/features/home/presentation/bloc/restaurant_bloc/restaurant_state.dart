import 'package:equatable/equatable.dart';

import '../../../../base/data/helpers/request_state.dart';
import '../../../data/model/menu.dart';
import '../../../data/model/restaurant.dart';

class RestaurantsState extends Equatable {
  final List<Restaurant> restaurants;
  final List<Restaurant> filteredRestaurants;
  final List<Menu> filteredMenu;
  final RequestState restaurantsState;
  final String restaurantsMessage;
  final bool showNearestR;
  final bool showPRestaurants;
  final bool showPMenu;
  final String selectedChip;

  const RestaurantsState(
      {this.restaurants = const [],
        this.filteredMenu = const [],
        this.selectedChip = "Restaurant",
        this.filteredRestaurants= const[],
        this.restaurantsState = RequestState.loading,
      this.restaurantsMessage = "",
      this.showNearestR = false,
      this.showPRestaurants = false,
      this.showPMenu = false});

  RestaurantsState copyWith({
    List<Restaurant>? restaurants,
    String? selectedChip,
    List<Restaurant>? filteredRestaurants,
    List<Menu>? filteredMenu,
    RequestState? restaurantsState,
    String? restaurantsMessage,
    bool? showAllNearest,
    bool? showPRestaurants,
    bool? showPMenu,

  }) {
    return RestaurantsState(
        restaurants: restaurants ?? this.restaurants,
        selectedChip: selectedChip ?? this.selectedChip,
        filteredRestaurants: filteredRestaurants ?? this.filteredRestaurants,
        filteredMenu: filteredMenu??this.filteredMenu,
        restaurantsState: restaurantsState ?? this.restaurantsState,
        restaurantsMessage: restaurantsMessage ?? this.restaurantsMessage,
        showNearestR: showAllNearest ?? this.showNearestR,
        showPRestaurants: showPRestaurants ?? this.showPRestaurants,
        showPMenu: showPMenu ?? this.showPMenu);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        restaurants,
        restaurantsState,
        restaurantsMessage,
        showNearestR,
        showPRestaurants,
        showPMenu,
        filteredRestaurants,
    selectedChip,
    filteredMenu
      ];
}
