class DealAddonValues {
  int? id;
  int? productId;
  String? name;
  int? price;
  String? image;

  DealAddonValues({
    required this.id,
    required this.productId,
    required this.name,
    required this.price,
    required this.image,
  });

  DealAddonValues.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    productId = json["product_id"];
    name = json["name"];
    price = json["price"];
    image = json["image"];
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "product_id": productId,
      "name": name,
      "price": price,
      "image": image,
    };
  }
}
