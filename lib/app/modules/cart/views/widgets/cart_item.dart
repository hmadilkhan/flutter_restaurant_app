import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../components/product_count_item.dart';
import '../../../../data/models/product_model.dart';
import '../../controllers/cart_controller.dart';

class CartItem extends GetView<CartController> {
  final ProductModel product;
  const CartItem({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.w),
      child: ListTile(
        leading: Image.network(
            "https://sabify.sabsoft.com.pk/api/website/image/${product.image}/prod",
            width: 60.w,
            height: 60.h),
        title: Text(product.name ?? 'No Name',
            style: theme.textTheme.headlineSmall),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${product.price} PKR',
              style: theme.textTheme.headlineSmall?.copyWith(
                color: theme.colorScheme.secondary,
              ),
            ),
            ProductCountItem(product: product)
          ],
        ),
        // trailing: Icon(
        //   Icons.delete,
        //   color: Colors.red,
        // ),
      ),
    );
    // return Padding(
    //   padding: EdgeInsets.symmetric(horizontal: 24.w),
    //   child: Row(
    //     crossAxisAlignment: CrossAxisAlignment.center,
    //     children: [
    //       Image.network(
    //           "https://sabify.sabsoft.com.pk/api/website/image/${product.image}/prod",
    //           width: 50.w,
    //           height: 40.h),
    //       16.horizontalSpace,
    //       Column(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [
    //           Text(product.name ?? 'No Name',
    //               style: theme.textTheme.headlineSmall),
    //           5.verticalSpace,
    //           Text(
    //             '1kg, ${product.price}\$',
    //             style: theme.textTheme.headlineSmall?.copyWith(
    //               color: theme.colorScheme.secondary,
    //             ),
    //           ),
    //         ],
    //       ),
    //       const Spacer(),
    //       ProductCountItem(product: product),
    //     ],
    //   ),
    // );
  }
}
