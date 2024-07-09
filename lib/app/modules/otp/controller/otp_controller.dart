import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_app/app/data/local/my_shared_pref.dart';
import 'package:grocery_app/app/data/local/storage_controller.dart';
import 'package:grocery_app/app/modules/login/controller/login_controller.dart';
import 'package:grocery_app/app/routes/app_pages.dart';

class OtpController extends GetxController {
  final StorageController storageController = Get.put(StorageController());
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String mobile = Get.find<LoginController>().phone.value;
  String name = Get.find<LoginController>().name.value;
  RxBool isRequested = true.obs;
  bool isLoading = Get.find<LoginController>().isLoading.value;

  void moveToShop(pin) {
    if (pin == storageController.readData("otp")) {
      MySharedPref.setIsAuth(true);
      MySharedPref.setUserName(name);
      MySharedPref.setUserPhone(mobile);
      Get.toNamed(Routes.BASE);
    }
  }

  void resendOTP() {
    if (isRequested.value == true) {
      isRequested.value = false;
      String? name = storageController.readData("username");
      String? mobile = storageController.readData("phone");
      Get.find<LoginController>().requestOTP(name!, mobile!);
      Timer(const Duration(seconds: 60), () {
        isRequested.value = true;
      });
    }
  }
}
