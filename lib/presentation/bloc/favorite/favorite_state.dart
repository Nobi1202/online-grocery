import 'package:equatable/equatable.dart';
import 'package:online_grocery/domain/entities/favorite_item_entity.dart';

class FavoriteState extends Equatable {
  final bool isLoading;
  final ListOfFavoriteItemEntity? favoriteItems;
  final String? apiError;

  const FavoriteState({
    this.isLoading = false,
    this.favoriteItems,
    this.apiError,
  });

  FavoriteState copyWith({
    bool? isLoading,
    ListOfFavoriteItemEntity? favoriteItems,
    String? apiError,
  }) {
    return FavoriteState(
      isLoading: isLoading ?? this.isLoading,
      favoriteItems: favoriteItems ?? this.favoriteItems,
      apiError: apiError ?? this.apiError,
    );
  }

  @override
  List<Object?> get props => [isLoading, favoriteItems, apiError];
}
