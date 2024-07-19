import 'package:get/get.dart';
import 'package:grocery_app/app/modules/product_details/controllers/product_details_controller.dart';

class AddonService {
  final ProductDetailsController productDetail;

  AddonService(this.productDetail);

  initializeAddons(product) {
    if (product.addons != null) {
      productDetail.tagAddons.clear();
      for (var i = 0; i < product.addons.length; i++) {
        productDetail.tagAddons.add(0);
      }
      for (var addon in product.addons) {
        productDetail.addons.add({
          "id": addon.id,
          "name": addon.name,
          "type": addon.type,
          "selection_limit": addon.selectionLimit,
          "is_required": addon.requiredStatus,
          "values": addon.values?.map((addonValue) => {
                "id": addonValue.id,
                "product_id": addonValue.productId,
                "name": addonValue.name,
                "price": addonValue.price,
                "image": addonValue.image,
              })
        });
      }
    }
  }

  checkAddonSelectedOrNot(addon, index, value) {
    var checkAddon = productDetail.selectedAddon
        .firstWhereOrNull((element) => element["id"] == addon["id"]);

    if (checkAddon != null) {
      checkAddon["values"] =
          addon["values"].firstWhere((element) => element["id"] == value);
    } else {
      productDetail.selectedAddon.add({
        "id": addon["id"],
        "name": addon["name"],
        "values":
            addon["values"].firstWhere((element) => element["id"] == value)
      });
    }
  }

  calculateAddonPrice(addon, index, value) {
    var addonPrice =
        addon["values"].firstWhere((element) => element["id"] == value);

    if (index >= 0 && index < productDetail.addonPrices.length) {
      productDetail.addonPrices[index] = addonPrice['price'];
    } else {
      productDetail.addonPrices.insert(index, addonPrice['price']);
    }

    productDetail.price.value = productDetail.originalPrice.value +
        (productDetail.addonPrices.isNotEmpty
            ? (productDetail.addonPrices
                .reduce((value, element) => value + element)) as int
            : 0) +
        (productDetail.subvariationPrices.isNotEmpty
            ? (productDetail.subvariationPrices
                .reduce((value, element) => value + element)) as int
            : 0);
  }
}
