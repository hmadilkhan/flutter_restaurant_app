import 'dart:convert';

import 'package:grocery_app/app/data/models/subvariation_model.dart';

class VariationModel {
  int? id;
  String? name;
  int? price;
  int? bdPrice;
  String? discountValue;
  String? image;
  List<Subvariation>? subvariations;

  VariationModel({
    required this.id,
    required this.name,
    required this.price,
    required this.bdPrice,
    required this.discountValue,
    required this.image,
    required this.subvariations,
  });

  factory VariationModel.fromMap(Map<String, dynamic> json) => VariationModel(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        bdPrice: json["bdPrice"],
        discountValue: json["discountValue"],
        image: json["image"],
        subvariations: json["subvariations"],
      );

  VariationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    bdPrice = json['bdPrice'];
    discountValue = json['discount_value'];
    image = json['image'];
    subvariations = List<Subvariation>.from(
        json['subvariations'].map((x) => Subvariation.fromJson(x)));
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'bdPrice': bdPrice,
      'discount_value': discountValue,
      'image': image,
      'subvariations': subvariations?.map((x) => x.toJson()).toList(),
    };
  }
}
