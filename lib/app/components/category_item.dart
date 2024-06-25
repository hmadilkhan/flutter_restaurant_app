import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:grocery_app/app/modules/products/controllers/products_controller.dart';
import 'package:grocery_app/utils/constants.dart';

import '../data/models/category_model.dart';
import '../routes/app_pages.dart';

class CategoryItem extends StatelessWidget {
  final CategoryModel category;
  final ProductsController controller;
  const CategoryItem({
    super.key,
    required this.category,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return GestureDetector(
      onTap: () =>
          controller.showCategoryWiseProduct(category.id, category.title),
      // onTap: () => Get.toNamed(Routes.PRODUCTS),
      child: Padding(
        padding: const EdgeInsets.only(right: 8.0, left: 8.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 37.r,
              backgroundColor: theme.cardColor,
              backgroundImage: (category.image != null
                  ? NetworkImage(
                      "${category.image}",
                    )
                  : const NetworkImage(
                      "https://sabify.sabsoft.com.pk/SabifyProject/public/images/departments/1695911795-Sunmi.png",
                    )),
            ).animate().fade(duration: 200.ms),
            10.verticalSpace,
            Text(category.title ?? '', style: theme.textTheme.titleLarge)
                .animate()
                .fade()
                .slideY(
                  duration: 200.ms,
                  begin: 1,
                  curve: Curves.easeInSine,
                ),
          ],
        ),
      ),
    );
  }
}
