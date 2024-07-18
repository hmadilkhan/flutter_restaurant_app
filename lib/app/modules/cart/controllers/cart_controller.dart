import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:grocery_app/app/data/local/storage_controller.dart';

import '../../../../utils/dummy_helper.dart';
import '../../../components/custom_snackbar.dart';
import '../../../data/models/product_model.dart';
import '../../base/controllers/base_controller.dart';

class CartController extends GetxController {
  // to hold the products in cart
  List<ProductModel> products = [];
  RxList cartItems = [].obs;
  RxList completeOrder = [].obs;
  var contact_details = [];
  final StorageController storageController = Get.put(StorageController());

  @override
  void onInit() {
    getCartProducts();
    super.onInit();
  }

  /// when the user press on purchase now button
  onPurchaseNowPressed() {
    // clearCart();
    // Get.back();
    print("${cartItems}");
    Map<String, dynamic> contactdetails = {
      'fullName': storageController.readData('username'),
      'email': '',
      'phNumber': storageController.readData('phone'),
      'fullAddress': '',
      'landmark': '',
      'instructions': '',
    };

    Map<String, dynamic> cartData = {
      'count': cartItems.length,
      'cartItems': cartItems,
      'totalAmount': storageController.readData('phone'),
      'fullAddress': '',
      'landmark': '',
      'instructions': '',
    };

    Map<String, dynamic> contact_details = {
      'contact_details': contactdetails,
      'cart_data': cartItems,
    };

    completeOrder.add(contact_details);

    // print("$completeOrder");

    CustomSnackBar.showCustomSnackBar(
        title: 'Purchased', message: 'Order placed with success');
  }

  /// get the cart products from the product list
  getCartProducts() {
    // products = DummyHelper.products.where((p) => p.quantity > 0).toList();
    products = products.toList();
    update();
  }

  getProductCountFromCart(productId) {
    var checkCartProduct =
        Get.find<CartController>().products.contains((p) => p.id == productId);
    print("Qty $checkCartProduct");
    if (Get.find<CartController>()
        .products
        .where((element) => element.id == productId)
        .isNotEmpty) {
      var product = products.firstWhere((p) => p.id == productId);
      return product.quantity;
    } else {
      return 1;
    }
  }

  /// clear products in cart and reset cart items count
  clearCart() {
    DummyHelper.products.map((p) => p.quantity = 0).toList();
    Get.find<BaseController>().getCartItemsCount();
  }
}
