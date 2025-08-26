abstract class FavoriteEvent {}

class OnFavoriteItemsEvent extends FavoriteEvent {
  final int id;

  OnFavoriteItemsEvent(this.id);
}
