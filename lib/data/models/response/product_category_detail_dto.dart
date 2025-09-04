// {
//     "products": [
//         {
//             "id": 121,
//             "title": "iPhone 5s",
//             "description": "The iPhone 5s is a classic smartphone known for its compact design and advanced features during its release. While it's an older model, it still provides a reliable user experience.",
//             "category": "smartphones",
//             "price": 199.99,
//             "discountPercentage": 12.91,
//             "rating": 2.83,
//             "stock": 25,
//             "tags": [
//                 "smartphones",
//                 "apple"
//             ],
//             "brand": "Apple",
//             "sku": "SMA-APP-IPH-121",
//             "weight": 2,
//             "dimensions": {
//                 "width": 5.29,
//                 "height": 18.38,
//                 "depth": 17.72
//             },
//             "warrantyInformation": "Lifetime warranty",
//             "shippingInformation": "Ships in 1 month",
//             "availabilityStatus": "In Stock",
//             "reviews": [
//                 {
//                     "rating": 5,
//                     "comment": "Highly recommended!",
//                     "date": "2025-04-30T09:41:02.054Z",
//                     "reviewerName": "Jace Smith",
//                     "reviewerEmail": "jace.smith@x.dummyjson.com"
//                 },
//                 {
//                     "rating": 1,
//                     "comment": "Not as described!",
//                     "date": "2025-04-30T09:41:02.054Z",
//                     "reviewerName": "Logan Torres",
//                     "reviewerEmail": "logan.torres@x.dummyjson.com"
//                 },
//                 {
//                     "rating": 5,
//                     "comment": "Very satisfied!",
//                     "date": "2025-04-30T09:41:02.054Z",
//                     "reviewerName": "Harper Kelly",
//                     "reviewerEmail": "harper.kelly@x.dummyjson.com"
//                 }
//             ],
//             "returnPolicy": "60 days return policy",
//             "minimumOrderQuantity": 3,
//             "meta": {
//                 "createdAt": "2025-04-30T09:41:02.054Z",
//                 "updatedAt": "2025-04-30T09:41:02.054Z",
//                 "barcode": "8814683940853",
//                 "qrCode": "https://cdn.dummyjson.com/public/qr-code.png"
//             },
//             "images": [
//                 "https://cdn.dummyjson.com/product-images/smartphones/iphone-5s/1.webp",
//                 "https://cdn.dummyjson.com/product-images/smartphones/iphone-5s/2.webp",
//                 "https://cdn.dummyjson.com/product-images/smartphones/iphone-5s/3.webp"
//             ],
//             "thumbnail": "https://cdn.dummyjson.com/product-images/smartphones/iphone-5s/thumbnail.webp"
//         },
//     ],
//     "total": 16,
//     "skip": 0,
//     "limit": 16
// }

import 'package:json_annotation/json_annotation.dart';

part 'product_category_detail_dto.g.dart';

/// explicitToJson: true is used to generate the toJson method for each class
/// for classes that have nested classes to ensure proper JSON serialization
@JsonSerializable(explicitToJson: true)
class ProductCategoryDetailDto {
  final List<ProductDetailDto> products;
  final int total;
  final int skip;
  final int limit;

  ProductCategoryDetailDto({
    required this.products,
    required this.total,
    required this.skip,
    required this.limit,
  });

  factory ProductCategoryDetailDto.fromJson(Map<String, dynamic> json) =>
      _$ProductCategoryDetailDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ProductCategoryDetailDtoToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ProductDetailDto {
  final int id;
  final String title;
  final String description;
  final String category;
  final double price;
  final double discountPercentage;
  final double? rating;
  final int? stock;
  final List<String>? tags;
  final String? brand;
  final String? sku;
  final double weight;
  final DimensionsDto? dimensions;
  final String? warrantyInformation;
  final String? shippingInformation;
  final String? availabilityStatus;
  final List<ReviewDto>? reviews;
  final String? returnPolicy;
  final int? minimumOrderQuantity;
  final MetaDto? meta;
  final List<String>? images;
  final String? thumbnail;

  ProductDetailDto({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.price,
    required this.discountPercentage,
    this.rating,
    this.stock,
    this.tags,
    this.brand,
    this.sku,
    required this.weight,
    this.dimensions,
    this.warrantyInformation,
    this.shippingInformation,
    this.availabilityStatus,
    this.reviews,
    this.returnPolicy,
    this.minimumOrderQuantity,
    this.meta,
    this.images,
    this.thumbnail,
  });

  factory ProductDetailDto.fromJson(Map<String, dynamic> json) =>
      _$ProductDetailDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ProductDetailDtoToJson(this);
}

@JsonSerializable()
class DimensionsDto {
  final double width;
  final double height;
  final double depth;

  DimensionsDto({
    required this.width,
    required this.height,
    required this.depth,
  });

  factory DimensionsDto.fromJson(Map<String, dynamic> json) =>
      _$DimensionsDtoFromJson(json);

  Map<String, dynamic> toJson() => _$DimensionsDtoToJson(this);
}

@JsonSerializable()
class ReviewDto {
  final int? rating;
  final String? comment;
  final String? date;
  final String? reviewerName;
  final String? reviewerEmail;

  ReviewDto({
    this.rating,
    this.comment,
    this.date,
    this.reviewerName,
    this.reviewerEmail,
  });

  factory ReviewDto.fromJson(Map<String, dynamic> json) =>
      _$ReviewDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewDtoToJson(this);
}

@JsonSerializable()
class MetaDto {
  final String? createdAt;
  final String? updatedAt;
  final String? barcode;
  final String? qrCode;

  MetaDto({this.createdAt, this.updatedAt, this.barcode, this.qrCode});

  factory MetaDto.fromJson(Map<String, dynamic> json) =>
      _$MetaDtoFromJson(json);

  Map<String, dynamic> toJson() => _$MetaDtoToJson(this);
}
