import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:online_grocery/data/models/request/user_login_schema.dart';
import 'package:online_grocery/di/injector.dart';
import 'package:online_grocery/domain/usecase/user_login_usecase.dart';
import 'package:online_grocery/presentation/bloc/login/login_event.dart';
import 'package:online_grocery/presentation/bloc/login/login_state.dart';

@injectable
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserLoginUsecase _userLoginUsecase = getIt<UserLoginUsecase>();

  LoginBloc() : super(const LoginState()) {
    on<OnLoginEvent>(_onLoginEvent);
  }

  Future<void> _onLoginEvent(
    OnLoginEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    try {
      final result = await _userLoginUsecase(
        UserLoginSchema(username: event.username, password: event.password),
      );
      result.fold(
        (failure) {
          emit(state.copyWith(apiErrorMsg: failure.toString()));
        },
        (success) {
          emit(state.copyWith(isSuccess: true));
        },
      );
    } catch (e) {
      emit(state.copyWith(apiErrorMsg: e.toString()));
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }
}
