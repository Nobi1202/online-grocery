import 'package:online_grocery/data/models/response/product_category_detail_dto.dart';
import 'package:online_grocery/domain/entities/product_detail_entity.dart';

extension ProductDetailMapper on ProductDetailDto {
  ProductDetailEntity toEntity() => ProductDetailEntity(
    id: id,
    title: title,
    description: description,
    price: price,
    rating: rating ?? 1,
    images: images,
  );
}
