import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_app/app/modules/checkout/controller/checkout_controller.dart';

class CustomerAddress extends GetView<CheckoutController> {
  const CustomerAddress({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
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
            leading: const Icon(
              Icons.person_search_outlined,
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  controller.username.toString(),
                  style: theme.textTheme.labelLarge,
                  softWrap: true,
                ),
              ],
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  controller.mobile.toString(),
                  style: theme.textTheme.labelLarge,
                ),
                Obx(
                  () => controller.orderType.value == "Delivery"
                      ? Text(
                          controller.address.value,
                          style: const TextStyle(fontFamily: 'Cairo'),
                        )
                      : const Center(),
                ),
              ],
            ),
            trailing: GestureDetector(
              onTap: () {
                if (controller.orderType.value == "Delivery") {
                  controller.showAddresses(context);
                }
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
        )
      ],
    );
  }
}
