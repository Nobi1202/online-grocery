import 'package:injectable/injectable.dart';
import 'package:online_grocery/domain/core/result.dart';
import 'package:online_grocery/domain/core/usecase.dart';
import 'package:online_grocery/domain/entities/product_category_detail_entity.dart';
import 'package:online_grocery/domain/repositories/product_repository.dart';

@Injectable()
final class GetProductsUsecase
    extends UseCaseAsync<ListOfProductCategoryDetailEntity, NoParams> {
  final IProductRepository _productRepository;

  GetProductsUsecase(this._productRepository);

  @override
  ResultFuture<ListOfProductCategoryDetailEntity> call(NoParams params) {
    return _productRepository.getProducts();
  }
}
