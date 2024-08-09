import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_app/app/components/custom_snackbar.dart';
import 'package:grocery_app/app/data/models/cart_model.dart';
import 'package:grocery_app/app/modules/cart/controllers/cart_controller.dart';
import 'package:grocery_app/app/modules/checkout/controller/widgets/delivery_area_bottom_sheet.dart';
import 'package:grocery_app/app/modules/checkout/controller/widgets/order_type_bottom_sheet.dart';
import 'package:grocery_app/app/modules/checkout/controller/widgets/pickup_location_bottom_sheet.dart';
import 'package:http/http.dart' as http;
import 'package:grocery_app/app/data/local/storage_controller.dart';
import 'package:grocery_app/app/modules/checkout/controller/widgets/address_bottom_sheet.dart';
import 'package:grocery_app/utils/api_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckoutController extends GetxController {
  final StorageController storageController = Get.put(StorageController());
  final cartController = Get.put(CartController());

  // Form State to validate User Input
  final formKey = GlobalKey<FormState>();

  List<String> areas = <String>[].obs; // Areas list
  RxList addresses = [].obs; // get all addresses from API
  RxList ordersModes = ["Delivery", "Pickup"].obs; // Array for order type
  RxList cartItems = <CartItem>[].obs;

  String? username = "";
  String? mobile = "";
  String? txtaddress = "";
  String? txtlandmark = "";
  RxString address = "No address found".obs;
  RxString landmark = "No landmark found".obs;
  RxString mode = "New Address".obs;
  RxBool isLoading = false.obs;
  int deliveryAreaId = 0;
  RxString deliveryAreaName = "No Area selected".obs;
  int pickupBranchId = 0;
  RxString pickupBranchName = "No branch selected".obs;
  RxString pickupBranchAddress = "".obs;
  RxString orderType = "Delivery".obs; // user selected order type
  var deliveryArea = {};
  var areaList = [];

  @override
  void onInit() {
    super.onInit();
    initaializeData();
  }

  initaializeData() {
    username = storageController.readData('username');
    mobile = storageController.readData('phone');
    requestDeliveryAreas();
    getCustomerAddresses();
  }

  changeMode(String name) {
    mode.value = name;
  }

  showAddresses(BuildContext context) {
    Get.bottomSheet(const AddressBottomSheet());
  }

  showOrderType(BuildContext context) {
    Get.bottomSheet(const OrderTypeBottomSheet());
  }

  showDeliveryArea(BuildContext context) {
    Get.bottomSheet(const DeliveryAreaBottomSheet());
  }

  showPickupLocations(BuildContext context) {
    Get.bottomSheet(const PickupLocationBottomSheet());
  }

  void changeOrderType(value) {
    if (value == "Pickup") {
      cartController.deliveryCharges.value = 0.00;
      deliveryAreaName.value = "No Address Selected";
      cartController.calculateTotalAmount();
    }
    orderType.value = value;
    Get.back();
  }

  void changePickupBranch(item) {
    pickupBranchId = item["branch_id"];
    pickupBranchName.value = item["branch_name"];
    pickupBranchAddress.value = item["branch_address"];
    Get.back();
  }

  void onChangeDeliveryArea(value) {
    var item = areaList.firstWhere((e) => e["name"] == value);
    // Recieved
    // print(item);
    // {id: 15, branch_id: 248, city_id: 1, name: Aram Bagh, longitude: null, latitude: null, delivery_time: null, delivery_amount: 70, min_order: 250}
    // Required;
//     deliveryArea = {
// cityId : 1
// branchId : 17
// areaName : "mahmodabad"
// areaId : 71
// type : "delivery"
// minOrder : 450 }
    deliveryArea["cityId"] = item["city_id"];
    deliveryArea["branchId"] = item["branch_id"];
    deliveryArea["areaName"] = item["name"];
    deliveryArea["areaId"] = item["id"];
    deliveryArea["type"] = orderType.value;
    deliveryArea["minOrder"] = item["min_order"];
    print(deliveryArea);
    deliveryAreaId = item["id"];
    deliveryAreaName.value = value;
    cartController.deliveryCharges.value =
        double.parse(item["delivery_amount"].toString());
    cartController.calculateTotalAmount();
    Get.back();
  }

  void placeOrder() {
    onPurchaseNowPressed(address.value, landmark.value);
  }

  String? fieldValidator(String value) {
    if (value.isEmpty) {
      return 'This field is required.';
    }
    return null;
  }

  saveAddress() {
    final isValid = formKey.currentState!.validate();
    if (isValid) {
      saveCustomerAddress();
    }
  }

  Future<Object?>? requestDeliveryAreas() async {
    isLoading.value = true;
    try {
      final uri = Uri.parse(ApiList.getAllData);
      final response = await http.get(uri, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      });
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        var locations = result['website']['locations'];
        areaList = locations;
        for (var location in locations) {
          areas.add(location["name"]);
        }
        // areas = locations;
        isLoading.value = false;
        return locations;
      } else {
        isLoading.value = false;
        throw Exception('Failed to load departments');
      }
    } catch (e) {
      isLoading.value = false;
      return e;
    }
  }

  Future<Object?>? getCustomerAddresses() async {
    isLoading.value = true;
    try {
      final uri = Uri.parse(ApiList.getCustomerAddresses);
      var body = {
        'webId': ApiList.websiteId.toString(),
        'mobile': mobile,
      };
      final response = await http.post(uri, body: body);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        addresses.value = result["addresses"];
        isLoading.value = false;
        return result;
      } else {
        isLoading.value = false;
        throw Exception('Failed to load departments');
      }
    } catch (e) {
      isLoading.value = false;
      print(e);
      return e;
    }
  }

  Future<void> saveCustomerAddress() async {
    // isLoading.value = true;
    try {
      final uri = Uri.parse(ApiList.saveCustomerAddress);
      var body = {
        'webid': ApiList.websiteId.toString(),
        'mobile': mobile,
        'address': txtaddress,
        'landmark': txtlandmark,
      };
      final response = await http.post(uri, body: body);
      if (response.statusCode == 200) {
        isLoading.value = false;
        Get.focusScope!.unfocus();
        Get.back();
        CustomSnackBar.showCustomSnackBar(
            title: 'Success', message: "Customer Added Successfully");
      } else if (response.statusCode == 500) {
        CustomSnackBar.showCustomErrorSnackBar(
            title: 'Error', message: response.body);
      } else {
        isLoading.value = false;
        throw Exception('Failed to load departments');
      }
    } catch (e) {
      isLoading.value = false;
      print(e);
    }
  }

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
        "count": cartController.cartItems.length,
        "cartItems": items,
        "deliveryArea": deliveryArea,
        "totalAmount": cartController.totalCartAmount.value,
        "subtotal": cartController.subTotalCartAmount.value,
        "area": "",
        "deliveryCharges": cartController.deliveryCharges.value,
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

  Future<List<CartItem>> loadCartItemsForCart() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? cartItemsJson = prefs.getStringList('cart_items');
    // print("Json $cartItemsJson");
    if (cartItemsJson == null) {
      return []; // Return an empty list if no cart items are found
    }
    List<CartItem> cartItems = cartItemsJson.map((item) {
      Map<String, dynamic> itemMap = json.decode(item);
      return CartItem.fromJson(itemMap);
    }).toList();
    print(json.encode(cartItems));
    return cartItems;
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
}
