import '../../domain/entities/products_entity.dart';

class ProductsModel extends ProductsEntity {
  const ProductsModel(
      super.success, super.products, super.filteredProductsCount);

  factory ProductsModel.fromJson(Map<String, dynamic> json) => ProductsModel(
      json['success'],
      List<ProductModel>.from(
          json['products'].map((x) => ProductModel.fromJson(x))),
      json['filteredProductsCount']);
}

class ProductAuMallModel extends ProductAuMallEntity {
  ProductAuMallModel({
    required super.id,
    required super.title,
    required super.description,
    required super.price,
    required super.ratingNumber,
    required super.thumbnailUrl,
    required super.isFavorite,
    // required super.category,
    required super.reviewNumber,
  });

  factory ProductAuMallModel.fromJson(Map<String, dynamic> json) {
    print("ProductFavoriteModel.fromJson ${json['id']}");
    print("ProductFavoriteModel.fromJson ${json['title']}");
    print("ProductFavoriteModel.fromJson ${json['description']}");
    print("ProductFavoriteModel.fromJson ${json['price']}");
    print("ProductFavoriteModel.fromJson ${json['rating_number']}");
    print("ProductFavoriteModel.fromJson ${json['review_number']}");
    print("ProductFavoriteModel.fromJson ${json['thumbnail_url']}");

    return ProductAuMallModel(
      id: json['id'],
      title: json['title'] ?? "",
      description: json['description'] ?? "",
      price: json['price'] ?? "",
      ratingNumber: json['rating_number'] ?? 0,
      // category: json['category'],
      reviewNumber: json['review_number'] ?? 0,
      thumbnailUrl: json['thumbnail_url'] ?? "",
      isFavorite: json['is_favorite'] ?? false,
    );
  }
}

class ProductModelSimple extends ProductSimpleEntity {
  ProductModelSimple({
    required super.id,
    required super.title,
    required super.description,
    required super.price,
    required super.isFavorite,
    required super.ratingNumber,
    required super.thumbnailUrl,
    // required super.category,
    required super.reviewNumber,
  });

  factory ProductModelSimple.fromJson(Map<String, dynamic> json) {
    print("ProductModelSimple.fromJson ${json['id']}");
    print("ProductModelSimple.fromJson ${json['title']}");
    print("ProductModelSimple.fromJson ${json['description']}");
    print("ProductModelSimple.fromJson ${json['price']}");
    print("ProductModelSimple.fromJson ${json['rating_number']}");
    print("ProductModelSimple.fromJson ${json['review_number']}");
    print("ProductModelSimple.fromJson ${json['thumbnail_url']}");

    return ProductModelSimple(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      price: json['price'],
      isFavorite: json['is_favorite'],
      ratingNumber: json['rating_number'],
      // category: json['category'],
      reviewNumber: json['review_number'],
      thumbnailUrl: json['thumbnail_url'],
    );
  }
}

class ProductModel extends ProductEntity {
  ProductModel(
      {required super.id,
      required super.name,
      required super.description,
      required super.price,
      required super.ratings,
      required super.images,
      required super.category,
      required super.stock,
      required super.numOfReviews,
      required super.user,
      required super.reviews,
      super.isFavourite});

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
      id: json['_id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      ratings: json['ratings'],
      images: List<ImageModel>.from(
          json['images'].map((x) => ImageModel.fromJson(x))),
      category: json['category'],
      stock: json['stock'],
      numOfReviews: json['numOfReviews'],
      user: json['user'],
      reviews: List<ReviewModel>.from(
          json['reviews'].map((x) => ReviewModel.fromJson(x))));
}

class ImageModel extends ImageEntity {
  const ImageModel(super.publicid, super.url);

  factory ImageModel.fromJson(Map<String, dynamic> json) =>
      ImageModel(json['public_id'], json['url']);
}

class ReviewModel extends ReviewEntity {
  const ReviewModel(
      super.user, super.name, super.rating, super.comment,
      // super.createdAt
      );

  factory ReviewModel.fromJson(Map<String, dynamic> json) => ReviewModel(
      json["user_full_name"] ?? "",
      json['user_full_name'] ?? "",
      json['rating'] ?? 0,
      json['comment'] ?? "",
      // DateTime.parse(json['createdAt'] as String)
  );
}
