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
  }) : quantity = quantity.obs;

  int get amount => quantity.value * price!;

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'],
      name: json['name'],
      quantity: json['quantity'],
      price: json['price'],
      totalAmount: json['total_amount'],
      description: json['description'],
      image: json['image'],
      variations: json['variations'],
      subVariations: json['subVariations'],
      addons: json['addons'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'quantity': quantity.value,
      'price': price,
      'total_amount': totalAmount,
      'description': description,
      'image': image,
      'variations': variations,
      'subVariations': subVariations,
      'addons': addons,
    };
  }
}
