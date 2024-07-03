import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../components/product_count_item.dart';
import '../../../../data/models/product_model.dart';
import '../../controllers/cart_controller.dart';

class CartItemList extends GetView<CartController> {
  var item;
  CartItemList({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    print(item);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: Image.network(
                "https://sabify.sabsoft.com.pk/api/website/image/${item["image"]}/prod",
                width: 60.w,
                height: 60.h),
            title: Text(item["name"] ?? 'No Name',
                style: theme.textTheme.headlineSmall),
            subtitle: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${item["price"]} PKR',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    color: theme.colorScheme.secondary,
                  ),
                ),
                // ProductCountItem(product: product)
              ],
            ),
          ),
          SizedBox(
            height: 15,
            child: ListView.builder(
                itemCount: item['variations'].length,
                itemBuilder: (context, index) {
                  final variation = item['variations'][index];
                  // print(" Print : ${variation[index]}");
                  return Text(variation["name"]);
                }),
          ),
          SizedBox(
            height: 15,
            child: ListView.builder(
                itemCount: item['addons'].length,
                itemBuilder: (context, index) {
                  final addon = item['addons'][index];
                  // print(" Print : ${variation[index]}");
                  return Text(addon["name"]);
                }),
          ),
        ],
      ),
    );
  }
}
