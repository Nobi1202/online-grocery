import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:online_grocery/data/datasources/local/secure_storage.dart';
import 'package:online_grocery/data/models/request/user_login_schema.dart';
import 'package:online_grocery/di/injector.dart';
import 'package:online_grocery/domain/usecase/login_user_usecase.dart';
import 'package:online_grocery/presentation/bloc/login/login_event.dart';
import 'package:online_grocery/presentation/bloc/login/login_state.dart';
import 'package:online_grocery/presentation/error/failure_mapper.dart';

@injectable
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUserUsecase _userLoginUsecase = getIt<LoginUserUsecase>();
  final SecureStorage _secureStorage = getIt<SecureStorage>();
  final FailureMapper _failureMapper;

  LoginBloc(@factoryParam this._failureMapper) : super(const LoginState()) {
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
          emit(
            state.copyWith(
              apiErrorMsg: _failureMapper.mapFailureToMessage(failure),
            ),
          );
        },
        (success) {
          _secureStorage.saveToken(success.accessToken);
          _secureStorage.saveRefreshToken(success.refreshToken);
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
