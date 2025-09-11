// home_bind.dart
import 'package:cinephile/model/movies_model.dart';
import 'package:cinephile/utilities/api_provider.dart';
import 'package:cinephile/utilities/storage_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class HomeBind implements Bindings {
  @override
  void dependencies() {
    Get.put(HomeController());
  }
}

class HomeController extends GetxController {
  static HomeController get to => Get.find();

  RxList<bool> isWishlisted = <bool>[].obs;
  var allMovies = <Data>[].obs;
  var isLoading = false.obs;
  var hasMore = true.obs;
  var scrollController = ScrollController().obs;
  var wishlistedMovies = <Data>[].obs;


  // Cursor-based pagination variables
  var nextCursor = Rx<String?>(null);
  var currentCursor = Rx<String?>(null);

  @override
  void onInit() {
    super.onInit();
    loadWishlistFromStorage();
    getMovieList();
    setupScrollController();
  }

  void setupScrollController() {
    scrollController.value.addListener(() {
      if (scrollController.value.position.pixels >=
          scrollController.value.position.maxScrollExtent - 100 &&
          !isLoading.value &&
          hasMore.value) {
        loadMoreMovies();
      }
    });
  }

  void loadWishlistFromStorage() {
    try {
      final storedWishlist = StorageService.getWishlist();
      if (storedWishlist.isNotEmpty) {
        wishlistedMovies.value = storedWishlist
            .map((item) => Data.fromJson(item))
            .whereType<Data>()
            .toList();

        if (kDebugMode) {
          print('Loaded ${wishlistedMovies.length} movies from storage');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error loading wishlist from storage: $e');
      }
    }
  }

  // Save wishlist to storage
  void saveWishlistToStorage() {
    try {
      final wishlistJson = wishlistedMovies.map((movie) => movie.toJson()).toList();
      StorageService.saveWishlist(wishlistJson);

      if (kDebugMode) {
        print('Saved ${wishlistedMovies.length} movies to storage');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error saving wishlist to storage: $e');
      }
    }
  }

  bool isMovieWishlisted(Data movie) {
    return wishlistedMovies.any((m) => m.movieId == movie.movieId);
  }

  void addToWishlist(Data movie) {
    if (!wishlistedMovies.any((m) => m.movieId == movie.movieId)) {
      wishlistedMovies.add(movie);
      saveWishlistToStorage(); // Save to storage after adding

      final movieIndex = allMovies.indexWhere((m) => m.movieId == movie.movieId);
      if (movieIndex != -1 && movieIndex < isWishlisted.length) {
        isWishlisted[movieIndex] = true;
      }
    }
  }

  void removeFromWishlist(Data movie) {
    wishlistedMovies.removeWhere((m) => m.movieId == movie.movieId);
    saveWishlistToStorage();

    final movieIndex = allMovies.indexWhere((m) => m.movieId == movie.movieId);
    if (movieIndex != -1 && movieIndex < isWishlisted.length) {
      isWishlisted[movieIndex] = false;
    }
    update();

  }

  void toggleWishlist(Data movie) {
    if (isMovieWishlisted(movie)) {
      removeFromWishlist(movie);
    } else {
      addToWishlist(movie);
    }
  }

  Future<void> getMovieList() async {
    try {
      isLoading.value = true;
      EasyLoading.show();

      nextCursor.value = null;
      currentCursor.value = null;

      final movies = await Api.to.getMoviesList(cursor: currentCursor.value);

      if (movies.data != null && movies.data!.isNotEmpty) {
        allMovies.value = movies.data!;

        isWishlisted.value = List.generate(movies.data!.length, (index) {
          final movie = movies.data![index];
          return isMovieWishlisted(movie);
        });

        nextCursor.value = movies.nextCursor;
        hasMore.value = nextCursor.value != null && nextCursor.value!.isNotEmpty;
      } else {
        allMovies.value = [];
        hasMore.value = false;
      }

      if (kDebugMode) {
        print('Loaded ${allMovies.length} movies');
        print('Next cursor: ${nextCursor.value}');
      }
    } catch (ex) {
      if (kDebugMode) {
        print('Exception: $ex');
      }
      allMovies.value = [];
      hasMore.value = false;
    } finally {
      isLoading.value = false;
      EasyLoading.dismiss();
    }
  }

  Future<void> loadMoreMovies() async {
    if (isLoading.value || !hasMore.value || nextCursor.value == null) return;

    try {
      isLoading.value = true;

      if (kDebugMode) {
        print('Loading more with cursor: ${nextCursor.value}');
      }

      final newMovies = await Api.to.getMoviesList(cursor: nextCursor.value);

      if (newMovies.data != null && newMovies.data!.isNotEmpty) {
        // final newMovieIds = newMovies.data!.map((e) => e.movieId).toSet();
        final existingMovieIds = allMovies.map((e) => e.movieId).toSet();

        final actuallyNewMovies = newMovies.data!
            .where((movie) => !existingMovieIds.contains(movie.movieId))
            .toList();

        if (actuallyNewMovies.isNotEmpty) {
          allMovies.addAll(actuallyNewMovies);

          final newWishlistStatus = actuallyNewMovies.map((movie) {
            return isMovieWishlisted(movie);
          }).toList();

          isWishlisted.addAll(newWishlistStatus);

          nextCursor.value = newMovies.nextCursor;
          hasMore.value = nextCursor.value != null && nextCursor.value!.isNotEmpty;

          if (kDebugMode) {
            print('Added ${actuallyNewMovies.length} new movies. Total: ${allMovies.length}');
            print('Next cursor: ${nextCursor.value}');
          }
        } else {
          hasMore.value = false;
          if (kDebugMode) {
            print('No new movies found. Stopping pagination.');
          }
        }
      } else {
        hasMore.value = false;
        if (kDebugMode) {
          print('No movies returned. Stopping pagination.');
        }
      }
    } catch (ex) {
      if (kDebugMode) {
        print('Exception loading more: $ex');
      }
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    scrollController.value.dispose();
    super.onClose();
  }
}