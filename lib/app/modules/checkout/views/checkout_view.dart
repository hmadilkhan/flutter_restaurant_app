import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/app/modules/checkout/components/checkout_app_bar.dart';
import 'package:grocery_app/app/modules/checkout/controller/checkout_controller.dart';
import 'package:grocery_app/app/modules/checkout/views/components/bottom_view.dart';
import 'package:grocery_app/app/modules/checkout/views/components/customer_address.dart';
import 'package:grocery_app/app/modules/checkout/views/components/delivery.dart';
import 'package:grocery_app/app/modules/checkout/views/components/order_summary.dart';
import 'package:grocery_app/app/modules/checkout/views/components/order_type.dart';
import 'package:grocery_app/app/modules/checkout/views/components/pickup.dart';
import 'package:grocery_app/app/modules/checkout/views/components/promo_code.dart';

class CheckoutView extends GetView<CheckoutController> {
  const CheckoutView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 245, 244, 244),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: theme.scaffoldBackgroundColor,
          title: const CheckoutAppBar(),
        ),
        body: ListView(
          scrollDirection: Axis.vertical,
          children: const [
            OrderType(),
            Delivery(),
            CustomerAddress(),
            Pickup(),
            PromoCode(),
            OrderSummary(),
          ],
        ),
        bottomNavigationBar: const BottomView());
  }
}
