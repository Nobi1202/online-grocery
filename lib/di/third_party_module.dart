import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:online_grocery/core/env/app_config.dart';
import 'package:online_grocery/data/core/dio_logger.dart';
import 'package:online_grocery/data/core/interceptors.dart';

@module
abstract class ThirdPartyModule {
  @lazySingleton
  Dio dio(
    AppConfig appConfig,
    @Named('baseUrl') String baseUrl,
    NetworkInterceptor networkInterceptor,
  ) {
    final dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 3),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );
    dio.interceptors.add(prettyDioLoggerInterceptor());
    dio.interceptors.addAll([networkInterceptor]);

    return dio;
  }
}
