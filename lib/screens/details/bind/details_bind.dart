import 'package:cinephile/model/movies_model.dart';
import 'package:cinephile/screens/home/bind/home_bind.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class DetailsBind implements Bindings {
  @override
  void dependencies() {
    Get.put(DetailsController());
  }
}

class DetailsController extends GetxController {
  static DetailsController get to => Get.find();

  late Data movieData;
  var isWishlisted = false.obs;

  void toggleWishlist() {
    final homeController = Get.find<HomeController>();

    if (isWishlisted.value) {
      homeController.removeFromWishlist(movieData);
    } else {
      homeController.addToWishlist(movieData);
    }

    isWishlisted.value = !isWishlisted.value;
  }

  @override
  void onInit() {
    super.onInit();
    final arguments = Get.arguments;
    if (arguments != null && arguments is Data) {
      movieData = arguments;
    } else if (arguments != null && arguments is Map<String, dynamic>) {
      movieData = Data.fromJson(arguments);
    }

    final homeController = Get.find<HomeController>();
    isWishlisted.value = homeController.isMovieWishlisted(movieData);

    if (kDebugMode) {
      print('Loaded movie: ${movieData.originalTitle}');
      print('Is wishlisted: ${isWishlisted.value}');
    }
  }
}