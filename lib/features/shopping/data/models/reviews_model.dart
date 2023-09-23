import '../../../home/data/models/detail_product_response.dart';
import '../../domain/entities/reviews_entity.dart';

class GetReviewsModel extends GetReviewsEntity {
  const GetReviewsModel(
      // super.success,
      super.reviews);
  factory GetReviewsModel.fromJson(Map<String, dynamic> json) {
    return GetReviewsModel(
      // json['success'],
      List<GetReviewModel>.from(
          json['data']['data'].map((x) => GetReviewModel.fromJson(x))),
    );
  }
}

class GetReviewModel extends GetReviewEntity {
  const GetReviewModel(
      super.user, super.name, super.rating, super.comment, super.createdAt);

  factory GetReviewModel.fromJson(Map<String, dynamic> json) => GetReviewModel(
      json['user'] != null ? User.fromJson(json['user']) : null,
      json['name'] ?? "",
      json['rating'] ?? 0,
      json['comment'] ?? "",
      DateTime.parse(json['created_at']));
}
