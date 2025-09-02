abstract class FavoriteEvent {}

class OnFavoriteItemsEvent extends FavoriteEvent {
  final int id;

  OnFavoriteItemsEvent(this.id);
}

class OnClearErrorEvent extends FavoriteEvent {}
