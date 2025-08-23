import 'package:flutter/material.dart';
import 'package:online_grocery/app.dart';
import 'package:online_grocery/di/env_module.dart';
import 'package:online_grocery/di/injector.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies(env: dev.name);
  runApp(const MyApp());
}
