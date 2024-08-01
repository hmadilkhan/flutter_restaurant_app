import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:grocery_app/app/modules/cart/views/widgets/cart_items_list.dart';

import '../../../../utils/constants.dart';
import '../../../components/custom_button.dart';
import '../../../components/custom_icon_button.dart';
import '../../../components/no_data.dart';
import '../controllers/cart_controller.dart';

class CartView extends GetView<CartController> {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 238, 236, 236),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: theme.scaffoldBackgroundColor,
        title: Container(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          width: double.infinity,
          decoration: BoxDecoration(color: theme.scaffoldBackgroundColor),
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
              Text('Cart 🛒', style: theme.textTheme.displaySmall),
              CustomIconButton(
                  backgroundColor: theme.scaffoldBackgroundColor,
                  borderColor: theme.dividerColor,
                  onPressed: () {
                    controller.clearAllCart(context);
                  },
                  icon: const Icon(
                    Icons.delete_outline,
                    color: Colors.red,
                  )),
            ],
          ),
        ),
      ),
      body: GetBuilder<CartController>(
        builder: (_) => Padding(
          padding: EdgeInsets.only(right: 6.w, left: 6.w),
          child: Obx(
            () => Column(
              children: [
                12.verticalSpace,
                Expanded(
                  child: controller.cartItems.isEmpty
                      ? const NoData(text: 'No Products in Your Cart Yet!')
                      : Container(
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 238, 236, 236),
                          ),
                          child: Obx(
                            () => Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10)),
                              child: ListView.separated(
                                separatorBuilder: (_, index) => Padding(
                                  padding:
                                      EdgeInsets.only(top: 5.h, bottom: 5.h),
                                  child: const Divider(
                                    thickness: 15,
                                    color: Color.fromARGB(255, 238, 236, 236),
                                  ),
                                ),
                                itemCount: controller.cartItems.length,
                                itemBuilder: (context, index) => Container(
                                  margin: EdgeInsets.symmetric(horizontal: 5.w),
                                  decoration: BoxDecoration(
                                      color: theme.scaffoldBackgroundColor,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: CartItemList(
                                    item: controller.cartItems[index],
                                    index: index,
                                  )
                                      .animate(delay: (100 * index).ms)
                                      .fade()
                                      .slideX(
                                        duration: 300.ms,
                                        begin: -1,
                                        curve: Curves.easeInSine,
                                      ),
                                ),
                              ),
                            ),
                          ),
                        ),
                ),
                10.verticalSpace,
                Container(
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 238, 236, 236)),
                  child: Visibility(
                    visible: controller.cartItems.isNotEmpty,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                      ),
                      child: CustomButton(
                        text: 'Checkout',
                        onPressed: () => Get.offNamed(
                            '/checkout'), //controller.onPurchaseNowPressed(),
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
                  ),
                ),
                // 30.verticalSpace,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
