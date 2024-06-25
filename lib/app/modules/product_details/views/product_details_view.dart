import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:grocery_app/app/components/sub_variation.dart';
import 'package:grocery_app/app/data/models/variation_model.dart';

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
    int? _value = 1;
    int tag = 3;
    List<String> options = [
      'News',
      'Entertainment',
      'Politics',
      'Automotive',
      'Sports',
      'Education',
      'Fashion',
      'Travel',
      'Food',
      'Tech',
      'Science',
    ];
    List<Map<String, dynamic>> optionsMultiple = [
      {
        "id": 1,
        "name": "Onions",
      },
      {
        "id": 2,
        "name": "Tomotoes",
      },
      {
        "id": 3,
        "name": "Jalepeno",
      },
      {
        "id": 4,
        "name": "Mushroom",
      },
    ];
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
                  Text(
                    '${controller.product.price} PKR',
                    style: theme.textTheme.displaySmall?.copyWith(
                      color: theme.colorScheme.secondary,
                    ),
                  ).animate().fade().slideX(
                        duration: 300.ms,
                        begin: -1,
                        curve: Curves.easeInSine,
                      ),
                  const Spacer(),
                  // ProductCountItem(product: controller.product)
                  //     .animate()
                  //     .fade(duration: 200.ms),
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(
                  () => controller.variations.isNotEmpty
                      ? Padding(
                          padding: EdgeInsets.only(left: 15.w, top: 0),
                          child: Text(
                            'Choose Your Preference',
                            style: theme.textTheme.displaySmall,
                          ).animate().fade().slideX(
                                duration: 300.ms,
                                begin: -1,
                                curve: Curves.easeInSine,
                              ),
                        )
                      : const Center(),
                ),
                // 10.verticalSpace,
                Obx(
                  () => controller.variations.isNotEmpty
                      ? Padding(
                          padding: EdgeInsets.only(left: 0.w, right: 15.w),
                          child: ChipsChoice<dynamic>.single(
                            value: controller.tag.value,
                            onChanged: (val) =>
                                {controller.getSelectionChange(val)},
                            choiceItems: C2Choice.listFrom<int, dynamic>(
                              source: controller.variations,
                              value: (i, v) => v['id'],
                              label: (i, v) => v['name'],
                              tooltip: (i, v) => v['name'],
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
                const Divider(
                  indent: 15,
                  endIndent: 15,
                  // color: Colors.transparent,
                ),
              ],
            ),
            SubVariation(controller: controller),

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
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 24.w),
            //   child: SizedBox(
            //     width: double.infinity,
            //     height: 200.h,
            //     child: ListView.builder(
            //         scrollDirection: Axis.horizontal,
            //         physics: const ClampingScrollPhysics(),
            //         shrinkWrap: true,
            //         itemCount: controller.product.variations?.length,
            //         itemBuilder: (context, index) {
            //           var name = controller.product.variations?[index].name;
            //           return Obx(() => Padding(
            //                 padding: const EdgeInsets.all(4.0),
            //                 child: ChoiceChip(
            //                   label: Text(name ?? ''),
            //                   selectedColor: theme.primaryColor,
            //                   checkmarkColor: theme.scaffoldBackgroundColor,
            //                   labelPadding: const EdgeInsets.all(5.0),
            //                   labelStyle: TextStyle(
            //                       fontSize: 16,
            //                       color:
            //                           (controller.selectedIndex.value == index
            //                               ? Colors.white
            //                               : Colors.black)),
            //                   selected: controller.selectedIndex.value == index,
            //                   backgroundColor: Colors.white,
            //                   showCheckmark: true,
            //                   onSelected: (bool selected) {
            //                     controller.getSelectionChange(index);
            //                   },
            //                 ),
            //               ));
            //         }),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
