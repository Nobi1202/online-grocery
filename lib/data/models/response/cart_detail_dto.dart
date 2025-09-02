// {
//     "carts": [
//         {
//             "id": 38,
//             "products": [
//                 {
//                     "id": 44,
//                     "title": "Family Tree Photo Frame",
//                     "price": 29.99,
//                     "quantity": 5,
//                     "total": 149.95,
//                     "discountPercentage": 10.68,
//                     "discountedTotal": 133.94,
//                     "thumbnail": "https://cdn.dummyjson.com/products/images/home-decoration/Family%20Tree%20Photo%20Frame/thumbnail.png"
//                 },
//                 {
//                     "id": 68,
//                     "title": "Pan",
//                     "price": 24.99,
//                     "quantity": 3,
//                     "total": 74.97,
//                     "discountPercentage": 5.16,
//                     "discountedTotal": 71.1,
//                     "thumbnail": "https://cdn.dummyjson.com/products/images/kitchen-accessories/Pan/thumbnail.png"
//                 },
//                 {
//                     "id": 149,
//                     "title": "Iron Golf",
//                     "price": 49.99,
//                     "quantity": 4,
//                     "total": 199.96,
//                     "discountPercentage": 12.89,
//                     "discountedTotal": 174.19,
//                     "thumbnail": "https://cdn.dummyjson.com/products/images/sports-accessories/Iron%20Golf/thumbnail.png"
//                 },
//                 {
//                     "id": 139,
//                     "title": "Baseball Glove",
//                     "price": 24.99,
//                     "quantity": 3,
//                     "total": 74.97,
//                     "discountPercentage": 12.13,
//                     "discountedTotal": 65.88,
//                     "thumbnail": "https://cdn.dummyjson.com/products/images/sports-accessories/Baseball%20Glove/thumbnail.png"
//                 },
//                 {
//                     "id": 150,
//                     "title": "Metal Baseball Bat",
//                     "price": 29.99,
//                     "quantity": 2,
//                     "total": 59.98,
//                     "discountPercentage": 18.43,
//                     "discountedTotal": 48.93,
//                     "thumbnail": "https://cdn.dummyjson.com/products/images/sports-accessories/Metal%20Baseball%20Bat/thumbnail.png"
//                 },
//                 {
//                     "id": 133,
//                     "title": "Samsung Galaxy S10",
//                     "price": 699.99,
//                     "quantity": 4,
//                     "total": 2799.96,
//                     "discountPercentage": 1.12,
//                     "discountedTotal": 2768.6,
//                     "thumbnail": "https://cdn.dummyjson.com/products/images/smartphones/Samsung%20Galaxy%20S10/thumbnail.png"
//                 }
//             ],
//             "total": 3359.79,
//             "discountedTotal": 3262.64,
//             "userId": 15,
//             "totalProducts": 6,
//             "totalQuantity": 21
//         }
//     ],
//     "total": 1,
//     "skip": 0,
//     "limit": 1
// }

import 'package:json_annotation/json_annotation.dart';

import 'product_item_dto.dart';

part 'cart_detail_dto.g.dart';

@JsonSerializable()
class CartDetailDto {
  final List<SingleCartDetailDto> carts;
  final double total;
  final int skip;
  final int limit;

  CartDetailDto({
    required this.carts,
    required this.total,
    required this.skip,
    required this.limit,
  });

  factory CartDetailDto.fromJson(Map<String, dynamic> json) =>
      _$CartDetailDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CartDetailDtoToJson(this);
}

@JsonSerializable()
class SingleCartDetailDto {
  final int id;
  final List<ProductItemDto> products;
  final double total;
  final double discountedTotal;
  final int userId;
  final int totalProducts;
  final int totalQuantity;

  SingleCartDetailDto({
    required this.id,
    required this.products,
    required this.total,
    required this.discountedTotal,
    required this.userId,
    required this.totalProducts,
    required this.totalQuantity,
  });

  factory SingleCartDetailDto.fromJson(Map<String, dynamic> json) =>
      _$SingleCartDetailDtoFromJson(json);

  Map<String, dynamic> toJson() => _$SingleCartDetailDtoToJson(this);
}
