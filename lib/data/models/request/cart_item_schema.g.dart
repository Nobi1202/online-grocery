// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_item_schema.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartItemSchema _$CartItemSchemaFromJson(Map<String, dynamic> json) =>
    CartItemSchema(
      merge: json['merge'] as bool,
      products: (json['products'] as List<dynamic>)
          .map((e) => ProductItemSchema.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CartItemSchemaToJson(CartItemSchema instance) =>
    <String, dynamic>{'merge': instance.merge, 'products': instance.products};

ProductItemSchema _$ProductItemSchemaFromJson(Map<String, dynamic> json) =>
    ProductItemSchema(
      id: (json['id'] as num).toInt(),
      quantity: (json['quantity'] as num).toInt(),
    );

Map<String, dynamic> _$ProductItemSchemaToJson(ProductItemSchema instance) =>
    <String, dynamic>{'id': instance.id, 'quantity': instance.quantity};
