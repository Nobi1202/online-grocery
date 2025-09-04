import 'package:equatable/equatable.dart';
import 'package:online_grocery/domain/entities/product_category_detail_entity.dart';

class ExploreProductsState extends Equatable {
  final bool isLoading;
  final ListOfProductCategoryDetailEntity? productCategoryDetails;
  final String? apiError;

  const ExploreProductsState({
    this.isLoading = false,
    this.productCategoryDetails,
    this.apiError,
  });

  ExploreProductsState copyWith({
    bool? isLoading,
    ListOfProductCategoryDetailEntity? productCategoryDetails,
    String? apiError,
  }) {
    return ExploreProductsState(
      isLoading: isLoading ?? this.isLoading,
      productCategoryDetails:
          productCategoryDetails ?? this.productCategoryDetails,
      apiError: apiError ?? this.apiError,
    );
  }

  @override
  List<Object?> get props => [isLoading, productCategoryDetails, apiError];
}
