import 'package:grocery_app/app/data/models/deal_addon.dart';

class DealDetails {
  int? id;
  int? productId;
  String? name;
  // List<DealAddon>? addons;
  dynamic addons;

  DealDetails({
    required this.id,
    required this.productId,
    required this.name,
    required this.addons,
  });

  DealDetails.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    productId = json["product_id"];
    name = json["name"];
    // addons =
    //     List<DealAddon>.from(json['addons'].map((x) => DealAddon.fromJson(x)));
    addons = json['addons'];
  }
}
