import 'package:injectable/injectable.dart';
import 'package:online_grocery/domain/core/result.dart';
import 'package:online_grocery/domain/core/usecase.dart';
import 'package:online_grocery/domain/repositories/product_repository.dart';

@Injectable()
final class DeleteAProductUsecase extends UseCaseAsync<void, int> {
  final IProductRepository _productRepository;

  DeleteAProductUsecase(this._productRepository);

  @override
  ResultFuture<void> call(int id) {
    return _productRepository.deleteProduct(id);
  }
}
