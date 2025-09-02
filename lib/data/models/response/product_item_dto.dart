// {
//     "id": 44,
//     "title": "Family Tree Photo Frame",
//     "price": 29.99,
//     "quantity": 5,
//     "total": 149.95,
//     "discountPercentage": 10.68,
//     "discountedTotal": 133.94,
//     "thumbnail": "https://cdn.dummyjson.com/products/images/home-decoration/Family%20Tree%20Photo%20Frame/thumbnail.png"
// },

import 'package:json_annotation/json_annotation.dart';

part 'product_item_dto.g.dart';

@JsonSerializable()
class ProductItemDto {
  final int id;
  final String title;
  final double price;
  final int quantity;
  final double total;
  final double discountPercentage;
  final double discountedTotal;
  final String thumbnail;

  ProductItemDto({
    required this.id,
    required this.title,
    required this.price,
    required this.quantity,
    required this.total,
    required this.discountPercentage,
    required this.discountedTotal,
    required this.thumbnail,
  });

  factory ProductItemDto.fromJson(Map<String, dynamic> json) =>
      _$ProductItemDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ProductItemDtoToJson(this);
}
