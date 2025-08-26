import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:online_grocery/di/injector.dart';
import 'package:online_grocery/domain/core/usecase.dart';
import 'package:online_grocery/domain/usecase/get_user_info_usecase.dart';
import 'package:online_grocery/presentation/bloc/account/account_event.dart';
import 'package:online_grocery/presentation/bloc/account/account_state.dart';
import 'package:online_grocery/presentation/error/failure_mapper.dart';

@injectable
class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final GetUserInfoUsecase _getUsecase = getIt<GetUserInfoUsecase>();
  final FailureMapper _failureMapper;

  AccountBloc(@factoryParam this._failureMapper) : super(AccountState()) {
    on<OnGetUserInfoEvent>(_onGetUserInfoEvent);
    on<OnClearErrorEvent>(_onClearErrorEvent);
    add(OnGetUserInfoEvent());
  }

  Future<void> _onGetUserInfoEvent(
    OnGetUserInfoEvent event,
    Emitter<AccountState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true));
      final result = await _getUsecase.call(NoParams());
      result.fold(
        (failure) => emit(
          state.copyWith(
            userInfo: null,
            apiError: _failureMapper.mapFailureToMessage(failure),
          ),
        ),
        (userInfo) => emit(state.copyWith(userInfo: userInfo)),
      );
    } catch (e) {
      emit(state.copyWith(userInfo: null, apiError: e.toString()));
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  void _onClearErrorEvent(OnClearErrorEvent event, Emitter<AccountState> emit) {
    emit(state.copyWith(apiError: null));
  }
}
