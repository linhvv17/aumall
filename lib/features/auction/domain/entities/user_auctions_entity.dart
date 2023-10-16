import 'package:aumall/features/auction/domain/entities/user_auction_data_entity.dart';

class UserAuctionsEntity {
  UserAuctionsEntity({
    required this.currentPage,
    required this.data,
  });
  final int currentPage;
  final List<UserAuctionDataEntity> data;
}