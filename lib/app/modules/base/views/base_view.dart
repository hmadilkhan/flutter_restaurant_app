import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:badges/badges.dart';
import 'package:badges/badges.dart' as badges;
import 'package:get/get.dart';
import 'package:grocery_app/app/components/bottom_nav_bar.dart';
import 'package:grocery_app/app/modules/cart/views/cart_view.dart';

import '../../../../utils/constants.dart';
import '../../../routes/app_pages.dart';
import '../../calendar/views/calendar_view.dart';
import '../../category/views/category_view.dart';
import '../../profile/views/profile_view.dart';
import '../controllers/base_controller.dart';
import '../../home/views/home_view.dart';

class BaseView extends GetView<BaseController> {
  const BaseView({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = context.theme;
    return GetBuilder<BaseController>(
      builder: (_) => Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          bottom: false,
          child: IndexedStack(
            index: controller.currentIndex,
            children: const [
              CategoryView(),
              CartView(),
              HomeView(),
              CalendarView(),
              ProfileView()
            ],
          ),
        ),
        bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: theme.secondaryHeaderColor,
          // backgroundColor: Colors.transparent,
          index: controller.currentIndex,
          items: const [
            CurvedNavigationBarItem(
              child: Icon(
                Icons.search,
              ),
              label: 'Search',
            ),
            CurvedNavigationBarItem(
              child: Icon(Icons.shopping_basket),
              label: 'Cart',
            ),
            CurvedNavigationBarItem(
              child: Icon(
                Icons.home_outlined,
              ),
              label: 'Home',
            ),
            CurvedNavigationBarItem(
              child: Icon(Icons.newspaper),
              label: 'Calendar',
            ),
            CurvedNavigationBarItem(
              child: Icon(Icons.perm_identity),
              label: 'Profile',
            ),
          ],
          color: Colors.white,
          buttonBackgroundColor: theme.primaryColor,
          animationCurve: Curves.easeInOut,
          animationDuration: const Duration(milliseconds: 600),
          onTap: (index) {
            controller.changeScreen(index);
          },
        ),
      ),
    );
  }
}
