import 'package:equatable/equatable.dart';

class AppState extends Equatable {
  final int currentIndex;
  final double? latitude;
  final double? longitude;

  const AppState({
    this.currentIndex = 0,
    this.latitude,
    this.longitude,
  });

  AppState copyWith({
    int? currentIndex,
    double? latitude,
    double? longitude,
  }) {
    return AppState(
      currentIndex: currentIndex ?? this.currentIndex,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        currentIndex,
        latitude,
        longitude,
      ];
}
