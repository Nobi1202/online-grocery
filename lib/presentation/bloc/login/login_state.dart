import 'package:equatable/equatable.dart';

class LoginState extends Equatable {
  final bool isLoading;
  final String apiErrorMsg;
  final bool isSuccess;

  const LoginState({
    this.isLoading = false,
    this.apiErrorMsg = '',
    this.isSuccess = false,
  });

  LoginState copyWith({bool? isLoading, String? apiErrorMsg, bool? isSuccess}) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      apiErrorMsg: apiErrorMsg ?? this.apiErrorMsg,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }

  @override
  List<Object?> get props => [isLoading, apiErrorMsg, isSuccess];
}
