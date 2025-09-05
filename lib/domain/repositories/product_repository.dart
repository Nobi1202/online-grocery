import 'package:online_grocery/domain/core/result.dart';
import 'package:online_grocery/domain/entities/category_entity.dart';
import 'package:online_grocery/domain/entities/product_category_detail_entity.dart';

abstract class IProductRepository {
  ResultFuture<List<CategoryEntity>> getAllProductCategories();

  ResultFuture<ListOfProductCategoryDetailEntity> getProductsByCategory(
    String category,
  );

  ResultFuture<void> deleteProduct(int id);
}
