import 'package:injectable/injectable.dart';
import 'package:online_grocery/domain/core/result.dart';
import 'package:online_grocery/domain/core/usecase.dart';
import 'package:online_grocery/domain/entities/favorite_item_entity.dart';
import 'package:online_grocery/domain/repositories/cart_repository.dart';

@Injectable()
final class GetFavoriteItemsUsecase
    extends UseCaseAsync<ListOfFavoriteItemEntity, int> {
  final ICartRepository _cartRepository;

  GetFavoriteItemsUsecase(this._cartRepository);

  @override
  ResultFuture<ListOfFavoriteItemEntity> call(int id) {
    return _cartRepository.getFavoriteItems(id);
  }
}
