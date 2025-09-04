import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:online_grocery/core/logging/app_logger.dart';
import 'package:online_grocery/data/datasources/local/secure_storage.dart';
import 'package:online_grocery/di/injector.dart';
import 'package:online_grocery/presentation/routes/route_name.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final localStorage = getIt<SecureStorage>();
  final logger = getIt<AppLogger>();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Future.delayed(const Duration(seconds: 2), () async {
        if (mounted) {
          final accessToken = await localStorage.getToken();
          logger.d('accessToken: $accessToken');
          if (mounted) {
            if (accessToken != null && accessToken.isNotEmpty) {
              context.go(RouteName.bottomTab);
            } else {
              context.go(RouteName.getStarted);
            }
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('Splash Screen')));
  }
}
