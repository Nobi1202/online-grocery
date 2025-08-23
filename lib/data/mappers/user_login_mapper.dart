import 'package:online_grocery/data/models/response/user_login_dto.dart';
import 'package:online_grocery/domain/entities/user_login_entity.dart';

extension UserLoginMapper on UserLoginDto {
  UserLoginEntity toEntity() => UserLoginEntity(
    id: id,
    username: username,
    email: email,
    firstName: firstName,
    lastName: lastName,
    gender: gender,
    image: image,
    accessToken: accessToken,
    refreshToken: refreshToken,
  );
}
