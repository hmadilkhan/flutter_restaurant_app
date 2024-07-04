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
                style: theme.textTheme.headlineMedium),
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
          if (item['subVariations'] != null) ...{
            for (int i = 0; i < item['subVariations'].length; i++) ...{
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: theme.primaryColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['subVariations'][i]["name"],
                        style: theme.textTheme.headlineSmall?.copyWith(
                            color: Colors.white,
                            backgroundColor: theme.primaryColor),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 10.w,
                ),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['subVariations'][i]["values"]['name'],
                        style: theme.textTheme.headlineSmall?.copyWith(
                          color: theme.colorScheme.secondary,
                        ),
                      ),
                      Text(
                        "PKR ${item['subVariations'][i]["values"]['price'].toString()}",
                        style: theme.textTheme.headlineSmall?.copyWith(
                          color: theme.colorScheme.secondary,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            },
          },
          if (item['addons'] != null) ...{
            for (int i = 0; i < item['addons'].length; i++) ...{
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: theme.primaryColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['addons'][i]["name"],
                        style: theme.textTheme.headlineSmall?.copyWith(
                            color: Colors.white,
                            backgroundColor: theme.primaryColor),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 12.w,
                ),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        item['addons'][i]["values"]['name'],
                        style: theme.textTheme.headlineSmall?.copyWith(
                          color: theme.colorScheme.secondary,
                        ),
                      ),
                      Text(
                        "PKR ${item['subVariations'][i]["values"]['price'].toString()}",
                        style: theme.textTheme.headlineSmall?.copyWith(
                          color: theme.colorScheme.secondary,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            },
          },
        ],
      ),
    );
  }
}
