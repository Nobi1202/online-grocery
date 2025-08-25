import 'package:json_annotation/json_annotation.dart';

part 'user_login_schema.g.dart';

@JsonSerializable()
class UserLoginSchema {
  final String username;
  final String password;

  UserLoginSchema({required this.username, required this.password});

  factory UserLoginSchema.fromJson(Map<String, dynamic> json) =>
      _$UserLoginSchemaFromJson(json);

  Map<String, dynamic> toJson() => _$UserLoginSchemaToJson(this);
}
