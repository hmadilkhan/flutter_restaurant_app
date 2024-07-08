import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_app/app/modules/otp/controller/otp_controller.dart';
import 'package:grocery_app/utils/tcolor.dart';

Widget bottomText() {
  return GetBuilder<OtpController>(builder: (controller) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Obx(
          () => Text(
            controller.isRequested.value == true
                ? "Please wait 60 seconds ?"
                : "Didn't Received the code ?",
            style: TextStyle(
                color: TColor.secondaryText,
                fontSize: 14,
                fontWeight: FontWeight.w500),
          ),
        ),
        Obx(
          () => TextButton(
            child: controller.isRequested.value == true
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Text("Click Here",
                    style: TextStyle(
                        color: TColor.primary,
                        fontSize: 18,
                        fontWeight: FontWeight.w700)),
            onPressed: () {
              print("object");
              controller.resendOTP();
            },
          ),
        ),
      ],
    );
  });
}
