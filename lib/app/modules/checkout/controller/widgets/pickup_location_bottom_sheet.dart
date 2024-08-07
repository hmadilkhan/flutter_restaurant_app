import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:grocery_app/app/modules/checkout/controller/checkout_controller.dart';
import 'package:grocery_app/app/modules/home/controllers/home_controller.dart';

class PickupLocationBottomSheet extends GetView<CheckoutController> {
  const PickupLocationBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>();
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
                    "Select Your Pickup Location",
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
                  restorationId: 'addressListView',
                  itemCount: homeController.branches.length,
                  itemBuilder: (BuildContext context, int index) {
                    final item = homeController.branches[index];
                    return Obx(
                      () => RadioListTile(
                        title: Text(item["branch_name"]),
                        onChanged: (value) {
                          print("branch Value : $value");
                          controller.changePickupBranch(item);
                        },
                        value: item["branch_name"],
                        groupValue: controller.pickupBranchName.value,
                      ),
                    );
                  },
                ),
              ),
            ]));
  }
}
