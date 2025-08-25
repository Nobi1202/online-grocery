import 'package:online_grocery/data/models/response/user_info_dto.dart';
import 'package:online_grocery/domain/entities/user_info_entity.dart';

extension UserInfoMapper on UserInfoDto {
  UserInfoEntity toEntity() => UserInfoEntity(
    id: id,
    email: email,
    gender: gender,
    image: image,
    fullName: '$firstName $lastName',
  );
}
