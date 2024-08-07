import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_app/app/modules/cart/controllers/cart_controller.dart';
import 'package:grocery_app/app/modules/checkout/controller/checkout_controller.dart';

class BottomView extends GetView<CheckoutController> {
  const BottomView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Container(
      padding: const EdgeInsets.all(5.0),
      decoration: const BoxDecoration(color: Colors.white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Text("Total Amount : ",
                  style: TextStyle(fontSize: 15, color: Colors.black)),
              Text(
                  "Rs. ${Get.find<CartController>().subTotalCartAmount.toStringAsFixed(2)}",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: theme.primaryColor)),
            ],
          ),
          ElevatedButton(
              onPressed: () {
                controller.placeOrder();
              },
              child: const Padding(
                padding: EdgeInsets.all(5.0),
                child: Text(
                  "Place Order",
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
              ))
        ],
      ),
    );
  }
}
