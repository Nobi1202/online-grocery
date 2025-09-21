import 'package:injectable/injectable.dart';
import 'package:online_grocery/domain/core/result.dart';
import 'package:online_grocery/domain/core/usecase.dart';
import 'package:online_grocery/domain/entities/product_detail_entity.dart';
import 'package:online_grocery/domain/repositories/product_repository.dart';

@Injectable()
final class GetProductDetailUsecase
    extends UseCaseAsync<ProductDetailEntity, int> {
  final IProductRepository _productRepository;

  GetProductDetailUsecase(this._productRepository);

  @override
  ResultFuture<ProductDetailEntity> call(int id) {
    return _productRepository.getProductDetail(id);
  }
}
