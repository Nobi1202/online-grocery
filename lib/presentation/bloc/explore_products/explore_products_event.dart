abstract class ExploreProductsEvent {}

class OnGetAllProductsByCategoryEvent extends ExploreProductsEvent {
  final String category;

  OnGetAllProductsByCategoryEvent(this.category);
}

class OnClearExploreProductsErrorEvent extends ExploreProductsEvent {}
