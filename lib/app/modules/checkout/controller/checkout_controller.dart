import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_app/app/components/custom_snackbar.dart';
import 'package:http/http.dart' as http;
import 'package:grocery_app/app/data/local/storage_controller.dart';
import 'package:grocery_app/app/modules/checkout/controller/widgets/address_bottom_sheet.dart';
import 'package:grocery_app/utils/api_list.dart';

class CheckoutController extends GetxController {
  final StorageController storageController = Get.put(StorageController());
  String? username = "";
  String? mobile = "";
  String? txtaddress = "";
  String? txtlandmark = "";
  RxString? address = "No address found".obs;
  RxString mode = "New Address".obs;
  RxBool isLoading = false.obs;
  int deliveryAreaId = 0;
  String deliveryAreaName = "";
  final formKey = GlobalKey<FormState>();
  var AreasList = [];
  List<String> areas = <String>[].obs;
  RxList addresses = [].obs;

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

  void onChangeDeliveryArea(value) {
    var item = AreasList.firstWhere((e) => e["name"] == value);
    deliveryAreaId = item["id"];
    deliveryAreaName = value;
    // print(item["id"]);
    // print(value);
  }

  String? fieldValidator(String value) {
    if (value.isEmpty) {
      return 'This field is required.';
    }
    return null;
  }

  saveAddress() {
    // isLoading.value = false;
    final isValid = formKey.currentState!.validate();
    // Get.focusScope!.unfocus();
    if (isValid) {
      // print("Address : $txtaddress and Landmark : $txtlandmark");
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
        AreasList = locations;
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
        print("Getting Addresses : $result");
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
}
