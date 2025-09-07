import 'package:equatable/equatable.dart';
import 'package:online_grocery/domain/entities/product_category_detail_entity.dart';

class ShopState extends Equatable {
  final bool isLoading;
  final ListOfProductCategoryDetailEntity? products;
  final CategorizedProductsEntity? categorizedProducts;
  final String? apiError;

  const ShopState({
    this.isLoading = false,
    this.products,
    this.categorizedProducts,
    this.apiError,
  });

  ShopState copyWith({
    bool? isLoading,
    ListOfProductCategoryDetailEntity? products,
    CategorizedProductsEntity? categorizedProducts,
    String? apiError,
  }) {
    return ShopState(
      isLoading: isLoading ?? this.isLoading,
      products: products ?? this.products,
      categorizedProducts: categorizedProducts ?? this.categorizedProducts,
      apiError: apiError ?? this.apiError,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    products,
    categorizedProducts,
    apiError,
  ];
}
