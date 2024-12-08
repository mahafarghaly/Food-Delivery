class Menu {
  final String? name;
  final String? image;
  final double? rate;
  final double? price;

  const Menu({
    this.name,
    this.image,
    this.rate,
    this.price,
  });
  factory Menu.fromJson(Map<String, dynamic> json) {
    return Menu(
      name: json['name'],
      image: json['image'],
      price: json['price']?.toDouble(),
      rate: json["rate"]?.toDouble(),
    );
  }
}
