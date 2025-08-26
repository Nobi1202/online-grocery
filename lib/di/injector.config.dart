// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:online_grocery/core/env/app_config.dart' as _i377;
import 'package:online_grocery/core/logging/app_logger.dart' as _i117;
import 'package:online_grocery/core/logging/console_app_logger.dart' as _i170;
import 'package:online_grocery/data/core/interceptors.dart' as _i675;
import 'package:online_grocery/data/datasources/local/secure_storage.dart'
    as _i12;
import 'package:online_grocery/data/datasources/remote/api_service.dart'
    as _i84;
import 'package:online_grocery/data/repositories/auth_respository_impl.dart'
    as _i729;
import 'package:online_grocery/data/repositories/cart_repository_impl.dart'
    as _i1045;
import 'package:online_grocery/di/env_module.dart' as _i262;
import 'package:online_grocery/di/third_party_module.dart' as _i410;
import 'package:online_grocery/domain/repositories/auth_repository.dart'
    as _i752;
import 'package:online_grocery/domain/repositories/cart_repository.dart'
    as _i642;
import 'package:online_grocery/domain/usecase/get_cart_items_usecase.dart'
    as _i854;
import 'package:online_grocery/domain/usecase/get_favorite_items_usecase.dart'
    as _i277;
import 'package:online_grocery/domain/usecase/get_user_info_usecase.dart'
    as _i183;
import 'package:online_grocery/domain/usecase/login_user_usecase.dart' as _i47;
import 'package:online_grocery/presentation/bloc/account/account_bloc.dart'
    as _i37;
import 'package:online_grocery/presentation/bloc/cart/cart_bloc.dart' as _i257;
import 'package:online_grocery/presentation/bloc/favorite/favorite_bloc.dart'
    as _i268;
import 'package:online_grocery/presentation/bloc/locale/locale_bloc.dart'
    as _i356;
import 'package:online_grocery/presentation/bloc/login/login_bloc.dart'
    as _i109;
import 'package:online_grocery/presentation/error/failure_mapper.dart' as _i519;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

const String _dev = 'dev';
const String _staging = 'staging';
const String _prod = 'prod';

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final thirdPartyModule = _$ThirdPartyModule();
    final envModule = _$EnvModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => thirdPartyModule.sharedPreferences(),
      preResolve: true,
    );
    gh.factory<_i558.FlutterSecureStorage>(
      () => thirdPartyModule.secureStorage(),
    );
    gh.singleton<_i377.AppConfig>(
      () => envModule.devConfig(),
      registerFor: {_dev},
    );
    gh.singleton<_i377.AppConfig>(
      () => envModule.stagingConfig(),
      registerFor: {_staging},
    );
    gh.factoryParam<_i109.LoginBloc, _i519.FailureMapper, dynamic>(
      (_failureMapper, _) => _i109.LoginBloc(_failureMapper),
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
    gh.singleton<_i12.SecureStorage>(
      () => _i12.SecureStorage(
        gh<_i558.FlutterSecureStorage>(),
        gh<_i460.SharedPreferences>(),
      ),
    );
    gh.lazySingleton<_i117.AppLogger>(() => _i170.ConsoleAppLogger());
    gh.singleton<_i377.AppConfig>(
      () => envModule.prodConfig(),
      registerFor: {_prod},
    );
    gh.factory<_i356.LocaleBloc>(
      () => _i356.LocaleBloc(gh<_i12.SecureStorage>()),
    );
    gh.lazySingleton<_i675.NetworkInterceptor>(
      () => _i675.NetworkInterceptor(
        gh<_i117.AppLogger>(),
        gh<_i12.SecureStorage>(),
      ),
    );
    gh.singleton<String>(
      () => envModule.prodBaseUrl(gh<_i377.AppConfig>()),
      instanceName: 'baseUrl',
      registerFor: {_prod},
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
    gh.lazySingleton<_i642.ICartRepository>(
      () => _i1045.CartRepositoryImpl(gh<_i84.ApiService>()),
    );
    gh.factory<_i47.LoginUserUsecase>(
      () => _i47.LoginUserUsecase(gh<_i752.IAuthRepository>()),
    );
    gh.factory<_i183.GetUserInfoUsecase>(
      () => _i183.GetUserInfoUsecase(gh<_i752.IAuthRepository>()),
    );
    gh.factory<_i277.GetFavoriteItemsUsecase>(
      () => _i277.GetFavoriteItemsUsecase(gh<_i642.ICartRepository>()),
    );
    gh.factory<_i854.GetCartItemsUsecase>(
      () => _i854.GetCartItemsUsecase(gh<_i642.ICartRepository>()),
    );
    gh.factory<_i37.AccountBloc>(
      () => _i37.AccountBloc(gh<_i183.GetUserInfoUsecase>()),
    );
    gh.factory<_i257.CartBloc>(
      () => _i257.CartBloc(gh<_i854.GetCartItemsUsecase>()),
    );
    gh.factory<_i268.FavoriteBloc>(
      () => _i268.FavoriteBloc(gh<_i277.GetFavoriteItemsUsecase>()),
    );
    return this;
  }
}

class _$ThirdPartyModule extends _i410.ThirdPartyModule {}

class _$EnvModule extends _i262.EnvModule {}
