import 'package:equatable/equatable.dart';
import 'package:food_app/features/home/data/model/menu_with_restaurant.dart';

import '../../../../base/data/helpers/request_state.dart';
import '../../../data/model/menu.dart';
import '../../../data/model/restaurant.dart';

class RestaurantsState extends Equatable {
  final List<Restaurant> restaurants;
  final List<Restaurant> filteredRestaurants;
  final List<MenuWithRestaurant> filteredMenu;
  final RequestState restaurantsState;
  final String restaurantsMessage;
   bool showNearestR;
   bool showPRestaurants;
   bool showPMenu;
  final String selectedChipType;

   RestaurantsState(
      {this.restaurants = const [],
        this.filteredMenu = const [],
        this.selectedChipType="",
        this.filteredRestaurants= const[],
        this.restaurantsState = RequestState.loading,
      this.restaurantsMessage = "",
      this.showNearestR = false,
      this.showPRestaurants = false,
      this.showPMenu = false});

  RestaurantsState copyWith({
    List<Restaurant>? restaurants,
    String? selectedChipType,
    List<Restaurant>? filteredRestaurants,
    List<MenuWithRestaurant>? filteredMenu,
    RequestState? restaurantsState,
    String? restaurantsMessage,
    bool? showAllNearest,
    bool? showPRestaurants,
    bool? showPMenu,

  }) {
    return RestaurantsState(
        restaurants: restaurants ?? this.restaurants,
        selectedChipType: selectedChipType ?? this.selectedChipType,
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
    selectedChipType,
    filteredMenu
      ];
}
