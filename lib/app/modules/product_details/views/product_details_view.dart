import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:grocery_app/app/modules/product_details/components/Addon.dart';
import 'package:grocery_app/app/modules/product_details/components/deal_variation.dart';
import 'package:grocery_app/app/modules/product_details/components/sub_variation.dart';
import 'package:grocery_app/app/data/models/variation_model.dart';
import 'package:grocery_app/app/widgets/deal_widget.dart';
import 'package:grocery_app/app/widgets/variation_widget.dart';

import '../../../../utils/constants.dart';
import '../../../../utils/dummy_helper.dart';
import '../../../components/custom_button.dart';
import '../../../components/custom_card.dart';
import '../../../components/custom_icon_button.dart';
import '../../../components/product_count_item.dart';
import '../controllers/product_details_controller.dart';

class ProductDetailsView extends GetView<ProductDetailsController> {
  const ProductDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            SizedBox(
              height: 330.h,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                                  "https://sabify.sabsoft.com.pk/api/website/image/${controller.product.image}/prod"),
                              fit: BoxFit.cover)),
                    ).animate().fade().scale(
                          duration: 1000.ms,
                          curve: Curves.fastOutSlowIn,
                        ),
                  ),
                  Positioned(
                    top: 24.h,
                    left: 24.w,
                    right: 24.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomIconButton(
                          onPressed: () => Get.back(),
                          backgroundColor: theme.scaffoldBackgroundColor,
                          icon: SvgPicture.asset(
                            Constants.backArrowIcon,
                            fit: BoxFit.none,
                            color: theme.appBarTheme.iconTheme?.color,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            30.verticalSpace,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: Text(
                controller.product.name ?? '',
                style: theme.textTheme.displayMedium,
              ).animate().fade().slideX(
                    duration: 300.ms,
                    begin: -1,
                    curve: Curves.easeInSine,
                  ),
            ),
            8.verticalSpace,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: Row(
                children: [
                  Obx(
                    () => Text(
                      '${controller.price} PKR',
                      style: theme.textTheme.displaySmall?.copyWith(
                        color: theme.colorScheme.secondary,
                      ),
                    ).animate().fade().slideX(
                          duration: 300.ms,
                          begin: -1,
                          curve: Curves.easeInSine,
                        ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
            8.verticalSpace,
            Padding(
              padding: EdgeInsets.only(left: 15.w, top: 0),
              child: Text(
                controller.product.description ?? 'No Description',
                style: theme.textTheme.bodyLarge,
              ).animate().fade().slideX(
                    duration: 300.ms,
                    begin: -1,
                    curve: Curves.easeInSine,
                  ),
            ),
            10.verticalSpace,
            const VariationWidget(),
            SubVariation(controller: controller),
            DealVariation(controller: controller),
            const Addon(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: CustomButton(
                text: 'Add to cart',
                onPressed: () => controller.onAddToCartPressed(),
                fontSize: 16.sp,
                radius: 50.r,
                verticalPadding: 16.h,
                hasShadow: false,
              ).animate().fade().slideY(
                    duration: 300.ms,
                    begin: 1,
                    curve: Curves.easeInSine,
                  ),
            ),
            30.verticalSpace,
          ],
        ),
      ),
    );
  }
}
