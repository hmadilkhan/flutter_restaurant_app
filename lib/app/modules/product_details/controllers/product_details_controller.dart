import 'package:get/get.dart';
import 'package:grocery_app/app/modules/product_details/services/addon_service.dart';
import 'package:grocery_app/app/modules/product_details/services/deals_service.dart';
import 'package:grocery_app/app/modules/product_details/services/sub_variation_service.dart';
import 'package:grocery_app/app/modules/product_details/services/variation_service.dart';
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
  RxList tagDeals = [].obs;
  RxList variations = [].obs;
  RxList addons = [].obs;
  RxList subVariations = [].obs;
  RxList deals = [].obs;
  List<dynamic> variationAddons = [].obs;
  var addonPrices = [];
  var subvariationPrices = [];
  var selectedVariation = [];
  var selectedSubVariation = [];
  var selectedAddon = [];
  var selectedDeals = [];
  var selectedDealsValues = [];
  late AddonService addonService;
  late SubVariationService subVariationService;
  late VariationService variationService;
  late DealsService dealsService;

  @override
  void onInit() {
    super.onInit();
    variationService = VariationService(this);
    subVariationService = SubVariationService(this);
    addonService = AddonService(this);
    dealsService = DealsService(this);
    initializeLists(product);
  }

  /// when the user press on add to cart button
  onAddToCartPressed() {
    // if (product.quantity == 0) {
    Get.find<BaseController>().onIncreasePressed(product.id ?? 0, price.value);
    // }
    Get.back();
  }

  getSelectionChange(index) {
    subVariations = [].obs;
    var variations =
        product.variations?.firstWhere((element) => element.id == index);
    // print("Variation Price : ${variations!.price!}");
    price.value = variations!.price!;
    originalPrice.value = variations.price!;
    subvariationPrices = [];
    selectedVariation.clear();
    variationService.addVariationToList(variations);
    if (variations.subvariations != null) {
      subVariationService.addSubVariationInList(variations.subvariations);
    }
    // Initializing List according to subvariations
    variationService.initializevariationTag(index);
    variationService.calculatePrice();
    update();
  }

  dealSelection(deals, index, value) {
    tagDeals[index] = value;
    dealsService.checkDealSelectedOrNot(deals, index, value);
  }

  initializeLists(product) {
    addonPrices = [];
    subvariationPrices = [];
    originalPrice.value = product.price;
    price.value = product.price;

    // Initializing Variation List
    variationService.initializeVariationList();
    addonService.initializeAddons(product);
    dealsService.initializeDeals(product);
  }

  getSubVariation(subvariation, index, value) {
    subVariationService.getSubVariation(subvariation, index, value);
    subVariationService.calculateSubVariationPrice(subvariation, index, value);
  }

  selectAddon(addon, index, value) {
    tagAddons[index] = value;
    addonService.checkAddonSelectedOrNot(addon, index, value);
    addonService.calculateAddonPrice(addon, index, value);
  }
}
