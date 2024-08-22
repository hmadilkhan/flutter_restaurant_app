import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:grocery_app/app/modules/product_details/controllers/product_details_controller.dart';

class DealAddon extends StatefulWidget {
  final index;
  final deal;
  const DealAddon({super.key, this.index, this.deal});

  @override
  State<DealAddon> createState() => _DealAddonState();
}

class _DealAddonState extends State<DealAddon> {
  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final controller = Get.put(ProductDetailsController());
    print(widget.deal);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.deal.isNotEmpty
            ? Padding(
                padding: EdgeInsets.only(left: 15.w, top: 0),
                child: Text(
                  'Addons',
                  style: theme.textTheme.displaySmall,
                ).animate().fade().slideX(
                      duration: 300.ms,
                      begin: -1,
                      curve: Curves.easeInSine,
                    ),
              )
            : const Center(),
        widget.deal.isNotEmpty
            ? Padding(
                padding: EdgeInsets.only(left: 0.w, right: 15.w),
                child: ChipsChoice<dynamic>.single(
                  value: controller.tagDeals[widget.index],
                  onChanged: (val) {
                    controller.dealSelection(
                        controller.deals[widget.index], widget.index, val);
                  },
                  choiceItems: C2Choice.listFrom<int, dynamic>(
                    source: widget.deal[0]['values'].toList(),
                    value: (i, v) => v['id'],
                    label: (i, v) => (v['name'] ?? 'No Name'),
                    tooltip: (i, v) => (v['name'] ?? 'No Name'),
                  ),
                  choiceCheckmark: true,
                  choiceStyle: C2ChipStyle.filled(
                    height: 30,
                    foregroundStyle: const TextStyle(fontSize: 15),
                    selectedStyle: C2ChipStyle(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(15),
                      ),
                      backgroundColor: theme.primaryColor,
                    ),
                  ),
                ),
              )
            : const Center(),
      ],
    );
  }
}
