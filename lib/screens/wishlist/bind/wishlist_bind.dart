import 'package:cinephile/screens/home/bind/home_bind.dart';
import 'package:get/get.dart';


class WishListBind implements Bindings {
  @override
  void dependencies() {
  }
}

class WishListController extends GetxController {
  static WishListController get to => Get.find();

  List<dynamic> getWishlistedMovies() {
    final homeController = Get.find<HomeController>();
    return homeController.wishlistedMovies.toList();
  }

  void removeFromWishlist(dynamic movie) {
    final homeController = Get.find<HomeController>();
    homeController.wishlistedMovies.remove(movie);
    update(); // Notify listeners
  }

  @override
  void onInit() {
    super.onInit();
  }
}