import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:grocery_app/app/components/custom_icon_button.dart';
import 'package:grocery_app/app/modules/checkout/components/checkout_app_bar.dart';
import 'package:grocery_app/app/modules/checkout/controller/checkout_controller.dart';
import 'package:grocery_app/utils/constants.dart';

class CheckoutView extends GetView<CheckoutController> {
  const CheckoutView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 238, 236, 236),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: theme.scaffoldBackgroundColor,
        title: const CheckoutAppBar(),
      ),
      body: Center(
        child: Text("Checkout View"),
      ),
    );
  }
}
