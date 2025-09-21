import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:online_grocery/di/injector.dart';
import 'package:online_grocery/domain/entities/cart_item_entity.dart';
import 'package:online_grocery/domain/usecase/delete_a_product_usecase.dart';
import 'package:online_grocery/domain/usecase/get_cart_items_usecase.dart';
import 'package:online_grocery/domain/usecase/update_a_cart_usecase.dart';
import 'package:online_grocery/presentation/bloc/cart/cart_event.dart';
import 'package:online_grocery/presentation/bloc/cart/cart_state.dart';
import 'package:online_grocery/presentation/error/failure_mapper.dart';

@injectable
class CartBloc extends Bloc<CartEvent, CartState> {
  final GetCartItemsUsecase _getCartItemsUsecase = getIt<GetCartItemsUsecase>();
  final UpdateACartUsecase _updateCartItemUsecase = getIt<UpdateACartUsecase>();
  final DeleteAProductUsecase _deleteCartItemUsecase =
      getIt<DeleteAProductUsecase>();
  final FailureMapper _failureMapper;

  CartBloc(@factoryParam this._failureMapper) : super(CartState()) {
    on<OnGetCartItemsEvent>(_onCartItems);
    on<OnClearCartItemsErrorEvent>(_onClearCartItemsError);
    on<OnUpdateCartItemEvent>(_onUpdateCartItem);
    on<OnDeleteCartItemEvent>(_onDeleteCartItem);
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

  Future<void> _onUpdateCartItem(
    OnUpdateCartItemEvent event,
    Emitter<CartState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true));
      final result = await _updateCartItemUsecase.call(event.params);
      result.fold(
        (failure) => emit(
          state.copyWith(
            cartItems: null,
            apiError: _failureMapper.mapFailureToMessage(failure),
          ),
        ),
        (cartItems) {
          // Keep the existing items and only update the one that matches the ID
          final updatedItem = cartItems.listOfCartItems.firstWhere(
            (item) => item.id == event.params.cartItemSchema.products.first.id,
          );

          final updatedCartItems = state.cartItems?.listOfCartItems.map((item) {
            return item.id == event.params.cartItemSchema.products.first.id
                ? updatedItem
                : item;
          }).toList();

          emit(
            state.copyWith(
              cartItems: ListOfCartItemEntity(
                listOfCartItems: updatedCartItems ?? [],
                total: cartItems.total,
              ),
            ),
          );
        },
      );
    } catch (e) {
      emit(state.copyWith(cartItems: null, apiError: e.toString()));
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> _onDeleteCartItem(
    OnDeleteCartItemEvent event,
    Emitter<CartState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true));
      final result = await _deleteCartItemUsecase.call(event.id);
      result.fold(
        (failure) => emit(
          state.copyWith(
            cartItems: null,
            apiError: _failureMapper.mapFailureToMessage(failure),
          ),
        ),
        (cartItems) {
          final newCartItems = state.cartItems?.listOfCartItems
              .where((element) => element.id != event.id)
              .toList();
          emit(
            state.copyWith(
              cartItems: ListOfCartItemEntity(
                listOfCartItems: newCartItems ?? [],
                total: state.cartItems?.total ?? 0,
              ),
            ),
          );
        },
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
