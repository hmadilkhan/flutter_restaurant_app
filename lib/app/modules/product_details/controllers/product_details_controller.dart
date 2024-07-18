import 'dart:convert';
import 'dart:ffi';

import 'package:get/get.dart';
import 'package:grocery_app/app/components/sub_variation.dart';
import 'package:grocery_app/app/data/models/subvariation_model.dart';
import '../../../data/models/product_model.dart';
import '../../base/controllers/base_controller.dart';

class ProductDetailsController extends GetxController {
  // get product details from arguments
  ProductModel product = Get.arguments;
  RxInt selectedIndex = 0.obs;
  RxInt tag = 0.obs;
  RxInt originalPrice = 0.obs;
  RxInt price = 0.obs;
  RxList tagVariation = [].obs;
  RxList tagAddons = [].obs;
  RxList variations = [].obs;
  RxList addons = [].obs;
  RxList subVariations = [].obs;
  var selectedVariation = [];
  var selectedSubVariation = [];
  var selectedAddon = [];

  @override
  void onInit() {
    super.onInit();
    initializeLists(product);
  }

  /// when the user press on add to cart button
  onAddToCartPressed() {
    // if (product.quantity == 0) {
    Get.find<BaseController>().onIncreasePressed(product.id ?? 0);
    // }
    Get.back();
  }

  getSelectionChange(index) {
    subVariations = [].obs;
    var variations =
        product.variations?.firstWhere((element) => element.id == index);
    price.value = variations!.price!;
    selectedVariation.clear();
    selectedVariation.add({
      "id": variations.id,
      "name": variations.name,
      "price": variations.price,
      "bdPrice": variations.bdPrice,
    });
    if (variations.subvariations != null) {
      for (var variation in variations.subvariations!) {
        subVariations.add({
          "id": variation.id,
          "name": variation.name,
          "values": variation.values?.map((subvariation) => {
                "id": subvariation.id,
                "product_id": subvariation.productId,
                "name": subvariation.name,
                "price": subvariation.price
              })
        });
      }
    }
    // Initializing List according to subvariations
    tagVariation.clear();
    for (var i = 0; i < subVariations.length; i++) {
      tagVariation.add(0);
    }
    // selectedIndex.value = index;
    tag.value = index;
    update();
  }

  initializeLists(product) {
    // price.value = product.price;
    originalPrice.value = product.price;
    for (var variation in product.variations) {
      variations.add({'id': variation.id, 'name': variation.name});
    }
    // Initializing List according to subvariations
    if (product.addons != null) {
      tagAddons.clear();
      for (var i = 0; i < product.addons.length; i++) {
        tagAddons.add(0);
      }
      for (var addon in product.addons) {
        addons.add({
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

  getSubVariation(subvariation, index, value) {
    var checkvariations = selectedSubVariation
        .firstWhereOrNull((element) => element["id"] == subvariation["id"]);
    if (checkvariations != null) {
      checkvariations["values"] = subvariation["values"]
          .firstWhere((element) => element["id"] == value);
    } else {
      selectedSubVariation.add({
        "id": subvariation["id"],
        "name": subvariation["name"],
        "values": subvariation["values"]
            .firstWhere((element) => element["id"] == value)
      });
    }
    tagVariation[index] = value;
  }

  selectAddon(addon, index, value) {
    tagAddons[index] = value;
    var checkAddon = selectedAddon
        .firstWhereOrNull((element) => element["id"] == addon["id"]);
    var addonPrice =
        addon["values"].firstWhere((element) => element["id"] == value);
    // print(addonPrice['price']);
    // print(originalPrice.value);

    price.value = originalPrice.value + addonPrice['price'] as int;
    if (checkAddon != null) {
      checkAddon["values"] =
          addon["values"].firstWhere((element) => element["id"] == value);
    } else {
      selectedAddon.add({
        "id": addon["id"],
        "name": addon["name"],
        "values":
            addon["values"].firstWhere((element) => element["id"] == value)
      });
    }
  }
}
