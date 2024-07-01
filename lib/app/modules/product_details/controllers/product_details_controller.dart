import 'package:get/get.dart';
import '../../../data/models/product_model.dart';
import '../../base/controllers/base_controller.dart';

class ProductDetailsController extends GetxController {
  // get product details from arguments
  ProductModel product = Get.arguments;
  RxInt selectedIndex = 0.obs;
  RxInt tag = 0.obs;
  RxInt price = 0.obs;
  RxList tagVariation = [].obs;
  RxList tagAddons = [].obs;
  RxList variations = [].obs;
  RxList addons = [].obs;
  RxList subVariations = [].obs;

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
    if (variations.subvariations != null) {
      for (var variation in variations.subvariations!) {
        subVariations.add({
          "id": variation.id,
          "name": variation.name,
          "values": variation.values?.map((subvaiation) => {
                "id": subvaiation.id,
                "product_id": subvaiation.productId,
                "name": subvaiation.name,
                "price": subvaiation.price
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
    price.value = product.price;
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
    // print(subvariation);
    tagVariation[index] = value;
  }

  selectAddon(subvariation, index, value) {
    // print(subvariation);
    tagAddons[index] = value;
  }
}
