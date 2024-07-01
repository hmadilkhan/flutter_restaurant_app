import 'package:grocery_app/app/data/models/addon_value.dart';

class AddonModel {
  int? id;
  String? name;
  String? type;
  int? selectionLimit;
  int? requiredStatus;
  List<AddonValue>? values;

  AddonModel({
    required this.id,
    required this.name,
    required this.type,
    required this.selectionLimit,
    required this.requiredStatus,
    required this.values,
  });

  factory AddonModel.fromMap(Map<String, dynamic> json) => AddonModel(
        id: json["id"],
        name: json["name"],
        type: json["type"],
        selectionLimit: json["selection_limit"],
        requiredStatus: json["is_required"],
        values: json["values"],
      );

  AddonModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    type = json["type"];
    selectionLimit = json["selection_limit"];
    requiredStatus = json["is_required"];
    values = List<AddonValue>.from(
        json['values'].map((x) => AddonValue.fromJson(x)));
  }
}
