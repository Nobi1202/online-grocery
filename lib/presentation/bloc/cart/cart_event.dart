import 'package:online_grocery/data/models/params/update_a_cart_params.dart';

abstract class CartEvent {}

class OnGetCartItemsEvent extends CartEvent {
  final int id;

  OnGetCartItemsEvent(this.id);
}

class OnClearCartItemsErrorEvent extends CartEvent {}

class OnUpdateCartItemEvent extends CartEvent {
  final UpdateACartParams params;

  OnUpdateCartItemEvent(this.params);
}

class OnDeleteCartItemEvent extends CartEvent {
  final int id;

  OnDeleteCartItemEvent(this.id);
}
