import 'package:injectable/injectable.dart';
import 'package:online_grocery/domain/core/result.dart';
import 'package:online_grocery/domain/core/usecase.dart';
import 'package:online_grocery/domain/entities/cart_item_entity.dart';
import 'package:online_grocery/domain/repositories/cart_repository.dart';

@Injectable()
final class GetCartItemsUsecase
    extends UseCaseAsync<ListOfCartItemEntity, int> {
  final ICartRepository _cartRepository;

  GetCartItemsUsecase(this._cartRepository);

  @override
  ResultFuture<ListOfCartItemEntity> call(int id) {
    return _cartRepository.getCartItems(id);
  }
}
