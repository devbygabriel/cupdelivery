import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:cupdelivery/src/pages/auth/view/sign_in_screen.dart';
import 'package:cupdelivery/src/pages/auth/view/sign_up_screen.dart';
import 'package:cupdelivery/src/pages/base/view/base_screen.dart';
import 'package:cupdelivery/src/pages/base/binding/navigation_binding.dart';
import 'package:cupdelivery/src/pages/cart/binding/cart_binding.dart';
import 'package:cupdelivery/src/pages/home/binding/home_binding.dart';
import 'package:cupdelivery/src/pages/orders/binding/orders_binding.dart';
import 'package:cupdelivery/src/pages/product/product_screen.dart';
import 'package:cupdelivery/src/pages/splash/splash_screen.dart';

abstract class AppPages {
  static final pages = <GetPage>[
    GetPage(name: PagesRoutes.productRoute, page: () => ProductScreen()),
    GetPage(name: PagesRoutes.splashRoute, page: () => const SplashScreen()),
    GetPage(name: PagesRoutes.signInRoute, page: () => SignInScreen()),
    GetPage(name: PagesRoutes.signUpRoute, page: () => SignUpScreen()),
    GetPage(
      name: PagesRoutes.baseRoute,
      page: () => const BaseScreen(),
      bindings: [
        HomeBinding(),
        NavigationBinding(),
        CartBinding(),
        OrdersBinding(),
      ],
    ),
  ];
}

abstract class PagesRoutes {
  static const String productRoute = '/product';
  static const String signInRoute = '/signin';
  static const String signUpRoute = '/signup';
  static const String splashRoute = '/splash';
  static const String baseRoute = '/';
}
