import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:grocery_app/app/modules/checkout/controller/checkout_controller.dart';
import 'package:grocery_app/app/modules/checkout/controller/widgets/address_main_container.dart';
import 'package:grocery_app/app/modules/checkout/controller/widgets/main_address.dart';

class AddressBottomSheet extends GetView<CheckoutController> {
  const AddressBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(8.0),
        width: MediaQuery.of(context).size.width * 0.95,
        height: MediaQuery.of(context).size.height * 0.6,
        decoration: BoxDecoration(
          color: context.theme.scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(30.0)),
        ),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 120.w),
                child: const Divider(
                  color: Color.fromARGB(255, 218, 216, 216),
                  thickness: 5,
                ),
              ),
              SizedBox(height: 20.w),
              const AddressMainContainer(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 36.w, vertical: 5.h),
                child: const Divider(),
              ),
              const MainAddress(),
            ]));
  }
}
