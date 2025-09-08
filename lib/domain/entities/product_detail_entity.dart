// final int id;
// final String title;
// final String description;
// final String category;
// final double price;
// final double discountPercentage;
// final double? rating;
// final int? stock;
// final List<String>? tags;
// final String? brand;
// final String? sku;
// final double weight;
// final DimensionsDto? dimensions;
// final String? warrantyInformation;
// final String? shippingInformation;
// final String? availabilityStatus;
// final List<ReviewDto>? reviews;
// final String? returnPolicy;
// final int? minimumOrderQuantity;
// final MetaDto? meta;
// final List<String>? images;
// final String? thumbnail;

import 'package:equatable/equatable.dart';

class ProductDetailEntity extends Equatable {
  final int id;
  final String title;
  final String description;
  final double price;
  final double rating;
  final List<String>? images;

  const ProductDetailEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.rating,
    required this.images,
  });

  @override
  List<Object?> get props => [id, title, description, price, rating, images];
}
