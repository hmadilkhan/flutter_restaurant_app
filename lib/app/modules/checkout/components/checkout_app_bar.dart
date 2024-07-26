import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:grocery_app/app/components/custom_icon_button.dart';
import 'package:grocery_app/utils/constants.dart';

class CheckoutAppBar extends StatelessWidget {
  const CheckoutAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomIconButton(
            onPressed: () => Get.back(),
            backgroundColor: theme.scaffoldBackgroundColor,
            borderColor: theme.dividerColor,
            icon: SvgPicture.asset(
              Constants.backArrowIcon,
              fit: BoxFit.none,
              color: theme.appBarTheme.iconTheme?.color,
            ),
          ),
          Text('Checkout', style: theme.textTheme.displaySmall),
          CustomIconButton(
            backgroundColor: theme.scaffoldBackgroundColor,
            borderColor: Colors.transparent,
            onPressed: () {},
            icon: null,
          ),
        ],
      ),
    );
  }
}
