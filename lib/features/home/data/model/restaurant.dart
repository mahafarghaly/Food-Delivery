import 'package:food_app/features/home/data/model/menu.dart';

class Restaurant {
  final String? name;
  final String? imageUrl;
  final double? lat;
  final double? long;
  final num? rate;
final List<Menu>? menu;
  Restaurant({
     this.name,
     this.imageUrl,
     this.lat,
     this.long,
    this.rate,
    this.menu,
  });

  factory Restaurant.fromFirestore(Map<String, dynamic> data) {
    return Restaurant(
      name: data['name'],
      imageUrl: data['image'],
      lat: data['location']['lat'],
      long: data['location']['long'],
      rate:data["rate"],
      menu: (data["menu"] as List<dynamic>?)
          ?.map((item) => Menu.fromJson(item as Map<String, dynamic>))
          .toList()
    );
  }
}
