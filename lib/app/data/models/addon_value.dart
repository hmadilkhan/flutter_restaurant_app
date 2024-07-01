class AddonValue {
  int? id;
  int? productId;
  String? name;
  int? price;
  String? image;

  AddonValue({
    required this.id,
    required this.productId,
    required this.name,
    required this.price,
    required this.image,
  });

  AddonValue.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    productId = json["product_id"];
    name = json["name"];
    price = json["price"];
    image = json["image"];
  }
}
