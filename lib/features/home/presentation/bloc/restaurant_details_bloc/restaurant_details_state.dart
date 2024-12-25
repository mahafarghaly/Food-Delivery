import 'package:equatable/equatable.dart';

 class RestaurantDetailsState extends Equatable {
  final bool? isFavorite;
   final bool showPMenu;
  const RestaurantDetailsState({
    this.isFavorite= false,
    this.showPMenu= false
});
  RestaurantDetailsState copyWith({
    bool? isFavorite,
    bool? showPMenu,
}) {
    return RestaurantDetailsState(
isFavorite: isFavorite??this.isFavorite,
    showPMenu: showPMenu??this.showPMenu,
    );
  }

  @override
  List<Object?> get props => [
    isFavorite,
    showPMenu,
  ];
}






