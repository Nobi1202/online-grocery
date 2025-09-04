import 'package:online_grocery/data/models/response/product_category_detail_dto.dart';
import 'package:online_grocery/domain/entities/product_category_detail_entity.dart';

extension ListOfProductCategoryDetailMapper on ProductCategoryDetailDto {
  ListOfProductCategoryDetailEntity toEntity() {
    if (products.isEmpty) {
      return ListOfProductCategoryDetailEntity(listOfProductCategoryDetail: []);
    }
    return ListOfProductCategoryDetailEntity(
      listOfProductCategoryDetail: List.from(
        products.map(
          (product) => ProductCategoryDetailEntity(
            id: product.id,
            title: product.title,
            price: product.price,
            thumbnail: product.thumbnail ?? '',
            weight: product.weight,
          ),
        ),
      ),
    );
  }
}
