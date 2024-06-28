import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:grocery_app/app/data/models/variation_model.dart';

import '../../../data/models/product_model.dart';
import '../../base/controllers/base_controller.dart';

class ProductDetailsController extends GetxController {
  // get product details from arguments
  ProductModel product = Get.arguments;
  RxInt selectedIndex = 0.obs;
  RxInt tag = 0.obs;
  RxList tagVariation = [].obs;
  RxList variations = [].obs;
  RxList subVariations = [].obs;

  @override
  void onInit() {
    super.onInit();
    getVariationsToList(product);
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
    if (variations != null && variations.subvariations != null) {
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
    // selectedIndex.value = index;
    tag.value = index;
    update();
  }

  getVariationsToList(product) {
    for (var variation in product.variations) {
      variations.add({'id': variation.id, 'name': variation.name});
    }
  }

  getSubVariation(index, value) {
    // tagVariation.insert(index, value);
    // tagVariation.replaceRange(0, 0, value);
    tagVariation[index] = value;
    print(tagVariation);
  }
}
