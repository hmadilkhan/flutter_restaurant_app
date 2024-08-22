import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:grocery_app/app/components/product_cart_count.dart';
import '../../controllers/cart_controller.dart';

class CartItemList extends GetView<CartController> {
  final item;
  final index;
  const CartItemList({super.key, required this.item, required this.index});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          leading: Image.network(
              "https://sabify.sabsoft.com.pk/api/website/image/${item.image}/prod",
              width: 80.w,
              height: 80.h),
          title: Text(item.name ?? 'No Name',
              style: theme.textTheme.headlineMedium),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(
                    () => Text(
                      '${controller.value.format(item.amount)} PKR',
                      style: theme.textTheme.headlineSmall?.copyWith(
                        color: theme.colorScheme.secondary,
                      ),
                    ),
                  ),
                  ProductCartCount(item: item, index: index),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5.w),
                child: GestureDetector(
                  onTap: () {
                    print(json.encode(item));
                    controller.showBottomDialog(context, item);
                  },
                  child: !item.subVariations.isEmpty || !item.deals.isEmpty
                      ? Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "View Details ",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[500]),
                              maxLines: 1,
                            ),
                            Icon(Icons.arrow_circle_down,
                                color: Colors.grey[500]),
                          ],
                        )
                      : const Center(),
                ),
              ),
            ],
          ),
        ),
        // if (item.subVariations != null) ...{
        //   for (int i = 0; i < item.subVariations.length; i++) ...{
        //     Padding(
        //       padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
        //       child: Container(
        //         width: double.infinity,
        //         padding: const EdgeInsets.all(10),
        //         decoration: BoxDecoration(
        //             shape: BoxShape.rectangle,
        //             color: theme.primaryColor,
        //             borderRadius: BorderRadius.circular(10)),
        //         child: Column(
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           children: [
        //             Text(
        //               item.subVariations[i]["name"].toString(),
        //               style: theme.textTheme.headlineSmall?.copyWith(
        //                   color: Colors.white,
        //                   backgroundColor: theme.primaryColor),
        //             ),
        //           ],
        //         ),
        //       ),
        //     ),
        //     Padding(
        //       padding: EdgeInsets.symmetric(
        //         horizontal: 10.w,
        //       ),
        //       child: Container(
        //         width: double.infinity,
        //         padding: const EdgeInsets.all(2),
        //         child: Row(
        //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //           children: [
        //             Text(
        //               item.subVariations[i]["values"]['name'],
        //               style: theme.textTheme.headlineSmall?.copyWith(
        //                 color: theme.colorScheme.secondary,
        //               ),
        //             ),
        //             Text(
        //               "PKR ${item.subVariations[i]["values"]['price'].toString()}",
        //               style: theme.textTheme.headlineSmall?.copyWith(
        //                 color: theme.colorScheme.secondary,
        //               ),
        //             ),
        //           ],
        //         ),
        //       ),
        //     )
        //   },
        // },
        // if (item.addons != null) ...{
        //   for (int i = 0; i < item.addons.length; i++) ...{
        //     Padding(
        //       padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
        //       child: Container(
        //         width: double.infinity,
        //         padding: const EdgeInsets.all(10),
        //         decoration: BoxDecoration(
        //             shape: BoxShape.rectangle,
        //             color: theme.primaryColor,
        //             borderRadius: BorderRadius.circular(10)),
        //         child: Column(
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           children: [
        //             Text(
        //               item.addons[i]["name"],
        //               style: theme.textTheme.headlineSmall?.copyWith(
        //                   color: Colors.white,
        //                   backgroundColor: theme.primaryColor),
        //             ),
        //           ],
        //         ),
        //       ),
        //     ),
        //     Padding(
        //       padding: EdgeInsets.symmetric(
        //         horizontal: 12.w,
        //       ),
        //       child: Container(
        //         width: double.infinity,
        //         padding: const EdgeInsets.all(2),
        //         child: Row(
        //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //           children: [
        //             Text(
        //               item.addons[i]["values"]['name'],
        //               style: theme.textTheme.headlineSmall?.copyWith(
        //                 color: theme.colorScheme.secondary,
        //               ),
        //             ),
        //             Text(
        //               "PKR ${item.subVariations[i]["values"]['price'].toString()}",
        //               style: theme.textTheme.headlineSmall?.copyWith(
        //                 color: theme.colorScheme.secondary,
        //               ),
        //             ),
        //           ],
        //         ),
        //       ),
        //     )
        //   },
        // },
      ],
    );
  }
}
