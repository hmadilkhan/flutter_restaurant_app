import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:grocery_app/app/modules/product_details/controllers/product_details_controller.dart';

class SubVariation extends StatelessWidget {
  final ProductDetailsController controller;
  const SubVariation({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return GetBuilder<ProductDetailsController>(builder: (controller) {
      return Obx(() => controller.subVariations.isNotEmpty
          ? SizedBox(
              width: double.infinity,
              height: 50.h,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 24.w, top: 0),
                    child: Text(
                      'Choose Your ',
                      style: theme.textTheme.displayLarge,
                    ).animate().fade().slideX(
                          duration: 300.ms,
                          begin: -1,
                          curve: Curves.easeInSine,
                        ),
                  ),
                ],
              ),
            )
          : const Center());
    });
  }
}
