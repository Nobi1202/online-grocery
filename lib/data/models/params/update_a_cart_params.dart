import 'package:online_grocery/data/models/request/cart_item_schema.dart';

class UpdateACartParams {
  final int id;
  final CartItemSchema cartItemSchema;

  UpdateACartParams({required this.id, required this.cartItemSchema});
}
