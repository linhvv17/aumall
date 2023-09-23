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
    required super.priceStep,
    required super.ratingNumber,
    required super.thumbnailUrl,
    required super.isFavorite,
    required super.categoryOfProductEntity,
    required super.userEntity,
    required super.reviewNumber,
  });

  factory ProductAuMallModel.fromJson(Map<String, dynamic> json) {
    return ProductAuMallModel(
      id: json['id'],
      title: json['title'] ?? "",
      description: json['description'] ?? "",
      price: json['price'] ?? "",
      priceStep: json['price_step'] ?? "0",
      ratingNumber: json['rating_number'] ?? "0",
      categoryOfProductEntity:
          CategoryOfProductModel.fromJson(json['category']),
      reviewNumber: json['review_number'] ?? 0,
      thumbnailUrl: json['thumbnail_url'] ?? "",
      isFavorite: json['is_favorite'] ?? false,
      userEntity: json['user'] != null ? UserModel.fromJson(json['user']) : null,
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
    super.user,
    super.name,
    super.rating,
    super.comment,
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

class CategoryOfProductModel extends CategoryOfProductEntity {
  const CategoryOfProductModel(super.id, super.name);

  factory CategoryOfProductModel.fromJson(Map<String, dynamic> json) =>
      CategoryOfProductModel(json['id'], json['name'].toString());

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

class ShopModel extends ShopEntity{
  const ShopModel(super.id, super.userId, super.name, super.address, super.contact, super.description, super.banner, super.image, super.note, super.status, super.createdAt, super.updatedAt, super.bannerUrl, super.imageUrl);

  factory ShopModel.fromJson(Map<String, dynamic> json) =>
      ShopModel(
        json['id'],
        json['user_id'],
        json['name'].toString(),
        json['address'].toString(),
        json['contact'].toString(),
        json['description'].toString(),
        json['banner'].toString(),
        json['image'].toString(),
        json['note'].toString(),
        json['status'],
        json['created_at'].toString(),
        json['updated_at'].toString(),
        json['banner_url'].toString(),
        json['image_url'].toString(),
      );
}

class UserModel extends UserShopEntity {
  const UserModel (super.id, super.name, super.fullName, super.storeName, super.shopName, super.avatarUrl, super.shop);
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      UserModel(
          json['id'],
          json['name'].toString(),
          json['full_name'].toString(),
          json['store_name'].toString(),
          json['shop_name'].toString(),
          json['avatar_url'].toString(),
          ShopModel.fromJson(json['shop']),
      );
}
