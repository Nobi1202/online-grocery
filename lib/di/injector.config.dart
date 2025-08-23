// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:online_grocery/core/env/app_config.dart' as _i377;
import 'package:online_grocery/core/logging/app_logger.dart' as _i117;
import 'package:online_grocery/core/logging/console_app_logger.dart' as _i170;
import 'package:online_grocery/data/core/interceptors.dart' as _i675;
import 'package:online_grocery/data/datasources/remote/api_service.dart'
    as _i84;
import 'package:online_grocery/data/repositories/auth_respository_impl.dart'
    as _i729;
import 'package:online_grocery/di/env_module.dart' as _i262;
import 'package:online_grocery/di/third_party_module.dart' as _i410;
import 'package:online_grocery/domain/repositories/auth_repository.dart'
    as _i752;
import 'package:online_grocery/domain/usecase/user_login_usecase.dart' as _i999;

const String _dev = 'dev';
const String _staging = 'staging';
const String _prod = 'prod';

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final envModule = _$EnvModule();
    final thirdPartyModule = _$ThirdPartyModule();
    gh.singleton<_i377.AppConfig>(
      () => envModule.devConfig(),
      registerFor: {_dev},
    );
    gh.singleton<_i377.AppConfig>(
      () => envModule.stagingConfig(),
      registerFor: {_staging},
    );
    gh.singleton<String>(
      () => envModule.stagingBaseUrl(gh<_i377.AppConfig>()),
      instanceName: 'baseUrl',
      registerFor: {_staging},
    );
    gh.singleton<String>(
      () => envModule.devBaseUrl(gh<_i377.AppConfig>()),
      instanceName: 'baseUrl',
      registerFor: {_dev},
    );
    gh.lazySingleton<_i117.AppLogger>(() => _i170.ConsoleAppLogger());
    gh.singleton<_i377.AppConfig>(
      () => envModule.prodConfig(),
      registerFor: {_prod},
    );
    gh.singleton<String>(
      () => envModule.prodBaseUrl(gh<_i377.AppConfig>()),
      instanceName: 'baseUrl',
      registerFor: {_prod},
    );
    gh.lazySingleton<_i675.NetworkInterceptor>(
      () => _i675.NetworkInterceptor(gh<_i117.AppLogger>()),
    );
    gh.lazySingleton<_i361.Dio>(
      () => thirdPartyModule.dio(
        gh<_i377.AppConfig>(),
        gh<String>(instanceName: 'baseUrl'),
        gh<_i675.NetworkInterceptor>(),
      ),
    );
    gh.lazySingleton<_i84.ApiService>(() => _i84.ApiService(gh<_i361.Dio>()));
    gh.lazySingleton<_i752.IAuthRepository>(
      () => _i729.AuthRepositoryImpl(gh<_i84.ApiService>()),
    );
    gh.factory<_i999.UserLoginUsecase>(
      () => _i999.UserLoginUsecase(gh<_i752.IAuthRepository>()),
    );
    return this;
  }
}

class _$EnvModule extends _i262.EnvModule {}

class _$ThirdPartyModule extends _i410.ThirdPartyModule {}
