import 'package:cinephile/model/movies_model.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/connect.dart';
import 'package:get/get_core/src/get_main.dart';

class Api extends GetConnect {
  static Api get to => Get.find();
  final error = false;
  final message = 'some error';
  var err = {'error': false, 'message': 'Network Or Other related issue'};
  var baseUrlCommon = 'https://jsonfakery.com/';

  @override
  void onInit() {
    super.onInit();
    httpClient.baseUrl = baseUrlCommon;
  }

  Future<MoviesModel> getMoviesList({String? cursor, int perPage = 20}) {
    Map<String, dynamic> queryParams = {
      'per_page': perPage.toString(),
    };

    if (cursor != null && cursor.isNotEmpty) {
      queryParams['cursor'] = cursor;
    }

    return get(
      'movies/infinite-scroll',
      query: queryParams,
    ).then((value) {
      if (kDebugMode) {
        print('movieList cursor: $cursor');
        print('Status: ${value.statusCode}');
        print('Response: ${value.body}');
      }

      if (value.statusCode == 200 && value.body != null) {
        return MoviesModel.fromJson(value.body);
      } else {
        throw Exception('Failed to load movies: ${value.statusCode}');
      }
    }).catchError((error) {
      if (kDebugMode) {
        print('API Error: $error');
      }
      throw error;
    });
  }
}