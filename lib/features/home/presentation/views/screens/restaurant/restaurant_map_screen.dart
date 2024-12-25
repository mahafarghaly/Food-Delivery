import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
class RestaurantMapScreen extends StatelessWidget {
  const RestaurantMapScreen(
      {required this.latitude, required this.longitude, super.key});
  final double latitude;
  final double longitude;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(latitude,longitude),
         zoom: 15,
        ),
        markers: {
          Marker(
            markerId: const MarkerId('restaurant'),
            position: LatLng(latitude,longitude),
          ),
        },
        circles: {
          Circle(
            circleId: const CircleId('restaurantCircle'),
            center: LatLng(latitude,longitude),
            radius: 100.r,
            strokeColor: Colors.blue.withOpacity(0.5),
            strokeWidth: 1,
            fillColor: Colors.blue.withOpacity(0.2),
          ),
        },
      ),
    );
  }


}
