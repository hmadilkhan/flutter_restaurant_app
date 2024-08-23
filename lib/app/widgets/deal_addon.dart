import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:grocery_app/app/modules/product_details/controllers/product_details_controller.dart';

class DealAddon extends StatefulWidget {
  final int index;
  final int variationId;
  final dynamic addon;
  final dynamic deal;
  final int mainId;
  const DealAddon(
      {super.key,
      required this.index,
      this.addon,
      required this.variationId,
      required this.mainId,
      this.deal});

  @override
  State<DealAddon> createState() => _DealAddonState();
}

class _DealAddonState extends State<DealAddon> {
  int tag = 0;
  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final controller = Get.put(ProductDetailsController());
    print(widget.mainId);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.addon.isNotEmpty
            ? Padding(
                padding: EdgeInsets.only(left: 15.w, top: 0),
                child: Text(
                  '${widget.addon["name"]} (Addons)',
                  style: theme.textTheme.displaySmall,
                ).animate().fade().slideX(
                      duration: 300.ms,
                      begin: -1,
                      curve: Curves.easeInSine,
                    ),
              )
            : const Center(),
        widget.addon.isNotEmpty
            ? Padding(
                padding: EdgeInsets.only(left: 0.w, right: 15.w),
                child: ChipsChoice<dynamic>.single(
                  value: tag,
                  onChanged: (val) {
                    controller.dealAddonSelection(
                        widget.addon,
                        widget.addon["id"],
                        val,
                        widget.variationId,
                        widget.deal);
                    setState(() {
                      tag = val;
                    });
                  },
                  choiceItems: C2Choice.listFrom<int, dynamic>(
                    source: widget.addon['values'].toList(),
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
