import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_app/app/modules/checkout/controller/checkout_controller.dart';
import 'package:grocery_app/app/modules/checkout/views/components/customer_address.dart';
import 'package:grocery_app/app/modules/checkout/views/components/delivery_area.dart';

class Delivery extends GetView<CheckoutController> {
  const Delivery({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.orderType.value == "Delivery"
        ? const Column(
            children: [
              DeliveryArea(),
              CustomerAddress(),
            ],
          )
        : const Center());
  }
}
