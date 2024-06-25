import 'package:grocery_app/app/data/models/subvariation_value.dart';

class Subvariation {
  int? prodId;
  int? id;
  String? name;
  String? requiredStatus;
  String? type;
  List<SubvariationValue>? values;

  Subvariation({
    required this.prodId,
    required this.id,
    required this.name,
    required this.requiredStatus,
    required this.type,
    required this.values,
  });

  factory Subvariation.fromMap(Map<String, dynamic> json) => Subvariation(
        prodId: json["prodID"],
        id: json["id"],
        name: json["name"],
        requiredStatus: json["required_status"],
        type: json["type"],
        values: json["values"],
      );

  Subvariation.fromJson(Map<String, dynamic> json) {
    prodId = json["prodID"];
    id = json["id"];
    name = json["name"];
    requiredStatus = json["required_status"];
    type = json["type"];
    values = List<SubvariationValue>.from(
        json['values'].map((x) => SubvariationValue.fromJson(x)));
  }
}
