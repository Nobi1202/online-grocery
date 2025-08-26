import 'package:online_grocery/data/models/response/cart_detail_dto.dart';
import 'package:online_grocery/domain/entities/favorite_item_entity.dart';

extension ListOfFavoriteItemsMapper on SingleCartDetailDto {
  ListOfFavoriteItemEntity toEntity() => ListOfFavoriteItemEntity(
    listOfFavoriteItems: List.from(
      products.map(
        (product) => FavoriteItemEntity(
          id: product.id,
          title: product.title,
          price: product.price,
          thumbnail: product.thumbnail,
        ),
      ),
    ),
  );
}
