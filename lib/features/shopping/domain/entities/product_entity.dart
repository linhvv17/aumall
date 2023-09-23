import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
   final int? id;
   final int? userId;
   final String? addedBy;
   final String? title;
   final String? description;
   final int? view;
   final String? content;
   final int? categoryId;
   final int? brandId;
   final int? madeInId;
   final String? thumbnail;
   final String? featured;
   final String? flashSale;
   final String? price;
   final String? discount;
   final int? reviewNumber;
   final String? ratingNumber;
   final String? createdAt;
   final String? thumbnailUrl;
   final String? videoLink;
   final bool? isFavorite;
   final bool? isWishList;

  const ProductEntity({
    this.id,
    this.userId,
    this.addedBy,
    this.title,
    this.description,
    this.view,
    this.content,
    this.categoryId,
    this.brandId,
    this.madeInId,
    this.thumbnail,
    this.featured,
    this.flashSale,
    this.price,
    this.discount,
    this.reviewNumber,
    this.ratingNumber,
    this.createdAt,
    this.thumbnailUrl,
    this.videoLink,
    this.isFavorite,
    this.isWishList,
  });

  @override
  List<Object?> get props {
    return [
      id,
      userId,
    ];
  }
}
