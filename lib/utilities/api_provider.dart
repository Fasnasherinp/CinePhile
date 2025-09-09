import 'package:get/get.dart';
import 'package:get/get_connect/connect.dart';
import 'package:get/get_core/src/get_main.dart';

class Api extends GetConnect {
//------------------------------- oms -------------------------------
  static Api get to => Get.find();
  final error = false;
  final message = 'some error';
  var err = {'error': false, 'message': 'Network Or Other related issue'};
  var baseUrlCommon = '';

//------------------------------- oms -------------------------------
  @override
void onInit() {
  super.onInit();
  httpClient.baseUrl = baseUrlCommon;
}
}