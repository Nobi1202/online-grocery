import 'package:json_annotation/json_annotation.dart';

part 'cart_item_schema.g.dart';

// merge: true, // this will include existing products in the cart
// products: [
//   {
//     id: 1,
//     quantity: 1,
//   },
// ]

@JsonSerializable()
class CartItemSchema {
  final bool merge;
  final List<ProductItemSchema> products;

  CartItemSchema({required this.merge, required this.products});

  factory CartItemSchema.fromJson(Map<String, dynamic> json) =>
      _$CartItemSchemaFromJson(json);

  Map<String, dynamic> toJson() => _$CartItemSchemaToJson(this);
}

@JsonSerializable()
class ProductItemSchema {
  final int id;
  final int quantity;

  ProductItemSchema({required this.id, required this.quantity});

  factory ProductItemSchema.fromJson(Map<String, dynamic> json) =>
      _$ProductItemSchemaFromJson(json);

  Map<String, dynamic> toJson() => _$ProductItemSchemaToJson(this);
}
