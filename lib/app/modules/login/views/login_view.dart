import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:grocery_app/app/components/round_button.dart';
import 'package:grocery_app/app/components/round_icon_button.dart';
import 'package:grocery_app/app/components/round_text_field.dart';
import 'package:grocery_app/app/modules/login/controller/login_controller.dart';
import 'package:grocery_app/app/routes/app_pages.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    LoginController controller = Get.put(LoginController());
    final theme = context.theme;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 70,
                ),
                Image.asset(
                  "assets/images/logo.png",
                  width: 250,
                  height: 150,
                ).animate().fade().slideX(
                      duration: 1200.ms,
                      begin: -1,
                      curve: Curves.easeInOut,
                    ),
                Text(
                  "Login",
                  style: TextStyle(
                      color: theme.primaryColor,
                      fontSize: 30,
                      fontWeight: FontWeight.w800),
                ),
                Text(
                  "Enter Login details to continue.",
                  style: TextStyle(
                      color: theme.colorScheme.secondary,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 15,
                ),
                Form(
                    key: controller.formKey,
                    child: Column(
                      children: [
                        RoundTextfield(
                          hintText: "Enter Name",
                          // controller: controller.name.value,
                          validator: (value) {
                            return controller.nameValidator(value!);
                          },
                          onChanged: (value) {
                            return controller.name.value = value;
                          },
                          errorText: controller.errorText.value,
                          keyboardType: TextInputType.name,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        RoundTextfield(
                          hintText: "Enter Phone Number ",
                          onChanged: (value) {
                            return controller.phone.value = value;
                          },
                          validator: (value) {
                            return controller.nameValidator(value!);
                          },
                          errorText: controller.errorText.value,
                          keyboardType: TextInputType.phone,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Obx(
                          () => controller.isLoading.value == false
                              ? RoundButton(
                                  title: "Login",
                                  onPressed: () {
                                    controller.btnLogin();
                                    // Get.toNamed(Routes.OTP);
                                  })
                              : const Center(
                                  child: CircularProgressIndicator(),
                                ),
                        ),
                      ],
                    )),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "Forgot your password?",
                    style: TextStyle(
                        color: theme.colorScheme.secondary,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Don't have an Account? ",
                        style: TextStyle(
                            color: theme.colorScheme.secondary,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        "Sign Up",
                        style: TextStyle(
                            color: theme.primaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
