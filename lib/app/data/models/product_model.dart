import 'package:grocery_app/app/data/models/addon_model.dart';
import 'package:grocery_app/app/data/models/deal_model.dart';
import 'package:grocery_app/app/data/models/variation_model.dart';

class ProductModel {
  int? id;
  String? image;
  String? name;
  String? description;
  int quantity = 1;
  int? price;
  int? categoryId;
  List<VariationModel>? variations;
  List<AddonModel>? addons;
  List<DealModel>? deals;

  ProductModel(
      {required this.id,
      required this.image,
      required this.name,
      required this.quantity,
      required this.price,
      required this.description,
      required this.categoryId,
      required this.variations,
      required this.addons,
      required this.deals});

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    quantity = 1;
    price = json['price'];
    categoryId = json['department_id'];
    variations = List<VariationModel>.from(
        json['variations'].map((x) => VariationModel.fromJson(x)));
    addons = List<AddonModel>.from(
        json['addons'].map((x) => AddonModel.fromJson(x)));
    deals =
        List<DealModel>.from(json['deals'].map((x) => DealModel.fromJson(x)));
  }
}
