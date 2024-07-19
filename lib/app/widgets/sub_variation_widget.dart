import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:grocery_app/app/modules/product_details/controllers/product_details_controller.dart';

class SubVariationWidget extends StatelessWidget {
  final int index;
  const SubVariationWidget({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return GetBuilder<ProductDetailsController>(builder: (controller) {
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: EdgeInsets.only(left: 15.w, top: 0),
          child: Text(
            'Choose Your ${controller.subVariations[index]['name']}',
            style: theme.textTheme.displaySmall,
          ).animate().fade().slideX(
                duration: 300.ms,
                begin: -1,
                curve: Curves.easeInSine,
              ),
        ),
        Obx(
          () => Padding(
            padding: EdgeInsets.only(left: 0.w, right: 15.w),
            child: ChipsChoice<dynamic>.single(
              value: controller.tagVariation[index],
              onChanged: (val) => {
                controller.getSubVariation(
                    controller.subVariations[index], index, val)
              },
              choiceItems: C2Choice.listFrom<int, dynamic>(
                source: controller.subVariations[index]['values'].toList(),
                value: (i, v) => v["id"],
                label: (i, v) =>
                    v['name'] + (v['price'] != 0 ? " - Rs. ${v['price']}" : ''),
                tooltip: (i, v) => v['name'],
              ),
              choiceCheckmark: true,
              choiceStyle: C2ChipStyle.filled(
                height: 45,
                padding: const EdgeInsets.all(10),
                foregroundStyle: const TextStyle(fontSize: 17),
                selectedStyle: C2ChipStyle(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(30),
                  ),
                  backgroundColor: theme.primaryColor,
                ),
              ),
            ).animate().fade().slideX(
                  duration: 700.ms,
                  begin: -1,
                  curve: Curves.easeInSine,
                ),
          ),
        ),
        const Divider(
          indent: 15,
          endIndent: 15,
          // color: Colors.transparent,
        ),
      ]);
    });
  }
}
