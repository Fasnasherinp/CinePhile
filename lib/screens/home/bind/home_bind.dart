import 'package:cinephile/utilities/app_route.dart';
import 'package:flutter_custom_utils/flutter_custom_utils.dart';
import 'package:get/get.dart';

class HomeBind implements Bindings {
  @override
  void dependencies() {
    Get.put(HomeController());
  }
}

class HomeController extends GetxController {
  static HomeController get to => Get.find();

  @override
  void onInit() {
    super.onInit();
    // Fetch data here when the controller is initialized
    // fetchNewMovies();
    // fetchUpcomingMovies();
  }

}