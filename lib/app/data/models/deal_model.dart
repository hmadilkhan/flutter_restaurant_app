import 'package:grocery_app/app/data/models/deal_details.dart';

class DealModel {
  int? id;
  int? inventoryDealId;
  int? isRequired;
  String? name;
  String? type;
  int? limit;
  List<DealDetails>? values;

  DealModel({
    required this.id,
    required this.inventoryDealId,
    required this.isRequired,
    required this.name,
    required this.type,
    required this.limit,
    required this.values,
  });

  DealModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    inventoryDealId = json["inventoryDealId"];
    isRequired = json["isRequired"];
    name = json["name"];
    type = json["type"];
    limit = json["limit"];
    values = List<DealDetails>.from(
        json['values'].map((x) => DealDetails.fromJson(x)));
  }
}
