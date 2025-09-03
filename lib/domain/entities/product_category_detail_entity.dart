import 'package:equatable/equatable.dart';

class ProductCategoryDetailEntity extends Equatable {
  final int id;
  final String title;
  final double price;
  final String thumbnail;
  final double weight;

  const ProductCategoryDetailEntity({
    required this.id,
    required this.title,
    required this.price,
    required this.thumbnail,
    required this.weight,
  });

  @override
  List<Object?> get props => [id, title, price, thumbnail, weight];
}

class ListOfProductCategoryDetailEntity extends Equatable {
  final List<ProductCategoryDetailEntity> listOfProductCategoryDetail;

  const ListOfProductCategoryDetailEntity({
    required this.listOfProductCategoryDetail,
  });

  @override
  List<Object?> get props => [listOfProductCategoryDetail];
}
