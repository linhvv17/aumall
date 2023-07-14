
import 'package:aumall/features/home/domain/entities/banner_entity.dart';
import 'package:aumall/features/shop/data/models/products_model.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/list_product_home_entity.dart';

// class ListProductHomeModel extends ListProductHomeEntity{
//   const ListProductHomeModel(super.newProducts, super.comingSoonProducts, super.suggestionProducts);
//   factory ListProductHomeModel.fromJson(Map<String, dynamic> json) {
//     return ListProductHomeModel(
//       // List<ImageModel>.from(
//       //     json['data'].map((x) => ImageModel.fromJson(x))),
//     );
//   }
// }

class ListProductHomeModel extends ListProductHomeEntity{

  const ListProductHomeModel(super.listProductHomeData);

  factory ListProductHomeModel.fromJson(Map<String, dynamic> json) {
    print('ListProductHomeModel.fromJson ${json}');
    return ListProductHomeModel(ListProductHomeData.fromJson(json['data']));
  }
}


class ListProductHomeDataEntity {
  final List<ProductModelSimple>? newProducts;
  final List<ProductModelSimple>? comingSoonProducts;
  final List<ProductModelSimple>? suggestionProducts;

  const ListProductHomeDataEntity(this.newProducts, this.comingSoonProducts, this.suggestionProducts);

}

class ListProductHomeData {
  late List<ProductModelSimple>? newProducts;
  late List<ProductModelSimple>? comingSoonProducts;
  late List<ProductModelSimple>? suggestionProducts;

  ListProductHomeData({required this.newProducts, required this.comingSoonProducts, required this.suggestionProducts});

  ListProductHomeData.fromJson(Map<String, dynamic> json) {
    if (json['newProducts'] != null) {
      newProducts = <ProductModelSimple>[];
      json['newProducts'].forEach((v) {
        newProducts!.add(ProductModelSimple.fromJson(v));
      });
    }
    if (json['comingSoonProducts'] != null) {
      comingSoonProducts = <ProductModelSimple>[];
      json['comingSoonProducts'].forEach((v) {
        comingSoonProducts!.add(ProductModelSimple.fromJson(v));
      });
    }
    if (json['suggestionProducts'] != null) {
      suggestionProducts = <ProductModelSimple>[];
      json['suggestionProducts'].forEach((v) {
        suggestionProducts!.add(ProductModelSimple.fromJson(v));
      });
    }
  }

}




class NewProducts{
  int? id;
  int? userId;
  Null? addedBy;
  String? title;
  String? description;
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
  Null? ratingNumber;
  String? createdAt;
  String? thumbnailUrl;
  Null? videoLink;
  Category? category;

  NewProducts(
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
        this.category});

  NewProducts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    addedBy = json['added_by'];
    title = json['title'];
    description = json['description'];
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
    thumbnailUrl = json['thumbnail_url'];
    videoLink = json['video_link'];
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['added_by'] = this.addedBy;
    data['title'] = this.title;
    data['description'] = this.description;
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
    data['thumbnail_url'] = thumbnailUrl;
    data['video_link'] = videoLink;
    if (category != null) {
      data['category'] = category!.toJson();
    }
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}