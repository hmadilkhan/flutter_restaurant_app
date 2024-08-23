import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:grocery_app/app/modules/product_details/controllers/product_details_controller.dart';
import 'package:grocery_app/app/widgets/deal_addon.dart';

class DealWidget extends GetView<ProductDetailsController> {
  final int index;
  const DealWidget({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    var mainId = 0;
    List<dynamic> variationAddons;
    final Map<String, dynamic> data = controller.deals[index];
    // Ensure that 'values' is treated as a List
    List<dynamic> valuesList = (data['values'] as Iterable).toList();
    // Accessing the addons  list from the first element in 'values'
    variationAddons = (valuesList[0]['addons'] as Iterable).toList();
    return GetBuilder<ProductDetailsController>(builder: (controller) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(
            () => controller.deals.isNotEmpty
                ? Padding(
                    padding: EdgeInsets.only(left: 15.w, top: 0),
                    child: Text(
                      'Choose Your ${controller.deals[index]['name']}',
                      style: theme.textTheme.displaySmall,
                    ).animate().fade().slideX(
                          duration: 300.ms,
                          begin: -1,
                          curve: Curves.easeInSine,
                        ),
                  )
                : const Center(),
          ),
          Obx(
            () => controller.deals.isNotEmpty
                ? Padding(
                    padding: EdgeInsets.only(left: 0.w, right: 15.w),
                    child: ChipsChoice<dynamic>.single(
                      value: controller.tagDeals[index],
                      onChanged: (val) => {
                        controller.dealSelection(
                            controller.deals[index], index, val),
                      },
                      choiceItems: C2Choice.listFrom<int, dynamic>(
                        source: controller.deals[index]['values'].toList(),
                        value: (i, v) => v['id'],
                        label: (i, v) => (v['name'] ?? 'No Name'),
                        tooltip: (i, v) => (v['name'] ?? 'No Name'),
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
                    ),
                  )
                : const Center(),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(variationAddons.length, (i) {
              return DealAddon(
                  index: index,
                  addon: variationAddons[i],
                  variationId: controller.deals[index]['id'],
                  deal: controller.deals[index]['values'],
                  mainId: mainId);
            }),
          ),
          const Divider(
            indent: 15,
            endIndent: 15,
            // color: Colors.transparent,
          ),
        ],
      );
    });
  }
}
