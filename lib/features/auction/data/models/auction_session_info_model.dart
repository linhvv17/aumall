import 'package:aumall/features/auction/domain/entities/auction_session_info_entity.dart';
import '../../../home/data/models/detail_product_response.dart';
import '../../../shop/data/models/products_model.dart';

class AuctionSessionInfoModel extends AuctionSessionInfoEntity {
  const AuctionSessionInfoModel(super.product, super.userAuctions);

  factory AuctionSessionInfoModel.fromJson(Map<String, dynamic> json) {
    print("AuctionSessionInfoModel.fromJson $json");
    Product product = Product.fromJson(json['product']);
    UserAuctions userAuctions = UserAuctions.fromJson(json['userAuctions']);
    return AuctionSessionInfoModel(product, userAuctions);
  }
}

class AuctionSessionInfo {
  AuctionSessionInfo({
    required this.status,
    required this.message,
    required this.data,
  });
  late final int status;
  late final String message;
  late final UserAuctionData data;

  AuctionSessionInfo.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = UserAuctionData.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['message'] = message;
    _data['data'] = data.toJson();
    return _data;
  }
}

class UserAuctionData {
  UserAuctionData({
    required this.id,
    required this.productId,
    required this.userId,
    required this.price,
    required this.createdAt,
    required this.user,
  });
  late final int id;
  late final int productId;
  late final int userId;
  late final String price;
  late final DateTime createdAt;
  late final User user;

  UserAuctionData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    userId = json['user_id'];
    price = json['price'];
    createdAt = DateTime.parse(json['created_at']);
    user = User.fromJson(json['user']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['product_id'] = productId;
    _data['user_id'] = userId;
    _data['price'] = price;
    _data['created_at'] = createdAt;
    _data['user'] = user.toJson();
    return _data;
  }
}

class User {
  User({
    required this.id,
    required this.fullName,
    required this.name,
    this.avatar,
    this.shopName,
    required this.avatarUrl,
    this.shop,
  });
  late final int id;
  late final String fullName;
  late final String name;
  late final Null avatar;
  late final Null shopName;
  late final String avatarUrl;
  late final Null shop;

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    name = json['name'];
    avatar = null;
    shopName = null;
    avatarUrl = json['avatar_url'];
    shop = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['full_name'] = fullName;
    _data['name'] = name;
    _data['avatar'] = avatar;
    _data['shop_name'] = shopName;
    _data['avatar_url'] = avatarUrl;
    _data['shop'] = shop;
    return _data;
  }
}

class Product {
  Product({
    required this.id,
    required this.title,
    required this.publishedAt,
    required this.expiredAt,
    required this.price,
    required this.currentPrice,
    required this.thumbnailUrl,
    required this.videoLink,
    required this.isFavorite,
    required this.isWishList,
  });
  late final int id;
  late final String title;
  late final String publishedAt;
  late final String expiredAt;
  late final String price;
  late final String currentPrice;
  late final String thumbnailUrl;
  late final String videoLink;
  late final bool isFavorite;
  late final bool isWishList;

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'].toString();
    publishedAt = json['published_at'].toString();
    expiredAt = json['expired_at'].toString();
    price = json['price'].toString();
    currentPrice = json['current_price'].toString();
    thumbnailUrl = json['thumbnail_url'].toString();
    videoLink = json['video_link'].toString();
    isFavorite = json['is_favorite'];
    isWishList = json['is_wish_list'] ?? false;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['title'] = title;
    _data['published_at'] = publishedAt;
    _data['expired_at'] = expiredAt;
    _data['price'] = price;
    _data['current_price'] = currentPrice;
    _data['thumbnail_url'] = thumbnailUrl;
    _data['video_link'] = videoLink;
    _data['is_favorite'] = isFavorite;
    _data['is_wish_list'] = isWishList;
    return _data;
  }
}

class UserAuctions {
  UserAuctions({
    required this.currentPage,
    required this.data,
  });
  late final int currentPage;
  late final List<UserAuctionData> data;

  UserAuctions.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    data = List.from(json['data'])
        .map((e) => UserAuctionData.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['current_page'] = currentPage;
    _data['data'] = data.map((e) => e.toJson()).toList();
    return _data;
  }
}
