import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_app/app/modules/login/controller/login_controller.dart';

class OtpController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  int validCode = Get.find<LoginController>().otp;
}
