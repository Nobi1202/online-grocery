import 'package:equatable/equatable.dart';
import 'package:online_grocery/domain/entities/category_entity.dart';

class ExploreState extends Equatable {
  final bool isLoading;
  final List<CategoryEntity> productCategories;
  final String? apiError;

  const ExploreState({
    this.isLoading = false,
    this.productCategories = const [],
    this.apiError,
  });

  ExploreState copyWith({
    bool? isLoading,
    List<CategoryEntity>? productCategories,
    String? apiError,
  }) {
    return ExploreState(
      isLoading: isLoading ?? this.isLoading,
      productCategories: productCategories ?? this.productCategories,
      apiError: apiError ?? this.apiError,
    );
  }

  @override
  List<Object?> get props => [isLoading, productCategories, apiError];
}
