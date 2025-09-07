import 'package:equatable/equatable.dart';

class ProductCategoryDetailEntity extends Equatable {
  final int id;
  final String title;
  final double price;
  final String thumbnail;
  final double weight;
  final String? category;

  const ProductCategoryDetailEntity({
    required this.id,
    required this.title,
    required this.price,
    required this.thumbnail,
    required this.weight,
    this.category,
  });

  @override
  List<Object?> get props => [id, title, price, thumbnail, weight, category];
}

class ListOfProductCategoryDetailEntity extends Equatable {
  final List<ProductCategoryDetailEntity> listOfProductCategoryDetail;

  const ListOfProductCategoryDetailEntity({
    required this.listOfProductCategoryDetail,
  });

  @override
  List<Object?> get props => [listOfProductCategoryDetail];
}

class CategoryProductsEntity extends Equatable {
  final String categoryName;
  final List<ProductCategoryDetailEntity> products;

  const CategoryProductsEntity({
    required this.categoryName,
    required this.products,
  });

  @override
  List<Object?> get props => [categoryName, products];
}

class CategorizedProductsEntity extends Equatable {
  final List<CategoryProductsEntity> categorizedProducts;

  const CategorizedProductsEntity({required this.categorizedProducts});

  /// Helper method to get products for a specific category
  List<ProductCategoryDetailEntity> getProductsForCategory(String category) {
    final categoryProducts = categorizedProducts
        .where(
          (cat) => cat.categoryName.toLowerCase() == category.toLowerCase(),
        )
        .firstOrNull;
    return categoryProducts?.products ?? [];
  }

  /// Helper method to get all category names
  List<String> getAllCategoryNames() {
    return categorizedProducts.map((cat) => cat.categoryName).toList();
  }

  @override
  List<Object?> get props => [categorizedProducts];
}
