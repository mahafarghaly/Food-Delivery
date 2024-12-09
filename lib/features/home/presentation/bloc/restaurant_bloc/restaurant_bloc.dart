import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/core/service/repository/app_repository.dart';
import '../../../../base/data/helpers/request_state.dart';
import '../../../data/model/menu.dart';
import '../../../data/model/menu_with_restaurant.dart';
import '../../../data/model/restaurant.dart';
import 'restaurant_event.dart';
import 'restaurant_state.dart';
class RestaurantsBloc
    extends Bloc<RestaurantsEvent, RestaurantsState> {
  final BaseAppRepository repository;
  RestaurantsBloc(this.repository)
      : super(
           RestaurantsState()){
    on<GetRestaurants>(_onGetNearestRestaurants);
    on<ToggleViewNearestMore>(_onToggleViewMoreNR);
    on<ToggleViewPRestaurantMore>(_onToggleViewMorePR);
    on<ToggleViewPMenuMore>(_onToggleViewMorePM);
    on<SearchRestaurantsEvent>(_onSearchRestaurants);
    on<SelectChipEvent>(_onSelectChipType);

  }
  Future<void> _onGetNearestRestaurants(
      GetRestaurants event, Emitter<RestaurantsState> emit) async {
    try {
      emit(state.copyWith(restaurantsState: RequestState.loading));
      final nearestRestaurants = await repository.getRestaurants();
      emit(state.copyWith(
        restaurants: nearestRestaurants,
        restaurantsState: RequestState.loaded,
      ));
    } catch (e) {
      emit(state.copyWith(
        restaurantsState: RequestState.error,
        restaurantsMessage: e.toString(),
      ));
    }
  }
  void _onToggleViewMoreNR(
      ToggleViewNearestMore event, Emitter<RestaurantsState> emit) {
    emit(state.copyWith(showAllNearest: !state.showNearestR));
  }
  void _onToggleViewMorePR(
      ToggleViewPRestaurantMore event, Emitter<RestaurantsState> emit) {
    emit(state.copyWith(showPRestaurants: !state.showPRestaurants));
  }
  void _onToggleViewMorePM(
      ToggleViewPMenuMore event, Emitter<RestaurantsState> emit) {
    emit(state.copyWith(showPMenu: !state.showPMenu));
  }
  // void _onSearchRestaurants(
  //     SearchRestaurantsEvent event,
  //     Emitter<RestaurantsState> emit,
  //     ) {
  //   final query = event.query.toLowerCase();
  //   final selectedChip = event.selectedChip;
  //
  //   List<Restaurant> filteredRestaurant = [];
  //   List<Menu> filteredMenu = [];
  //
  //   if (selectedChip == "Restaurant") {
  //     filteredRestaurant = state.restaurants
  //         .where((restaurant) =>
  //     restaurant.name?.toLowerCase().contains(query) ?? false)
  //         .toList();
  //
  //     emit(state.copyWith(
  //       filteredRestaurants: filteredRestaurant,
  //       filteredMenu: [],
  //     ));
  //   } else if (selectedChip == "Menu") {
  //     filteredMenu = state.restaurants
  //         .expand((restaurant) => restaurant.menu ?? <Menu>[])
  //         .where((menuItem) =>
  //     menuItem.name?.toLowerCase().contains(query) ?? false)
  //         .toList() ;
  //
  //     emit(state.copyWith(
  //       filteredRestaurants: [],
  //       filteredMenu: filteredMenu,
  //     ));
  //   } else {
  //     final restaurantMatches = state.restaurants
  //         .where((restaurant) =>
  //     restaurant.name?.toLowerCase().contains(query) ?? false)
  //         .toList();
  //
  //     final menuMatches = state.restaurants
  //         .expand((restaurant) => restaurant.menu ?? <Menu>[])
  //         .where((menuItem) =>
  //     menuItem.name?.toLowerCase().contains(query) ?? false)
  //         .toList();
  //
  //     filteredRestaurant = restaurantMatches;
  //     filteredMenu = menuMatches;
  //
  //     emit(state.copyWith(
  //       filteredRestaurants: filteredRestaurant,
  //       filteredMenu: filteredMenu,
  //     ));
  //   }
  //
  //   print("Search Results:");
  //   for (var result in filteredRestaurant) {
  //     print("Restaurant: ${result.name}");
  //   }
  //   for (var result in filteredMenu) {
  //     print("Menu: ${result.name}");
  //   }
  // }

  void _onSearchRestaurants(
      SearchRestaurantsEvent event,
      Emitter<RestaurantsState> emit,
      ) {
    final query = event.query.toLowerCase();
    final selectedChipType = state.selectedChipType;

    List<Restaurant> filteredRestaurant = [];
    List<MenuWithRestaurant> filteredMenu = [];

    if (selectedChipType == "Restaurant") {
      filteredRestaurant = state.restaurants
          .where((restaurant) =>
      restaurant.name?.toLowerCase().contains(query) ?? false)
          .toList();

      emit(state.copyWith(
        filteredRestaurants: filteredRestaurant,
        filteredMenu: [],
      ));
    } else if (selectedChipType == "Menu") {
      filteredMenu = state.restaurants
          .expand((restaurant) => restaurant.menu?.map((menuItem) {
        return MenuWithRestaurant(
          menu: menuItem,
          restaurantName: restaurant.name ?? "Unknown",
        );
      }) ?? <MenuWithRestaurant>[])
          .where((menuWithRestaurant) =>
      menuWithRestaurant.menu.name?.toLowerCase().contains(query) ?? false)
          .toList();

      emit(state.copyWith(
        filteredRestaurants: [],
        filteredMenu: filteredMenu,
      ));
    } else {
      final restaurantMatches = state.restaurants
          .where((restaurant) =>
      restaurant.name?.toLowerCase().contains(query) ?? false)
          .toList();

      final menuMatches = state.restaurants
          .expand((restaurant) => restaurant.menu?.map((menuItem) {
        return MenuWithRestaurant(
          menu: menuItem,
          restaurantName: restaurant.name ?? "Unknown",
        );
      }) ?? <MenuWithRestaurant>[])
          .where((menuWithRestaurant) =>
      menuWithRestaurant.menu.name?.toLowerCase().contains(query) ?? false)
          .toList();

      filteredRestaurant = restaurantMatches;
      filteredMenu = menuMatches;

      emit(state.copyWith(
        filteredRestaurants: filteredRestaurant,
        filteredMenu: filteredMenu,
      ));
    }

    print("Search Results:");
    for (var result in filteredRestaurant) {
      print("Restaurant: ${result.name}");
    }
    for (var result in filteredMenu) {
      print("Menu: ${result.menu.name} from Restaurant: ${result.restaurantName}");
    }
  }


  void _onSelectChipType(SelectChipEvent event, Emitter<RestaurantsState> emit) {
    emit(state.copyWith(selectedChipType: event.chipLabel));
  }

}
