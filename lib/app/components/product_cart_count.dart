import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:grocery_app/app/modules/cart/controllers/cart_controller.dart';

import '../../utils/constants.dart';
import '../modules/base/controllers/base_controller.dart';
import 'custom_icon_button.dart';

class ProductCartCount extends GetView<BaseController> {
  var item;
  var index;
  ProductCartCount({super.key, required this.item, required this.index});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final CartController cartController = CartController();
    return Row(
      children: [
        CustomIconButton(
          width: 36.w,
          height: 36.h,
          onPressed: () => {
            cartController.decreaseQuantity(item, context),
          },
          icon: SvgPicture.asset(
            Constants.removeIcon,
            fit: BoxFit.none,
          ),
          backgroundColor: theme.cardColor,
        ),
        16.horizontalSpace,
        GetBuilder<CartController>(
          id: 'ProductQuantity',
          builder: (baseController) => Obx(
            () => Text(
              item.quantity.value.toString(),
              style: theme.textTheme.headlineMedium,
            ),
          ),
        ),
        16.horizontalSpace,
        CustomIconButton(
          width: 36.w,
          height: 36.h,
          onPressed: () => {
            cartController.increaseQuantity(item),
          },
          icon: SvgPicture.asset(
            Constants.addIcon,
            fit: BoxFit.none,
          ),
          backgroundColor: theme.primaryColor,
        ),
      ],
    );
  }
}
