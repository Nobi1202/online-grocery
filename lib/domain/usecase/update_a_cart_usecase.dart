import 'package:injectable/injectable.dart';
import 'package:online_grocery/data/models/params/update_a_cart_params.dart';
import 'package:online_grocery/domain/core/result.dart';
import 'package:online_grocery/domain/core/usecase.dart';
import 'package:online_grocery/domain/repositories/cart_repository.dart';

@Injectable()
final class UpdateACartUsecase extends UseCaseAsync<void, UpdateACartParams> {
  final ICartRepository _cartRepository;

  UpdateACartUsecase(this._cartRepository);

  @override
  ResultFuture<void> call(UpdateACartParams params) {
    return _cartRepository.updateCartItem(params);
  }
}
