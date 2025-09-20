import 'package:chottu_link/chottu_link.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_grocery/di/injector.dart';
import 'package:online_grocery/l10n/app_localizations.dart';
import 'package:online_grocery/presentation/bloc/locale/locale_bloc.dart';
import 'package:online_grocery/presentation/bloc/locale/locale_state.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:online_grocery/presentation/routes/app_router.dart';
import 'package:online_grocery/presentation/routes/route_name.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
    _initializeDeepLinkHandling();
  }

  void _initializeDeepLinkHandling() {
    /// 🔗 Listen for incoming dynamic links
    /// This handles both cold start and warm start deep links
    ChottuLink.onLinkReceived.listen((String link) {
      debugPrint(" ✅ Link Received: $link");

      /// Add a small delay to ensure the app is fully initialized
      Future.delayed(const Duration(milliseconds: 500), () {
        _handleDeepLink(link);
      });
    });
  }

  void _handleDeepLink(String link) {
    try {
      /// Check if the widget is still mounted
      if (!mounted) {
        debugPrint(" ❌ Widget not mounted, skipping deep link: $link");
        return;
      }

      /// Tip: ➡️ Navigate to a specific page or take action based on the link
      /// Example: https://onlinegrocery.chottu.link/product/8
      if (link.contains("/product/")) {
        final productId = link.split("/product/")[1];
        final productIdInt = int.tryParse(productId);

        if (productIdInt != null) {
          /// Use GoRouter.router.go() instead of context.pushNamed()
          /// This works because we have access to the router instance directly
          AppRouter.router.goNamed(
            RouteName.productDetail,
            extra: {'id': productIdInt, 'isFromDeepLink': true},
          );
          debugPrint(" ✅ Navigated to product detail with ID: $productIdInt");
        } else {
          debugPrint(" ❌ Invalid product ID: $productId");
        }
      } else {
        debugPrint(" ❌ Unsupported deep link format: $link");
      }
    } catch (e) {
      debugPrint(" ❌ Error handling deep link: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<LocaleBloc>(),
      child: BlocBuilder<LocaleBloc, LocaleState>(
        builder: (context, state) {
          return ScreenUtilInit(
            designSize: const Size(375, 812),
            builder: (context, child) {
              return MaterialApp.router(
                debugShowCheckedModeBanner: false,
                locale: Locale(state.locale),
                supportedLocales: const [Locale('en'), Locale('vi')],
                localizationsDelegates: const [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                ],
                routerConfig: AppRouter.router,
              );
            },
          );
        },
      ),
    );
  }
}
