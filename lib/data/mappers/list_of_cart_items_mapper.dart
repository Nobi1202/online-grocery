import 'package:online_grocery/data/models/response/cart_detail_dto.dart';
import 'package:online_grocery/domain/entities/cart_item_entity.dart';

extension ListOfCartItemsMapper on CartDetailDto {
  ListOfCartItemEntity toEntity() => ListOfCartItemEntity(
    total: carts.first.total,
    listOfCartItems: List.from(
      carts.first.products.map(
        (product) => CartItemEntity(
          id: product.id,
          title: product.title,
          price: product.price,
          thumbnail: product.thumbnail,
          quantity: product.quantity,
          total: product.total,
        ),
      ),
    ),
  );
}
