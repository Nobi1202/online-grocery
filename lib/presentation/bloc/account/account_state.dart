import 'package:equatable/equatable.dart';
import 'package:online_grocery/domain/entities/user_info_entity.dart';

class AccountState extends Equatable {
  final bool isLoading;
  final UserInfoEntity? userInfo;
  final String? apiError;

  const AccountState({this.isLoading = false, this.userInfo, this.apiError});

  AccountState copyWith({
    bool? isLoading,
    UserInfoEntity? userInfo,
    String? apiError,
  }) {
    return AccountState(
      isLoading: isLoading ?? this.isLoading,
      userInfo: userInfo ?? this.userInfo,
      apiError: apiError ?? this.apiError,
    );
  }

  @override
  List<Object?> get props => [isLoading, userInfo, apiError];
}
