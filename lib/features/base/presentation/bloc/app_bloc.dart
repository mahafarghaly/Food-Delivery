import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/features/base/presentation/bloc/app_event.dart';
import 'package:location/location.dart';

import 'app_state.dart';
class AppBloc extends Bloc<AppEvent, AppState> {
  final Location location = Location();
  AppBloc()
      : super(const AppState()) {
    on<ChangeBottomNavIndexEvent>((event, emit) {
      emit(state.copyWith(currentIndex: event.newIndex));
    });
    on<FetchLocationEvent>((event, emit) async {
      try {
        bool serviceEnabled = await location.serviceEnabled();
        if (!serviceEnabled) {
          serviceEnabled = await location.requestService();
          if (!serviceEnabled) throw Exception("Location service is disabled.");
        }

        PermissionStatus permissionGranted = await location.hasPermission();
        if (permissionGranted == PermissionStatus.denied) {
          permissionGranted = await location.requestPermission();
          if (permissionGranted != PermissionStatus.granted) {
            throw Exception("Location permission denied.");
          }
        }
        final locationData = await location.getLocation();
        emit(state.copyWith(
          latitude: locationData.latitude,
          longitude: locationData.longitude,
        ));
      } catch (e) {
        print("Error fetching location: $e");
      }
    });


  }

}
