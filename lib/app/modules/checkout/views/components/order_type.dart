import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_app/app/modules/checkout/controller/checkout_controller.dart';

class OrderType extends GetView<CheckoutController> {
  const OrderType({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Container(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: ListTile(
            leading: const Icon(Icons.maps_home_work_outlined),
            title: const Text("Select Your Order Type"),
            subtitle: Obx(() => Text(controller.orderType.value)),
            trailing: GestureDetector(
              onTap: () {
                controller.showOrderType(context);
              },
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  VerticalDivider(
                    color: Color.fromARGB(255, 245, 244, 244),
                    thickness: 2,
                  ),
                  Icon(Icons.arrow_forward_ios_outlined),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
