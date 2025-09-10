
import 'package:get/get.dart';

class DetailsBind implements Bindings {
  @override
  void dependencies() {
    Get.put(DetailsController());
  }
}

class DetailsController extends GetxController {
  static DetailsController get to => Get.find();

  final RxString selectedTab = 'About Movie'.obs;

  void changeTab(String tabName) {
    selectedTab.value = tabName;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    // Fetch data here when the controller is initialized
    // fetchNewMovies();
    // fetchUpcomingMovies();
  }

}