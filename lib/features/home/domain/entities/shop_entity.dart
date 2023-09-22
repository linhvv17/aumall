import 'package:equatable/equatable.dart';

class ShopEntity extends Equatable {
  final int? id;
  final int? user_id;
  final String? name;
  final String? banner;
  final String? image;
  final String? created_at;
  final String? banner_url;
  final String? image_url;

  const ShopEntity({
    this.id,
    this.name,
    this.user_id,
    this.banner,
    this.image,
    this.created_at,
    this.banner_url,
    this.image_url,
  });

  @override
  List<Object?> get props {
    return [
      id,
      name,
    ];
  }
}
