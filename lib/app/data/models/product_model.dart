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

  ProductModel(
      {required this.id,
      required this.image,
      required this.name,
      required this.quantity,
      required this.price,
      required this.description,
      required this.categoryId,
      required this.variations});

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
  }
}
