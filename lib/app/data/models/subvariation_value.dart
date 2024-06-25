class SubvariationValue {
  int? id;
  int? productId;
  String? name;
  int? price;

  SubvariationValue({
    required this.id,
    required this.productId,
    required this.name,
    required this.price,
  });

  SubvariationValue.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    productId = json["product_id"];
    name = json["name"];
    price = json["price"];
  }
}
