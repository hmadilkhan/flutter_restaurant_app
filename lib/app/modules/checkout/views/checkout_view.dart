import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_app/app/modules/checkout/components/checkout_app_bar.dart';
import 'package:grocery_app/app/modules/checkout/controller/checkout_controller.dart';

class CheckoutView extends GetView<CheckoutController> {
  const CheckoutView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 245, 244, 244),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: theme.scaffoldBackgroundColor,
        title: const CheckoutAppBar(),
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          const SizedBox(
            height: 2,
          ),
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: ListTile(
              leading: const Icon(Icons.maps_home_work_outlined),
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
                    () => Text(
                      controller.address.toString(),
                      style: const TextStyle(fontFamily: 'Cairo'),
                    ),
                  ),
                ],
              ),
              trailing: GestureDetector(
                onTap: () {
                  controller.showAddresses(context);
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
      ),
    );
  }
}
