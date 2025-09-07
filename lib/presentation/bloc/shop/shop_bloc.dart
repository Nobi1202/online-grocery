import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:online_grocery/di/injector.dart';
import 'package:online_grocery/domain/core/usecase.dart';
import 'package:online_grocery/domain/entities/product_category_detail_entity.dart';
import 'package:online_grocery/domain/usecase/get_products_usecase.dart';
import 'package:online_grocery/presentation/bloc/shop/shop_event.dart';
import 'package:online_grocery/presentation/bloc/shop/shop_state.dart';
import 'package:online_grocery/presentation/error/failure_mapper.dart';

@injectable
class ShopBloc extends Bloc<ShopEvent, ShopState> {
  final GetProductsUsecase _getUsecase = getIt<GetProductsUsecase>();
  final FailureMapper _failureMapper;

  ShopBloc(@factoryParam this._failureMapper) : super(ShopState()) {
    on<OnGetProductsEvent>(_onGetProductsEvent);
    on<OnClearShopErrorEvent>(_onClearShopErrorEvent);
    on<OnSearchProductsEvent>(_onSearchProductsEvent);
    add(OnGetProductsEvent());
  }

  Future<void> _onGetProductsEvent(
    OnGetProductsEvent event,
    Emitter<ShopState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true));
      final result = await _getUsecase.call(NoParams());
      result.fold(
        (failure) => emit(
          state.copyWith(
            products: null,
            categorizedProducts: null,
            apiError: _failureMapper.mapFailureToMessage(failure),
          ),
        ),
        (products) {
          final categorizedProducts = groupProductsByCategory(products);
          emit(
            state.copyWith(
              products: products,
              categorizedProducts: categorizedProducts,
            ),
          );
        },
      );
    } catch (e) {
      emit(
        state.copyWith(
          products: null,
          categorizedProducts: null,
          apiError: e.toString(),
        ),
      );
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  void _onClearShopErrorEvent(
    OnClearShopErrorEvent event,
    Emitter<ShopState> emit,
  ) {
    emit(state.copyWith(apiError: null));
  }

  void _onSearchProductsEvent(
    OnSearchProductsEvent event,
    Emitter<ShopState> emit,
  ) {
    emit(state.copyWith(apiError: null));
  }

  /// Groups products by their category
  CategorizedProductsEntity groupProductsByCategory(
    ListOfProductCategoryDetailEntity products,
  ) {
    final Map<String, List<ProductCategoryDetailEntity>> groupedProducts = {};

    for (final product in products.listOfProductCategoryDetail) {
      final category = product.category ?? 'Other';

      if (groupedProducts.containsKey(category)) {
        groupedProducts[category]!.add(product);
      } else {
        groupedProducts[category] = [product];
      }
    }

    final categorizedProducts = groupedProducts.entries
        .map(
          (entry) => CategoryProductsEntity(
            categoryName: entry.key,
            products: entry.value,
          ),
        )
        .toList();

    // Sort categories alphabetically, but put 'Other' at the end
    categorizedProducts.sort((a, b) {
      if (a.categoryName == 'Other') return 1;
      if (b.categoryName == 'Other') return -1;
      return a.categoryName.compareTo(b.categoryName);
    });

    return CategorizedProductsEntity(categorizedProducts: categorizedProducts);
  }
}
