import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:grocery_app/app/modules/checkout/controller/checkout_controller.dart';

class AddressTopButtons extends GetView<CheckoutController> {
  final String address;
  const AddressTopButtons(this.address, {super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Expanded(
          child: InkWell(
              onTap: () {
                controller.changeMode(address);
              },
              child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: (controller.mode.value == address
                        ? Colors.white
                        : context.theme.primaryColor),
                    borderRadius: (address == "New Address"
                        ? const BorderRadius.only(
                            bottomLeft: Radius.circular(12),
                            topLeft: Radius.circular(12))
                        : const BorderRadius.only(
                            bottomRight: Radius.circular(12),
                            topRight: Radius.circular(12))),
                  ),
                  child: Text(
                    address,
                    style: TextStyle(
                        color: (controller.mode.value == address
                            ? Colors.grey[800]
                            : Colors.white),
                        fontSize: 15),
                  ))),
        ));
  }
}
