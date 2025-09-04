abstract class CartEvent {}

class OnGetCartItemsEvent extends CartEvent {
  final int id;

  OnGetCartItemsEvent(this.id);
}

class OnClearCartItemsErrorEvent extends CartEvent {}
