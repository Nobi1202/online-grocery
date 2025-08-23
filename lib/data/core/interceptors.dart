// import 'dart:io';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:online_grocery/core/logging/app_logger.dart';

@lazySingleton
class NetworkInterceptor extends Interceptor {
  NetworkInterceptor(this._log);

  // final AuthTokenStore _tokens;
  final AppLogger _log;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // final token = await _tokens.readAccessToken();
    // if (token != null && token.isNotEmpty) {
    //   options.headers['Authorization'] = 'Bearer $token';
    // }
    _log.t(
      'REQ ${options.method} ${options.uri}',
      meta: {
        'headers': options.headers,
        'query': options.queryParameters,
        'data': options.data,
      },
    );
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _log.t(
      'RES [${response.statusCode}] ${response.requestOptions.uri}',
      meta: {'data': response.data},
    );
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final ro = err.requestOptions;
    final status = err.response?.statusCode;
    // final isNoInternet =
    //     err.type == DioExceptionType.connectionError ||
    //     err.error is SocketException;

    _log.e(
      'ERR ${ro.method} ${ro.uri}',
      error: err,
      stackTrace: err.stackTrace,
      meta: {'statusCode': status, 'type': err.type.name},
    );

    // There is no need to redirect here. Let RepoImpl map to Failure, then UI handles it.
    handler.next(err);
  }
}
