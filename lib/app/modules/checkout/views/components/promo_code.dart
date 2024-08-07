import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_app/app/modules/checkout/controller/checkout_controller.dart';

class PromoCode extends GetView<CheckoutController> {
  const PromoCode({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Column(children: [
      const SizedBox(
        height: 10,
      ),
      Container(
        padding: const EdgeInsets.all(10.0),
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: TextFormField(
          style: theme.textTheme.labelLarge,
          decoration: InputDecoration(
              hintText: "Apply Voucher",
              filled: true,
              fillColor: const Color.fromARGB(255, 245, 244, 244),
              enabledBorder: OutlineInputBorder(
                gapPadding: 4.0,
                borderRadius: BorderRadius.circular(5),
                borderSide: const BorderSide(
                  color: Colors.white,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: const BorderSide(
                  color: Colors.white,
                ),
              ),
              suffixIcon: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text(
                    "APPLY",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )),
        ),
      )
    ]);
  }
}
