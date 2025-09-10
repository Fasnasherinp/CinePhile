
import 'package:cinephile/screens/details/bind/details_bind.dart';
import 'package:cinephile/screens/details/view/details_view.dart';
import 'package:cinephile/screens/home/bind/home_bind.dart';
import 'package:cinephile/screens/home/view/home_view.dart';
import 'package:cinephile/screens/introscreen/bind/intro_bind.dart';
import 'package:cinephile/screens/introscreen/view/intro_view.dart';
import 'package:cinephile/screens/splash/bind/splash_bind.dart';
import 'package:cinephile/screens/splash/view/splash_view.dart';
import 'package:cinephile/screens/wishlist/bind/wishlist_bind.dart';
import 'package:cinephile/screens/wishlist/view/wishlist_view.dart';
import 'package:cinephile/utilities/app_route.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
      name: Routes.intro,
      page: () => const IntroView(),
      binding: IntroBind(),
    ),
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
    GetPage(
      name: Routes.details,
      page: () => const DetailsView(),
      binding: DetailsBind(),
    ),
    GetPage(
      name: Routes.wishlist,
      page: () => const WishlistView(),
      binding: WishListBind(),
    ),
  ];
}