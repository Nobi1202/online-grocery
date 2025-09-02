abstract class CartEvent {}

class OnCartItemsEvent extends CartEvent {
  final int id;

  OnCartItemsEvent(this.id);
}
