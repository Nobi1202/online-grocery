import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:online_grocery/di/injector.dart';
import 'package:online_grocery/domain/usecase/get_product_detail_usecase.dart';
import 'package:online_grocery/presentation/bloc/product_detail/product_detail_event.dart';
import 'package:online_grocery/presentation/bloc/product_detail/product_detail_state.dart';
import 'package:online_grocery/presentation/error/failure_mapper.dart';

@injectable
class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  final GetProductDetailUsecase _getUsecase = getIt<GetProductDetailUsecase>();
  final FailureMapper _failureMapper;

  ProductDetailBloc(@factoryParam this._failureMapper)
    : super(ProductDetailState()) {
    on<OnGetProductDetailEvent>(_onGetProductDetailEvent);
    on<OnClearProductDetailErrorEvent>(_onClearProductDetailErrorEvent);
  }

  Future<void> _onGetProductDetailEvent(
    OnGetProductDetailEvent event,
    Emitter<ProductDetailState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true));
      final result = await _getUsecase.call(event.id);
      result.fold(
        (failure) => emit(
          state.copyWith(
            productDetail: null,
            apiError: _failureMapper.mapFailureToMessage(failure),
          ),
        ),
        (productDetail) {
          emit(state.copyWith(productDetail: productDetail));
        },
      );
    } catch (e) {
      emit(state.copyWith(productDetail: null, apiError: e.toString()));
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  void _onClearProductDetailErrorEvent(
    OnClearProductDetailErrorEvent event,
    Emitter<ProductDetailState> emit,
  ) {
    emit(state.copyWith(apiError: null));
  }
}
