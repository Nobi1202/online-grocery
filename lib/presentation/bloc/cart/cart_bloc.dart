import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:online_grocery/domain/usecase/get_cart_items_usecase.dart';
import 'package:online_grocery/presentation/bloc/cart/cart_event.dart';
import 'package:online_grocery/presentation/bloc/cart/cart_state.dart';

@injectable
class CartBloc extends Bloc<CartEvent, CartState> {
  final GetCartItemsUsecase _getCartItemsUsecase;

  CartBloc(this._getCartItemsUsecase) : super(CartState()) {
    on<OnCartItemsEvent>(_onCartItems);
    add(OnCartItemsEvent(1));
  }

  Future<void> _onCartItems(
    OnCartItemsEvent event,
    Emitter<CartState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true));
      final result = await _getCartItemsUsecase.call(event.id);
      result.fold(
        (failure) =>
            emit(state.copyWith(cartItems: null, apiError: failure.toString())),
        (cartItems) => emit(state.copyWith(cartItems: cartItems)),
      );
    } catch (e) {
      emit(state.copyWith(cartItems: null, apiError: e.toString()));
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }
}
