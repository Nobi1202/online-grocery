import 'package:injectable/injectable.dart';
import 'package:online_grocery/data/core/guard.dart';
import 'package:online_grocery/data/datasources/remote/api_service.dart';
import 'package:online_grocery/data/mappers/user_info_mapper.dart';
import 'package:online_grocery/data/mappers/user_login_mapper.dart';
import 'package:online_grocery/data/models/request/user_login_schema.dart';
import 'package:online_grocery/domain/core/result.dart';
import 'package:online_grocery/domain/entities/user_info_entity.dart';
import 'package:online_grocery/domain/entities/user_login_entity.dart';
import 'package:online_grocery/domain/repositories/auth_repository.dart';

@LazySingleton(as: IAuthRepository)
class AuthRepositoryImpl extends IAuthRepository {
  final ApiService _apiService;

  AuthRepositoryImpl(this._apiService);

  @override
  ResultFuture<UserLoginEntity> login(UserLoginSchema userLoginSchema) {
    return guardDio<UserLoginEntity>(() async {
      final dto = await _apiService.login(userLoginSchema);
      return dto.toEntity();
    });
  }

  @override
  ResultFuture<UserInfoEntity> getUserInfo() {
    return guardDio<UserInfoEntity>(() async {
      final dto = await _apiService.getUserInfo();
      return dto.toEntity();
    });
  }
}
