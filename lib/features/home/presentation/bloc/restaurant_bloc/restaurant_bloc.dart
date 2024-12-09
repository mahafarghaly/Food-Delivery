import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/core/service/repository/app_repository.dart';
import '../../../../base/data/helpers/request_state.dart';
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

}
