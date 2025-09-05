import 'package:injectable/injectable.dart';
import 'package:online_grocery/data/core/guard.dart';
import 'package:online_grocery/data/datasources/remote/api_service.dart';
import 'package:online_grocery/data/mappers/category_mapper.dart';
import 'package:online_grocery/data/mappers/list_of_product_category_detail_mapper.dart';
import 'package:online_grocery/domain/core/result.dart';
import 'package:online_grocery/domain/entities/category_entity.dart';
import 'package:online_grocery/domain/entities/product_category_detail_entity.dart';
import 'package:online_grocery/domain/repositories/product_repository.dart';

@LazySingleton(as: IProductRepository)
class ProductRepositoryImpl extends IProductRepository {
  final ApiService _apiService;

  ProductRepositoryImpl(this._apiService);

  @override
  ResultFuture<List<CategoryEntity>> getAllProductCategories() {
    return guardDio<List<CategoryEntity>>(() async {
      final dto = await _apiService.getAllProductCategories();
      return dto.map((e) => e.toEntity()).toList();
    });
  }

  @override
  ResultFuture<ListOfProductCategoryDetailEntity> getProductsByCategory(
    String category,
  ) {
    return guardDio<ListOfProductCategoryDetailEntity>(() async {
      final dto = await _apiService.getProductsByCategory(category);
      return dto.toEntity();
    });
  }

  @override
  ResultFuture<void> deleteProduct(int id) {
    return guardDio<void>(() async {
      await _apiService.deleteProduct(id);
    });
  }
}
