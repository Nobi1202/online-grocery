import 'package:equatable/equatable.dart';

class UserInfoEntity extends Equatable {
  final int id;
  final String email;
  final String gender;
  final String image;
  final String fullName;

  const UserInfoEntity({
    required this.id,
    required this.email,
    required this.gender,
    required this.image,
    required this.fullName,
  });

  @override
  List<Object?> get props => [id, email, gender, image, fullName];
}
