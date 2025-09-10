import 'package:cinephile/model/movies_model.dart';
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

  var isWishlisted = false.obs;
  late Data movieData;


  void toggleWishlist() {
    isWishlisted.value = !isWishlisted.value;
  }

  @override
  void onInit() {
    super.onInit();
    // Get movie data from arguments
    final arguments = Get.arguments;
    if (arguments != null && arguments is Data) {
      movieData = arguments;
    } else if (arguments != null && arguments is Map<String, dynamic>) {
      movieData = Data.fromJson(arguments);
    }

    if (kDebugMode) {
      print('Loaded movie: ${movieData.originalTitle}');
    }
  }
}