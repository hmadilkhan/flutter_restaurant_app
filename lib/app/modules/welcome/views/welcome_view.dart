import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:grocery_app/config/theme/my_fonts.dart';

import '../../../../utils/constants.dart';
import '../../../components/custom_button.dart';
import '../../../data/local/my_shared_pref.dart';
import '../../../routes/app_pages.dart';
import '../controllers/welcome_controller.dart';

class WelcomeView extends GetView<WelcomeController> {
  const WelcomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isLightTheme = MySharedPref.getThemeIsLight();
    final theme = context.theme;
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              isLightTheme ? Constants.newBackground : Constants.backgroundDark,
              fit: BoxFit.fill,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                95.verticalSpace,
                CircleAvatar(
                  radius: 33.r,
                  backgroundColor: theme.primaryColorDark,
                  child: Image.asset(
                    Constants.logo,
                    width: 40.33.w,
                    height: 33.40.h,
                  ),
                ).animate().fade().slideY(
                      duration: 300.ms,
                      begin: -1,
                      curve: Curves.easeInSine,
                    ),
                30.verticalSpace,
                Text(
                  'Get your food delivered to your home',
                  style: theme.textTheme.displayLarge,
                  textAlign: TextAlign.center,
                ).animate().fade().slideY(
                      duration: 300.ms,
                      begin: -1,
                      curve: Curves.easeInSine,
                    ),
                24.verticalSpace,
                Text(
                  'The best deliverey app in town for delivering your daily fresh groceries',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: MyFonts.body1TextSize,
                      color: theme.scaffoldBackgroundColor),
                  textAlign: TextAlign.center,
                ).animate().fade().slideY(
                      duration: 300.ms,
                      begin: 1,
                      curve: Curves.easeInSine,
                    ),
                25.verticalSpace,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 70.w),
                  child: CustomButton(
                    text: 'Shop now',
                    onPressed: () => Get.offNamed(Routes.BASE),
                    fontSize: 16.sp,
                    radius: 50.r,
                    verticalPadding: 16.h,
                    hasShadow: false,
                    backgroundColor: theme.scaffoldBackgroundColor,
                    foregroundColor:
                        isLightTheme ? theme.primaryColor : Colors.white,
                  ).animate().fade().slideY(
                        duration: 300.ms,
                        begin: 1,
                        curve: Curves.easeInSine,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
