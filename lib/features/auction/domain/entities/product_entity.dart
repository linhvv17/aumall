class ProductEntity {
  ProductEntity({
    required this.id,
    required this.title,
    required this.publishedAt,
    required this.expiredAt,
    required this.price,
    required this.priceStep,
    required this.currentPrice,
    required this.thumbnailUrl,
    required this.videoLink,
    required this.isFavorite,
    required this.isWishList,
  });
  final int id;
  final String title;
  final String publishedAt;
  final String expiredAt;
  final String price;
  final String priceStep;
  final String currentPrice;
  final String thumbnailUrl;
  final String videoLink;
  final bool isFavorite;
  final bool isWishList;
}