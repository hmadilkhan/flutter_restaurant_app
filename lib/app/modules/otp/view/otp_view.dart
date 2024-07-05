import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/app/modules/otp/controller/otp_controller.dart';
import 'package:grocery_app/app/modules/otp/view/widgets/bottom_text.dart';
import 'package:grocery_app/app/modules/otp/view/widgets/header_text.dart';
import 'package:grocery_app/app/modules/otp/view/widgets/pin_form.dart';

class OtpView extends GetView<OtpController> {
  const OtpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            headerText(),
            pinInputForm(),
            bottomText(),
          ],
        ),
      ),
    );
  }
}
