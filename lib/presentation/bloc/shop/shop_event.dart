abstract class ShopEvent {}

class OnGetProductsEvent extends ShopEvent {}

class OnClearShopErrorEvent extends ShopEvent {}

class OnSearchProductsEvent extends ShopEvent {
  final String searchQuery;

  OnSearchProductsEvent(this.searchQuery);
}
