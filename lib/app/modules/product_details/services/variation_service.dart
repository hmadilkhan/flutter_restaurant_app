import 'package:grocery_app/app/modules/product_details/controllers/product_details_controller.dart';

class VariationService {
  final ProductDetailsController productDetail;

  VariationService(this.productDetail);

  initializevariationTag(index) {
    productDetail.tagVariation.clear();
    for (var i = 0; i < productDetail.subVariations.length; i++) {
      productDetail.tagVariation.add(0);
    }
    productDetail.tag.value = index;
  }

  initializeVariationList() {
    for (var variation in productDetail.product.variations!) {
      productDetail.variations.add({
        'id': variation.id,
        'name': variation.name,
        'price': variation.price
      });
    }
  }

  addVariationToList(variations) {
    productDetail.selectedVariation.add({
      "id": variations.id,
      "name": variations.name,
      "price": variations.price,
      "bdPrice": variations.bdPrice,
    });
  }

  calculatePrice() {
    productDetail.price.value = productDetail.originalPrice.value +
        (productDetail.addonPrices.isNotEmpty
            ? (productDetail.addonPrices
                .reduce((value, element) => value + element)) as int
            : 0) +
        (productDetail.subvariationPrices.isNotEmpty
            ? productDetail.subvariationPrices
                .reduce((value, element) => value + element)
            : 0) as int;
  }
}
