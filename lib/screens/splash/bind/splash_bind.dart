import 'package:cinephile/utilities/app_route.dart';
import 'package:flutter_custom_utils/flutter_custom_utils.dart';
import 'package:get/get.dart';


class SplashBind implements Bindings {
  @override
  void dependencies() {
    Get.put(SplashController());
  }
}

class SplashController extends GetxController {
  static SplashController get to => Get.find();

  @override
  void onInit() {
    super.onInit();
    3.cSeconds.cDelay(() {
      Get.toNamed(Routes.intro);
    });
  }
}