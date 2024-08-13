import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:grocery_app/app/modules/product_details/controllers/product_details_controller.dart';
import 'package:grocery_app/app/widgets/deal_widget.dart';

class DealVariation extends StatelessWidget {
  final ProductDetailsController controller;
  const DealVariation({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductDetailsController>(builder: (controller) {
      return Obx(() => controller.deals.isNotEmpty
          ? Column(
              // mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (int i = 0; i < controller.deals.length; i++) ...{
                  DealWidget(index: i)
                }
              ],
            )
          : const Center());
    });
  }
}
