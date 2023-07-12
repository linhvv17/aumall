import 'package:aumall/features/home/data/models/banner_model.dart';
import 'package:aumall/features/shop/domain/entities/products_entity.dart';
import 'package:equatable/equatable.dart';

import '../../data/models/list_product_home_model.dart';
import '../../domain/entities/product_detail_entity.dart';

class ProductDetailModel extends ProductDetailEntity{
  const ProductDetailModel(
      super.productDetailData,
      super.relatedProducts
      );
  
  factory ProductDetailModel.fromJson(Map<String, dynamic> json) {
    print('ProductDetailModel.fromJson $json');
    return ProductDetailModel(
        ProductDetailData.fromJson(json['data']),
        // ListRelatedProducts(relatedProducts: []),
        ListRelatedProducts.fromJson(json)
    );
  }
  
  
}


class ProductDetailData {
  int? id;
  int? userId;
  Null? addedBy;
  String? title;
  String? description;
  int? view;
  Null? videoProvider;
  Null? videoUrl;
  String? content;
  int? categoryId;
  int? brandId;
  int? madeInId;
  String? thumbnail;
  Null? featured;
  Null? flashSale;
  String? price;
  Null? discount;
  int? reviewNumber;
  int? ratingNumber;
  String? createdAt;
  String? updatedAt;
  String? thumbnailUrl;
  Null? videoLink;
  List<Images>? images;
  Brand? brand;
  MadeIn? madeIn;
  Category? category;
  User? user;
  List<Reviews>? reviews;

  ProductDetailData(
      {this.id,
        this.userId,
        this.addedBy,
        this.title,
        this.description,
        this.view,
        this.videoProvider,
        this.videoUrl,
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
        this.updatedAt,
        this.thumbnailUrl,
        this.videoLink,
        this.images,
        this.brand,
        this.madeIn,
        this.category,
        this.user,
        this.reviews});

  ProductDetailData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    addedBy = json['added_by'];
    title = json['title'];
    description = json['description'];
    view = json['view'];
    videoProvider = json['video_provider'];
    videoUrl = json['video_url'];
    content = json['content'];
    categoryId = json['category_id'];
    brandId = json['brand_id'];
    madeInId = json['made_in_id'];
    thumbnail = json['thumbnail'];
    featured = json['featured'];
    flashSale = json['flash_sale'];
    price = json['price'];
    discount = json['discount'];
    reviewNumber = json['review_number'];
    ratingNumber = json['rating_number'];
    createdAt = json['created_at'] as String;
    updatedAt = json['updated_at'] as String;
    thumbnailUrl = json['thumbnail_url'];
    videoLink = json['video_link'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(Images.fromJson(v));
      });
    }
    brand = json['brand'] != null ? Brand.fromJson(json['brand']) : null;
    madeIn =
    json['made_in'] != null ? MadeIn.fromJson(json['made_in']) : null;
    category = json['category'] != null
        ? Category.fromJson(json['category'])
        : null;
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    if (json['reviews'] != null) {
      reviews = <Reviews>[];
      json['reviews'].forEach((v) {
        reviews!.add(Reviews.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['added_by'] = this.addedBy;
    data['title'] = this.title;
    data['description'] = this.description;
    data['view'] = this.view;
    data['video_provider'] = this.videoProvider;
    data['video_url'] = this.videoUrl;
    data['content'] = this.content;
    data['category_id'] = this.categoryId;
    data['brand_id'] = this.brandId;
    data['made_in_id'] = this.madeInId;
    data['thumbnail'] = this.thumbnail;
    data['featured'] = this.featured;
    data['flash_sale'] = this.flashSale;
    data['price'] = this.price;
    data['discount'] = this.discount;
    data['review_number'] = this.reviewNumber;
    data['rating_number'] = this.ratingNumber;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['thumbnail_url'] = this.thumbnailUrl;
    data['video_link'] = this.videoLink;
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    if (this.brand != null) {
      data['brand'] = this.brand!.toJson();
    }
    if (this.madeIn != null) {
      data['made_in'] = this.madeIn!.toJson();
    }
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.reviews != null) {
      data['reviews'] = this.reviews!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


class ListRelatedProducts {
  late List<RelatedProduct>? relatedProducts;
  ListRelatedProducts({required this.relatedProducts});
  ListRelatedProducts.fromJson(Map<String, dynamic> json) {
    if (['relatedProducts'] != null) {
      relatedProducts = <RelatedProduct>[];
      json['relatedProducts'].forEach((v) {
        relatedProducts!.add(RelatedProduct.fromJson(v));
      });
    }

    print("ListRelatedProducts.fromJson ${relatedProducts!.length}");

    //
    // list = json.decode(response.body)['results']
    //     .map((data) => Model.fromJson(data))
    //     .toList();

  }
}








class ProductDetail {
  int? status;
  String? message;
  Data? data;
  List<RelatedProduct>? relatedProducts;

  ProductDetail({this.status, this.message, this.data, this.relatedProducts});

  ProductDetail.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    if (json['relatedProducts'] != null) {
      relatedProducts = <RelatedProduct>[];
      json['relatedProducts'].forEach((v) {
        relatedProducts!.add(new RelatedProduct.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    if (this.relatedProducts != null) {
      data['relatedProducts'] =
          this.relatedProducts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  int? userId;
  Null? addedBy;
  String? title;
  String? description;
  int? view;
  Null? videoProvider;
  Null? videoUrl;
  String? content;
  int? categoryId;
  int? brandId;
  int? madeInId;
  String? thumbnail;
  Null? featured;
  Null? flashSale;
  String? price;
  Null? discount;
  Null? reviewNumber;
  int? ratingNumber;
  String? createdAt;
  String? updatedAt;
  String? thumbnailUrl;
  Null? videoLink;
  List<Images>? images;
  Brand? brand;
  MadeIn? madeIn;
  Category? category;
  User? user;
  List<Reviews>? reviews;

  Data(
      {this.id,
        this.userId,
        this.addedBy,
        this.title,
        this.description,
        this.view,
        this.videoProvider,
        this.videoUrl,
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
        this.updatedAt,
        this.thumbnailUrl,
        this.videoLink,
        this.images,
        this.brand,
        this.madeIn,
        this.category,
        this.user,
        this.reviews});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    addedBy = json['added_by'];
    title = json['title'];
    description = json['description'];
    view = json['view'];
    videoProvider = json['video_provider'];
    videoUrl = json['video_url'];
    content = json['content'];
    categoryId = json['category_id'];
    brandId = json['brand_id'];
    madeInId = json['made_in_id'];
    thumbnail = json['thumbnail'];
    featured = json['featured'];
    flashSale = json['flash_sale'];
    price = json['price'];
    discount = json['discount'];
    reviewNumber = json['review_number'];
    ratingNumber = json['rating_number'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    thumbnailUrl = json['thumbnail_url'];
    videoLink = json['video_link'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(new Images.fromJson(v));
      });
    }
    brand = json['brand'] != null ? new Brand.fromJson(json['brand']) : null;
    madeIn =
    json['made_in'] != null ? new MadeIn.fromJson(json['made_in']) : null;
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    if (json['reviews'] != null) {
      reviews = <Reviews>[];
      json['reviews'].forEach((v) {
        reviews!.add(new Reviews.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['added_by'] = this.addedBy;
    data['title'] = this.title;
    data['description'] = this.description;
    data['view'] = this.view;
    data['video_provider'] = this.videoProvider;
    data['video_url'] = this.videoUrl;
    data['content'] = this.content;
    data['category_id'] = this.categoryId;
    data['brand_id'] = this.brandId;
    data['made_in_id'] = this.madeInId;
    data['thumbnail'] = this.thumbnail;
    data['featured'] = this.featured;
    data['flash_sale'] = this.flashSale;
    data['price'] = this.price;
    data['discount'] = this.discount;
    data['review_number'] = this.reviewNumber;
    data['rating_number'] = this.ratingNumber;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['thumbnail_url'] = this.thumbnailUrl;
    data['video_link'] = this.videoLink;
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    if (this.brand != null) {
      data['brand'] = this.brand!.toJson();
    }
    if (this.madeIn != null) {
      data['made_in'] = this.madeIn!.toJson();
    }
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.reviews != null) {
      data['reviews'] = this.reviews!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Images {
  int? id;
  int? productId;
  String? src;
  String? imageUrl;

  Images({this.id, this.productId, this.src, this.imageUrl});

  Images.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    src = json['src'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['src'] = this.src;
    data['image_url'] = this.imageUrl;
    return data;
  }
}

class Brand {
  int? id;
  String? name;
  String? alias;
  String? image;
  String? imageUrl;

  Brand({this.id, this.name, this.alias, this.image, this.imageUrl});

  Brand.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    alias = json['alias'];
    image = json['image'] ?? '';
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['alias'] = alias;
    data['image'] = image;
    data['image_url'] = imageUrl;
    return data;
  }
}

class MadeIn {
  int? id;
  String? name;
  Null? image;
  String? imageUrl;

  MadeIn({this.id, this.name, this.image, this.imageUrl});

  MadeIn.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['image_url'] = this.imageUrl;
    return data;
  }
}

class Category {
  int? id;
  String? name;

  Category({this.id, this.name});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class UserCreate {
  int? id;
  String? name;
  String? fullName;
  Null? storeName;

  UserCreate({this.id, this.name, this.fullName, this.storeName});

  UserCreate.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    fullName = json['full_name'];
    storeName = json['store_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['full_name'] = this.fullName;
    data['store_name'] = this.storeName;
    return data;
  }
}

class Reviews {
  int? id;
  int? productId;
  int? userId;
  String? comment;
  int? rating;
  String? createdAt;
  String? userFullName;
  User? user;

  Reviews(
      {this.id,
        this.productId,
        this.userId,
        this.comment,
        this.rating,
        this.createdAt,
        this.userFullName,
        this.user});

  Reviews.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    userId = json['user_id'];
    comment = json['comment'];
    rating = json['rating'] ;
    createdAt = json['created_at'] as String;
    userFullName = json['user_full_name'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['user_id'] = this.userId;
    data['comment'] = this.comment;
    data['rating'] = this.rating;
    data['created_at'] = this.createdAt;
    data['user_full_name'] = this.userFullName;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? fullName;
  String? name;
  String? email;

  User({this.id, this.fullName, this.name, this.email});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    name = json['name'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['full_name'] = this.fullName;
    data['name'] = this.name;
    data['email'] = this.email;
    return data;
  }
}

class RelatedProduct {
  int? id;
  int? userId;
  Null? addedBy;
  String? title;
  String? description;
  int? view;
  String? content;
  int? categoryId;
  int? brandId;
  int? madeInId;
  String? thumbnail;
  Null? featured;
  Null? flashSale;
  String? price;
  Null? discount;
  int? reviewNumber;
  int? ratingNumber;
  String? createdAt;
  String? thumbnailUrl;
  Null? videoLink;
  List<Images>? images;
  Brand? brand;
  MadeIn? madeIn;
  Category? category;
  User? user;

  RelatedProduct(
      {this.id,
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
        this.images,
        this.brand,
        this.madeIn,
        this.category,
        this.user});

  RelatedProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    addedBy = json['added_by'];
    title = json['title'];
    description = json['description'];
    view = json['view'];
    content = json['content'];
    categoryId = json['category_id'];
    brandId = json['brand_id'];
    madeInId = json['made_in_id'];
    thumbnail = json['thumbnail'];
    featured = json['featured'];
    flashSale = json['flash_sale'];
    price = json['price'];
    discount = json['discount'];
    reviewNumber = json['review_number'];
    ratingNumber = json['rating_number'];
    createdAt = json['created_at'] as String;
    thumbnailUrl = json['thumbnail_url'];
    videoLink = json['video_link'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(new Images.fromJson(v));
      });
    }
    brand = json['brand'] != null ? new Brand.fromJson(json['brand']) : null;
    madeIn =
    json['made_in'] != null ? new MadeIn.fromJson(json['made_in']) : null;
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['added_by'] = this.addedBy;
    data['title'] = this.title;
    data['description'] = this.description;
    data['view'] = this.view;
    data['content'] = this.content;
    data['category_id'] = this.categoryId;
    data['brand_id'] = this.brandId;
    data['made_in_id'] = this.madeInId;
    data['thumbnail'] = this.thumbnail;
    data['featured'] = this.featured;
    data['flash_sale'] = this.flashSale;
    data['price'] = this.price;
    data['discount'] = this.discount;
    data['review_number'] = this.reviewNumber;
    data['rating_number'] = this.ratingNumber;
    data['created_at'] = this.createdAt;
    data['thumbnail_url'] = this.thumbnailUrl;
    data['video_link'] = this.videoLink;
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    if (this.brand != null) {
      data['brand'] = this.brand!.toJson();
    }
    if (this.madeIn != null) {
      data['made_in'] = this.madeIn!.toJson();
    }
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}
