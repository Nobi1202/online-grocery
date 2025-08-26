import 'package:equatable/equatable.dart';

class ListOfCartItemEntity extends Equatable {
  final List<CartItemEntity> listOfCartItems;
  final double total;

  const ListOfCartItemEntity({
    required this.listOfCartItems,
    required this.total,
  });

  @override
  List<Object?> get props => [listOfCartItems, total];
}

class CartItemEntity extends Equatable {
  final int id;
  final String title;
  final double price;
  final String thumbnail;
  final int quantity;
  final double total;

  const CartItemEntity({
    required this.id,
    required this.title,
    required this.price,
    required this.thumbnail,
    required this.quantity,
    required this.total,
  });

  @override
  List<Object?> get props => [id, title, price, thumbnail, quantity, total];
}
