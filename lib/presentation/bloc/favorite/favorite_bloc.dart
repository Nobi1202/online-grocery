import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:online_grocery/domain/usecase/get_favorite_items_usecase.dart';
import 'package:online_grocery/presentation/bloc/favorite/favorite_event.dart';
import 'package:online_grocery/presentation/bloc/favorite/favorite_state.dart';

@injectable
class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final GetFavoriteItemsUsecase _getFavoriteItemsUsecase;

  FavoriteBloc(this._getFavoriteItemsUsecase) : super(FavoriteState()) {
    on<OnFavoriteItemsEvent>(_onFavoriteItems);
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
          state.copyWith(favoriteItems: null, apiError: failure.toString()),
        ),
        (favoriteItems) => emit(state.copyWith(favoriteItems: favoriteItems)),
      );
    } catch (e) {
      emit(state.copyWith(favoriteItems: null, apiError: e.toString()));
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }
}
