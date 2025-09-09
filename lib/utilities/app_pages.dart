
import 'package:cinephile/screens/home/bind/home_bind.dart';
import 'package:cinephile/screens/home/view/home_view.dart';
import 'package:cinephile/screens/splash/bind/splash_bind.dart';
import 'package:cinephile/screens/splash/view/splash_view.dart';
import 'package:cinephile/utilities/app_route.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
      name: Routes.splash,
      page: () => const SplashView(),
      binding: SplashBind(),
    ),
    GetPage(
      name: Routes.home,
      page: () => const HomeView(),
      binding: HomeBind(),
    ),
  ];
}