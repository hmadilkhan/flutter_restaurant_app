import 'package:grocery_app/app/data/models/deal_addon_values.dart';

class DealAddon {
  int? id;
  String? name;
  String? type;
  int? selectionLimit;
  int? isRequired;
  List<DealAddonValues>? values;

  DealAddon({
    required this.id,
    required this.name,
    required this.type,
    required this.isRequired,
    required this.selectionLimit,
    required this.values,
  });

  DealAddon.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    type = json["type"];
    selectionLimit = json["selection_limit"];
    isRequired = json["is_required"];
    values = List<DealAddonValues>.from(
        json['values'].map((x) => DealAddonValues.fromJson(x)));
  }
}
