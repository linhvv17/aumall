import 'package:aumall/features/shopping/domain/entities/product/product_entity.dart';

class ProductModel extends ProductEntity {
  const ProductModel(
      super.id,
      super.userId,
      super.addedBy,
      super.title,
      super.description,
      super.view,
      super.content,
      super.categoryId,
      super.brandId,
      super.madeInId,
      super.thumbnail,
      super.featured,
      super.flashSale,
      super.price,
      super.discount,
      super.reviewNumber,
      super.ratingNumber,
      super.createdAt,
      super.thumbnailUrl,
      super.videoLink,
      super.isFavorite,
      // super.isWishList
      );

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        json['id'],
        json['user_id'],
        json['addedBy'].toString(),
        json['title'],
        json['description'],
        json['view'],
        json['content'],
        json['category_id'],
        json['brand_id'],
        json['made_in_id'],
        json['thumbnail'],
        json['featured'].toString(),
        json['flashSale'].toString(),
        json['price'],
        json['discount'].toString(),
        json['review_number'],
        json['rating_number'],
        json['created_at'],
        json['thumbnail_url'],
        json['videoLink'].toString(),
        json['is_favorite'],
        // json['isWishList'] ?? false,
      );
}
