import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_app/app/routes/app_pages.dart';

class LoginController extends GetxController {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  void btnLogin() {
    Get.toNamed(Routes.OTP);
  }
}
