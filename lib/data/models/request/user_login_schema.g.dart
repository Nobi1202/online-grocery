// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_login_schema.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserLoginSchema _$UserLoginSchemaFromJson(Map<String, dynamic> json) =>
    UserLoginSchema(
      username: json['username'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$UserLoginSchemaToJson(UserLoginSchema instance) =>
    <String, dynamic>{
      'username': instance.username,
      'password': instance.password,
    };
