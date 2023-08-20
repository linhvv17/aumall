import 'package:hive/hive.dart';

part 'cart_product_model.g.dart';

@HiveType(typeId: 4)
class CartProductModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String description;
  @HiveField(3)
  final String price;
  @HiveField(4)
  final num ratings;
  @HiveField(5)
  final String productImage;
  @HiveField(6)
  final int numOfReviews;
  @HiveField(7)
  bool isFavourite = false;
  @HiveField(8)
  num amount = 1;
  CartProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.ratings,
    required this.productImage,
    required this.numOfReviews,
    this.isFavourite = false,
    this.amount = 0,
  });
}
