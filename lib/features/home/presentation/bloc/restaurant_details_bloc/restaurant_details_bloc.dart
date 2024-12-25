import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/features/home/presentation/bloc/restaurant_details_bloc/restaurant_details_event.dart';
import 'package:food_app/features/home/presentation/bloc/restaurant_details_bloc/restaurant_details_state.dart';

class RestaurantDetailsBloc
    extends Bloc<RestaurantDetailsEvent, RestaurantDetailsState> {
  RestaurantDetailsBloc() : super(const RestaurantDetailsState()){
  on<ToggleFavoriteEvent>(_onToggleFavButton);
  on<ToggleViewPMenuAll>(_onToggleViewAllPR);
  }
  void _onToggleFavButton(ToggleFavoriteEvent event, Emitter<RestaurantDetailsState> emit){
    emit(state.copyWith(isFavorite: !(state.isFavorite ?? false)));
  }
  void _onToggleViewAllPR(
      ToggleViewPMenuAll event, Emitter<RestaurantDetailsState> emit) {
    emit(state.copyWith(showPMenu: !state.showPMenu));
  }
}
