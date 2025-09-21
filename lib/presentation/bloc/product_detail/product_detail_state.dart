import 'package:equatable/equatable.dart';
import 'package:online_grocery/domain/entities/product_detail_entity.dart';

class ProductDetailState extends Equatable {
  final bool isLoading;
  final ProductDetailEntity? productDetail;
  final String? apiError;

  const ProductDetailState({
    this.isLoading = false,
    this.productDetail,
    this.apiError,
  });

  ProductDetailState copyWith({
    bool? isLoading,
    ProductDetailEntity? productDetail,
    String? apiError,
  }) {
    return ProductDetailState(
      isLoading: isLoading ?? this.isLoading,
      productDetail: productDetail ?? this.productDetail,
      apiError: apiError ?? this.apiError,
    );
  }

  @override
  List<Object?> get props => [isLoading, productDetail, apiError];
}
