// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfoDto _$UserInfoDtoFromJson(Map<String, dynamic> json) => UserInfoDto(
  id: (json['id'] as num).toInt(),
  firstName: json['firstName'] as String,
  lastName: json['lastName'] as String,
  maidenName: json['maidenName'] as String,
  age: (json['age'] as num).toInt(),
  gender: json['gender'] as String,
  email: json['email'] as String,
  phone: json['phone'] as String,
  username: json['username'] as String,
  password: json['password'] as String,
  birthDate: json['birthDate'] as String,
  image: json['image'] as String,
  height: (json['height'] as num).toDouble(),
  weight: (json['weight'] as num).toDouble(),
  eyeColor: json['eyeColor'] as String,
);

Map<String, dynamic> _$UserInfoDtoToJson(UserInfoDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'maidenName': instance.maidenName,
      'age': instance.age,
      'gender': instance.gender,
      'email': instance.email,
      'phone': instance.phone,
      'username': instance.username,
      'password': instance.password,
      'birthDate': instance.birthDate,
      'image': instance.image,
      'height': instance.height,
      'weight': instance.weight,
      'eyeColor': instance.eyeColor,
    };
