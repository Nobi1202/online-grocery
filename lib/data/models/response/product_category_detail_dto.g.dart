// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_category_detail_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductCategoryDetailDto _$ProductCategoryDetailDtoFromJson(
  Map<String, dynamic> json,
) => ProductCategoryDetailDto(
  products: (json['products'] as List<dynamic>)
      .map((e) => ProductDetailDto.fromJson(e as Map<String, dynamic>))
      .toList(),
  total: (json['total'] as num).toInt(),
  skip: (json['skip'] as num).toInt(),
  limit: (json['limit'] as num).toInt(),
);

Map<String, dynamic> _$ProductCategoryDetailDtoToJson(
  ProductCategoryDetailDto instance,
) => <String, dynamic>{
  'products': instance.products.map((e) => e.toJson()).toList(),
  'total': instance.total,
  'skip': instance.skip,
  'limit': instance.limit,
};

ProductDetailDto _$ProductDetailDtoFromJson(Map<String, dynamic> json) =>
    ProductDetailDto(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      description: json['description'] as String,
      category: json['category'] as String,
      price: (json['price'] as num).toDouble(),
      discountPercentage: (json['discountPercentage'] as num).toDouble(),
      rating: (json['rating'] as num).toDouble(),
      stock: (json['stock'] as num).toInt(),
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
      brand: json['brand'] as String,
      sku: json['sku'] as String,
      weight: (json['weight'] as num).toDouble(),
      dimensions: DimensionsDto.fromJson(
        json['dimensions'] as Map<String, dynamic>,
      ),
      warrantyInformation: json['warrantyInformation'] as String,
      shippingInformation: json['shippingInformation'] as String,
      availabilityStatus: json['availabilityStatus'] as String,
      reviews: (json['reviews'] as List<dynamic>)
          .map((e) => ReviewDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      returnPolicy: json['returnPolicy'] as String,
      minimumOrderQuantity: (json['minimumOrderQuantity'] as num).toInt(),
      meta: MetaDto.fromJson(json['meta'] as Map<String, dynamic>),
      images: (json['images'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      thumbnail: json['thumbnail'] as String,
    );

Map<String, dynamic> _$ProductDetailDtoToJson(ProductDetailDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'category': instance.category,
      'price': instance.price,
      'discountPercentage': instance.discountPercentage,
      'rating': instance.rating,
      'stock': instance.stock,
      'tags': instance.tags,
      'brand': instance.brand,
      'sku': instance.sku,
      'weight': instance.weight,
      'dimensions': instance.dimensions.toJson(),
      'warrantyInformation': instance.warrantyInformation,
      'shippingInformation': instance.shippingInformation,
      'availabilityStatus': instance.availabilityStatus,
      'reviews': instance.reviews.map((e) => e.toJson()).toList(),
      'returnPolicy': instance.returnPolicy,
      'minimumOrderQuantity': instance.minimumOrderQuantity,
      'meta': instance.meta.toJson(),
      'images': instance.images,
      'thumbnail': instance.thumbnail,
    };

DimensionsDto _$DimensionsDtoFromJson(Map<String, dynamic> json) =>
    DimensionsDto(
      width: (json['width'] as num).toDouble(),
      height: (json['height'] as num).toDouble(),
      depth: (json['depth'] as num).toDouble(),
    );

Map<String, dynamic> _$DimensionsDtoToJson(DimensionsDto instance) =>
    <String, dynamic>{
      'width': instance.width,
      'height': instance.height,
      'depth': instance.depth,
    };

ReviewDto _$ReviewDtoFromJson(Map<String, dynamic> json) => ReviewDto(
  rating: (json['rating'] as num).toInt(),
  comment: json['comment'] as String,
  date: json['date'] as String,
  reviewerName: json['reviewerName'] as String,
  reviewerEmail: json['reviewerEmail'] as String,
);

Map<String, dynamic> _$ReviewDtoToJson(ReviewDto instance) => <String, dynamic>{
  'rating': instance.rating,
  'comment': instance.comment,
  'date': instance.date,
  'reviewerName': instance.reviewerName,
  'reviewerEmail': instance.reviewerEmail,
};

MetaDto _$MetaDtoFromJson(Map<String, dynamic> json) => MetaDto(
  createdAt: json['createdAt'] as String,
  updatedAt: json['updatedAt'] as String,
  barcode: json['barcode'] as String,
  qrCode: json['qrCode'] as String,
);

Map<String, dynamic> _$MetaDtoToJson(MetaDto instance) => <String, dynamic>{
  'createdAt': instance.createdAt,
  'updatedAt': instance.updatedAt,
  'barcode': instance.barcode,
  'qrCode': instance.qrCode,
};
