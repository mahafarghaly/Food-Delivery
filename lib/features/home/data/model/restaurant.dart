import 'package:food_app/features/home/data/model/menu.dart';

class Restaurant {
  final String? name;
  final String? imageUrl;
  final String? logo;
  final double? lat;
  final double? long;
  final num? rate;
  final String? description;
final List<Menu>? menu;
  Restaurant({
     this.name,
     this.imageUrl,
    this.logo,
     this.lat,
     this.long,
    this.rate,
    this.menu,
    this.description
  });

  factory Restaurant.fromFirestore(Map<String, dynamic> data) {
    return Restaurant(
      name: data['name'],
      imageUrl: data['image'],
      logo: data['logo'],
      lat: data['location']['lat'],
      long: data['location']['long'],
      rate:data["rate"],
      description: data["description"],
      menu: (data["menu"] as List<dynamic>?)
          ?.map((item) => Menu.fromJson(item as Map<String, dynamic>))
          .toList()
    );
  }
}
