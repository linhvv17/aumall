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
    this.qouantity=1,
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
      this.user, this.name, this.rating, this.comment,
      // this.createdAt
      );

  @override
  List<Object?> get props => [user, name, rating, comment];
}

class ProductFavoriteEntity extends Equatable {
  int? id;
  String? title;
  String? description;
  String? price;
  int? ratingNumber;
  int? reviewNumber;
  String? thumbnailUrl;


  ProductFavoriteEntity(
  {this.id,
  this.title,
  this.description,
  this.price,
  this.ratingNumber,
  this.reviewNumber,
  this.thumbnailUrl,
  });

  ProductFavoriteEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    title = json['title'] ?? "0";
    description = json['description'] ?? "";
    price = json['price'] ?? "";
    ratingNumber = json['rating_number'] ?? 0;
    reviewNumber = json['review_number'] ?? 0;
    thumbnailUrl = json['thumbnail_url'] ?? "";
  }

  @override
  List<Object?> get props => [
    id, title, description, price,ratingNumber, reviewNumber,thumbnailUrl
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
  String? discount;
  int? reviewNumber;
  int? ratingNumber;
  String? createdAt;
  String? thumbnailUrl;
  String? videoLink;
  // Category? category;

  ProductSimpleEntity(
      {this.id,
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
    userId = json['user_id']?? 0;
    addedBy = json['added_by'] ?? "";
    title = json['title']?? "";
    description = json['description']?? "";
    content = json['content']?? "";
    categoryId = json['category_id']?? "";
    brandId = json['brand_id']?? "";
    madeInId = json['made_in_id']?? "";
    thumbnail = json['thumbnail']?? "";
    featured = json['featured']?? "";
    flashSale = json['flash_sale']?? "";
    price = json['price']?? "";
    discount = json['discount']?? "";
    reviewNumber = json['review_number'] ?? 0;
    ratingNumber = json['rating_number'] ?? 0;
    createdAt = json['created_at'] as String ?? "";
    thumbnailUrl = json['thumbnail_url']?? "";
    videoLink = json['video_link']?? "";
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
