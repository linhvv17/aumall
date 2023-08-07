class DetailProductResponse {
  DetailProductResponse({
    required this.status,
    required this.message,
    required this.data,
    required this.relatedProducts,
  });
  late final int status;
  late final String message;
  late final ProductDetailDataModel data;
  late final List<RelatedProducts> relatedProducts;

  DetailProductResponse.fromJson(Map<String, dynamic> json){
    status = json['status'];
    message = json['message'];
    data = ProductDetailDataModel.fromJson(json['data']);
    relatedProducts = List.from(json['relatedProducts']).map((e)=>RelatedProducts.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['message'] = message;
    _data['data'] = data.toJson();
    _data['relatedProducts'] = relatedProducts.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class ProductDetailDataModel {
  ProductDetailDataModel({
    required this.id,
    required this.userId,
    required this.addedBy,
    required this.title,
    required this.description,
    required this.view,
    required this.videoProvider,
    required this.videoUrl,
    required this.content,
    required this.categoryId,
    required this.brandId,
    required this.madeInId,
    required this.thumbnail,
    required this.featured,
    required this.flashSale,
    required this.price,
    required this.discount,
    required this.reviewNumber,
    required this.ratingNumber,
    required this.createdAt,
    required this.updatedAt,
    required this.thumbnailUrl,
    required this.videoLink,
    required this.images,
    required this.brand,
    required this.madeIn,
    required this.category,
    required this.user,
    required this.reviews,
  });
  late final int id;
  late final int userId;
  late final String addedBy;
  late final String title;
  late final String description;
  late final int view;
  late final String videoProvider;
  late final String videoUrl;
  late final String content;
  late final int categoryId;
  late final int brandId;
  late final int madeInId;
  late final String thumbnail;
  late final String featured;
  late final String flashSale;
  late final String price;
  late final String discount;
  late final int reviewNumber;
  late final int ratingNumber;
  late final DateTime createdAt;
  late final String updatedAt;
  late final String thumbnailUrl;
  late final String videoLink;
  late final List<Images> images;
  late final Brand brand;
  late final MadeIn madeIn;
  late final Category category;
  late final User user;
  late final List<Reviews> reviews;

  ProductDetailDataModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    userId = json['user_id'];
    addedBy = json['added_by'].toString() ?? '';//
    title = json['title'].toString();
    description = json['description'].toString();
    view = json['view'];
    videoProvider = json['video_provider'].toString()?? '';//
    videoUrl = json['video_url'].toString()?? '';//
    content = json['content'].toString();
    categoryId = json['category_id'];
    brandId = json['brand_id'];
    madeInId = json['made_in_id'];
    thumbnail = json['thumbnail'];
    featured = json['featured'].toString()?? '';//
    flashSale = json['flash_sale'].toString()?? '';//
    price = json['price'].toString();
    discount = json['discount'].toString()?? '';//
    reviewNumber = json['review_number'];
    ratingNumber = json['rating_number'];
    createdAt = DateTime.parse(json['created_at']);
    updatedAt = json['updated_at'].toString();
    thumbnailUrl = json['thumbnail_url'].toString();
    videoLink = json['video_link'].toString()?? '';//
    images = List.from(json['images']).map((e)=>Images.fromJson(e)).toList();
    brand = Brand.fromJson(json['brand']);
    madeIn = MadeIn.fromJson(json['made_in']);
    category = Category.fromJson(json['category']);
    user = User.fromJson(json['user']);
    reviews = List.from(json['reviews']).map((e)=>Reviews.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['user_id'] = userId;
    _data['added_by'] = addedBy;
    _data['title'] = title;
    _data['description'] = description;
    _data['view'] = view;
    _data['video_provider'] = videoProvider;
    _data['video_url'] = videoUrl;
    _data['content'] = content;
    _data['category_id'] = categoryId;
    _data['brand_id'] = brandId;
    _data['made_in_id'] = madeInId;
    _data['thumbnail'] = thumbnail;
    _data['featured'] = featured;
    _data['flash_sale'] = flashSale;
    _data['price'] = price;
    _data['discount'] = discount;
    _data['review_number'] = reviewNumber;
    _data['rating_number'] = ratingNumber;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['thumbnail_url'] = thumbnailUrl;
    _data['video_link'] = videoLink;
    _data['images'] = images.map((e)=>e.toJson()).toList();
    _data['brand'] = brand.toJson();
    _data['made_in'] = madeIn.toJson();
    _data['category'] = category.toJson();
    _data['user'] = user.toJson();
    _data['reviews'] = reviews.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Images {
  Images({
    required this.id,
    required this.productId,
    required this.src,
    required this.imageUrl,
  });
  late final int id;
  late final int productId;
  late final String src;
  late final String imageUrl;

  Images.fromJson(Map<String, dynamic> json){
    id = json['id'];
    productId = json['product_id'];
    src = json['src'].toString();
    imageUrl = json['image_url'].toString();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['product_id'] = productId;
    _data['src'] = src;
    _data['image_url'] = imageUrl;
    return _data;
  }
}

class Brand {
  Brand({
    required this.id,
    required this.name,
    required this.alias,
    required this.image,
    required this.imageUrl,
  });
  late final int id;
  late final String name;
  late final String alias;
  late final String image;
  late final String imageUrl;

  Brand.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'].toString();
    alias = json['alias'].toString();
    image = json['image'].toString() ?? '';
    imageUrl = json['image_url'].toString();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['alias'] = alias;
    _data['image'] = image;
    _data['image_url'] = imageUrl;
    return _data;
  }
}

class MadeIn {
  MadeIn({
    required this.id,
    required this.name,
    required this.image,
    required this.imageUrl,
  });
  late final int id;
  late final String name;
  late final String image;
  late final String imageUrl;

  MadeIn.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'].toString();
    image = json['image'].toString() ?? '';
    imageUrl = json['image_url'].toString();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['image'] = image;
    _data['image_url'] = imageUrl;
    return _data;
  }
}

class Category {
  Category({
    required this.id,
    required this.name,
  });
  late final int id;
  late final String name;

  Category.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    return _data;
  }
}

// class User {
//   User({
//     required this.id,
//     required this.name,
//     required this.fullName,
//     required this.storeName,
//   });
//   late final int id;
//   late final String name;
//   late final String fullName;
//   late final String storeName;
//
//   User.fromJson(Map<String, dynamic> json){
//     id = json['id'];
//     name = json['name'];
//     fullName = json['full_name'];
//     storeName = json['store_name'] ?? '';//
//   }
//
//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['id'] = id;
//     _data['name'] = name;
//     _data['full_name'] = fullName;
//     _data['store_name'] = storeName;
//     return _data;
//   }
// }

class User {
  User({
    required this.id,
    required this.name,
    required this.fullName,
    required this.storeName,
    required this.shopName,
    required this.avatarUrl,
    required this.shop,
  });
  late final int id;
  late final String? name;
  late final String? fullName;
  late final String? storeName;
  late final String? shopName;
  late final String? avatarUrl;
  late final Shop? shop;

  User.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'].toString() ?? "";
    fullName = json['full_name'].toString() ?? "";
    storeName = json['store_name'].toString() ?? "";
    shopName = json['shop_name'].toString() ?? "";
    avatarUrl = json['avatar_url'].toString() ?? "";
    shop = json['shop'] != null ? Shop.fromJson(json['shop']) : null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['full_name'] = fullName;
    _data['store_name'] = storeName;
    _data['shop_name'] = shopName;
    _data['avatar_url'] = avatarUrl;
    _data['shop'] = shop !=null ? shop?.toJson() : null;
    return _data;
  }
}

class Shop {
  Shop({
    required this.id,
    required this.userId,
    required this.name,
    required this.address,
    required this.contact,
    required this.description,
    required this.banner,
    required this.image,
    required this.note,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.bannerUrl,
    required this.imageUrl,
  });
  late final int id;
  late final int userId;
  late final String? name;
  late final String? address;
  late final String ?contact;
  late final String? description;
  late final String? banner;
  late final String? image;
  late final String? note;
  late final int status;
  late final String? createdAt;
  late final String? updatedAt;
  late final String? bannerUrl;
  late final String? imageUrl;

  Shop.fromJson(Map<String, dynamic> json){
    id = json['id'];
    userId = json['user_id'];
    name = json['name'].toString() ?? "";
    address = json['address'].toString() ?? "";
    contact = json['contact'].toString() ?? "";
    description = json['description'].toString() ?? "";
    banner = json['banner'].toString() ?? "";
    image = json['image'].toString() ?? "";
    note = json['note'].toString() ?? "";
    status = json['status'];
    createdAt = json['created_at'].toString() ?? "";
    updatedAt = json['updated_at'].toString() ?? "";
    bannerUrl = json['banner_url'].toString() ?? "";
    imageUrl = json['image_url'].toString() ?? "";
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['name'] = name;
    data['address'] = address;
    data['contact'] = contact;
    data['description'] = description;
    data['banner'] = banner;
    data['image'] = image;
    data['note'] = note;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['banner_url'] = bannerUrl;
    data['image_url'] = imageUrl;
    return data;
  }
}


class Reviews {
  Reviews({
    required this.id,
    required this.productId,
    required this.userId,
    required this.comment,
    required this.rating,
    required this.createdAt,
    required this.userFullName,
    required this.user,
  });
  late final int id;
  late final int productId;
  late final int userId;
  late final String comment;
  late final int rating;
  late final DateTime createdAt;
  late final String userFullName;
  late final User? user;

  Reviews.fromJson(Map<String, dynamic> json){
    id = json['id'];
    productId = json['product_id'];
    userId = json['user_id'];
    comment = json['comment'].toString();
    rating = json['rating'];
    createdAt = DateTime.parse(json['created_at']);
    userFullName = json['user_full_name'].toString();
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['product_id'] = productId;
    _data['user_id'] = userId;
    _data['comment'] = comment;
    _data['rating'] = rating;
    _data['created_at'] = createdAt;
    _data['user_full_name'] = userFullName;
    _data['user'] = user?.toJson();
    return _data;
  }
}

class RelatedProducts {
  RelatedProducts({
    required this.id,
    required this.userId,
    required this.addedBy,
    required this.title,
    required this.description,
    required this.view,
    required this.content,
    required this.categoryId,
    required this.brandId,
    required this.madeInId,
    required this.thumbnail,
    required this.featured,
    required this.flashSale,
    required this.price,
    required this.discount,
    required this.reviewNumber,
    required this.ratingNumber,
    required this.createdAt,
    required this.thumbnailUrl,
    required this.videoLink,
    required this.images,
    required this.brand,
    required this.madeIn,
    required this.category,
    required this.user,
  });
  late final int id;
  late final int userId;
  late final String addedBy;
  late final String title;
  late final String description;
  late final int view;
  late final String content;
  late final int categoryId;
  late final int brandId;
  late final int madeInId;
  late final String thumbnail;
  late final String featured;
  late final String flashSale;
  late final String price;
  late final String discount;
  late final int reviewNumber;
  late final int ratingNumber;
  late final String createdAt;
  late final String thumbnailUrl;
  late final String videoLink;
  late final List<Images> images;
  late final Brand brand;
  late final MadeIn madeIn;
  late final Category category;
  late final User user;

  RelatedProducts.fromJson(Map<String, dynamic> json){
    id = json['id'];
    userId = json['user_id'];
    addedBy = json['added_by'].toString() ?? '';//
    title = json['title'].toString();
    description = json['description'].toString();
    view = json['view'];
    content = json['content'].toString();
    categoryId = json['category_id'];
    brandId = json['brand_id'];
    madeInId = json['made_in_id'];
    thumbnail = json['thumbnail'].toString();
    featured = json['featured'].toString() ?? '';//
    flashSale = json['flash_sale'].toString() ?? '';//
    price = json['price'].toString();
    discount = json['discount'].toString() ?? '';//
    reviewNumber = json['review_number'];
    ratingNumber = json['rating_number'];
    createdAt = json['created_at'].toString();
    thumbnailUrl = json['thumbnail_url'].toString();
    videoLink = json['video_link'].toString() ?? '';//
    images = List.from(json['images']).map((e)=>Images.fromJson(e)).toList();
    brand = Brand.fromJson(json['brand']);
    madeIn = MadeIn.fromJson(json['made_in']);
    category = Category.fromJson(json['category']);
    user = User.fromJson(json['user']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['user_id'] = userId;
    _data['added_by'] = addedBy;
    _data['title'] = title;
    _data['description'] = description;
    _data['view'] = view;
    _data['content'] = content;
    _data['category_id'] = categoryId;
    _data['brand_id'] = brandId;
    _data['made_in_id'] = madeInId;
    _data['thumbnail'] = thumbnail;
    _data['featured'] = featured;
    _data['flash_sale'] = flashSale;
    _data['price'] = price;
    _data['discount'] = discount;
    _data['review_number'] = reviewNumber;
    _data['rating_number'] = ratingNumber;
    _data['created_at'] = createdAt;
    _data['thumbnail_url'] = thumbnailUrl;
    _data['video_link'] = videoLink;
    _data['images'] = images.map((e)=>e.toJson()).toList();
    _data['brand'] = brand.toJson();
    _data['made_in'] = madeIn.toJson();
    _data['category'] = category.toJson();
    _data['user'] = user.toJson();
    return _data;
  }
}


class ListRelatedProducts {
  late List<RelatedProducts>? relatedProducts;
  ListRelatedProducts({required this.relatedProducts});
  ListRelatedProducts.fromJson(Map<String, dynamic> json) {
    if (['relatedProducts'] != null) {
      relatedProducts = <RelatedProducts>[];
      json['relatedProducts'].forEach((v) {
        relatedProducts!.add(RelatedProducts.fromJson(v));
      });
    }

    print("ListRelatedProducts.fromJson ${relatedProducts!.length}");

    //
    // list = json.decode(response.body)['results']
    //     .map((data) => Model.fromJson(data))
    //     .toList();

  }
}