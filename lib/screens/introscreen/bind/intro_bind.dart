

import 'package:get/get.dart';

class IntroBind implements Bindings {
  @override
  void dependencies() {
    Get.put(IntroController());
  }
}

class IntroController extends GetxController {
  static IntroController get to => Get.find();

}