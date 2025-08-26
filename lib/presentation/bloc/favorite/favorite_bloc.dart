import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:online_grocery/di/injector.dart';
import 'package:online_grocery/domain/usecase/get_favorite_items_usecase.dart';
import 'package:online_grocery/presentation/bloc/favorite/favorite_event.dart';
import 'package:online_grocery/presentation/bloc/favorite/favorite_state.dart';
import 'package:online_grocery/presentation/error/failure_mapper.dart';

@injectable
class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final GetFavoriteItemsUsecase _getFavoriteItemsUsecase =
      getIt<GetFavoriteItemsUsecase>();
  final FailureMapper _failureMapper;

  FavoriteBloc(@factoryParam this._failureMapper) : super(FavoriteState()) {
    on<OnFavoriteItemsEvent>(_onFavoriteItems);
    on<OnClearErrorEvent>(_onClearError);
    add(OnFavoriteItemsEvent(15));
  }

  Future<void> _onFavoriteItems(
    OnFavoriteItemsEvent event,
    Emitter<FavoriteState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true));
      final result = await _getFavoriteItemsUsecase.call(event.id);
      result.fold(
        (failure) => emit(
          state.copyWith(
            favoriteItems: null,
            apiError: _failureMapper.mapFailureToMessage(failure),
          ),
        ),
        (favoriteItems) => emit(state.copyWith(favoriteItems: favoriteItems)),
      );
    } catch (e) {
      emit(state.copyWith(favoriteItems: null, apiError: e.toString()));
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  void _onClearError(OnClearErrorEvent event, Emitter<FavoriteState> emit) {
    emit(state.copyWith(apiError: null));
  }
}
