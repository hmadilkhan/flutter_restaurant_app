import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:grocery_app/app/modules/product_details/controllers/product_details_controller.dart';
import 'package:grocery_app/app/widgets/addon_widget.dart';

class Addon extends StatelessWidget {
  const Addon({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return GetBuilder<ProductDetailsController>(builder: (controller) {
      return Obx(() => controller.addons.isNotEmpty
          ? Column(
              // mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 15.w, top: 0),
                  child: Text(
                    'Addons',
                    style: theme.textTheme.displayLarge,
                  ).animate().fade().slideX(
                        duration: 300.ms,
                        begin: -1,
                        curve: Curves.easeInSine,
                      ),
                ),
                15.verticalSpace,
                for (int i = 0; i < controller.addons.length; i++) ...{
                  AddonWidget(index: i)
                }
              ],
            )
          : const Center());
    });
  }
}
