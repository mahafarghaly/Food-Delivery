import 'package:equatable/equatable.dart';

import '../../../../base/data/helpers/request_state.dart';
import '../../../data/model/menu_with_restaurant.dart';
import '../../../data/model/restaurant.dart';

class SearchState extends Equatable {
  final List<Restaurant> filteredRestaurants;
  final List<MenuWithRestaurant> filteredMenu;
  const SearchState({
    this.filteredRestaurants = const[],
    this.filteredMenu = const[],
  }
  );

  SearchState copyWith({
    List<Restaurant>? filteredRestaurants,
    List<MenuWithRestaurant>? filteredMenu,

  }) {
    return SearchState(

        filteredRestaurants: filteredRestaurants ?? this.filteredRestaurants,
        filteredMenu: filteredMenu??this.filteredMenu,
  );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
    filteredRestaurants,
    filteredMenu
  ];
}
