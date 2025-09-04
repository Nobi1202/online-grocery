import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_grocery/di/injector.dart';
import 'package:online_grocery/domain/core/usecase.dart';
import 'package:online_grocery/domain/usecase/get_all_product_category_usecase.dart';
import 'package:online_grocery/presentation/bloc/explore/explore_event.dart';
import 'package:online_grocery/presentation/bloc/explore/explore_state.dart';
import 'package:online_grocery/presentation/error/failure_mapper.dart';

class ExploreBloc extends Bloc<ExploreEvent, ExploreState> {
  final FailureMapper _failureMapper;
  final GetAllProductCategoryUsecase _getAllProductCategoriesUsecase =
      getIt<GetAllProductCategoryUsecase>();

  ExploreBloc(this._failureMapper) : super(ExploreState()) {
    on<OnGetAllProductCategoriesEvent>(_onGetAllProductCategories);
    on<OnClearErrorEvent>(_onClearError);
    add(OnGetAllProductCategoriesEvent());
  }

  Future<void> _onGetAllProductCategories(
    OnGetAllProductCategoriesEvent event,
    Emitter<ExploreState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true));
      final result = await _getAllProductCategoriesUsecase.call(NoParams());
      result.fold(
        (failure) => emit(
          state.copyWith(apiError: _failureMapper.mapFailureToMessage(failure)),
        ),
        (productCategories) =>
            emit(state.copyWith(productCategories: productCategories)),
      );
    } catch (e) {
      emit(state.copyWith(apiError: e.toString()));
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  void _onClearError(OnClearErrorEvent event, Emitter<ExploreState> emit) {
    emit(state.copyWith(apiError: null));
  }
}
