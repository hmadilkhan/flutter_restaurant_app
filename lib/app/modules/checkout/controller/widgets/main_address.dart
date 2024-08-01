import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_app/app/modules/checkout/controller/checkout_controller.dart';
import 'package:grocery_app/app/modules/checkout/controller/widgets/address_list.dart';
import 'package:grocery_app/app/modules/checkout/controller/widgets/new_address.dart';

class MainAddress extends GetView<CheckoutController> {
  const MainAddress({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          padding: const EdgeInsets.all(5),
          child: (controller.mode.value == "New Address"
              ? const NewAddress()
              : const AddressList()),
        ));
  }
}
