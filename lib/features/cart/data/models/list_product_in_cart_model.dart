
import '../../../shop/data/models/products_model.dart';
import '../../domain/entities/list_product_in_cart_entity.dart';

class ListProductInCartModel extends ListProductInCartEntity {
  const ListProductInCartModel(super.listProductInCart);

  factory ListProductInCartModel.fromJson(Map<String, dynamic> json) {
    print("ListProductInCartModel.fromJson json${json}");
    print("ListProductInCartModel.fromJson json data ${json['data']}");

    List<ProductInCartModel> list
    = List<ProductInCartModel>.from(
        json['data']['data'].map((x) => ProductInCartModel.fromJson(x)));

    print("ListProductInCartModel.fromJson json data List<ProductFavoriteModel> ${list}");
    print("ListProductInCartModel.fromJson json data List<ProductFavoriteModel> ${list.length}");
    return ListProductInCartModel(
        list
    );
  }

}





class ProductInCartModel extends ProductInCartEntity{
  ProductInCartModel(
    super.id,
    super.productId,
    super.orderId,
    super.amount,
    super.quantity,
    super.createdAt,
    super.product,
  );


  factory ProductInCartModel.fromJson(Map<String, dynamic> json) =>
      ProductInCartModel(
    json['id'],
    json['product_id'],
    json['order_id'],
    json['amount'],
    json['quantity'],
    json['created_at'],
    ProductModel.fromJson(json['product']),
  );

  // Map<String, dynamic> toJson() {
  //   final _data = <String, dynamic>{};
  //   _data['id'] = id;
  //   _data['product_id'] = productId;
  //   _data['order_id'] = orderId;
  //   _data['amount'] = amount;
  //   _data['quantity'] = quantity;
  //   _data['created_at'] = createdAt;
  //   _data['product'] = product.toJson();
  //   return _data;
  // }
}

class ProductModel extends ProductEntity{
  const ProductModel(
    super.id,
    super.title,
    super.thumbnail,
    super.price,
    super.discount,
    super.currentStock,
    super.thumbnailUrl,
    super.videoLink,
    super.isFavorite,
    // super.isWishList,
  );

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      ProductModel(
    json['id'],
    json['title'],
    json['thumbnail'],
    json['price'],
    json['discount'].toString(),
    json['current_stock'].toString(),
    json['thumbnail_url'],
    json['video_link'].toString(),
    json['is_favorite'],
    // json['is_wish_list'] ?? false,
  );

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['title'] = title;
    _data['thumbnail'] = thumbnail;
    _data['price'] = price;
    _data['discount'] = discount;
    _data['current_stock'] = currentStock;
    _data['thumbnail_url'] = thumbnailUrl;
    _data['video_link'] = videoLink;
    _data['is_favorite'] = isFavorite;
    // _data['is_wish_list'] = isWishList;
    return _data;
  }
}