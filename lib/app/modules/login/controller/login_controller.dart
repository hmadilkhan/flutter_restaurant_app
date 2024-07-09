import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:grocery_app/app/data/local/my_shared_pref.dart';
import 'package:grocery_app/app/data/local/storage_controller.dart';
import 'package:grocery_app/app/routes/app_pages.dart';
import 'package:grocery_app/utils/api_list.dart';
import 'package:http/http.dart' as http;

class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final StorageController storageController = Get.put(StorageController());
  RxString name = RxString('');
  RxString phone = RxString('');
  RxnString errorText = RxnString(null);
  Rxn<Function()> submitFunc = Rxn<Function()>(null);
  RxBool isLoading = false.obs;
  String otp = "";

  void btnLogin() async {
    isLoading.value = false;
    final isValid = formKey.currentState!.validate();
    Get.focusScope!.unfocus();

    if (isValid) {
      formKey.currentState!.save();
      storageController.saveData("username", name.value);
      storageController.saveData("phone", phone.value);
      await requestOTP(name.value, phone.value);
      Get.offNamed(Routes.OTP);

      // User those values to send our auth request ...
    }
  }

  String? nameValidator(String value) {
    if (value.isEmpty) {
      return 'Please enter a complete name.';
    }
    return null;
  }

  Future<Object?>? requestOTP(String name, String phone) async {
    isLoading.value = true;
    try {
      final uri = Uri.parse(ApiList.login);
      var body = {
        'phNumber': phone,
        'fullName': name,
        'webId': ApiList.websiteId.toString(),
        'mode': 'android'
      };
      print(body);
      await http
          .post(
        uri,
        body: body,
      )
          .then((response) {
        print(response.statusCode);
        if (response.statusCode == 200) {
          var result = jsonDecode(response.body);
          otp = result['otp'].toString();
          storageController.removeData("otp");
          storageController.saveData('otp', result['otp'].toString());
          print("storage OTP : ${storageController.readData('otp')}");
          print("OTP is set to : $otp");
          isLoading.value = false;
          return otp;
        } else {
          isLoading.value = false;
          throw Exception('Failed to Login');
        }
      }).catchError((error) {
        isLoading.value = false;
        print(error);
        return error;
      });
    } catch (e) {
      return e;
    }
    return null;
  }
}
