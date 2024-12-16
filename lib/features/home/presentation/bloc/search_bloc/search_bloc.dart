import 'package:bloc/bloc.dart';
import 'package:food_app/features/home/presentation/bloc/restaurant_bloc/restaurant_bloc.dart';
import 'package:food_app/features/home/presentation/bloc/search_bloc/search_event.dart';
import 'package:food_app/features/home/presentation/bloc/search_bloc/search_state.dart';
import '../../../data/model/menu_with_restaurant.dart';
import '../../../data/model/restaurant.dart';
import '../restaurant_bloc/restaurant_event.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final RestaurantsBloc restaurantBloc;

  SearchBloc(this.restaurantBloc) : super(const SearchState()) {
    on<SearchRestaurantEvent>(_onSearchRestaurants);
    on<SelectTypeEvent>(_onSelectChipType);
    on<SelectDistanceEvent>(_onSelectDistance);
    restaurantBloc.add(GetRestaurants());
    on<FilterFoodItemEvent>(_onSelectFoodItem);
  }

  void _onSearchRestaurants(
    SearchRestaurantEvent event,
    Emitter<SearchState> emit,
  ) {
    final query = event.query.toLowerCase();
    final selectedChipType = state.selectedChipType;

    List<Restaurant> filteredRestaurant = [];
    List<MenuWithRestaurant> filteredMenu = [];
    if (selectedChipType == "Restaurant") {
      filteredRestaurant = restaurantBloc.state.restaurants
          .where((restaurant) =>
              restaurant.name?.toLowerCase().contains(query) ?? false)
          .toList();

      emit(state.copyWith(
        filteredRestaurants: filteredRestaurant,
        filteredMenu: [],
        selectedFoodItems: [],
      ));
    } else if (selectedChipType == "Menu") {
      filteredMenu = restaurantBloc.state.restaurants
          .expand((restaurant) =>
              restaurant.menu?.map((menuItem) {
                return MenuWithRestaurant(
                  menu: menuItem,
                  restaurantName: restaurant.name ?? "Unknown",
                );
              }) ??
              <MenuWithRestaurant>[])
          .where((menuWithRestaurant) =>
              menuWithRestaurant.menu.name?.toLowerCase().contains(query) ??
              false)
          .toList();

      emit(state.copyWith(
        filteredRestaurants: [],
        selectedFoodItems: [],
        filteredMenu: filteredMenu,
      ));
    } else {
      final restaurantMatches = restaurantBloc.state.restaurants
          .where((restaurant) =>
              restaurant.name?.toLowerCase().contains(query) ?? false)
          .toList();

      final menuMatches = restaurantBloc.state.restaurants
          .expand((restaurant) =>
              restaurant.menu?.map((menuItem) {
                return MenuWithRestaurant(
                  menu: menuItem,
                  restaurantName: restaurant.name ?? "Unknown",
                );
              }) ??
              <MenuWithRestaurant>[])
          .where((menuWithRestaurant) =>
              menuWithRestaurant.menu.name?.toLowerCase().contains(query) ??
              false)
          .toList();

      filteredRestaurant = restaurantMatches;
      filteredMenu = menuMatches;

      emit(state.copyWith(
        filteredRestaurants: filteredRestaurant,
        filteredMenu: filteredMenu,
        selectedFoodItems: [],
      ));
    }
  }

  void _onSelectChipType(SelectTypeEvent event, Emitter<SearchState> emit) {
    final currentSelectedChip = state.selectedChipType;

    if (currentSelectedChip == event.chipLabel) {
      emit(state.copyWith(selectedChipType: null));
    } else {
      emit(state.copyWith(selectedChipType: event.chipLabel));
    }
  }

  void _onSelectDistance(SelectDistanceEvent event, Emitter<SearchState> emit,
  ) {
    final selectedDistance = state.selectedDistance;
    if(selectedDistance==event.distance){
      emit(state.copyWith(selectedDistance: null));
    }else{
      emit(state.copyWith(selectedDistance: event.distance));
    }


  }
  void _onSelectFoodItem(FilterFoodItemEvent event, Emitter<SearchState> emit) {
    final currentSelected = List<String>.from(state.selectedFoodItems);

    if (currentSelected.contains(event.foodItemName)) {
      currentSelected.remove(event.foodItemName);
    } else {
      currentSelected.add(event.foodItemName);
    }

    final filteredMenu = restaurantBloc.state.restaurants
        .expand((restaurant) => restaurant.menu ?? [])
        .where((menuItem) =>
        currentSelected.contains(menuItem.name))
        .map((menuItem) => MenuWithRestaurant(
      menu: menuItem,
      restaurantName: restaurantBloc.state.restaurants
          .firstWhere(
              (restaurant) => restaurant.menu?.contains(menuItem) ?? false)
          .name ?? "Unknown",
    ))
        .toList();
    emit(state.copyWith(
      filteredMenu:filteredMenu,
      filteredRestaurants: [],
      selectedFoodItems: currentSelected,
      selectedChipType: ""
    ));
  }

}
