import 'package:online_grocery/data/models/params/update_a_cart_params.dart';
import 'package:online_grocery/domain/core/result.dart';
import 'package:online_grocery/domain/entities/cart_item_entity.dart';
import 'package:online_grocery/domain/entities/favorite_item_entity.dart';

abstract class ICartRepository {
  ResultFuture<ListOfCartItemEntity> getCartItems(int id);

  ResultFuture<ListOfFavoriteItemEntity> getFavoriteItems(int id);

  ResultFuture<void> updateCartItem(UpdateACartParams params);
}
