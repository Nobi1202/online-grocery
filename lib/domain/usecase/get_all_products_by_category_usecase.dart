import 'package:injectable/injectable.dart';
import 'package:online_grocery/domain/core/result.dart';
import 'package:online_grocery/domain/core/usecase.dart';
import 'package:online_grocery/domain/entities/product_category_detail_entity.dart';
import 'package:online_grocery/domain/repositories/product_repository.dart';

@Injectable()
final class GetAllProductsByCategoryUsecase
    extends UseCaseAsync<ListOfProductCategoryDetailEntity, String> {
  final IProductRepository _productRepository;

  GetAllProductsByCategoryUsecase(this._productRepository);

  @override
  ResultFuture<ListOfProductCategoryDetailEntity> call(String category) {
    return _productRepository.getProductsByCategory(category);
  }
}
