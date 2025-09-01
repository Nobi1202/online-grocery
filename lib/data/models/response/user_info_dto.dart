import 'package:json_annotation/json_annotation.dart';

part 'user_info_dto.g.dart';

@JsonSerializable()
class UserInfoDto {
  final int id;
  final String firstName;
  final String lastName;
  final String maidenName;
  final int age;
  final String gender;
  final String email;
  final String phone;
  final String username;
  final String password;
  final String birthDate;
  final String image;
  final double height;
  final double weight;
  final String eyeColor;

  UserInfoDto({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.maidenName,
    required this.age,
    required this.gender,
    required this.email,
    required this.phone,
    required this.username,
    required this.password,
    required this.birthDate,
    required this.image,
    required this.height,
    required this.weight,
    required this.eyeColor,
  });

  factory UserInfoDto.fromJson(Map<String, dynamic> json) =>
      _$UserInfoDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UserInfoDtoToJson(this);
}

// "id": 1,
// "firstName": "Emily",
// "lastName": "Johnson",
// "maidenName": "Smith",
// "age": 28,
// "gender": "female",
// "email": "emily.johnson@x.dummyjson.com",
// "phone": "+81 965-431-3024",
// "username": "emilys",
// "password": "emilyspass",
// "birthDate": "1996-5-30",
// "image": "https://dummyjson.com/icon/emilys/128",
// "bloodGroup": "O-",
// "height": 193.24,
// "weight": 63.16,
// "eyeColor": "Green",
