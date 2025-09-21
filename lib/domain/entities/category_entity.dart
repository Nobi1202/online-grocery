import 'package:equatable/equatable.dart';

class CategoryEntity extends Equatable {
  final String slug;
  final String name;
  final String url;

  const CategoryEntity({
    required this.slug,
    required this.name,
    required this.url,
  });

  @override
  List<Object?> get props => [slug, name, url];
}
