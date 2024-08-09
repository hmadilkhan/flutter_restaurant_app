import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_app/app/modules/checkout/controller/checkout_controller.dart';

class AddressList extends GetView<CheckoutController> {
  const AddressList({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.addresses.isNotEmpty
        ? Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.35,
                child: ListView.builder(
                  restorationId: 'addressListView',
                  itemCount: controller.addresses.length,
                  itemBuilder: (BuildContext context, int index) {
                    final item = controller.addresses[index];
                    return RadioListTile(
                        title: Text(item["landmark"]),
                        subtitle: Text(item["address"]),
                        // leading: const Icon(Icons.home),
                        onChanged: (value) {
                          controller.address.value = value["address"];
                          controller.landmark.value = value["landmark"];
                          print(controller.landmark.value);
                        },
                        value: item,
                        groupValue: controller.address);
                  },
                ),
              ),
            ],
          )
        : const Center(
            child: Text("List has no addresses"),
          ));
  }
}
