import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:grocery_app/app/data/local/storage_controller.dart';
import 'package:grocery_app/app/modules/base/controllers/base_controller.dart';
import 'package:grocery_app/app/modules/products/controllers/products_controller.dart';
import 'package:grocery_app/app/routes/app_pages.dart';
import 'package:grocery_app/utils/api_list.dart';

import '../../../../utils/constants.dart';
import '../../../components/category_item.dart';
import '../../../components/custom_form_field.dart';
import '../../../components/custom_icon_button.dart';
import '../../../components/dark_transition.dart';
import '../../../components/product_item.dart';
import '../controllers/home_controller.dart';
import 'package:badges/badges.dart' as badges;

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    final StorageController _storage = StorageController();
    final theme = context.theme;
    final productsController = Get.put(ProductsController());

    return DarkTransition(
      offset: Offset(context.width, -1),
      isDark: !controller.isLightTheme,
      builder: (context, _) => Scaffold(
        body: Stack(
          children: [
            Positioned(
              top: -100.h,
              child: SvgPicture.asset(
                Constants.container,
                fit: BoxFit.fill,
                color: theme.canvasColor,
              ),
            ),
            ListView(
              children: [
                Column(
                  children: [
                    ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 24.w),
                      title: Text(
                        controller.getGreeting(),
                        style: theme.textTheme.bodyMedium
                            ?.copyWith(fontSize: 12.sp),
                      ),
                      subtitle: Text(
                        _storage.readData("username") ?? '',
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      leading: CircleAvatar(
                        radius: 22.r,
                        backgroundColor: theme.primaryColorDark,
                        child: ClipOval(
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Image.asset(Constants.avatar),
                          ),
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CustomIconButton(
                              onPressed: () =>
                                  controller.onChangeThemePressed(),
                              backgroundColor: theme.primaryColorDark,
                              icon: GetBuilder<HomeController>(
                                id: 'Theme',
                                builder: (_) => Icon(
                                  controller.isLightTheme
                                      ? Icons.dark_mode_outlined
                                      : Icons.light_mode_outlined,
                                  color: theme.appBarTheme.iconTheme?.color,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                          GetBuilder<BaseController>(
                            id: 'CartBadge',
                            builder: (basecontroller) => GestureDetector(
                              onTap: () {
                                Get.toNamed(Routes.CART);
                              },
                              child: badges.Badge(
                                position: badges.BadgePosition.topStart(
                                    top: -16, start: 20),
                                badgeContent: Text(
                                  basecontroller.cartItemsCount.toString(),
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                badgeStyle: badges.BadgeStyle(
                                  elevation: 2,
                                  badgeColor: theme.primaryColor,
                                  borderSide: const BorderSide(
                                      color: Colors.white, width: 1),
                                ),
                                child: CircleAvatar(
                                  radius: 22.r,
                                  backgroundColor:
                                      theme.scaffoldBackgroundColor,
                                  child: SvgPicture.asset(
                                    Constants.cartIcon,
                                    fit: BoxFit.none,
                                    color: theme.appBarTheme.iconTheme?.color,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    10.verticalSpace,
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: CustomFormField(
                        backgroundColor: theme.primaryColorDark,
                        textSize: 14.sp,
                        hint: 'Search category',
                        hintFontSize: 14.sp,
                        hintColor: theme.hintColor,
                        maxLines: 1,
                        borderRound: 60.r,
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.h, horizontal: 10.w),
                        focusedBorderColor: Colors.transparent,
                        isSearchField: true,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.search,
                        prefixIcon: SvgPicture.asset(Constants.searchIcon,
                            fit: BoxFit.none),
                      ),
                    ),
                    20.verticalSpace,
                    SizedBox(
                        width: double.infinity,
                        height: 158.h,
                        child: FutureBuilder(
                            future: controller.downloadAllData(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return CarouselSlider.builder(
                                  options: CarouselOptions(
                                    initialPage: 1,
                                    viewportFraction: 0.9,
                                    enableInfiniteScroll: true,
                                    autoPlay: true,
                                    autoPlayInterval:
                                        const Duration(seconds: 3),
                                  ),
                                  itemCount: controller.cards.length,
                                  itemBuilder:
                                      (context, itemIndex, pageViewIndex) {
                                    // return Image.asset(
                                    //     controller.cards[itemIndex]);
                                    return Image.network(
                                        "https://sabify.sabsoft.com.pk/api/website/image/${controller.cards[itemIndex]}/slider/${ApiList.companyId}-${ApiList.websiteId}");
                                  },
                                );
                              } else {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                            })),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Column(
                    // mainAxisSize: MainAxisSize.min,
                    children: [
                      20.verticalSpace,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Categories 😋',
                            style: theme.textTheme.headlineMedium,
                          ),
                          Text(
                            'See all',
                            style: theme.textTheme.titleLarge?.copyWith(
                              color: theme.primaryColor,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                      16.verticalSpace,
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.13,
                        child: FutureBuilder(
                          future: controller.downloadAllData(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return ListView.builder(
                                  itemCount: controller.categories.length,
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    final category =
                                        controller.categories[index];
                                    return CategoryItem(
                                      category: category,
                                      controller: productsController,
                                    );
                                  });
                            } else {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                          },
                        ),
                      ),
                      20.verticalSpace,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Best selling 🔥',
                            style: theme.textTheme.headlineMedium,
                          ),
                          Text(
                            'See all',
                            style: theme.textTheme.titleLarge?.copyWith(
                              color: theme.primaryColor,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                      16.verticalSpace,
                      FutureBuilder(
                          future: productsController.downloadAllData(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return GridView.builder(
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 16.w,
                                  mainAxisSpacing: 16.h,
                                  mainAxisExtent: 214.h,
                                ),
                                shrinkWrap: true,
                                primary: false,
                                itemCount: 2,
                                itemBuilder: (context, index) =>
                                    // Text(
                                    //     "Product ${controller.products.length}"),
                                    ProductItem(
                                  product: productsController.products[index],
                                ),
                              );
                            } else {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                          }),
                      20.verticalSpace,
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
