import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_app/app/data/local/my_shared_pref.dart';
import 'package:grocery_app/app/modules/login/controller/login_controller.dart';
import 'package:grocery_app/app/routes/app_pages.dart';

class OtpController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String validCode = Get.find<LoginController>().otp;
  String mobile = Get.find<LoginController>().phone.value;
  String name = Get.find<LoginController>().name.value;
  RxBool isRequested = false.obs;

  void moveToShop(pin) {
    if (pin == validCode) {
      MySharedPref.setIsAuth(true);
      MySharedPref.setUserName(name);
      Get.toNamed(Routes.BASE);
    }
  }

  void resendOTP() {
    if (isRequested.value == false) {
      isRequested.value = true;
      print("Hit ");
      Timer(const Duration(seconds: 60), () {
        //checkFirstSeen(); your logic
        isRequested.value = false;
        print("Run After timer");
      });
    }
  }
}
