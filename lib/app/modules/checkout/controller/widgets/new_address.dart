import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_custom_selector/flutter_custom_selector.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:grocery_app/app/components/custom_button.dart';
import 'package:grocery_app/app/modules/checkout/controller/checkout_controller.dart';

class NewAddress extends GetView<CheckoutController> {
  const NewAddress({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKey,
      autovalidateMode: AutovalidateMode.always,
      child: Column(
        children: [
          Obx(
            () => controller.isLoading.value == false
                ? CustomSingleSelectField<String>(
                    items: controller.areas,
                    title: "Delivery Area",
                    onSelectionDone: (value) {
                      controller.onChangeDeliveryArea(value);
                    },
                    validator: (value) {
                      return controller.fieldValidator(value!);
                    },
                    itemAsString: (item) => item,
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  ),
          ),
          15.verticalSpace,
          TextFormField(
            maxLines: 2,
            onChanged: (value) {
              controller.txtaddress = value;
            },
            validator: (value) {
              return controller.fieldValidator(value!);
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              hintText: 'Enter your address here',
            ),
          ),
          15.verticalSpace,
          TextFormField(
            maxLines: 1,
            onChanged: (value) {
              controller.txtlandmark = value;
            },
            validator: (value) {
              return controller.fieldValidator(value!);
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              hintText: 'Enter your landmark',
            ),
          ),
          15.verticalSpace,
          Container(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: Visibility(
              // visible: controller.isLoading.value,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                ),
                child: CustomButton(
                  text: 'Save Address',
                  onPressed: () => controller
                      .saveAddress(), //controller.onPurchaseNowPressed(),
                  fontSize: 16.sp,
                  radius: 50.r,
                  verticalPadding: 16.h,
                  hasShadow: false,
                ).animate().fade().slideY(
                      duration: 300.ms,
                      begin: 1,
                      curve: Curves.easeInSine,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
