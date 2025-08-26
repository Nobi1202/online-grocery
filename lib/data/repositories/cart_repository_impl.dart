import 'package:injectable/injectable.dart';
import 'package:online_grocery/data/core/guard.dart';
import 'package:online_grocery/data/datasources/remote/api_service.dart';
import 'package:online_grocery/data/mappers/list_of_cart_items_mapper.dart';
import 'package:online_grocery/data/mappers/list_of_favorite_items_mapper.dart';
import 'package:online_grocery/domain/core/result.dart';
import 'package:online_grocery/domain/entities/cart_item_entity.dart';
import 'package:online_grocery/domain/entities/favorite_item_entity.dart';
import 'package:online_grocery/domain/repositories/cart_repository.dart';

@LazySingleton(as: ICartRepository)
class CartRepositoryImpl extends ICartRepository {
  final ApiService _apiService;

  CartRepositoryImpl(this._apiService);

  @override
  ResultFuture<ListOfCartItemEntity> getCartItems(int id) {
    return guardDio<ListOfCartItemEntity>(() async {
      final dto = await _apiService.getCartItems(id);
      return dto.toEntity();
    });
  }

  @override
  ResultFuture<ListOfFavoriteItemEntity> getFavoriteItems(int id) {
    return guardDio<ListOfFavoriteItemEntity>(() async {
      final dto = await _apiService.getFavoriteItems(id);
      return dto.toEntity();
    });
  }
}
