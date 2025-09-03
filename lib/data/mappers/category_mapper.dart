import 'package:online_grocery/data/models/response/category_dto.dart';
import 'package:online_grocery/domain/entities/category_entity.dart';

extension CategoryMapper on CategoryDto {
  CategoryEntity toEntity() => CategoryEntity(slug: slug, name: name, url: url);
}
