import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:grocery_app/app/modules/cart/controllers/cart_controller.dart';
import 'package:grocery_app/app/modules/checkout/controller/checkout_controller.dart';

class OrderSummary extends GetView<CartController> {
  const OrderSummary({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final checkoutController = Get.put(CheckoutController());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.w),
          decoration: const BoxDecoration(color: Colors.white),
          child: const Text(
            "Order Summary",
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey),
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.zero, bottomRight: Radius.zero),
          ),
          child: Column(
            children: [
              Obx(
                () => Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Sub Total", style: theme.textTheme.labelLarge),
                      Text(
                          "Rs. ${controller.subTotalCartAmount.toStringAsFixed(2)}",
                          style: theme.textTheme.labelLarge),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Tax Amount", style: theme.textTheme.labelLarge),
                    Text("Rs. 250", style: theme.textTheme.labelLarge),
                  ],
                ),
              ),
              Obx(
                () => checkoutController.orderType.value == "Delivery" &&
                        controller.deliveryCharges.value > 0
                    ? Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 15.w, vertical: 8.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Delivery Amount",
                                style: theme.textTheme.labelLarge),
                            Text(
                                "Rs. ${controller.deliveryCharges.toStringAsFixed(2)}",
                                style: theme.textTheme.labelLarge),
                          ],
                        ),
                      )
                    : const Center(),
              ),
              const Divider(
                thickness: 2,
              ),
              Obx(
                () => Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Total Amount", style: theme.textTheme.displaySmall),
                      // subtitle: Text("Sub Title"),
                      Text(
                          "Rs. ${controller.totalCartAmount.toStringAsFixed(2)}",
                          style: theme.textTheme.displaySmall),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
