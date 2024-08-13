import 'package:get/get.dart';
import 'package:grocery_app/app/modules/product_details/controllers/product_details_controller.dart';

class DealsService {
  final ProductDetailsController productDetail;

  DealsService(this.productDetail);

  initializeDeals(product) {
    if (product.deals != null) {
      productDetail.tagAddons.clear();
      for (var i = 0; i < product.deals.length; i++) {
        productDetail.tagDeals.add(0);
      }
      for (var deal in product.deals) {
        productDetail.deals.add({
          "id": deal.id,
          "inventoryDealId": deal.inventoryDealId,
          "isRequired": deal.isRequired,
          "name": deal.name,
          "type": deal.type,
          "limit": deal.limit,
          "values": deal.values?.map((addonValue) => {
                "id": addonValue.id,
                "product_id": addonValue.productId,
                "name": addonValue.name,
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
