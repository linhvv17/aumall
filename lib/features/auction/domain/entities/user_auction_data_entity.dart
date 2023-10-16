import '../../../profile/domain/entities/profile_entity.dart';

class UserAuctionDataEntity {
  UserAuctionDataEntity({
    required this.id,
    required this.productId,
    required this.userId,
    required this.price,
    required this.createdAt,
    required this.user,
  });
  final int id;
  final int productId;
  final int userId;
  final String price;
  final DateTime createdAt;
  final UserEntity user;
}