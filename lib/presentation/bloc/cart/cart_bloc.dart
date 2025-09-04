import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:online_grocery/di/injector.dart';
import 'package:online_grocery/domain/usecase/get_cart_items_usecase.dart';
import 'package:online_grocery/presentation/bloc/cart/cart_event.dart';
import 'package:online_grocery/presentation/bloc/cart/cart_state.dart';
import 'package:online_grocery/presentation/error/failure_mapper.dart';

@injectable
class CartBloc extends Bloc<CartEvent, CartState> {
  final GetCartItemsUsecase _getCartItemsUsecase = getIt<GetCartItemsUsecase>();
  final FailureMapper _failureMapper;

  CartBloc(@factoryParam this._failureMapper) : super(CartState()) {
    on<OnGetCartItemsEvent>(_onCartItems);
    on<OnClearCartItemsErrorEvent>(_onClearCartItemsError);
    add(OnGetCartItemsEvent(15));
  }

  Future<void> _onCartItems(
    OnGetCartItemsEvent event,
    Emitter<CartState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true));
      final result = await _getCartItemsUsecase.call(event.id);
      result.fold(
        (failure) => emit(
          state.copyWith(
            cartItems: null,
            apiError: _failureMapper.mapFailureToMessage(failure),
          ),
        ),
        (cartItems) => emit(state.copyWith(cartItems: cartItems)),
      );
    } catch (e) {
      emit(state.copyWith(cartItems: null, apiError: e.toString()));
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  void _onClearCartItemsError(
    OnClearCartItemsErrorEvent event,
    Emitter<CartState> emit,
  ) {
    emit(state.copyWith(apiError: null));
  }
}
