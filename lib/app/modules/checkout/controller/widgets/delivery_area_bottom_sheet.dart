import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:grocery_app/app/modules/checkout/controller/checkout_controller.dart';

class DeliveryAreaBottomSheet extends GetView<CheckoutController> {
  const DeliveryAreaBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(8.0),
        width: MediaQuery.of(context).size.width * 0.95,
        height: MediaQuery.of(context).size.height * 0.4,
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
              Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: const Text(
                    "Please Select Delivery Area",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Colors.black),
                  ),
                ),
              ),
              const Divider(),
              SizedBox(
                height: 200,
                child: ListView.builder(
                  restorationId: 'deliveryAreaListView',
                  itemCount: controller.areas.length,
                  itemBuilder: (BuildContext context, int index) {
                    final item = controller.areas[index];
                    return Obx(
                      () => RadioListTile(
                        title: Text(item),
                        onChanged: (value) {
                          controller.onChangeDeliveryArea(value);
                        },
                        value: item,
                        groupValue: controller.deliveryAreaName.value,
                      ),
                    );
                  },
                ),
              ),
            ]));
  }
}
