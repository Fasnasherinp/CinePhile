import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class WishListBind implements Bindings {
  @override
  void dependencies() {
    Get.put(WishListController());
  }
}

class WishListController extends GetxController {
  static WishListController get to => Get.find();

  @override
  void onInit() {
    super.onInit();
    // Fetch data here when the controller is initialized
    // fetchNewMovies();
    // fetchUpcomingMovies();
  }

}