import 'package:chottu_link/chottu_link.dart';
import 'package:flutter/material.dart';
import 'package:online_grocery/app.dart';
import 'package:online_grocery/di/env_module.dart';
import 'package:online_grocery/di/injector.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// ✅ Initialize the ChottuLink SDK
  /// Make sure to call this before using any ChottuLink features.
  await ChottuLink.init(apiKey: "c_app_vGkiGhH9c8wZ3rT7DDyJyqn6GamvRhjy");
  await configureDependencies(env: dev.name);
  runApp(const App());
}
