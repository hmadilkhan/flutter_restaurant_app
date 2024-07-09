import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_app/app/modules/login/controller/login_controller.dart';
import 'package:grocery_app/app/modules/otp/controller/otp_controller.dart';
import 'package:grocery_app/app/modules/otp/controller/timer_controller.dart';
import 'package:grocery_app/utils/tcolor.dart';

Widget bottomText() {
  final TimerController timerController = Get.put(TimerController());
  return GetBuilder<OtpController>(builder: (controller) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Obx(
          () => Text(
            controller.isRequested.value == false
                ? "Request another OTP in: ${timerController.timeRemaining.value}s"
                : "Didn't Received the code ?",
            style: TextStyle(
                color: TColor.secondaryText,
                fontSize: 14,
                fontWeight: FontWeight.w500),
          ),
        ),
        Obx(
          () => TextButton(
              onPressed: controller.isRequested.value
                  ? () {
                      controller.resendOTP();
                      timerController.startTimer();
                    }
                  : null,
              child: controller.isLoading == true
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Text("Click Here",
                      style: TextStyle(
                          color: controller.isRequested.value
                              ? TColor.primary
                              : TColor.secondaryText,
                          fontSize: 18,
                          fontWeight: FontWeight.w700))),
        ),
      ],
    );
  });
}
