import 'package:aumall/features/home/data/models/banner_model.dart';
import 'package:aumall/features/shopping/domain/entities/products_entity.dart';
import 'package:equatable/equatable.dart';

class ListProductInCartEntity extends Equatable {
  final List<ProductInCartEntity> listProductInCart;
  const ListProductInCartEntity(this.listProductInCart);
  @override
  List<Object?> get props => [];
}

class ProductInCartEntity extends Equatable {
  ProductInCartEntity(
    this.id,
    this.productId,
    this.orderId,
    this.amount,
    this.quantity,
    this.createdAt,
    this.product,
  );
  int id;
  int productId;
  int orderId;
  String amount;
  int quantity;
  String createdAt;
  ProductEntity product;

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ProductEntity extends Equatable {
  const ProductEntity(
    this.id,
    this.title,
    this.thumbnail,
    this.price,
    this.discount,
    this.currentStock,
    this.thumbnailUrl,
    this.videoLink,
    this.isFavorite,
    // this.isWishList,
  );
  final int id;
  final String title;
  final String thumbnail;
  final String price;
  final String discount;
  final String currentStock;
  final String thumbnailUrl;
  final String videoLink;
  final bool isFavorite;
  // final bool isWishList;

  @override
  List<Object?> get props => [];
}
