import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/app/data/models/product_model.dart';
import 'package:grocery_app/app/modules/products/controllers/products_controller.dart';
import 'package:grocery_app/app/modules/product_details/controllers/product_details_controller.dart';
import 'package:grocery_app/app/services/cart_service.dart';
import '../../cart/controllers/cart_controller.dart';

class BaseController extends GetxController {
  ProductsController productsController = Get.put(ProductsController());
  final CartService cartService = Get.find<CartService>();
  // current screen index
  int currentIndex = 2;

  // to count the number of products in the cart
  int cartItemsCount = 0;

  @override
  void onInit() {
    getCartItemsCount();
    super.onInit();
  }

  /// change the selected screen index
  changeScreen(int selectedIndex) {
    currentIndex = selectedIndex;
    update();
  }

  getProductCountFromCart(productId) {
    var product =
        productsController.products.firstWhere((p) => p.id == productId);
    return product.quantity;
  }

  /// calculate the number of products in the cart
  getCartItemsCount() {
    var products = Get.find<CartController>().products;
    // cartItemsCount = products.fold<int>(0, (p, c) => p + c.quantity);
    cartItemsCount = products.length;
    update(['CartBadge']);
  }

  /// when the user press on add + icon
  onIncreasePressed(int productId, int totalAmount) {
    var selectedvariation =
        Get.find<ProductDetailsController>().selectedVariation;
    var selectedSubVariation =
        Get.find<ProductDetailsController>().selectedSubVariation;
    var selectedaddons = Get.find<ProductDetailsController>().selectedAddon;
    if (selectedvariation.length > 0) {
      selectedvariation[0] = {"selectedSubVariation": selectedSubVariation};
    }
    // selectedvariation.add({"selectedSubVariation": selectedSubVariation});
    if (Get.find<CartController>()
        .products
        .where((element) => element.id == productId)
        .isNotEmpty) {
      var cartproduct = Get.find<CartController>()
          .products
          .firstWhere((p) => p.id == productId);
      cartproduct.quantity++;
    } else {
      var product =
          productsController.products.firstWhere((p) => p.id == productId);
      Get.find<CartController>().products.add(product);

      cartService.cartItems.add({
        "id": product.id,
        "name": product.name,
        "image": product.image,
        "description": product.description,
        "quantity": 1,
        "price": product.price,
        "total_amount": totalAmount,
        "variations": selectedvariation,
        "subVariations": selectedSubVariation,
        "addons": selectedaddons,
      });

      Get.put(CartService()).cartItems.add({
        "id": product.id,
        "name": product.name,
        "image": product.image,
        "description": product.description,
        "quantity": 1,
        "price": product.price,
        "total_amount": totalAmount,
        "variations": selectedvariation,
        "subVariations": selectedSubVariation,
        "addons": selectedaddons,
      });
    }
    getCartItemsCount();
    if (Get.isRegistered<CartController>()) {
      Get.find<CartController>().getCartProducts();
    }
    print(Get.find<CartController>().cartItems);
    update(['ProductQuantity']);
  }

  /// when the user press on remove - icon
  onDecreasePressed(int productId) {
    var product = Get.find<CartController>()
        .products
        .firstWhere((p) => p.id == productId);
    var checkQty = (product.quantity - 1);
    if (checkQty > 0) {
      product.quantity--;
      getCartItemsCount();
      if (Get.isRegistered<CartController>()) {
        Get.find<CartController>().getCartProducts();
      }
      update(['ProductQuantity']);
    }

    if (checkQty == 0) {
      cartCountDialog(product);
    }
  }

  void cartCountDialog(ProductModel product) {
    Get.defaultDialog(
      title: "Delete",
      titlePadding: const EdgeInsets.all(10.0),
      middleText:
          "Are you sure that you want to remove this item from the cart?",
      middleTextStyle: const TextStyle(fontSize: 15),
      textConfirm: "Confirm",
      textCancel: "Cancel",
      buttonColor: Get.theme.primaryColor,
      titleStyle: const TextStyle(color: Colors.black87, fontSize: 22),
      barrierDismissible: false,
      cancelTextColor: Colors.black45,
      onConfirm: () {
        updateCartMethod(product, "Confirm");
        Get.back();
      },
      onCancel: () {
        updateCartMethod(product, "Cancel");
      },
    );
  }

  void updateCartMethod(ProductModel product, String mode) {
    getCartItemsCount();
    if (mode == "Confirm") {
      Get.find<CartController>().products.remove(product);
    }
    if (Get.isRegistered<CartController>()) {
      Get.find<CartController>().getCartProducts();
    }
    Get.find<CartController>().clearCart();
    update(['ProductQuantity']);
  }
}
