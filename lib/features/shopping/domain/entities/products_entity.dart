import 'package:aumall/features/shopping/domain/entities/product/shop_entity.dart';
import 'package:equatable/equatable.dart';

import '../../../home/data/models/list_product_home_model.dart';

class ProductsEntity extends Equatable {
  final bool success;
  final List<ProductEntity> products;
  final int filteredProductsCount;

  const ProductsEntity(
    this.success,
    this.products,
    this.filteredProductsCount,
  );

  @override
  List<Object> get props => [success, products, filteredProductsCount];
}

class ProductEntity extends Equatable {
  final String id;
  final String name;
  final String description;

  final int price;
  final num ratings;
  final List<ImageEntity> images;
  final String category;
  final int stock;
  final int numOfReviews;
  final String user;
  final List<ReviewEntity>? reviews;
  int qouantity = 1;
  bool isFavourite = false;

  ProductEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.ratings,
    required this.images,
    required this.category,
    required this.stock,
    required this.numOfReviews,
    required this.user,
    required this.reviews,
    this.isFavourite = false,
    this.qouantity = 1,
  });

  @override
  List<Object?> get props {
    return [
      id,
      name,
      description,
      price,
      ratings,
      images,
      category,
      stock,
      numOfReviews,
      user,
      reviews,
      isFavourite,
    ];
  }
}

class ImageEntity extends Equatable {
  final String publicid;
  final String url;

  const ImageEntity(this.publicid, this.url);

  @override
  List<Object> get props => [publicid, url];
}

class ReviewEntity extends Equatable {
  final String? user;
  final String? name;
  final num? rating;
  final String? comment;

  // final DateTime? createdAt;
  const ReviewEntity(
    this.user,
    this.name,
    this.rating,
    this.comment,
    // this.createdAt
  );

  @override
  List<Object?> get props => [user, name, rating, comment];
}

class CategoryOfProductEntity extends Equatable {
  const CategoryOfProductEntity(
    this.id,
    this.name,
  );

  final int? id;
  final String? name;

  @override
  List<Object?> get props => [
        id,
        name,
      ];
}

class UserShopEntity extends Equatable {
  const UserShopEntity(
    this.id,
    this.name,
    this.fullName,
    this.storeName,
    this.shopName,
    this.avatarUrl,
    this.shop,
  );

  final int id;
  final String? name;
  final String? fullName;
  final String? storeName;
  final String? shopName;
  final String? avatarUrl;
  final ShopEntity? shop;

  @override
  List<Object?> get props => [
        id,
        name,
      ];
}

// class ShopEntity extends Equatable {
//   const ShopEntity(
//     this.id,
//     this.userId,
//     this.name,
//     this.address,
//     this.contact,
//     this.description,
//     this.banner,
//     this.image,
//     this.note,
//     this.status,
//     this.createdAt,
//     this.updatedAt,
//     this.bannerUrl,
//     this.imageUrl,
//   );
//
//   final int id;
//   final int userId;
//   final String? name;
//   final String? address;
//   final String? contact;
//   final String? description;
//   final String? banner;
//   final String? image;
//   final String? note;
//   final int status;
//   final String? createdAt;
//   final String? updatedAt;
//   final String? bannerUrl;
//   final String? imageUrl;
//
//   @override
//   List<Object?> get props => [
//         id,
//         name,
//       ];
// }

class ProductAuMallEntity extends Equatable {
  int? id;
  String? title;
  String? description;
  String? price;
  String? priceStep;
  String? ratingNumber;
  int? reviewNumber;
  String? thumbnailUrl;
  bool? isFavorite;
  CategoryOfProductEntity? categoryOfProductEntity;
  UserShopEntity? userEntity;

  ProductAuMallEntity(
      {this.id,
      this.title,
      this.description,
      this.price,
      this.priceStep,
      this.ratingNumber,
      this.reviewNumber,
      this.thumbnailUrl,
      this.isFavorite,
      this.categoryOfProductEntity,
      this.userEntity});

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        price,
        ratingNumber,
        reviewNumber,
        thumbnailUrl,
        isFavorite,
        categoryOfProductEntity,
        userEntity,
      ];
}

class ProductSimpleEntity extends Equatable {
  int? id;
  int? userId;
  String? addedBy;
  String? title;
  String? description;
  String? content;
  int? categoryId;
  int? brandId;
  int? madeInId;
  String? thumbnail;
  String? featured;
  String? flashSale;
  String? price;
  bool? isFavorite;
  String? discount;
  int? reviewNumber;
  String? ratingNumber;
  String? createdAt;
  String? thumbnailUrl;
  String? videoLink;

  // Category? category;

  ProductSimpleEntity({
    this.id,
    this.userId,
    this.addedBy,
    this.title,
    this.description,
    this.content,
    this.categoryId,
    this.brandId,
    this.madeInId,
    this.thumbnail,
    this.featured,
    this.flashSale,
    this.price,
    this.isFavorite,
    this.discount,
    this.reviewNumber,
    this.ratingNumber,
    this.createdAt,
    this.thumbnailUrl,
    this.videoLink,
    // this.category
  });

  ProductSimpleEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    userId = json['user_id'] ?? 0;
    addedBy = json['added_by'] ?? "";
    title = json['title'] ?? "";
    description = json['description'] ?? "";
    content = json['content'] ?? "";
    categoryId = json['category_id'] ?? "";
    brandId = json['brand_id'] ?? "";
    madeInId = json['made_in_id'] ?? "";
    thumbnail = json['thumbnail'] ?? "";
    featured = json['featured'] ?? "";
    flashSale = json['flash_sale'] ?? "";
    price = json['price'] ?? "";
    isFavorite = json['is_favorite'] ?? false;
    discount = json['discount'] ?? "";
    reviewNumber = json['review_number'] ?? 0;
    ratingNumber = json['rating_number'] ?? "0";
    createdAt = json['created_at'] as String ?? "";
    thumbnailUrl = json['thumbnail_url'] ?? "";
    videoLink = json['video_link'] ?? "";
    // category = json['category'] != null
    //     ? Category.fromJson(json['category'])
    //     : Category(id: 1, name: "NULL");
  }

  @override
  List<Object?> get props {
    return [
      id,
      title,
      description,
      price,
      isFavorite,
      ratingNumber,
      thumbnailUrl,
      // category,
      reviewNumber,
      content,
      categoryId,
      brandId,
    ];
  }
}
