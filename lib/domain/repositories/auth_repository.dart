import 'package:online_grocery/data/models/request/user_login_schema.dart';
import 'package:online_grocery/domain/core/result.dart';
import 'package:online_grocery/domain/entities/user_info_entity.dart';
import 'package:online_grocery/domain/entities/user_login_entity.dart';

abstract class IAuthRepository {
  ResultFuture<UserLoginEntity> login(UserLoginSchema userLoginSchema);

  ResultFuture<UserInfoEntity> getUserInfo();
}
