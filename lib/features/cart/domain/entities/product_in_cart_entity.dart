import 'package:equatable/equatable.dart';

class ProductInCartEntity extends Equatable {
  final String id;
  final String productId;
  final String amount;
  final String quantity;
  final String createdAt;
  final ProductEntity productEntity;

  const ProductInCartEntity(
      this.id,
      this.productId,
      this.amount,
      this.quantity,
      this.createdAt,
      this.productEntity
      );

  @override
  List<Object> get props => [];
}

class ProductEntity extends Equatable{
  final String id;
  final String title;
  final String thumbnail;
  final String price;
  final String discount;
  final String currentStock;
  final String thumbnailUrl;
  final String videoLink;
  final String isFavorite;
  final String isWishList;

  const ProductEntity(this.id, this.title, this.thumbnail, this.price, this.discount, this.currentStock, this.thumbnailUrl, this.videoLink, this.isFavorite, this.isWishList);

  @override
  List<Object?> get props => [];

}