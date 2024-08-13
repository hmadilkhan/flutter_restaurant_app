class DealDetails {
  int? id;
  int? productId;
  String? name;

  DealDetails({
    required this.id,
    required this.productId,
    required this.name,
  });

  DealDetails.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    productId = json["productId"];
    name = json["name"];
  }
}
