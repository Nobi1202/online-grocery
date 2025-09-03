// [
//   {
//     "slug": "beauty",
//     "name": "Beauty",
//     "url": "https://dummyjson.com/products/category/beauty"
//   },
// ]

import 'package:json_annotation/json_annotation.dart';

part 'category_dto.g.dart';

@JsonSerializable()
class CategoryDto {
  final String slug;
  final String name;
  final String url;

  CategoryDto({required this.slug, required this.name, required this.url});

  factory CategoryDto.fromJson(Map<String, dynamic> json) =>
      _$CategoryDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryDtoToJson(this);
}
