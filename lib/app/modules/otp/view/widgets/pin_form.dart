import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_app/app/modules/otp/controller/otp_controller.dart';
import 'package:pinput/pinput.dart';

Widget pinInputForm() {
  return GetBuilder<OtpController>(builder: (controller) {
    return Form(
        key: controller.formKey,
        child: Column(
          children: [
            Pinput(
              length: 6,
              validator: (value) {
                return value == controller.storageController.readData("otp")
                    ? null
                    : 'Incorrect Pin';
              },
              onCompleted: (pin) {
                controller.moveToShop(pin);
              },
            ),
          ],
        ));
  });
}
