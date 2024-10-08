import 'package:get/get.dart';

class CartItem {
  int? id;
  String? name;
  RxInt quantity;
  int? price;
  int? totalAmount;
  String? description;
  String? image;
  dynamic variations;
  dynamic subVariations;
  dynamic deals;
  dynamic addons;

  CartItem({
    required this.id,
    required this.name,
    required int quantity,
    required this.price,
    required this.totalAmount,
    required this.description,
    required this.image,
    required this.variations,
    required this.subVariations,
    required this.addons,
    required this.deals,
  }) : quantity = quantity.obs;

  int get amount => quantity.value * price!;

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'],
      name: json['name'],
      quantity: json['quantity'],
      price: json['price'],
      totalAmount: json['totalAmount'],
      description: json['description'],
      image: json['image'],
      variations: json['selectedVariation'],
      subVariations: json['subVariations'],
      addons: json['selectedAddons'],
      deals: json['selectedDeals'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'quantity': quantity.value,
      'price': price,
      'totalAmount': totalAmount,
      'description': description,
      'image': image,
      'selectedVariation': variations,
      'subVariations': subVariations,
      'selectedAddons': addons,
      'selectedDeals': deals,
    };
  }
}
