import 'package:aumall/features/home/data/models/banner_model.dart';
import 'package:aumall/features/shopping/domain/entities/products_entity.dart';
import 'package:equatable/equatable.dart';

import '../../data/models/auction_session_info_model.dart';

class AuctionSessionInfoEntity extends Equatable {
  final Product product;
  final UserAuctions userAuctions;
  const AuctionSessionInfoEntity(this.product, this.userAuctions);
  @override
  List<Object?> get props => [];
}
