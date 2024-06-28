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
          ? Column(
              // mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (int i = 0; i < controller.subVariations.length; i++) ...{
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 15.w, top: 0),
                          child: Text(
                            'Choose Your ${controller.subVariations[i]['name']}',
                            style: theme.textTheme.displaySmall,
                          ).animate().fade().slideX(
                                duration: 300.ms,
                                begin: -1,
                                curve: Curves.easeInSine,
                              ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 0.w, right: 15.w),
                          child: ChipsChoice<dynamic>.single(
                            value: controller.tagVariation[i],
                            onChanged: (val) =>
                                {controller.getSubVariation(i, val)},
                            choiceItems: C2Choice.listFrom<int, dynamic>(
                              source: controller.subVariations[i]['values']
                                  .toList(),
                              value: (i, v) => v["id"],
                              label: (i, v) => v['name'],
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
                        const Divider(
                          indent: 15,
                          endIndent: 15,
                          // color: Colors.transparent,
                        ),
                      ])
                }
              ],
            )
          : const Center());

      // return Obx(() => controller.subVariations.isNotEmpty
      //     ? SizedBox(
      //         width: double.infinity,
      //         height: 200.h,
      //         child: ListView.builder(
      //           scrollDirection: Axis.vertical,
      //           physics: const ClampingScrollPhysics(),
      //           itemCount: controller.subVariations.length,
      //           itemBuilder: (context, index) {
      //             final subvariation = controller.subVariations[index];
      //             return Column(
      //               mainAxisSize: MainAxisSize.max,
      //               crossAxisAlignment: CrossAxisAlignment.start,
      //               children: [
      //                 Padding(
      //                   padding: EdgeInsets.only(left: 24.w, top: 0),
      //                   child: Text(
      //                     'Choose Your ${subvariation['name']}',
      //                     style: theme.textTheme.displayLarge,
      //                   ).animate().fade().slideX(
      //                         duration: 300.ms,
      //                         begin: -1,
      //                         curve: Curves.easeInSine,
      //                       ),
      //                 ),
      //                 Padding(
      //                   padding: EdgeInsets.only(left: 24.w, top: 0),
      //                   child: ChipsChoice<dynamic>.single(
      //                     value: controller.tag.value,
      //                     onChanged: (val) => {},
      //                     choiceItems: C2Choice.listFrom<int, dynamic>(
      //                       source: subvariation['values'].toList(),
      //                       value: (i, v) => v["id"],
      //                       label: (i, v) => v['name'],
      //                       tooltip: (i, v) => v['name'],
      //                     ),
      //                     choiceCheckmark: true,
      //                     choiceStyle: C2ChipStyle.filled(
      //                       // color: theme.primaryColor,
      //                       padding: const EdgeInsets.all(5),
      //                       foregroundStyle: const TextStyle(fontSize: 17),
      //                       selectedStyle: C2ChipStyle(
      //                         borderRadius: const BorderRadius.all(
      //                           Radius.circular(25),
      //                         ),
      //                         backgroundColor: theme.primaryColor,
      //                         // borderColor: theme.primaryColor,
      //                         // foregroundColor: theme.primaryColor,
      //                       ),
      //                     ),
      //                   ).animate().fade().slideX(
      //                         duration: 300.ms,
      //                         begin: -1,
      //                         curve: Curves.easeInSine,
      //                       ),
      //                 )
      //               ],
      //             );
      //           },
      //         ),
      //       )
      //     : const Center());
    });
  }
}
