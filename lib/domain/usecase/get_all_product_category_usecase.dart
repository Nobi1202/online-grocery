import 'package:injectable/injectable.dart';
import 'package:online_grocery/domain/core/result.dart';
import 'package:online_grocery/domain/core/usecase.dart';
import 'package:online_grocery/domain/entities/category_entity.dart';
import 'package:online_grocery/domain/repositories/product_repository.dart';

@Injectable()
final class GetAllProductCategoryUsecase
    extends UseCaseAsync<List<CategoryEntity>, NoParams> {
  final IProductRepository _productRepository;

  GetAllProductCategoryUsecase(this._productRepository);

  @override
  ResultFuture<List<CategoryEntity>> call(NoParams params) {
    return _productRepository.getAllProductCategories();
  }
}
