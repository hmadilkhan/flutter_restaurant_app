import 'package:get/get.dart';
import 'package:grocery_app/app/data/models/subvariation_model.dart';
import 'package:grocery_app/app/modules/product_details/controllers/product_details_controller.dart';

class SubVariationService {
  final ProductDetailsController productDetail;

  SubVariationService(this.productDetail);

  getSubVariation(subvariation, index, value) {
    var checkvariations = productDetail.selectedSubVariation
        .firstWhereOrNull((element) => element["id"] == subvariation["id"]);
    if (checkvariations != null) {
      checkvariations["values"] = subvariation["values"]
          .firstWhere((element) => element["id"] == value);
    } else {
      productDetail.selectedSubVariation.add({
        "id": subvariation["id"],
        "name": subvariation["name"],
        "values": subvariation["values"]
            .where((element) => element["id"] == value)
            .toList()
      });
      print("Add : ${productDetail.selectedSubVariation}");
    }
    productDetail.tagVariation[index] = value;
  }

  addSubVariationInList(subVariations) {
    for (var variation in subVariations) {
      productDetail.subVariations.add({
        "id": variation.id,
        "name": variation.name,
        "values": variation.values
            ?.map((subvariation) => {
                  "id": subvariation.id,
                  "product_id": subvariation.productId,
                  "name": subvariation.name,
                  "price": subvariation.price,
                })
            .toList(), // Convert the map result to a List
      });
    }
  }

  calculateSubVariationPrice(subvariation, index, value) {
    var subVariationPrice = productDetail.selectedSubVariation
        .firstWhereOrNull((element) => element["id"] == subvariation["id"]);
    print("Price : ${subVariationPrice['values']}");
    // if (subVariationPrice['values']['price'] != null) {
    if (index >= 0 && index < productDetail.subvariationPrices.length) {
      productDetail.subvariationPrices[index] =
          subVariationPrice['values']['price'] ?? 0;
    } else {
      productDetail.subvariationPrices
          .insert(index, (subVariationPrice['values'][0]['price'] ?? 0));
    }
    productDetail.price.value = productDetail.originalPrice.value +
        (productDetail.addonPrices.isNotEmpty
            ? (productDetail.addonPrices
                .reduce((value, element) => value + element)) as int
            : 0) +
        (productDetail.subvariationPrices
            .reduce((value, element) => value + element)) as int;
    // }
  }
}
