abstract class ProductDetailEvent {}

class OnGetProductDetailEvent extends ProductDetailEvent {
  final int id;

  OnGetProductDetailEvent(this.id);
}

class OnClearProductDetailErrorEvent extends ProductDetailEvent {}
