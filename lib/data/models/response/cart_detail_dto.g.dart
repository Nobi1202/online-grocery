// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_detail_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartDetailDto _$CartDetailDtoFromJson(Map<String, dynamic> json) =>
    CartDetailDto(
      carts: (json['carts'] as List<dynamic>)
          .map((e) => SingleCartDetailDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      total: (json['total'] as num).toDouble(),
      skip: (json['skip'] as num).toInt(),
      limit: (json['limit'] as num).toInt(),
    );

Map<String, dynamic> _$CartDetailDtoToJson(CartDetailDto instance) =>
    <String, dynamic>{
      'carts': instance.carts,
      'total': instance.total,
      'skip': instance.skip,
      'limit': instance.limit,
    };

SingleCartDetailDto _$SingleCartDetailDtoFromJson(Map<String, dynamic> json) =>
    SingleCartDetailDto(
      id: (json['id'] as num).toInt(),
      products: (json['products'] as List<dynamic>)
          .map((e) => ProductItemDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      total: (json['total'] as num).toDouble(),
      discountedTotal: (json['discountedTotal'] as num).toDouble(),
      userId: (json['userId'] as num).toInt(),
      totalProducts: (json['totalProducts'] as num).toInt(),
      totalQuantity: (json['totalQuantity'] as num).toInt(),
    );

Map<String, dynamic> _$SingleCartDetailDtoToJson(
  SingleCartDetailDto instance,
) => <String, dynamic>{
  'id': instance.id,
  'products': instance.products,
  'total': instance.total,
  'discountedTotal': instance.discountedTotal,
  'userId': instance.userId,
  'totalProducts': instance.totalProducts,
  'totalQuantity': instance.totalQuantity,
};
