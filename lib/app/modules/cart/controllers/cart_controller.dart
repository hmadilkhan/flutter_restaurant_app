import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:grocery_app/app/data/local/storage_controller.dart';
import 'package:grocery_app/app/data/models/cart_model.dart';
import 'package:grocery_app/app/modules/products/controllers/products_controller.dart';
import 'package:grocery_app/utils/api_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../utils/dummy_helper.dart';
import '../../../components/custom_snackbar.dart';
import '../../../data/models/product_model.dart';
import '../../base/controllers/base_controller.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class CartController extends GetxController {
  // to hold the products in cart
  List<ProductModel> products = [];
  RxList cartItems = <CartItem>[].obs;
  RxList completeOrder = [].obs;
  var cartItemsModel = <CartItem>[].obs;
  var contactDetails = [];
  var qty = [].obs;
  final StorageController storageController = Get.put(StorageController());
  RxDouble totalCartAmount = 0.00.obs;
  RxDouble subTotalCartAmount = 0.00.obs;
  RxDouble deliveryCharges = 0.00.obs;

  final value = NumberFormat("#,##0", "en_US");

  @override
  void onInit() {
    super.onInit();
    // getCartProducts();
    loadCartItems();
  }

  /// when the user press on purchase now button
  onPurchaseNowPressed(address, landmark) async {
    // clearCart();
    // Get.back();
    // print("${cartItems}");
    var items = await loadCartItemsForCart();

    final data = {
      "contact_details": {
        "fullName": storageController.readData('username'),
        "email": null,
        "phNumber": storageController.readData('phone'),
        "fullAddress": address,
        "landmark": landmark,
        "instructions": null
      },
      "cart_data": {
        "count": cartItems.length,
        "cartItems": items,
        "deliveryArea": {},
        "totalAmount": totalCartAmount.value,
        "subtotal": subTotalCartAmount.value,
        "area": "",
        "deliveryCharges": deliveryCharges.value,
        "orderAmount": 0,
      },
      "webId": ApiList.websiteId,
      "companyId": ApiList.companyId,
      "entireDiscountDetails": null,
      "voucher": null
    };

    // print(jsonEncode(data));

    await placeOrderOnServer(address, landmark, data);

    CustomSnackBar.showCustomSnackBar(
        title: 'Purchased', message: 'Order placed with success');
  }

  Future<Object?>? placeOrderOnServer(address, landmark, completeArray) async {
    try {
      final uri = Uri.parse(ApiList.placeOrder);

      final response = await http.post(uri,
          headers: {
            "content-type": "application/json",
          },
          body: jsonEncode(completeArray));
      print("Response Body : ${response.body}");

      if (response.statusCode == 200) {
        print(response.body);
        return response.body;
      } else {
        print("Error");
        throw Exception('Failed to load departments');
      }
    } catch (e) {
      print("Error $e");
      return e;
    }
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
    print(cartItems);
    // cartItems.remove(item);
    updateCartItems(item, 0);
    // saveCartItems();
  }

  void removeAllItemFromCart() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('cart_items', []);
    await Get.find<BaseController>().getCartItemsCount();
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
      calculateTotalAmount();
    }
  }

  Future<List<String>?> loadCartItemsForCart() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? cartItemsJson = prefs.getStringList('cart_items');
    // print("Json $cartItemsJson");
    return cartItemsJson;
  }

  calculateTotalAmount() {
    subTotalCartAmount.value =
        cartItems.fold(0, (sum, item) => sum + item.totalAmount);
    totalCartAmount.value = subTotalCartAmount.value + deliveryCharges.value;
    print("Total Cart : $totalCartAmount");
  }

  void increaseQuantity(CartItem item) {
    item.quantity++;
    updateCartItems(item, item.quantity);
  }

  void decreaseQuantity(CartItem item, BuildContext context) {
    if (item.quantity > 1) {
      item.quantity--;
      updateCartItems(item, item.quantity);
    } else {
      Get.defaultDialog(
        title: 'Remove Item',
        middleText: 'Are you sure you want to remove this item from the cart?',
        textConfirm: 'Yes',
        textCancel: 'No',
        buttonColor: context.theme.primaryColor,
        onConfirm: () {
          removeFromCart(item);
          Get.back();
        },
        onCancel: () {
          // Do nothing
        },
      );
    }
  }

  void clearAllCart(BuildContext context) {
    Get.defaultDialog(
      title: 'Clear Cart',
      titlePadding: const EdgeInsets.all(5),
      titleStyle: const TextStyle(fontSize: 20),
      middleText: 'Are you sure you want to remove all items from the cart?',
      textConfirm: 'Yes',
      textCancel: 'No',
      buttonColor: context.theme.primaryColor,
      onConfirm: () {
        removeAllItemFromCart();
        Get.back();
      },
      onCancel: () {
        // Do nothing
      },
    );
  }

  Future<void> updateCartItems(item, qty) async {
    await loadCartItems();
    int index = cartItems.indexWhere((element) => element.id == item.id);
    if (index != -1) {
      if (qty == 0) {
        cartItems.removeAt(index);
        cartItems.refresh();
        int productindex =
            products.indexWhere((element) => element.id == item.id);
        if (productindex != -1) {
          products.removeAt(productindex);
        }
      } else {
        cartItems[index].quantity = qty;
        cartItems[index].totalAmount = (qty.value * cartItems[index].price);
        cartItems.refresh(); // Trigger UI update
      }
      saveCartItems();
      await Get.find<BaseController>().getCartItemsCount();
    }
  }

  Future<int?> lengthCartItems() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? cartItemsJson = prefs.getStringList('cart_items');
    return cartItemsJson?.length ?? 0;
  }

  showBottomDialog(BuildContext context, dynamic item) {
    Get.bottomSheet(Container(
      padding: const EdgeInsets.all(8.0),
      width: MediaQuery.of(context).size.width * 0.95,
      height: MediaQuery.of(context).size.height * 0.5,
      decoration: BoxDecoration(
        color: context.theme.scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30.0)),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 120.w),
              child: const Divider(
                color: Color.fromARGB(255, 218, 216, 216),
                thickness: 5,
              ),
            ),
            SizedBox(height: 20.w),
            if (item.subVariations != null) ...{
              for (int i = 0; i < item.subVariations.length; i++) ...{
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: context.theme.primaryColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.subVariations[i]["name"].toString(),
                          style: context.theme.textTheme.headlineSmall
                              ?.copyWith(
                                  color: Colors.white,
                                  backgroundColor: context.theme.primaryColor),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                  ),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          item.subVariations[i]["values"]['name'],
                          style:
                              context.theme.textTheme.headlineSmall?.copyWith(
                            color: context.theme.colorScheme.secondary,
                          ),
                        ),
                        Text(
                          "PKR ${item.subVariations[i]["values"]['price'].toString()}",
                          style:
                              context.theme.textTheme.headlineSmall?.copyWith(
                            color: context.theme.colorScheme.secondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              },
            },
            if (item.addons != null) ...{
              for (int i = 0; i < item.addons.length; i++) ...{
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: context.theme.primaryColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.addons[i]["name"],
                          style: context.theme.textTheme.headlineSmall
                              ?.copyWith(
                                  color: Colors.white,
                                  backgroundColor: context.theme.primaryColor),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                  ),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          item.addons[i]["values"]['name'],
                          style:
                              context.theme.textTheme.headlineSmall?.copyWith(
                            color: context.theme.colorScheme.secondary,
                          ),
                        ),
                        Text(
                          "PKR ${item.subVariations[i]["values"]['price'].toString()}",
                          style:
                              context.theme.textTheme.headlineSmall?.copyWith(
                            color: context.theme.colorScheme.secondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              },
            },
            const SizedBox(height: 10.0),
          ],
        ),
      ),
    ));
  }
}
