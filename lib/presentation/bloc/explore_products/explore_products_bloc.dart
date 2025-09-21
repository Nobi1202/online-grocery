import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_grocery/di/injector.dart';
import 'package:online_grocery/domain/usecase/get_all_products_by_category_usecase.dart';
import 'package:online_grocery/presentation/bloc/explore_products/explore_products_event.dart';
import 'package:online_grocery/presentation/bloc/explore_products/explore_products_state.dart';
import 'package:online_grocery/presentation/error/failure_mapper.dart';

class ExploreProductsBloc
    extends Bloc<ExploreProductsEvent, ExploreProductsState> {
  final FailureMapper _failureMapper;
  final GetAllProductsByCategoryUsecase _getAllProductsByCategoryUsecase =
      getIt<GetAllProductsByCategoryUsecase>();

  ExploreProductsBloc(this._failureMapper) : super(ExploreProductsState()) {
    on<OnGetAllProductsByCategoryEvent>(_onGetAllProductsByCategory);
    on<OnClearExploreProductsErrorEvent>(_onClearExploreProductsError);
  }

  Future<void> _onGetAllProductsByCategory(
    OnGetAllProductsByCategoryEvent event,
    Emitter<ExploreProductsState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true));
      final result = await _getAllProductsByCategoryUsecase.call(
        event.category,
      );
      result.fold(
        (failure) => emit(
          state.copyWith(apiError: _failureMapper.mapFailureToMessage(failure)),
        ),
        (productCategoryDetails) => emit(
          state.copyWith(productCategoryDetails: productCategoryDetails),
        ),
      );
    } catch (e) {
      emit(state.copyWith(apiError: e.toString()));
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  void _onClearExploreProductsError(
    OnClearExploreProductsErrorEvent event,
    Emitter<ExploreProductsState> emit,
  ) {
    emit(state.copyWith(apiError: null));
  }
}
