import 'package:get/get.dart';
import 'package:grocery_app/app/data/local/my_shared_pref.dart';

import '../../../routes/app_pages.dart';

class SplashController extends GetxController {
  @override
  void onInit() async {
    MySharedPref.setIsAuth(false);
    print("checking Auth : ${MySharedPref.getIsAuth()}");
    await Future.delayed(const Duration(seconds: 2));
    if (MySharedPref.getIsAuth() == true) {
      Get.offNamed(Routes.BASE);
    } else {
      Get.offNamed(Routes.WELCOME);
    }
    super.onInit();
  }
}
