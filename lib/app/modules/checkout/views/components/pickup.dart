import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_app/app/modules/checkout/controller/checkout_controller.dart';

class Pickup extends GetView<CheckoutController> {
  const Pickup({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.orderType.value == "Pickup"
        ? Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: ListTile(
                  leading: const Icon(Icons.directions_bike_outlined),
                  title: const Text("Select Your Pickup Location"),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(() => Text(controller.pickupBranchName.value)),
                      Obx(() => Text(controller.pickupBranchAddress.value))
                    ],
                  ),
                  trailing: GestureDetector(
                    onTap: () {
                      controller.showPickupLocations(context);
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
          )
        : const Center());
  }
}
