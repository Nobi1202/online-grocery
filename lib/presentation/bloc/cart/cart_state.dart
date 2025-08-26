import 'package:equatable/equatable.dart';
import 'package:online_grocery/domain/entities/cart_item_entity.dart';

class CartState extends Equatable {
  final bool isLoading;
  final ListOfCartItemEntity? cartItems;
  final String? apiError;

  const CartState({this.isLoading = false, this.cartItems, this.apiError});

  CartState copyWith({
    bool? isLoading,
    ListOfCartItemEntity? cartItems,
    String? apiError,
  }) {
    return CartState(
      isLoading: isLoading ?? this.isLoading,
      cartItems: cartItems ?? this.cartItems,
      apiError: apiError ?? this.apiError,
    );
  }

  @override
  List<Object?> get props => [isLoading, cartItems, apiError];
}
