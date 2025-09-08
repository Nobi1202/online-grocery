import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:online_grocery/presentation/routes/route_name.dart';
import 'package:online_grocery/presentation/screens/account/account_screen.dart';
import 'package:online_grocery/presentation/screens/bottom_tab/bottom_tab.dart';
import 'package:online_grocery/presentation/screens/cart/cart_screen.dart';
import 'package:online_grocery/presentation/screens/explore/explore_screen.dart';
import 'package:online_grocery/presentation/screens/explore_products/explore_products_screen.dart';
import 'package:online_grocery/presentation/screens/favourite/favourite_screen.dart';
import 'package:online_grocery/presentation/screens/get_started/get_started_screen.dart';
import 'package:online_grocery/presentation/screens/login/login_screen.dart';
import 'package:online_grocery/presentation/screens/product_detail/product_detail_screen.dart';
import 'package:online_grocery/presentation/screens/shop/shop_screen.dart';
import 'package:online_grocery/presentation/screens/splash/splash_screen.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

class AppRouter {
  static final router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: RouteName.splash,
    routes: [
      GoRoute(
        path: RouteName.splash,
        name: RouteName.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: RouteName.getStarted,
        name: RouteName.getStarted,
        builder: (context, state) => const GetStartedScreen(),
      ),
      GoRoute(
        path: RouteName.login,
        name: RouteName.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: RouteName.bottomTab,
        name: RouteName.bottomTab,
        builder: (context, state) => const BottomTab(),
      ),
      GoRoute(
        path: RouteName.account,
        name: RouteName.account,
        builder: (context, state) => const AccountScreen(),
      ),
      GoRoute(
        path: RouteName.cart,
        name: RouteName.cart,
        builder: (context, state) => const CartScreen(),
      ),
      GoRoute(
        path: RouteName.explore,
        name: RouteName.explore,
        builder: (context, state) => const ExploreScreen(),
      ),
      GoRoute(
        path: RouteName.favourite,
        name: RouteName.favourite,
        builder: (context, state) => const FavouriteScreen(),
      ),
      GoRoute(
        path: RouteName.shop,
        name: RouteName.shop,
        builder: (context, state) => const ShopScreen(),
      ),
      GoRoute(
        path: RouteName.exploreProducts,
        name: RouteName.exploreProducts,
        builder: (context, state) =>
            ExploreProductsScreen(category: state.extra as String),
      ),
      GoRoute(
        path: RouteName.productDetail,
        name: RouteName.productDetail,
        builder: (context, state) =>
            ProductDetailScreen(id: state.extra as int),
      ),
    ],
  );
}
