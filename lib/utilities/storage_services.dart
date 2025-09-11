import 'package:get_storage/get_storage.dart';

class StorageService {
  static final GetStorage _storage = GetStorage();

  static const String wishlistKey = 'wishlisted_movies';

  static Future<void> init() async {
    await GetStorage.init();
  }

  static Future<void> saveWishlist(List<Map<String, dynamic>> movies) async {
    await _storage.write(wishlistKey, movies);
  }

  static List<Map<String, dynamic>> getWishlist() {
    final storedData = _storage.read(wishlistKey);
    if (storedData != null && storedData is List) {
      return storedData.cast<Map<String, dynamic>>();
    }
    return [];
  }

  static Future<void> clearWishlist() async {
    await _storage.remove(wishlistKey);
  }

  static bool hasWishlistData() {
    return _storage.hasData(wishlistKey);
  }
}