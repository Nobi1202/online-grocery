import 'package:equatable/equatable.dart';

class ListOfFavoriteItemEntity extends Equatable {
  final List<FavoriteItemEntity> listOfFavoriteItems;

  const ListOfFavoriteItemEntity({required this.listOfFavoriteItems});

  @override
  List<Object?> get props => [listOfFavoriteItems];
}

class FavoriteItemEntity extends Equatable {
  final int id;
  final String title;
  final double price;
  final String thumbnail;

  const FavoriteItemEntity({
    required this.id,
    required this.title,
    required this.price,
    required this.thumbnail,
  });

  @override
  List<Object?> get props => [id, title, price, thumbnail];
}
