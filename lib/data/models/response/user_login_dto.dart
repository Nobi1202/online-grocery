// {
//   "id": 1,
//   "username": "emilys",
//   "email": "emily.johnson@x.dummyjson.com",
//   "firstName": "Emily",
//   "lastName": "Johnson",
//   "gender": "female",
//   "image": "https://dummyjson.com/icon/emilys/128",
//   "accessToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...", // JWT accessToken (for backward compatibility) in response and cookies
//   "refreshToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..." // refreshToken in response and cookies
// }

import 'package:json_annotation/json_annotation.dart';

part 'user_login_dto.g.dart';

@JsonSerializable()
class UserLoginDto {
  final int id;
  final String username;
  final String email;
  final String firstName;
  final String lastName;
  final String gender;
  final String image;
  final String accessToken;
  final String refreshToken;

  UserLoginDto({
    required this.id,
    required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.image,
    required this.accessToken,
    required this.refreshToken,
  });

  factory UserLoginDto.fromJson(Map<String, dynamic> json) =>
      _$UserLoginDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UserLoginDtoToJson(this);
}
