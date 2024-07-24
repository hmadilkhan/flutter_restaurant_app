import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:grocery_app/app/data/local/storage_controller.dart';
import 'package:grocery_app/app/data/models/cart_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../utils/dummy_helper.dart';
import '../../../components/custom_snackbar.dart';
import '../../../data/models/product_model.dart';
import '../../base/controllers/base_controller.dart';

class CartController extends GetxController {
  // to hold the products in cart
  List<ProductModel> products = [];
  RxList cartItems = <CartItem>[].obs;
  RxList completeOrder = [].obs;
  var cartItemsModel = <CartItem>[].obs;
  var contact_details = [];
  var qty = [].obs;
  final StorageController storageController = Get.put(StorageController());

  @override
  void onInit() {
    super.onInit();
    getCartProducts();
    loadCartItems();
  }

  /// when the user press on purchase now button
  onPurchaseNowPressed() {
    // clearCart();
    // Get.back();
    // print("${cartItems}");
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

    CustomSnackBar.showCustomSnackBar(
        title: 'Purchased', message: 'Order placed with success');
  }

  /// get the cart products from the product list
  getCartProducts() {
    products = products.toList();
    update();
  }

  getProductCountFromCart(productId) {
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

  void addToCart(CartItem item) {
    cartItems.add(item);
    saveCartItems();
  }

  void removeFromCart(CartItem item) {
    cartItems.remove(item);
    saveCartItems();
  }

  Future<void> saveCartItems() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> cartItemsJson =
        cartItems.map((item) => jsonEncode(item.toJson())).toList();
    await prefs.setStringList('cart_items', cartItemsJson);
  }

  Future<void> loadCartItems() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? cartItemsJson = prefs.getStringList('cart_items');
    if (cartItemsJson != null) {
      cartItems.assignAll(cartItemsJson
          .map((item) => CartItem.fromJson(jsonDecode(item)))
          .toList());
    }
  }

  void increaseQuantity(CartItem item) {
    item.quantity++;
    updateCartItems(item, item.quantity);
  }

  void decreaseQuantity(CartItem item) {
    if (item.quantity > 1) {
      item.quantity--;
      updateCartItems(item, item.quantity);
    }
  }

  Future<void> updateCartItems(item, qty) async {
    await loadCartItems();
    int index = cartItems.indexWhere((element) => element.id == item.id);
    if (index != -1) {
      cartItems[index].quantity = qty;
      cartItems[index].totalAmount = (qty.value * cartItems[index].price);
      cartItems.refresh(); // Trigger UI update
      saveCartItems();
    }
  }

  Future<int?> lengthCartItems() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? cartItemsJson = prefs.getStringList('cart_items');
    return cartItemsJson?.length;
  }
}
