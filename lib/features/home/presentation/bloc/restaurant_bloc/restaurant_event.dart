import 'package:equatable/equatable.dart';

sealed class RestaurantsEvent  extends Equatable{
  const RestaurantsEvent();
@override
  List<Object?> get props => [];
}

class GetRestaurants extends RestaurantsEvent {}
class ToggleViewNearestMore extends RestaurantsEvent {}
class ToggleViewPRestaurantMore extends RestaurantsEvent {}
class ToggleViewPMenuMore extends RestaurantsEvent {}

